enum DeliveredVia {
  inPerson,
  courier,
  leftAtLocation,
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
    }
  }
}
