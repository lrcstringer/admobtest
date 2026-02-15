/// Type of reward in a campaign
enum RewardType {
  qrCode,
  voucherCode,
  discountCode,
  digitalContent,
}

extension RewardTypeX on RewardType {
  String get displayName {
    switch (this) {
      case RewardType.qrCode:
        return 'QR Code';
      case RewardType.voucherCode:
        return 'Voucher Code';
      case RewardType.discountCode:
        return 'Discount Code';
      case RewardType.digitalContent:
        return 'Digital Content';
    }
  }

  /// Whether this reward type has a scannable/copyable code
  bool get hasCode => true;

  /// Whether this reward type should display a QR code
  bool get isQrType => this == RewardType.qrCode;

  /// Parse from Firestore snake_case string
  static RewardType fromString(String value) {
    switch (value) {
      case 'qr_code':
      case 'qrCode':
        return RewardType.qrCode;
      case 'voucher_code':
      case 'voucherCode':
        return RewardType.voucherCode;
      case 'discount_code':
      case 'discountCode':
        return RewardType.discountCode;
      case 'digital_content':
      case 'digitalContent':
        return RewardType.digitalContent;
      default:
        assert(() {
          // ignore: avoid_print
          print('[RewardType] Unrecognized value "$value", defaulting to voucherCode');
          return true;
        }());
        return RewardType.voucherCode;
    }
  }

  /// Convert to Firestore snake_case string
  String get firestoreValue {
    switch (this) {
      case RewardType.qrCode:
        return 'qr_code';
      case RewardType.voucherCode:
        return 'voucher_code';
      case RewardType.discountCode:
        return 'discount_code';
      case RewardType.digitalContent:
        return 'digital_content';
    }
  }
}

/// Status of a reward campaign
enum CampaignStatus {
  draft,
  active,
  paused,
  exhausted,
  expired,
  cancelled,
}

extension CampaignStatusX on CampaignStatus {
  String get displayName {
    switch (this) {
      case CampaignStatus.draft:
        return 'Draft';
      case CampaignStatus.active:
        return 'Active';
      case CampaignStatus.paused:
        return 'Paused';
      case CampaignStatus.exhausted:
        return 'Exhausted';
      case CampaignStatus.expired:
        return 'Expired';
      case CampaignStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive => this == CampaignStatus.active;
  bool get isTerminal =>
      this == CampaignStatus.exhausted ||
      this == CampaignStatus.expired ||
      this == CampaignStatus.cancelled;

  static CampaignStatus fromString(String value) {
    switch (value) {
      case 'draft':
        return CampaignStatus.draft;
      case 'active':
        return CampaignStatus.active;
      case 'paused':
        return CampaignStatus.paused;
      case 'exhausted':
        return CampaignStatus.exhausted;
      case 'expired':
        return CampaignStatus.expired;
      case 'cancelled':
        return CampaignStatus.cancelled;
      default:
        return CampaignStatus.draft;
    }
  }
}

/// Status of a reward item
enum RewardItemStatus {
  available,
  allocated,
  redeemed,
  expired,
  revoked,
}

extension RewardItemStatusX on RewardItemStatus {
  String get displayName {
    switch (this) {
      case RewardItemStatus.available:
        return 'Available';
      case RewardItemStatus.allocated:
        return 'Active';
      case RewardItemStatus.redeemed:
        return 'Redeemed';
      case RewardItemStatus.expired:
        return 'Expired';
      case RewardItemStatus.revoked:
        return 'Revoked';
    }
  }

  bool get isUsable => this == RewardItemStatus.allocated;
  bool get isTerminal =>
      this == RewardItemStatus.redeemed ||
      this == RewardItemStatus.expired ||
      this == RewardItemStatus.revoked;

  static RewardItemStatus fromString(String value) {
    switch (value) {
      case 'available':
        return RewardItemStatus.available;
      case 'allocated':
        return RewardItemStatus.allocated;
      case 'redeemed':
        return RewardItemStatus.redeemed;
      case 'expired':
        return RewardItemStatus.expired;
      case 'revoked':
        return RewardItemStatus.revoked;
      default:
        assert(() {
          // ignore: avoid_print
          print('[RewardItemStatus] Unrecognized value "$value", defaulting to available');
          return true;
        }());
        return RewardItemStatus.available;
    }
  }
}
