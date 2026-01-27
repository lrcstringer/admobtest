/// Status of a cashout request
enum CashoutStatus {
  /// Cashout request submitted
  pending,

  /// On hold (e.g., first-time cashout 48h hold)
  onHold,

  /// Being processed by G-PAY
  processing,

  /// Successfully completed
  completed,

  /// Failed to process
  failed,

  /// Cancelled by user or system
  cancelled,
}

extension CashoutStatusX on CashoutStatus {
  bool get isPending =>
      this == CashoutStatus.pending || this == CashoutStatus.onHold;
  bool get isProcessing => this == CashoutStatus.processing;
  bool get isComplete => this == CashoutStatus.completed;
  bool get isFailed => this == CashoutStatus.failed;

  String get displayName {
    switch (this) {
      case CashoutStatus.pending:
        return 'Pending';
      case CashoutStatus.onHold:
        return 'On Hold';
      case CashoutStatus.processing:
        return 'Processing';
      case CashoutStatus.completed:
        return 'Completed';
      case CashoutStatus.failed:
        return 'Failed';
      case CashoutStatus.cancelled:
        return 'Cancelled';
    }
  }
}
