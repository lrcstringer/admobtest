enum DeliveryMethod {
  collection,
  delivery,
  both,
}

extension DeliveryMethodX on DeliveryMethod {
  String get displayName {
    switch (this) {
      case DeliveryMethod.collection:
        return 'Collection';
      case DeliveryMethod.delivery:
        return 'Delivery';
      case DeliveryMethod.both:
        return 'Collection & Delivery';
    }
  }
}
