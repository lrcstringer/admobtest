import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/data/models/gift_model.dart';
import 'package:imalichat/domain/enums/gift_status.dart';
import 'package:imalichat/domain/enums/gift_style.dart';

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

/// Helper to generate valid JSON for a GiftModel
Map<String, dynamic> _validJson({
  String id = 'gift_1',
  String senderId = 'sender_1',
  String? senderName = 'Test Sender',
  String recipientId = 'recipient_1',
  String? recipientName = 'Test Recipient',
  int? amount = 500,
  String? conversationId = 'conv_1',
  String? communityId,
  String? messageId = 'msg_1',
  String? message = 'Happy birthday!',
  String? style = 'birthday',
  String? status = 'pending',
  String? createdAt = '2024-06-01T00:00:00.000Z',
  String? openedAt,
  String? claimedAt,
  String? expiresAt = '2024-06-08T00:00:00.000Z',
  String? debitTransactionId = 'j_debit_1',
  String? creditTransactionId,
}) {
  return {
    'id': id,
    'senderId': senderId,
    if (senderName != null) 'senderName': senderName,
    'recipientId': recipientId,
    if (recipientName != null) 'recipientName': recipientName,
    if (amount != null) 'amount': amount,
    if (conversationId != null) 'conversationId': conversationId,
    if (communityId != null) 'communityId': communityId,
    if (messageId != null) 'messageId': messageId,
    if (message != null) 'message': message,
    if (style != null) 'style': style,
    if (status != null) 'status': status,
    if (createdAt != null) 'createdAt': createdAt,
    if (openedAt != null) 'openedAt': openedAt,
    if (claimedAt != null) 'claimedAt': claimedAt,
    if (expiresAt != null) 'expiresAt': expiresAt,
    if (debitTransactionId != null) 'debitTransactionId': debitTransactionId,
    if (creditTransactionId != null) 'creditTransactionId': creditTransactionId,
  };
}

