/// Status of a marketplace provider
enum ProviderStatus {
  pending,
  approved,
  suspended,
  rejected,
}

extension ProviderStatusX on ProviderStatus {
  String get displayName {
    switch (this) {
      case ProviderStatus.pending:
        return 'Pending';
      case ProviderStatus.approved:
        return 'Approved';
      case ProviderStatus.suspended:
        return 'Suspended';
      case ProviderStatus.rejected:
        return 'Rejected';
    }
  }

  bool get isActive => this == ProviderStatus.approved;
}
