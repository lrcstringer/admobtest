/// Status of a Gooi-Gooi payout.
enum GooiPayoutStatus {
  pending,
  triggered,
  processing,
  completed,
  failed,
}

extension GooiPayoutStatusX on GooiPayoutStatus {
  String get displayName {
    switch (this) {
      case GooiPayoutStatus.pending:
        return 'Pending';
      case GooiPayoutStatus.triggered:
        return 'Triggered';
      case GooiPayoutStatus.processing:
        return 'Processing';
      case GooiPayoutStatus.completed:
        return 'Completed';
      case GooiPayoutStatus.failed:
        return 'Failed';
    }
  }

  static GooiPayoutStatus fromString(String value) {
    return GooiPayoutStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => GooiPayoutStatus.pending,
    );
  }
}
