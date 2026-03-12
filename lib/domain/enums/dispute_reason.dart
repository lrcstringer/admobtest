enum DisputeReason {
  notReceived,
  notAsDescribed,
  damaged,
  sellerUnresponsive,
  other,
}

extension DisputeReasonX on DisputeReason {
  String get displayName {
    switch (this) {
      case DisputeReason.notReceived:
        return 'Not Received';
      case DisputeReason.notAsDescribed:
        return 'Not as Described';
      case DisputeReason.damaged:
        return 'Damaged';
      case DisputeReason.sellerUnresponsive:
        return 'Seller Unresponsive';
      case DisputeReason.other:
        return 'Other';
    }
  }
}
