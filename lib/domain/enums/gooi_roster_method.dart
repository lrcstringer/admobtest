/// How roster positions are determined in a Gooi-Gooi group.
enum GooiRosterMethod {
  agreed,
  random,
  bidding,
}

extension GooiRosterMethodX on GooiRosterMethod {
  String get displayName {
    switch (this) {
      case GooiRosterMethod.agreed:
        return 'Agreed';
      case GooiRosterMethod.random:
        return 'Random';
      case GooiRosterMethod.bidding:
        return 'Bidding';
    }
  }

  String get description {
    switch (this) {
      case GooiRosterMethod.agreed:
        return 'Members negotiate the order via chat, then the Initiator locks it.';
      case GooiRosterMethod.random:
        return 'Positions are randomly assigned when the roster is locked.';
      case GooiRosterMethod.bidding:
        return 'Members bid for earlier positions by accepting a smaller payout.';
    }
  }

  static GooiRosterMethod fromString(String value) {
    return GooiRosterMethod.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => GooiRosterMethod.agreed,
    );
  }
}
