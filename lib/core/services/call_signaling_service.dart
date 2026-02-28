import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/call_session_model.dart';
import '../../domain/entities/call_session.dart';
import '../../domain/enums/call_status.dart';
import '../../domain/enums/call_type.dart';

/// Stateless Firestore signaling service for call SDP and ICE candidates.
///
/// Safe as a @lazySingleton — no internal state, all operations are idempotent.
@lazySingleton
class CallSignalingService {
  final FirebaseFirestore _firestore;

  CallSignalingService(this._firestore);

  DocumentReference _callDoc(String callId) =>
      _firestore.collection('calls').doc(callId);

  // ── SDP ──

  Future<void> sendOffer(String callId, RTCSessionDescription offer) async {
    try {
      await _callDoc(callId).update({
        'offer': {'sdp': offer.sdp, 'type': offer.type},
      });
    } catch (e) {
      debugPrint('CallSignaling: sendOffer failed: $e');
      rethrow;
    }
  }

  Future<void> sendAnswer(String callId, RTCSessionDescription answer) async {
    try {
      await _callDoc(callId).update({
        'answer': {'sdp': answer.sdp, 'type': answer.type},
      });
    } catch (e) {
      debugPrint('CallSignaling: sendAnswer failed: $e');
      rethrow;
    }
  }

  // ── ICE Candidates ──

  /// Send a local ICE candidate.
  /// [isCaller] determines which subcollection to write to — replaces
  /// the broken _getCallerId() approach from the original plan.
  Future<void> sendIceCandidate(
    String callId,
    RTCIceCandidate candidate, {
    required bool isCaller,
  }) async {
    final subcollection = isCaller ? 'callerCandidates' : 'calleeCandidates';
    try {
      await _callDoc(callId).collection(subcollection).add({
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('CallSignaling: sendIceCandidate failed: $e');
      // Don't rethrow — losing one candidate is recoverable
    }
  }

  /// Watch the remote peer's ICE candidates.
  Stream<RTCIceCandidate> watchRemoteIceCandidates(
    String callId, {
    required bool isCaller,
  }) {
    // Watch the OTHER peer's subcollection
    final subcollection = isCaller ? 'calleeCandidates' : 'callerCandidates';
    return _callDoc(callId)
        .collection(subcollection)
        .snapshots()
        .expand((snap) => snap.docChanges
            .where((change) => change.type == DocumentChangeType.added)
            .map((change) {
              final data = change.doc.data()!;
              return RTCIceCandidate(
                data['candidate'] as String,
                data['sdpMid'] as String,
                data['sdpMLineIndex'] as int,
              );
            }));
  }

  // ── Call Document Watching ──

  /// Watch the call document for real-time changes (status, SDP, upgrade).
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

  // ── Heartbeat ──

  Future<void> sendHeartbeat(String callId, {required bool isCaller}) async {
    final field = isCaller ? 'callerHeartbeat' : 'calleeHeartbeat';
    try {
      await _callDoc(callId).update({field: FieldValue.serverTimestamp()});
    } catch (e) {
      debugPrint('CallSignaling: heartbeat failed: $e');
    }
  }

  // ── ICE Restart Count ──

  Future<void> updateIceRestartCount(String callId, int count) async {
    try {
      await _callDoc(callId).update({'iceRestartCount': count});
    } catch (e) {
      debugPrint('CallSignaling: updateIceRestartCount failed: $e');
    }
  }

  // ── Video Upgrade ──

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
}
