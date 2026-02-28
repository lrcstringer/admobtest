import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/call_session_model.dart';
import 'package:imalichat/domain/enums/call_status.dart';
import 'package:imalichat/domain/enums/call_type.dart';

void main() {
  group('CallSessionModel', () {
    final sampleJson = {
      'callId': 'call_123',
      'conversationId': 'conv_456',
      'callerId': 'user_a',
      'calleeId': 'user_b',
      'callerName': 'Alice',
      'callerAvatarUrl': 'https://example.com/avatar.jpg',
      'callType': 'voice',
      'status': 'ringing',
      'offer': {'type': 'offer', 'sdp': 'v=0\r\n...'},
      'answer': null,
      'videoUpgradeRequest': null,
      'videoUpgradeRequesterId': null,
      'createdAt': '2026-02-28T10:00:00.000Z',
      'answeredAt': null,
      'endedAt': null,
      'endReason': null,
      'durationSeconds': null,
    };

    test('fromJson creates model from valid JSON', () {
      final model = CallSessionModel.fromJson(sampleJson);

      expect(model.callId, 'call_123');
      expect(model.conversationId, 'conv_456');
      expect(model.callerId, 'user_a');
      expect(model.calleeId, 'user_b');
      expect(model.callerName, 'Alice');
      expect(model.callerAvatarUrl, 'https://example.com/avatar.jpg');
      expect(model.callType, 'voice');
      expect(model.status, 'ringing');
      expect(model.offer, isNotNull);
      expect(model.answer, isNull);
    });

    test('toJson produces valid JSON', () {
      final model = CallSessionModel.fromJson(sampleJson);
      final json = model.toJson();

      expect(json['callId'], 'call_123');
      expect(json['callType'], 'voice');
      expect(json['status'], 'ringing');
    });

    test('toEntity converts to domain entity correctly', () {
      final model = CallSessionModel.fromJson(sampleJson);
      final entity = model.toEntity();

      expect(entity.callId, 'call_123');
      expect(entity.conversationId, 'conv_456');
      expect(entity.callType, CallType.voice);
      expect(entity.status, CallStatus.ringing);
      expect(entity.callerName, 'Alice');
    });

    test('toEntity maps video callType correctly', () {
      final json = Map<String, dynamic>.from(sampleJson);
      json['callType'] = 'video';
      final entity = CallSessionModel.fromJson(json).toEntity();

      expect(entity.callType, CallType.video);
    });

    test('toEntity maps all status values correctly', () {
      for (final status in CallStatus.values) {
        final json = Map<String, dynamic>.from(sampleJson);
        json['status'] = status.name;
        final entity = CallSessionModel.fromJson(json).toEntity();
        expect(entity.status, status);
      }
    });

    test('toEntity falls back to idle for unknown status', () {
      final json = Map<String, dynamic>.from(sampleJson);
      json['status'] = 'unknown_status';
      final entity = CallSessionModel.fromJson(json).toEntity();
      expect(entity.status, CallStatus.idle);
    });

    test('toEntity handles string timestamps', () {
      final json = Map<String, dynamic>.from(sampleJson);
      json['createdAt'] = '2026-02-28T10:00:00.000Z';
      json['answeredAt'] = '2026-02-28T10:01:00.000Z';

      final entity = CallSessionModel.fromJson(json).toEntity();
      expect(entity.createdAt, isNotNull);
      expect(entity.answeredAt, isNotNull);
    });

    test('toEntity handles null timestamps', () {
      final entity = CallSessionModel.fromJson(sampleJson).toEntity();
      expect(entity.answeredAt, isNull);
      expect(entity.endedAt, isNull);
    });

    test('toEntity maps offer SDP strings', () {
      final entity = CallSessionModel.fromJson(sampleJson).toEntity();
      expect(entity.offer?['type'], 'offer');
      expect(entity.offer?['sdp'], 'v=0\r\n...');
    });

    test('handles complete ended call JSON', () {
      final endedJson = {
        'callId': 'call_999',
        'conversationId': 'conv_1',
        'callerId': 'user_a',
        'calleeId': 'user_b',
        'callerName': 'Alice',
        'callerAvatarUrl': null,
        'callType': 'video',
        'status': 'ended',
        'offer': {'type': 'offer', 'sdp': 'sdp_offer'},
        'answer': {'type': 'answer', 'sdp': 'sdp_answer'},
        'videoUpgradeRequest': null,
        'videoUpgradeRequesterId': null,
        'createdAt': '2026-02-28T10:00:00.000Z',
        'answeredAt': '2026-02-28T10:00:05.000Z',
        'endedAt': '2026-02-28T10:05:05.000Z',
        'endReason': 'normal',
        'durationSeconds': 300,
      };

      final entity = CallSessionModel.fromJson(endedJson).toEntity();
      expect(entity.status, CallStatus.ended);
      expect(entity.durationSeconds, 300);
      expect(entity.endReason, 'normal');
      expect(entity.answer?['type'], 'answer');
    });
  });
}
