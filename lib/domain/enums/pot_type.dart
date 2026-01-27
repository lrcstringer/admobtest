/// Type of prize pot
enum PotType {
  /// Daily pot (resets every day at 8pm SAST)
  daily,

  /// Weekly pot (resets every Sunday at 8pm SAST)
  weekly,
}

extension PotTypeX on PotType {
  bool get isDaily => this == PotType.daily;
  bool get isWeekly => this == PotType.weekly;

  String get displayName {
    switch (this) {
      case PotType.daily:
        return 'Daily Pot';
      case PotType.weekly:
        return 'Weekly Pot';
    }
  }

  int get topWinners {
    switch (this) {
      case PotType.daily:
        return 5;
      case PotType.weekly:
        return 10;
    }
  }
}
