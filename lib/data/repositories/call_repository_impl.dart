import 'package:injectable/injectable.dart';

import '../../domain/enums/call_type.dart';
import '../../domain/repositories/call_repository.dart';
import '../datasources/remote/call_remote_datasource.dart';

@LazySingleton(as: CallRepository)
class CallRepositoryImpl implements CallRepository {
  final CallRemoteDatasource _datasource;

  CallRepositoryImpl(this._datasource);

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
}
