/// Status of a marketplace provider
enum ProviderStatus {
  pending,
  approved,
  active,
  suspended,
  banned,
  deregisteredPending,
  deregistered,
}

extension ProviderStatusX on ProviderStatus {
  String get displayName {
    switch (this) {
      case ProviderStatus.pending:
        return 'Pending';
      case ProviderStatus.approved:
        return 'Approved';
      case ProviderStatus.active:
        return 'Active';
      case ProviderStatus.suspended:
        return 'Suspended';
      case ProviderStatus.banned:
        return 'Banned';
      case ProviderStatus.deregisteredPending:
        return 'De-registering';
      case ProviderStatus.deregistered:
        return 'De-registered';
    }
  }

  bool get isActive =>
      this == ProviderStatus.active || this == ProviderStatus.approved;

  /// Convert from string
  static ProviderStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return ProviderStatus.pending;
      case 'approved':
        return ProviderStatus.approved;
      case 'active':
        return ProviderStatus.active;
      case 'suspended':
        return ProviderStatus.suspended;
      case 'banned':
        return ProviderStatus.banned;
      case 'deregisteredPending':
        return ProviderStatus.deregisteredPending;
      case 'deregistered':
        return ProviderStatus.deregistered;
      case 'rejected': // legacy — treat as banned
        return ProviderStatus.banned;
      default:
        return ProviderStatus.active;
    }
  }
}
