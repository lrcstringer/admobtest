import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/gift.dart';
import 'package:imalichat/domain/enums/gift_status.dart';
import 'package:imalichat/domain/enums/gift_style.dart';

/// Local helper with sensible defaults
Gift _gift({
  String id = 'gift_test',
  String senderId = 'sender_1',
  String senderName = 'Sender',
  String recipientId = 'recipient_1',
  String recipientName = 'Recipient',
  int amount = 500,
  String? conversationId = 'conv_1',
  String? communityId,
  String messageId = 'msg_1',
  String message = 'Test gift',
  GiftStyle style = GiftStyle.celebration,
  GiftStatus status = GiftStatus.pending,
  DateTime? createdAt,
  DateTime? openedAt,
  DateTime? claimedAt,
  DateTime? expiresAt,
  String? debitTransactionId,
  String? creditTransactionId,
}) {
  return Gift(
    id: id,
    senderId: senderId,
    senderName: senderName,
    recipientId: recipientId,
    recipientName: recipientName,
    amount: amount,
    conversationId: conversationId,
    communityId: communityId,
    messageId: messageId,
    message: message,
    style: style,
    status: status,
    createdAt: createdAt ?? DateTime(2024, 6, 1),
    openedAt: openedAt,
    claimedAt: claimedAt,
    expiresAt: expiresAt ?? DateTime(2024, 6, 8),
    debitTransactionId: debitTransactionId,
    creditTransactionId: creditTransactionId,
  );
}

void main() {
  group('Gift', () {
    group('status helpers', () {
      test('isPending returns true for pending status', () {
        expect(_gift(status: GiftStatus.pending).isPending, isTrue);
      });

      test('isPending returns false for non-pending status', () {
        expect(_gift(status: GiftStatus.opened).isPending, isFalse);
        expect(_gift(status: GiftStatus.claimed).isPending, isFalse);
        expect(_gift(status: GiftStatus.expired).isPending, isFalse);
      });

      test('isOpened returns true for opened status', () {
        expect(_gift(status: GiftStatus.opened).isOpened, isTrue);
      });

      test('isOpened returns false for non-opened status', () {
        expect(_gift(status: GiftStatus.pending).isOpened, isFalse);
        expect(_gift(status: GiftStatus.claimed).isOpened, isFalse);
      });

      test('isClaimed returns true for claimed status', () {
        expect(_gift(status: GiftStatus.claimed).isClaimed, isTrue);
      });

      test('isClaimed returns false for non-claimed status', () {
        expect(_gift(status: GiftStatus.pending).isClaimed, isFalse);
        expect(_gift(status: GiftStatus.opened).isClaimed, isFalse);
      });

      test('isExpired returns true for expired status', () {
        expect(_gift(status: GiftStatus.expired).isExpired, isTrue);
      });

      test('isExpired returns true when expiresAt is in the past', () {
        final gift = _gift(
          status: GiftStatus.pending,
          expiresAt: DateTime(2020, 1, 1), // in the past
        );
        expect(gift.isExpired, isTrue);
      });

      test('isExpired returns false when status is not expired and expiresAt is in the future', () {
        final gift = _gift(
          status: GiftStatus.pending,
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        );
        expect(gift.isExpired, isFalse);
      });
    });

    group('context helpers', () {
      test('isInConversation returns true when conversationId is set', () {
        expect(_gift(conversationId: 'conv_1').isInConversation, isTrue);
      });

      test('isInConversation returns false when conversationId is null', () {
        expect(_gift(conversationId: null).isInConversation, isFalse);
      });

      test('isInCommunity returns true when communityId is set', () {
        expect(
          _gift(conversationId: null, communityId: 'comm_1').isInCommunity,
          isTrue,
        );
      });

      test('isInCommunity returns false when communityId is null', () {
        expect(_gift(communityId: null).isInCommunity, isFalse);
      });
    });

    group('amountZar', () {
      test('converts tokens to ZAR (÷100)', () {
        expect(_gift(amount: 5000).amountZar, 50.0);
        expect(_gift(amount: 100).amountZar, 1.0);
        expect(_gift(amount: 0).amountZar, 0.0);
        expect(_gift(amount: 50).amountZar, 0.5);
      });
    });

    group('styleDisplayName', () {
      test('returns correct name for ndlovukazi', () {
        expect(_gift(style: GiftStyle.ndlovukazi).styleDisplayName, 'Ndlovukazi');
      });

      test('returns correct name for celebration', () {
        expect(_gift(style: GiftStyle.celebration).styleDisplayName, 'Celebration');
      });

      test('returns correct name for love', () {
        expect(_gift(style: GiftStyle.love).styleDisplayName, 'Love');
      });

      test('returns correct name for birthday', () {
        expect(_gift(style: GiftStyle.birthday).styleDisplayName, 'Birthday');
      });

      test('returns correct name for professional', () {
        expect(_gift(style: GiftStyle.professional).styleDisplayName, 'Professional');
      });
    });
  });

  group('GiftStats', () {
    test('creates with correct values', () {
      const stats = GiftStats(
        totalSent: 10,
        totalReceived: 5,
        totalAmountSent: 5000,
        totalAmountReceived: 2500,
      );

      expect(stats.totalSent, 10);
      expect(stats.totalReceived, 5);
      expect(stats.totalAmountSent, 5000);
      expect(stats.totalAmountReceived, 2500);
    });
  });
}