void main() {
  group('GiftModel', () {
    group('fromJson', () {
      test('parses all fields correctly from complete JSON', () {
        final model = GiftModel.fromJson(_validJson());

        expect(model.id, 'gift_1');
        expect(model.senderId, 'sender_1');
        expect(model.senderName, 'Test Sender');
        expect(model.recipientId, 'recipient_1');
        expect(model.recipientName, 'Test Recipient');
        expect(model.amount, 500);
        expect(model.conversationId, 'conv_1');
        expect(model.communityId, isNull);
        expect(model.messageId, 'msg_1');
        expect(model.message, 'Happy birthday!');
        expect(model.style, 'birthday');
        expect(model.status, 'pending');
        expect(model.createdAt, DateTime.utc(2024, 6, 1));
        expect(model.openedAt, isNull);
        expect(model.claimedAt, isNull);
        expect(model.expiresAt, DateTime.utc(2024, 6, 8));
        expect(model.debitTransactionId, 'j_debit_1');
        expect(model.creditTransactionId, isNull);
      });

      test('defaults senderName to Unknown when missing', () {
        final json = _validJson(senderName: null);
        final model = GiftModel.fromJson(json);
        expect(model.senderName, 'Unknown');
      });

      test('defaults recipientName to Unknown when missing', () {
        final json = _validJson(recipientName: null);
        final model = GiftModel.fromJson(json);
        expect(model.recipientName, 'Unknown');
      });

      test('defaults amount to 0 when missing', () {
        final json = _validJson(amount: null);
        final model = GiftModel.fromJson(json);
        expect(model.amount, 0);
      });

      test('defaults style to celebration when missing', () {
        final json = _validJson(style: null);
        final model = GiftModel.fromJson(json);
        expect(model.style, 'celebration');
      });

      test('defaults status to pending when missing', () {
        final json = _validJson(status: null);
        final model = GiftModel.fromJson(json);
        expect(model.status, 'pending');
      });

      test('defaults messageId to empty string when missing', () {
        final json = _validJson(messageId: null);
        final model = GiftModel.fromJson(json);
        expect(model.messageId, '');
      });

      test('defaults message to empty string when missing', () {
        final json = _validJson(message: null);
        final model = GiftModel.fromJson(json);
        expect(model.message, '');
      });

      test('parses DateTime from ISO string', () {
        final model = GiftModel.fromJson(_validJson(
          openedAt: '2024-06-01T02:00:00.000Z',
          claimedAt: '2024-06-01T03:00:00.000Z',
        ));
        expect(model.openedAt, DateTime.utc(2024, 6, 1, 2));
        expect(model.claimedAt, DateTime.utc(2024, 6, 1, 3));
      });

      test('parses DateTime from DateTime object', () {
        final dt = DateTime(2024, 7, 15);
        final json = _validJson();
        json['createdAt'] = dt;
        final model = GiftModel.fromJson(json);
        expect(model.createdAt, dt);
      });

      test('nullable DateTime fields are null when absent', () {
        final model = GiftModel.fromJson(_validJson());
        expect(model.openedAt, isNull);
        expect(model.claimedAt, isNull);
        expect(model.creditTransactionId, isNull);
        expect(model.communityId, isNull);
      });
    });

    group('fromFirestore', () {
      test('extracts doc.id as id', () {
        final doc = MockDocumentSnapshot();
        when(() => doc.id).thenReturn('firestore_gift_id');
        when(() => doc.data()).thenReturn({
          'senderId': 'sender_1',
          'recipientId': 'recipient_1',
          'createdAt': '2024-06-01T00:00:00.000Z',
          'expiresAt': '2024-06-08T00:00:00.000Z',
        });

        final model = GiftModel.fromFirestore(doc);
        expect(model.id, 'firestore_gift_id');
      });
    });

    group('toEntity', () {
      test('converts all GiftStyle values correctly', () {
        for (final entry in {
          'ndlovukazi': GiftStyle.ndlovukazi,
          'celebration': GiftStyle.celebration,
          'love': GiftStyle.love,
          'birthday': GiftStyle.birthday,
          'professional': GiftStyle.professional,
        }.entries) {
          final model = GiftModel.fromJson(_validJson(style: entry.key));
          expect(model.toEntity().style, entry.value);
        }
      });

      test('defaults unknown style to celebration', () {
        final model = GiftModel.fromJson(_validJson(style: 'unknown_style'));
        expect(model.toEntity().style, GiftStyle.celebration);
      });

      test('converts all GiftStatus values correctly', () {
        for (final entry in {
          'pending': GiftStatus.pending,
          'opened': GiftStatus.opened,
          'claimed': GiftStatus.claimed,
          'expired': GiftStatus.expired,
        }.entries) {
          final model = GiftModel.fromJson(_validJson(status: entry.key));
          expect(model.toEntity().status, entry.value);
        }
      });

      test('defaults unknown status to pending', () {
        final model = GiftModel.fromJson(_validJson(status: 'unknown_status'));
        expect(model.toEntity().status, GiftStatus.pending);
      });

      test('maps all fields to entity correctly', () {
        final model = GiftModel.fromJson(_validJson(
          openedAt: '2024-06-01T02:00:00.000Z',
          claimedAt: '2024-06-01T03:00:00.000Z',
          creditTransactionId: 'j_credit_1',
        ));
        final entity = model.toEntity();

        expect(entity.id, 'gift_1');
        expect(entity.senderId, 'sender_1');
        expect(entity.senderName, 'Test Sender');
        expect(entity.recipientId, 'recipient_1');
        expect(entity.recipientName, 'Test Recipient');
        expect(entity.amount, 500);
        expect(entity.conversationId, 'conv_1');
        expect(entity.communityId, isNull);
        expect(entity.messageId, 'msg_1');
        expect(entity.message, 'Happy birthday!');
        expect(entity.style, GiftStyle.birthday);
        expect(entity.status, GiftStatus.pending);
        expect(entity.openedAt, isNotNull);
        expect(entity.claimedAt, isNotNull);
        expect(entity.debitTransactionId, 'j_debit_1');
        expect(entity.creditTransactionId, 'j_credit_1');
      });
    });
  });

  group('GiftStatsModel', () {
    test('fromJson with all fields', () {
      final model = GiftStatsModel.fromJson({
        'totalSent': 10,
        'totalReceived': 5,
        'totalAmountSent': 5000,
        'totalAmountReceived': 2500,
      });

      expect(model.totalSent, 10);
      expect(model.totalReceived, 5);
      expect(model.totalAmountSent, 5000);
      expect(model.totalAmountReceived, 2500);
    });

    test('fromJson defaults missing fields to 0', () {
      final model = GiftStatsModel.fromJson({});

      expect(model.totalSent, 0);
      expect(model.totalReceived, 0);
      expect(model.totalAmountSent, 0);
      expect(model.totalAmountReceived, 0);
    });

    test('toEntity maps correctly', () {
      final model = GiftStatsModel.fromJson({
        'totalSent': 3,
        'totalReceived': 7,
        'totalAmountSent': 1500,
        'totalAmountReceived': 3500,
      });
      final entity = model.toEntity();

      expect(entity.totalSent, 3);
      expect(entity.totalReceived, 7);
      expect(entity.totalAmountSent, 1500);
      expect(entity.totalAmountReceived, 3500);
    });
  });
}
