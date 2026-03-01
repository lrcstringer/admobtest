/// Lifecycle status of a token pool / collection room
enum PoolStatus {
  /// Active, accepting contributions
  collecting,

  /// (Sasaza only) Sent to recipient, awaiting open/claim
  sent,

  /// Payout distributed (save) or claimed (sasaza)
  completed,

  /// Organizer cancelled, refunds issued
  cancelled,

  /// Collection/claim period expired, refunds issued
  expired,
}

extension PoolStatusX on PoolStatus {
  String get displayName => switch (this) {
        PoolStatus.collecting => 'Collecting',
        PoolStatus.sent => 'Sent',
        PoolStatus.completed => 'Completed',
        PoolStatus.cancelled => 'Cancelled',
        PoolStatus.expired => 'Expired',
      };

  bool get isCollecting => this == PoolStatus.collecting;
  bool get isSent => this == PoolStatus.sent;
  bool get isCompleted => this == PoolStatus.completed;
  bool get isCancelled => this == PoolStatus.cancelled;
  bool get isExpired => this == PoolStatus.expired;

  /// Whether the pool is in a terminal state
  bool get isTerminal =>
      this == PoolStatus.completed ||
      this == PoolStatus.cancelled ||
      this == PoolStatus.expired;
}
