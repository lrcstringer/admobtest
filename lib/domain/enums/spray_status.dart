/// Lifecycle status of a community token spray.
enum SprayStatus {
  active,
  closed,
  claimed,
  expired;

  String get displayName {
    switch (this) {
      case SprayStatus.active:
        return 'Active';
      case SprayStatus.closed:
        return 'Closed';
      case SprayStatus.claimed:
        return 'Claimed';
      case SprayStatus.expired:
        return 'Expired';
    }
  }
}
