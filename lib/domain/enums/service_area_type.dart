enum ServiceAreaType {
  myLocationOnly,
  deliverNearby,
  nationwide,
}

extension ServiceAreaTypeX on ServiceAreaType {
  String get displayName {
    switch (this) {
      case ServiceAreaType.myLocationOnly:
        return 'My Location Only';
      case ServiceAreaType.deliverNearby:
        return 'Deliver Nearby';
      case ServiceAreaType.nationwide:
        return 'Nationwide';
    }
  }
}
