/// Status of a Gooi-Gooi contribution.
enum GooiContributionStatus {
  pending,
  paid,
  late_,
  missed,
}

extension GooiContributionStatusX on GooiContributionStatus {
  String get displayName {
    switch (this) {
      case GooiContributionStatus.pending:
        return 'Pending';
      case GooiContributionStatus.paid:
        return 'Paid';
      case GooiContributionStatus.late_:
        return 'Late';
      case GooiContributionStatus.missed:
        return 'Missed';
    }
  }

  bool get isOutstanding =>
      this == GooiContributionStatus.pending ||
      this == GooiContributionStatus.late_;

  static GooiContributionStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PAID':
        return GooiContributionStatus.paid;
      case 'LATE':
        return GooiContributionStatus.late_;
      case 'MISSED':
        return GooiContributionStatus.missed;
      default:
        return GooiContributionStatus.pending;
    }
  }
}
