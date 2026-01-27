/// Status of a money chat card
enum ChatCardStatus {
  /// Card is pending action
  pending,

  /// Card has been paid/completed
  paid,

  /// Request was declined
  declined,

  /// Request expired (past due date)
  expired,

  /// Card was cancelled by sender
  cancelled,
}

extension ChatCardStatusX on ChatCardStatus {
  bool get isPending => this == ChatCardStatus.pending;
  bool get isComplete => this == ChatCardStatus.paid;
  bool get isFinal =>
      this == ChatCardStatus.paid ||
      this == ChatCardStatus.declined ||
      this == ChatCardStatus.expired ||
      this == ChatCardStatus.cancelled;

  String get displayName {
    switch (this) {
      case ChatCardStatus.pending:
        return 'Pending';
      case ChatCardStatus.paid:
        return 'Completed';
      case ChatCardStatus.declined:
        return 'Declined';
      case ChatCardStatus.expired:
        return 'Expired';
      case ChatCardStatus.cancelled:
        return 'Cancelled';
    }
  }
}
