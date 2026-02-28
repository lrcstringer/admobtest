import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/call_session.dart';
import 'package:imalichat/domain/enums/call_status.dart';
import 'package:imalichat/domain/enums/call_type.dart';

void main() {
  group('CallSession', () {
    CallSession createSession({
      CallStatus status = CallStatus.idle,
      CallType callType = CallType.voice,
    }) {
      return CallSession(
        callId: 'call_1',
        conversationId: 'conv_1',
        callerId: 'caller_1',
        calleeId: 'callee_1',
        callerName: 'Test Caller',
        callType: callType,
        status: status,
      );
    }

    test('creates with required fields', () {
      final session = createSession();

      expect(session.callId, 'call_1');
      expect(session.conversationId, 'conv_1');
      expect(session.callerId, 'caller_1');
      expect(session.calleeId, 'callee_1');
      expect(session.callerName, 'Test Caller');
      expect(session.callType, CallType.voice);
      expect(session.status, CallStatus.idle);
    });

    test('optional fields default to null', () {
      final session = createSession();

      expect(session.callerAvatarUrl, isNull);
      expect(session.offer, isNull);
      expect(session.answer, isNull);
      expect(session.videoUpgradeRequest, isNull);
      expect(session.videoUpgradeRequesterId, isNull);
      expect(session.createdAt, isNull);
      expect(session.answeredAt, isNull);
      expect(session.endedAt, isNull);
      expect(session.endReason, isNull);
      expect(session.durationSeconds, isNull);
    });

    test('copyWith creates new instance with changed fields', () {
      final session = createSession();
      final updated = session.copyWith(
        status: CallStatus.active,
        callType: CallType.video,
        durationSeconds: 120,
      );

      expect(updated.status, CallStatus.active);
      expect(updated.callType, CallType.video);
      expect(updated.durationSeconds, 120);
      // Original unchanged
      expect(updated.callId, 'call_1');
      expect(updated.callerName, 'Test Caller');
    });

    test('equality works for identical values', () {
      final a = createSession();
      final b = createSession();
      expect(a, equals(b));
    });

    test('inequality when values differ', () {
      final a = createSession(status: CallStatus.idle);
      final b = createSession(status: CallStatus.active);
      expect(a, isNot(equals(b)));
    });

    test('supports offer and answer maps', () {
      final session = createSession().copyWith(
        offer: {'type': 'offer', 'sdp': 'v=0\r\n...'},
        answer: {'type': 'answer', 'sdp': 'v=0\r\n...'},
      );

      expect(session.offer?['type'], 'offer');
      expect(session.answer?['type'], 'answer');
    });

    test('supports video upgrade fields', () {
      final session = createSession().copyWith(
        videoUpgradeRequest: 'pending',
        videoUpgradeRequesterId: 'caller_1',
      );

      expect(session.videoUpgradeRequest, 'pending');
      expect(session.videoUpgradeRequesterId, 'caller_1');
    });
  });
}
