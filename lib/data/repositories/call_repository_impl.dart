import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/call_session.dart';
import '../../domain/enums/call_status.dart';
import '../../domain/enums/call_type.dart';
import '../../domain/repositories/call_repository.dart';
import '../datasources/remote/call_remote_datasource.dart';
import '../models/call_session_model.dart';

@LazySingleton(as: CallRepository)
class CallRepositoryImpl implements CallRepository {
  final CallRemoteDatasource _datasource;
  final FirebaseFirestore _firestore;

  CallRepositoryImpl(this._datasource, this._firestore);

  DocumentReference _callDoc(String callId) =>
      _firestore.collection('calls').doc(callId);

  @override
  Future<String> initiateCall({
    required String conversationId,
    required String recipientId,
    required CallType callType,
  }) {
    return _datasource.initiateCall(
      conversationId: conversationId,
      recipientId: recipientId,
      callType: callType.name,
    );
  }

  @override
  Future<void> answerCall(String callId) => _datasource.answerCall(callId);

  @override
  Future<void> endCall(String callId, {String? reason}) =>
      _datasource.endCall(callId, reason: reason);

  @override
  Future<Map<String, dynamic>> getTurnCredentials() =>
      _datasource.getTurnCredentials();

  @override
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

  @override
  Future<void> sendOffer(String callId, Map<String, String> offer) async {
    await _callDoc(callId).update({
      'offer': {'sdp': offer['sdp'], 'type': offer['type']},
    });
  }

  @override
  Future<void> sendAnswer(String callId, Map<String, String> answer) async {
    await _callDoc(callId).update({
      'answer': {'sdp': answer['sdp'], 'type': answer['type']},
    });
  }

  @override
  Future<void> sendIceCandidate(
    String callId,
    Map<String, dynamic> candidate, {
    required bool isCaller,
  }) async {
    final subcollection = isCaller ? 'callerCandidates' : 'calleeCandidates';
    await _callDoc(callId).collection(subcollection).add({
      'candidate': candidate['candidate'],
      'sdpMid': candidate['sdpMid'],
      'sdpMLineIndex': candidate['sdpMLineIndex'],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Stream<Map<String, dynamic>> watchRemoteIceCandidates(
    String callId, {
    required bool isCaller,
  }) {
    // Watch the OTHER peer's candidates
    final subcollection = isCaller ? 'calleeCandidates' : 'callerCandidates';
    return _callDoc(callId)
        .collection(subcollection)
        .snapshots()
        .expand((snap) => snap.docChanges
            .where((change) => change.type == DocumentChangeType.added)
            .map((change) {
              final data = change.doc.data()!;
              return {
                'candidate': data['candidate'] as String,
                'sdpMid': data['sdpMid'] as String,
                'sdpMLineIndex': data['sdpMLineIndex'] as int,
              };
            }));
  }

  @override
  Future<void> sendHeartbeat(String callId, {required bool isCaller}) async {
    final field = isCaller ? 'callerHeartbeat' : 'calleeHeartbeat';
    await _callDoc(callId).update({field: FieldValue.serverTimestamp()});
  }

  @override
  Future<void> requestVideoUpgrade(String callId, String requesterId) async {
    await _callDoc(callId).update({
      'videoUpgradeRequest': 'pending',
      'videoUpgradeRequesterId': requesterId,
    });
  }

  @override
  Future<void> respondVideoUpgrade(String callId, bool accepted) async {
    await _callDoc(callId).update({
      'videoUpgradeRequest': accepted ? 'accepted' : 'declined',
    });
  }
}
