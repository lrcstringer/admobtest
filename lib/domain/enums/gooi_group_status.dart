/// Status of a Gooi-Gooi rotating savings group.
enum GooiGroupStatus {
  forming,
  active,
  completed,
  dissolved,
}

extension GooiGroupStatusX on GooiGroupStatus {
  String get displayName {
    switch (this) {
      case GooiGroupStatus.forming:
        return 'Forming';
      case GooiGroupStatus.active:
        return 'Active';
      case GooiGroupStatus.completed:
        return 'Completed';
      case GooiGroupStatus.dissolved:
        return 'Dissolved';
    }
  }

  bool get isJoinable => this == GooiGroupStatus.forming;

  bool get isTerminal =>
      this == GooiGroupStatus.completed || this == GooiGroupStatus.dissolved;

  static GooiGroupStatus fromString(String value) {
    return GooiGroupStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => GooiGroupStatus.forming,
    );
  }
}
