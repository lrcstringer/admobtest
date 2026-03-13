// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:imalichat/data/models/token_pool_model.dart';
import 'package:imalichat/domain/enums/gift_style.dart';
import 'package:imalichat/domain/enums/pool_mode.dart';
import 'package:imalichat/domain/enums/pool_status.dart';

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

Map<String, dynamic> _validJson({
  String id = 'pool_1',
  String mode = 'sasaza',
  String status = 'collecting',
  String organizerId = 'user123',
  String? organizerName = 'Test Organizer',
  String? recipientId = 'user789',
  String? recipientName = 'Recipient',
  String conversationId = 'conv_1',
  String title = 'Birthday Gift',
  String message = 'Happy Birthday!',
  String style = 'birthday',
  int? totalAmount = 5000,
  int? contributionCount = 3,
  int? contributorCount = 2,
  Map<String, dynamic>? contributions,
  List<Map<String, dynamic>>? payouts,
  String? giftMessageId,
  String? giftConversationId,
  List<String>? inviteeIds,
  String? expiresAt = '2024-07-01T00:00:00.000',
  String createdAt = '2024-06-01T00:00:00.000',
  String updatedAt = '2024-06-01T00:00:00.000',
  String? sentAt,
  String? completedAt,
  String? cancelledAt,
  String groupAccountId = 'group:pool_1',
  bool reminderSent = false,
}) {
  return {
    'id': id,
    'mode': mode,
    'status': status,
    'organizerId': organizerId,
    if (organizerName != null) 'organizerName': organizerName,
    if (recipientId != null) 'recipientId': recipientId,
    if (recipientName != null) 'recipientName': recipientName,
    'conversationId': conversationId,
    'title': title,
    'message': message,
    'style': style,
    if (totalAmount != null) 'totalAmount': totalAmount,
    if (contributionCount != null) 'contributionCount': contributionCount,
    if (contributorCount != null) 'contributorCount': contributorCount,
    'contributions': contributions ?? {
      'user123': {
        'userId': 'user123',
        'displayName': 'Test User',
        'totalAmount': 3000,
        'contributionCount': 2,
        'anonymous': false,
        'lastContributedAt': '2024-06-01T00:00:00.000',
      },
    },
    'payouts': payouts ?? [],
    if (giftMessageId != null) 'giftMessageId': giftMessageId,
    if (giftConversationId != null) 'giftConversationId': giftConversationId,
    'inviteeIds': inviteeIds ?? ['user456'],
    if (expiresAt != null) 'expiresAt': expiresAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    if (sentAt != null) 'sentAt': sentAt,
    if (completedAt != null) 'completedAt': completedAt,
    if (cancelledAt != null) 'cancelledAt': cancelledAt,
    'groupAccountId': groupAccountId,
    'reminderSent': reminderSent,
  };
}

