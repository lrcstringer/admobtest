/// User account status
enum UserStatus {
  /// Account created but not verified
  pending,

  /// Account is active and verified
  active,

  /// Account is temporarily suspended
  suspended,

  /// Account is permanently banned
  banned,
}

extension UserStatusX on UserStatus {
  bool get isActive => this == UserStatus.active;
  bool get isSuspended => this == UserStatus.suspended;
  bool get isBanned => this == UserStatus.banned;
  bool get canUseApp => this == UserStatus.active;
}
