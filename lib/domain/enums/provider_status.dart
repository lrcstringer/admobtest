/// Status of a marketplace provider (Spec §8.25 — no approval queue)
enum ProviderStatus {
  active,
  suspended,
  banned,
}

extension ProviderStatusX on ProviderStatus {
  String get displayName {
    switch (this) {
      case ProviderStatus.active:
        return 'Active';
      case ProviderStatus.suspended:
        return 'Suspended';
      case ProviderStatus.banned:
        return 'Banned';
    }
  }

  bool get isActive => this == ProviderStatus.active;

  /// Convert from string with legacy mapping
  static ProviderStatus fromString(String value) {
    switch (value) {
      case 'active':
        return ProviderStatus.active;
      case 'approved': // legacy
        return ProviderStatus.active;
      case 'suspended':
        return ProviderStatus.suspended;
      case 'banned':
        return ProviderStatus.banned;
      case 'pending': // legacy — treat as active (instant registration)
        return ProviderStatus.active;
      case 'rejected': // legacy — treat as banned
        return ProviderStatus.banned;
      default:
        return ProviderStatus.active;
    }
  }
}
