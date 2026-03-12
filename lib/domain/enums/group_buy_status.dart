/// Status of a group buy (Hlangana deal)
enum GroupBuyStatus {
  open,
  targetMet,
  expired,
  completed,
  cancelling,
  cancelled,
}

extension GroupBuyStatusX on GroupBuyStatus {
  String get displayName {
    switch (this) {
      case GroupBuyStatus.open:
        return 'Open';
      case GroupBuyStatus.targetMet:
        return 'Target Met';
      case GroupBuyStatus.expired:
        return 'Expired';
      case GroupBuyStatus.completed:
        return 'Completed';
      case GroupBuyStatus.cancelling:
        return 'Cancelling';
      case GroupBuyStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive =>
      this == GroupBuyStatus.open || this == GroupBuyStatus.targetMet;

  bool get isTerminal =>
      this == GroupBuyStatus.expired ||
      this == GroupBuyStatus.completed ||
      this == GroupBuyStatus.cancelling ||
      this == GroupBuyStatus.cancelled;

  bool get isJoinable => this == GroupBuyStatus.open;
}