void main() {
  group('TokenPoolModel', () {
    // ── fromJson ──────────────────────────────────────────────────────

    group('fromJson', () {
      test('parses all fields correctly from complete JSON', () {
        final model = TokenPoolModel.fromJson(_validJson());

        expect(model.id, 'pool_1');
        expect(model.mode, 'sasaza');
        expect(model.status, 'collecting');
        expect(model.organizerId, 'user123');
        expect(model.organizerName, 'Test Organizer');
        expect(model.recipientId, 'user789');
        expect(model.recipientName, 'Recipient');
        expect(model.conversationId, 'conv_1');
        expect(model.title, 'Birthday Gift');
        expect(model.message, 'Happy Birthday!');
        expect(model.style, 'birthday');
        expect(model.totalAmount, 5000);
        expect(model.contributionCount, 3);
        expect(model.contributorCount, 2);
        expect(model.contributions, isNotEmpty);
        expect(model.inviteeIds, ['user456']);
        expect(model.groupAccountId, 'group:pool_1');
        expect(model.reminderSent, false);
      });

      test('parses minimal JSON with nullable fields missing', () {
        final json = _validJson(
          recipientId: null,
          recipientName: null,
          giftMessageId: null,
          giftConversationId: null,
          expiresAt: null,
          sentAt: null,
          completedAt: null,
          cancelledAt: null,
        );
        final model = TokenPoolModel.fromJson(json);

        expect(model.recipientId, isNull);
        expect(model.recipientName, isNull);
        expect(model.giftMessageId, isNull);
        expect(model.giftConversationId, isNull);
        expect(model.expiresAt, isNull);
        expect(model.sentAt, isNull);
        expect(model.completedAt, isNull);
        expect(model.cancelledAt, isNull);
      });

      test('defaults mode to sasaza for unknown mode string', () {
        final model = TokenPoolModel.fromJson(_validJson(mode: 'unknown'));
        final entity = model.toEntity();
        expect(entity.mode, PoolMode.sasaza);
      });

      test('defaults status to collecting for unknown status string', () {
        final model = TokenPoolModel.fromJson(_validJson(status: 'unknown'));
        final entity = model.toEntity();
        expect(entity.status, PoolStatus.collecting);
      });

      test('defaults style to celebration for unknown style string', () {
        final model = TokenPoolModel.fromJson(_validJson(style: 'unknown'));
        final entity = model.toEntity();
        expect(entity.style, GiftStyle.celebration);
      });

      test('parses each mode string correctly', () {
        for (final entry in {'sasaza': PoolMode.sasaza, 'save': PoolMode.save}.entries) {
          final model = TokenPoolModel.fromJson(_validJson(mode: entry.key));
          expect(model.toEntity().mode, entry.value);
        }
      });

      test('parses each status string correctly', () {
        final cases = {
          'collecting': PoolStatus.collecting,
          'sent': PoolStatus.sent,
          'completed': PoolStatus.completed,
          'cancelled': PoolStatus.cancelled,
          'expired': PoolStatus.expired,
        };
        for (final entry in cases.entries) {
          final model = TokenPoolModel.fromJson(_validJson(status: entry.key));
          expect(model.toEntity().status, entry.value);
        }
      });

      test('parses each style string correctly', () {
        final cases = {
          'ndlovukazi': GiftStyle.ndlovukazi,
          'celebration': GiftStyle.celebration,
          'love': GiftStyle.love,
          'birthday': GiftStyle.birthday,
          'professional': GiftStyle.professional,
        };
        for (final entry in cases.entries) {
          final model = TokenPoolModel.fromJson(_validJson(style: entry.key));
          expect(model.toEntity().style, entry.value);
        }
      });

      test('defaults totalAmount to 0 when null', () {
        final model = TokenPoolModel.fromJson(_validJson(totalAmount: null));
        expect(model.totalAmount, 0);
      });

      test('defaults contributionCount and contributorCount to 0 when null', () {
        final model = TokenPoolModel.fromJson(
          _validJson(contributionCount: null, contributorCount: null),
        );
        expect(model.contributionCount, 0);
        expect(model.contributorCount, 0);
      });

      test('defaults organizerName to Unknown when null', () {
        final model = TokenPoolModel.fromJson(_validJson(organizerName: null));
        expect(model.organizerName, 'Unknown');
      });

      test('defaults inviteeIds to empty list when null', () {
        final json = _validJson();
        json['inviteeIds'] = null;
        final model = TokenPoolModel.fromJson(json);
        expect(model.inviteeIds, isEmpty);
      });

      test('defaults inviteeIds to empty list when not a List', () {
        final json = _validJson();
        json['inviteeIds'] = 'not-a-list';
        final model = TokenPoolModel.fromJson(json);
        expect(model.inviteeIds, isEmpty);
      });

      test('defaults contributions to empty map when null', () {
        final json = _validJson();
        json['contributions'] = null;
        final model = TokenPoolModel.fromJson(json);
        expect(model.contributions, isEmpty);
      });

      test('defaults payouts to empty list when null', () {
        final json = _validJson();
        json['payouts'] = null;
        final model = TokenPoolModel.fromJson(json);
        expect(model.payouts, isEmpty);
      });

      test('handles DateTime objects for date fields', () {
        final json = _validJson();
        json['createdAt'] = DateTime(2024, 6, 1);
        final model = TokenPoolModel.fromJson(json);
        expect(model.createdAt, DateTime(2024, 6, 1));
      });
    });

    // ── fromFirestore ─────────────────────────────────────────────────

    group('fromFirestore', () {
      test('creates model using doc.id', () {
        final mockDoc = MockDocumentSnapshot();
        when(() => mockDoc.id).thenReturn('pool_from_fs');
        when(() => mockDoc.data()).thenReturn(_validJson()..remove('id'));

        final model = TokenPoolModel.fromFirestore(mockDoc);
        expect(model.id, 'pool_from_fs');
        expect(model.mode, 'sasaza');
        expect(model.organizerId, 'user123');
      });
    });

    // ── toEntity ──────────────────────────────────────────────────────

    group('toEntity', () {
      test('converts all fields to TokenPool entity correctly', () {
        final model = TokenPoolModel.fromJson(_validJson());
        final entity = model.toEntity();

        expect(entity.id, 'pool_1');
        expect(entity.mode, PoolMode.sasaza);
        expect(entity.status, PoolStatus.collecting);
        expect(entity.style, GiftStyle.birthday);
        expect(entity.organizerId, 'user123');
        expect(entity.recipientId, 'user789');
        expect(entity.totalAmount, 5000);
        expect(entity.inviteeIds, ['user456']);
        expect(entity.groupAccountId, 'group:pool_1');
      });

      test('converts contributions map to PoolContribution entities', () {
        final model = TokenPoolModel.fromJson(_validJson());
        final entity = model.toEntity();

        expect(entity.contributions.length, 1);
        expect(entity.contributions['user123']!.displayName, 'Test User');
        expect(entity.contributions['user123']!.anonymous, false);
        expect(entity.contributions['user123']!.totalAmount, 3000);
      });

      test('converts payouts list to PoolPayout entities', () {
        final json = _validJson(payouts: [
          {'userId': 'u1', 'displayName': 'User 1', 'amount': 5000},
        ]);
        final entity = TokenPoolModel.fromJson(json).toEntity();

        expect(entity.payouts.length, 1);
        expect(entity.payouts[0].userId, 'u1');
        expect(entity.payouts[0].amount, 5000);
      });

      test('handles missing nested contribution fields with defaults', () {
        final json = _validJson(contributions: {
          'user1': {'userId': 'user1'},
        });
        final entity = TokenPoolModel.fromJson(json).toEntity();

        expect(entity.contributions['user1']!.displayName, 'Unknown');
        expect(entity.contributions['user1']!.totalAmount, 0);
        expect(entity.contributions['user1']!.anonymous, false);
      });
    });
  });
}
