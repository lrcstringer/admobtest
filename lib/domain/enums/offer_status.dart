enum OfferStatus {
  pending,
  accepted,
  declined,
  countered,
  expired,
  withdrawn,
}

extension OfferStatusX on OfferStatus {
  String get displayName {
    switch (this) {
      case OfferStatus.pending:
        return 'Pending';
      case OfferStatus.accepted:
        return 'Accepted';
      case OfferStatus.declined:
        return 'Declined';
      case OfferStatus.countered:
        return 'Countered';
      case OfferStatus.expired:
        return 'Expired';
      case OfferStatus.withdrawn:
        return 'Withdrawn';
    }
  }

  bool get isTerminal =>
      this == OfferStatus.accepted ||
      this == OfferStatus.declined ||
      this == OfferStatus.expired ||
      this == OfferStatus.withdrawn;

  bool get isActive =>
      this == OfferStatus.pending || this == OfferStatus.countered;
}
