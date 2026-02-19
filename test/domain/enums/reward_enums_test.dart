import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/enums/reward_enums.dart';

void main() {
  // ---------------------------------------------------------------------------
  // RewardType
  // ---------------------------------------------------------------------------
  group('RewardType', () {
    group('displayName', () {
      test('returns correct name for each type', () {
        expect(RewardType.qrCode.displayName, 'QR Code');
        expect(RewardType.voucherCode.displayName, 'Voucher Code');
        expect(RewardType.discountCode.displayName, 'Discount Code');
        expect(RewardType.digitalContent.displayName, 'Digital Content');
      });
    });

    group('isQrType', () {
      test('returns true only for qrCode', () {
        expect(RewardType.qrCode.isQrType, isTrue);
      });

      test('returns false for non-QR types', () {
        expect(RewardType.voucherCode.isQrType, isFalse);
        expect(RewardType.discountCode.isQrType, isFalse);
        expect(RewardType.digitalContent.isQrType, isFalse);
      });
    });

    group('firestoreValue', () {
      test('returns snake_case string for each type', () {
        expect(RewardType.qrCode.firestoreValue, 'qr_code');
        expect(RewardType.voucherCode.firestoreValue, 'voucher_code');
        expect(RewardType.discountCode.firestoreValue, 'discount_code');
        expect(RewardType.digitalContent.firestoreValue, 'digital_content');
      });
    });

    group('fromString', () {
      test('parses camelCase values', () {
        expect(RewardTypeX.fromString('qrCode'), RewardType.qrCode);
        expect(RewardTypeX.fromString('voucherCode'), RewardType.voucherCode);
        expect(RewardTypeX.fromString('discountCode'), RewardType.discountCode);
        expect(
            RewardTypeX.fromString('digitalContent'), RewardType.digitalContent);
      });

      test('parses snake_case values', () {
        expect(RewardTypeX.fromString('qr_code'), RewardType.qrCode);
        expect(RewardTypeX.fromString('voucher_code'), RewardType.voucherCode);
        expect(
            RewardTypeX.fromString('discount_code'), RewardType.discountCode);
        expect(RewardTypeX.fromString('digital_content'),
            RewardType.digitalContent);
      });

      test('defaults to voucherCode for unknown value', () {
        expect(RewardTypeX.fromString('unknown'), RewardType.voucherCode);
        expect(RewardTypeX.fromString(''), RewardType.voucherCode);
        expect(RewardTypeX.fromString('QRCODE'), RewardType.voucherCode);
      });
    });
  });

  // ---------------------------------------------------------------------------
  // CampaignStatus
  // ---------------------------------------------------------------------------
  group('CampaignStatus', () {
    group('displayName', () {
      test('returns correct name for each status', () {
        expect(CampaignStatus.draft.displayName, 'Draft');
        expect(CampaignStatus.active.displayName, 'Active');
        expect(CampaignStatus.paused.displayName, 'Paused');
        expect(CampaignStatus.exhausted.displayName, 'Exhausted');
        expect(CampaignStatus.expired.displayName, 'Expired');
        expect(CampaignStatus.cancelled.displayName, 'Cancelled');
      });
    });

    group('isActive', () {
      test('returns true only for active', () {
        expect(CampaignStatus.active.isActive, isTrue);
      });

      test('returns false for all non-active statuses', () {
        expect(CampaignStatus.draft.isActive, isFalse);
        expect(CampaignStatus.paused.isActive, isFalse);
        expect(CampaignStatus.exhausted.isActive, isFalse);
        expect(CampaignStatus.expired.isActive, isFalse);
        expect(CampaignStatus.cancelled.isActive, isFalse);
      });
    });

    group('isTerminal', () {
      test('returns true for exhausted, expired, and cancelled', () {
        expect(CampaignStatus.exhausted.isTerminal, isTrue);
        expect(CampaignStatus.expired.isTerminal, isTrue);
        expect(CampaignStatus.cancelled.isTerminal, isTrue);
      });

      test('returns false for draft, active, and paused', () {
        expect(CampaignStatus.draft.isTerminal, isFalse);
        expect(CampaignStatus.active.isTerminal, isFalse);
        expect(CampaignStatus.paused.isTerminal, isFalse);
      });
    });

    group('fromString', () {
      test('parses all known values', () {
        expect(CampaignStatusX.fromString('draft'), CampaignStatus.draft);
        expect(CampaignStatusX.fromString('active'), CampaignStatus.active);
        expect(CampaignStatusX.fromString('paused'), CampaignStatus.paused);
        expect(
            CampaignStatusX.fromString('exhausted'), CampaignStatus.exhausted);
        expect(CampaignStatusX.fromString('expired'), CampaignStatus.expired);
        expect(
            CampaignStatusX.fromString('cancelled'), CampaignStatus.cancelled);
      });

      test('defaults to draft for unknown value', () {
        expect(CampaignStatusX.fromString('unknown'), CampaignStatus.draft);
        expect(CampaignStatusX.fromString(''), CampaignStatus.draft);
        expect(CampaignStatusX.fromString('Active'), CampaignStatus.draft);
      });
    });
  });

  // ---------------------------------------------------------------------------
  // RewardItemStatus
  // ---------------------------------------------------------------------------
  group('RewardItemStatus', () {
    group('displayName', () {
      test('returns correct name for each status', () {
        expect(RewardItemStatus.available.displayName, 'Available');
        expect(RewardItemStatus.allocated.displayName, 'Active');
        expect(RewardItemStatus.redeemed.displayName, 'Redeemed');
        expect(RewardItemStatus.expired.displayName, 'Expired');
        expect(RewardItemStatus.revoked.displayName, 'Revoked');
      });

      test('allocated displays as Active (not Allocated)', () {
        expect(RewardItemStatus.allocated.displayName, isNot('Allocated'));
        expect(RewardItemStatus.allocated.displayName, 'Active');
      });
    });

    group('isUsable', () {
      test('returns true only for allocated', () {
        expect(RewardItemStatus.allocated.isUsable, isTrue);
      });

      test('returns false for all non-allocated statuses', () {
        expect(RewardItemStatus.available.isUsable, isFalse);
        expect(RewardItemStatus.redeemed.isUsable, isFalse);
        expect(RewardItemStatus.expired.isUsable, isFalse);
        expect(RewardItemStatus.revoked.isUsable, isFalse);
      });
    });

    group('isTerminal', () {
      test('returns true for redeemed, expired, and revoked', () {
        expect(RewardItemStatus.redeemed.isTerminal, isTrue);
        expect(RewardItemStatus.expired.isTerminal, isTrue);
        expect(RewardItemStatus.revoked.isTerminal, isTrue);
      });

      test('returns false for available and allocated', () {
        expect(RewardItemStatus.available.isTerminal, isFalse);
        expect(RewardItemStatus.allocated.isTerminal, isFalse);
      });
    });

    group('fromString', () {
      test('parses all known values', () {
        expect(RewardItemStatusX.fromString('available'),
            RewardItemStatus.available);
        expect(RewardItemStatusX.fromString('allocated'),
            RewardItemStatus.allocated);
        expect(RewardItemStatusX.fromString('redeemed'),
            RewardItemStatus.redeemed);
        expect(
            RewardItemStatusX.fromString('expired'), RewardItemStatus.expired);
        expect(
            RewardItemStatusX.fromString('revoked'), RewardItemStatus.revoked);
      });

      test('defaults to available for unknown value', () {
        expect(
            RewardItemStatusX.fromString('unknown'), RewardItemStatus.available);
        expect(RewardItemStatusX.fromString(''), RewardItemStatus.available);
        expect(RewardItemStatusX.fromString('Allocated'),
            RewardItemStatus.available);
      });
    });
  });
}
