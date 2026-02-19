/// Lifecycle status of an iMali gift.
enum GiftStatus {
  pending,
  opened,
  claimed,
  expired;

  String get displayName {
    switch (this) {
      case GiftStatus.pending:
        return 'Pending';
      case GiftStatus.opened:
        return 'Opened';
      case GiftStatus.claimed:
        return 'Claimed';
      case GiftStatus.expired:
        return 'Expired';
    }
  }
}
