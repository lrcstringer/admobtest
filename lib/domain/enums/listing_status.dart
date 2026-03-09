/// Status of a marketplace listing
enum ListingStatus {
  active,
  flagged,
  removed,
  soldOut,
  expired,
}

extension ListingStatusX on ListingStatus {
  String get displayName {
    switch (this) {
      case ListingStatus.active:
        return 'Active';
      case ListingStatus.flagged:
        return 'Flagged';
      case ListingStatus.removed:
        return 'Removed';
      case ListingStatus.soldOut:
        return 'Sold Out';
      case ListingStatus.expired:
        return 'Expired';
    }
  }

  bool get isVisible => this == ListingStatus.active;
}
