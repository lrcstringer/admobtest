/// Status of a Gooi-Gooi cycle.
enum GooiCycleStatus {
  pending,
  collecting,
  awaitingTrigger,
  payoutProcessing,
  complete,
  defaulted,
  payoutFailed,
}

extension GooiCycleStatusX on GooiCycleStatus {
  String get displayName {
    switch (this) {
      case GooiCycleStatus.pending:
        return 'Pending';
      case GooiCycleStatus.collecting:
        return 'Collecting';
      case GooiCycleStatus.awaitingTrigger:
        return 'Awaiting Trigger';
      case GooiCycleStatus.payoutProcessing:
        return 'Processing Payout';
      case GooiCycleStatus.complete:
        return 'Complete';
      case GooiCycleStatus.defaulted:
        return 'Defaulted';
      case GooiCycleStatus.payoutFailed:
        return 'Payout Failed';
    }
  }

  bool get isActive =>
      this == GooiCycleStatus.collecting ||
      this == GooiCycleStatus.awaitingTrigger;

  bool get isTerminal =>
      this == GooiCycleStatus.complete ||
      this == GooiCycleStatus.defaulted;

  static GooiCycleStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':
        return GooiCycleStatus.pending;
      case 'COLLECTING':
        return GooiCycleStatus.collecting;
      case 'AWAITING_TRIGGER':
        return GooiCycleStatus.awaitingTrigger;
      case 'PAYOUT_PROCESSING':
        return GooiCycleStatus.payoutProcessing;
      case 'COMPLETE':
        return GooiCycleStatus.complete;
      case 'DEFAULTED':
        return GooiCycleStatus.defaulted;
      case 'PAYOUT_FAILED':
        return GooiCycleStatus.payoutFailed;
      default:
        return GooiCycleStatus.pending;
    }
  }
}
