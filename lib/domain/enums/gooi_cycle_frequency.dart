/// How often Gooi-Gooi cycles occur.
enum GooiCycleFrequency {
  weekly,
  biweekly,
  monthly,
}

extension GooiCycleFrequencyX on GooiCycleFrequency {
  String get displayName {
    switch (this) {
      case GooiCycleFrequency.weekly:
        return 'Weekly';
      case GooiCycleFrequency.biweekly:
        return 'Bi-weekly';
      case GooiCycleFrequency.monthly:
        return 'Monthly';
    }
  }

  int get approximateDays {
    switch (this) {
      case GooiCycleFrequency.weekly:
        return 7;
      case GooiCycleFrequency.biweekly:
        return 14;
      case GooiCycleFrequency.monthly:
        return 30;
    }
  }

  static GooiCycleFrequency fromString(String value) {
    return GooiCycleFrequency.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => GooiCycleFrequency.monthly,
    );
  }
}
