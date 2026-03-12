/// How an order was physically delivered to the buyer (Spec §8.25).
enum DeliveredVia {
  inPerson,
  courier,
  leftAtLocation,
  digital,
}

extension DeliveredViaX on DeliveredVia {
  String get displayName {
    switch (this) {
      case DeliveredVia.inPerson:
        return 'In Person';
      case DeliveredVia.courier:
        return 'Courier';
      case DeliveredVia.leftAtLocation:
        return 'Left at Location';
      case DeliveredVia.digital:
        return 'Digital';
    }
  }

  static DeliveredVia fromString(String value) {
    return DeliveredVia.values.firstWhere(
      (e) => e.name == value,
      orElse: () => DeliveredVia.inPerson,
    );
  }
}
