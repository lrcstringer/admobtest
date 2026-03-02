import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/call_session_model.dart';
import '../../domain/entities/call_session.dart';
import '../../domain/enums/call_status.dart';
import '../../domain/enums/call_type.dart';

/// Hybrid signaling service: RTDB for SDP + ICE (fast), Firestore for
/// call lifecycle + video upgrade (managed by Cloud Functions).
///
/// Safe as a @lazySingleton — all operations are keyed by callId.
@lazySingleton
class CallSignalingService {
  final FirebaseFirestore _firestore;
  final FirebaseDatabase _rtdb;

  CallSignalingService(this._firestore, this._rtdb);

  DocumentReference _callDoc(String callId) =>
      _firestore.collection('calls').doc(callId);

  DatabaseReference _signalingRef(String callId) =>
      _rtdb.ref('callSignaling/$callId');

  // ── SDP Descriptions (via RTDB — ~10-50ms vs Firestore's 100-300ms) ──
  //
  // Role-based nodes: each side writes to its own node, watches the other's.
  // This supports Perfect Negotiation where EITHER side can send an offer
  // (e.g. callee-initiated ICE restart or video upgrade renegotiation).
  //   callerDescription — written by caller, watched by callee
  //   calleeDescription — written by callee, watched by caller

  /// Send an SDP description (offer or answer) to our own RTDB node.
  Future<void> sendDescription(
    String callId,
    RTCSessionDescription desc, {
    required bool isCaller,
  }) async {
    final node = isCaller ? 'callerDescription' : 'calleeDescription';
    try {
      await _signalingRef(callId).child(node).set({
        'sdp': desc.sdp,
        'type': desc.type,
      });
    } catch (e) {
      debugPrint('CallSignaling: sendDescription ($node) failed: $e');
      rethrow;
    }
  }

  /// One-shot fetch of the remote peer's latest SDP description from RTDB.
  Future<RTCSessionDescription?> getRemoteDescription(
    String callId, {
    required bool isCaller,
  }) async {
    // Read the OTHER side's description
    final node = isCaller ? 'calleeDescription' : 'callerDescription';
    final snap = await _signalingRef(callId).child(node).get();
    if (!snap.exists || snap.value == null) return null;
    final data = snap.value as Map<dynamic, dynamic>;
    return RTCSessionDescription(
      data['sdp'] as String,
      data['type'] as String,
    );
  }

  /// Watch the remote peer's SDP description node for changes.
  /// Fires for the initial value (if present) and on every update.
  /// Supports both offers AND answers from the remote side (Perfect Negotiation).
  Stream<RTCSessionDescription> watchRemoteDescription(
    String callId, {
    required bool isCaller,
  }) {
    // Watch the OTHER side's description
    final node = isCaller ? 'calleeDescription' : 'callerDescription';
    return _signalingRef(callId)
        .child(node)
        .onValue
        .where((event) => event.snapshot.exists && event.snapshot.value != null)
        .map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      return RTCSessionDescription(
        data['sdp'] as String,
        data['type'] as String,
      );
    });
  }

  // ── ICE Candidates (via RTDB — no batching needed, fast enough) ──

  /// Send a local ICE candidate via RTDB push. Fire-and-forget.
  void sendIceCandidate(
    String callId,
    RTCIceCandidate candidate, {
    required bool isCaller,
  }) {
    final subcol = isCaller ? 'callerCandidates' : 'calleeCandidates';
    _signalingRef(callId).child(subcol).push().set({
      'candidate': candidate.candidate,
      'sdpMid': candidate.sdpMid,
      'sdpMLineIndex': candidate.sdpMLineIndex,
    }).catchError((e) {
      debugPrint('CallSignaling: sendIceCandidate failed: $e');
    });
  }

  /// Watch the remote peer's ICE candidates via RTDB onChildAdded.
  Stream<RTCIceCandidate> watchRemoteIceCandidates(
    String callId, {
    required bool isCaller,
  }) {
    // Watch the OTHER peer's candidates
    final subcol = isCaller ? 'calleeCandidates' : 'callerCandidates';
    return _signalingRef(callId)
        .child(subcol)
        .onChildAdded
        .map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      return RTCIceCandidate(
        data['candidate'] as String,
        data['sdpMid'] as String,
        data['sdpMLineIndex'] as int,
      );
    });
  }

  // ── Call Document (stays on Firestore — managed by Cloud Functions) ──

  /// Fetch the current call document once.
  Future<CallSession?> getCall(String callId) async {
    final snap = await _callDoc(callId).get();
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) return null;
    return CallSessionModel.fromJson(data).toEntity();
  }

  /// Watch the call document for status changes and video upgrade.
  Stream<CallSession> watchCall(String callId) {
    return _callDoc(callId).snapshots().map((snap) {
      final data = snap.data() as Map<String, dynamic>?;
      if (data == null) {
        return CallSession(
          callId: callId,
          conversationId: '',
          callerId: '',
          calleeId: '',
          callerName: '',
          callType: CallType.voice,
          status: CallStatus.ended,
        );
      }
      return CallSessionModel.fromJson(data).toEntity();
    });
  }

  // ── Heartbeat (Firestore — every 5s, not latency-critical) ──

  Future<void> sendHeartbeat(String callId, {required bool isCaller}) async {
    final field = isCaller ? 'callerHeartbeat' : 'calleeHeartbeat';
    try {
      await _callDoc(callId).update({field: FieldValue.serverTimestamp()});
    } catch (e) {
      debugPrint('CallSignaling: heartbeat failed: $e');
    }
  }

  // ── ICE Restart Count (Firestore) ──

  Future<void> updateIceRestartCount(String callId, int count) async {
    try {
      await _callDoc(callId).update({'iceRestartCount': count});
    } catch (e) {
      debugPrint('CallSignaling: updateIceRestartCount failed: $e');
    }
  }

  // ── Video Upgrade (Firestore — rare, not latency-critical) ──

  Future<void> requestVideoUpgrade(String callId, String requesterId) async {
    await _callDoc(callId).update({
      'videoUpgradeRequest': 'pending',
      'videoUpgradeRequesterId': requesterId,
    });
  }

  Future<void> respondVideoUpgrade(String callId, bool accepted) async {
    await _callDoc(callId).update({
      'videoUpgradeRequest': accepted ? 'accepted' : 'declined',
    });
  }

  // ── RTDB Cleanup ──

  /// Remove RTDB signaling data after call ends. Best effort.
  Future<void> cleanupSignaling(String callId) async {
    try {
      await _signalingRef(callId).remove();
      debugPrint('CallSignaling: RTDB cleanup for $callId');
    } catch (e) {
      debugPrint('CallSignaling: RTDB cleanup failed: $e');
    }
  }
}
