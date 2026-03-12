/// Status of a marketplace listing (Spec §8.25)
enum ListingStatus {
  pending,
  active,
  paused,
  expired,
  flagged,
  removed,
  sold,
}

extension ListingStatusX on ListingStatus {
  String get displayName {
    switch (this) {
      case ListingStatus.pending:
        return 'Pending';
      case ListingStatus.active:
        return 'Active';
      case ListingStatus.paused:
        return 'Paused';
      case ListingStatus.expired:
        return 'Expired';
      case ListingStatus.flagged:
        return 'Flagged';
      case ListingStatus.removed:
        return 'Removed';
      case ListingStatus.sold:
        return 'Sold';
    }
  }

  bool get isVisible => this == ListingStatus.active;

  bool get isTerminal =>
      this == ListingStatus.removed || this == ListingStatus.sold;

  /// Convert from string with legacy mapping
  static ListingStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return ListingStatus.pending;
      case 'active':
        return ListingStatus.active;
      case 'paused':
        return ListingStatus.paused;
      case 'expired':
        return ListingStatus.expired;
      case 'flagged':
        return ListingStatus.flagged;
      case 'removed':
        return ListingStatus.removed;
      case 'sold':
        return ListingStatus.sold;
      case 'soldOut': // legacy
        return ListingStatus.sold;
      default:
        return ListingStatus.active;
    }
  }
}
