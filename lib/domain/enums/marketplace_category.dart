/// Categories for Intengiso Marketplace listings (Spec §8.25 — 8-category system)
enum MarketplaceCategory {
  foodAndDrinks,
  beautyAndWellness,
  homeAndProperty,
  clothingAndFashion,
  fixAndRepair,
  movingAndDelivery,
  kidsPetsAndCare,
  everythingElse,
}

extension MarketplaceCategoryX on MarketplaceCategory {
  String get displayName {
    switch (this) {
      case MarketplaceCategory.foodAndDrinks:
        return 'Food & Drinks';
      case MarketplaceCategory.beautyAndWellness:
        return 'Beauty & Wellness';
      case MarketplaceCategory.homeAndProperty:
        return 'Home & Property';
      case MarketplaceCategory.clothingAndFashion:
        return 'Clothing & Fashion';
      case MarketplaceCategory.fixAndRepair:
        return 'Fix & Repair';
      case MarketplaceCategory.movingAndDelivery:
        return 'Moving & Delivery';
      case MarketplaceCategory.kidsPetsAndCare:
        return 'Kids, Pets & Care';
      case MarketplaceCategory.everythingElse:
        return 'Everything Else';
    }
  }

  String get emoji {
    switch (this) {
      case MarketplaceCategory.foodAndDrinks:
        return '🍲';
      case MarketplaceCategory.beautyAndWellness:
        return '💅';
      case MarketplaceCategory.homeAndProperty:
        return '🏠';
      case MarketplaceCategory.clothingAndFashion:
        return '👗';
      case MarketplaceCategory.fixAndRepair:
        return '🔧';
      case MarketplaceCategory.movingAndDelivery:
        return '🚚';
      case MarketplaceCategory.kidsPetsAndCare:
        return '👶';
      case MarketplaceCategory.everythingElse:
        return '📦';
    }
  }

  /// Convert from string (Firestore/JSON) to enum, with fallback
  static MarketplaceCategory fromString(String value) {
    switch (value) {
      case 'foodAndDrinks':
        return MarketplaceCategory.foodAndDrinks;
      case 'beautyAndWellness':
        return MarketplaceCategory.beautyAndWellness;
      case 'homeAndProperty':
        return MarketplaceCategory.homeAndProperty;
      case 'clothingAndFashion':
        return MarketplaceCategory.clothingAndFashion;
      case 'fixAndRepair':
        return MarketplaceCategory.fixAndRepair;
      case 'movingAndDelivery':
        return MarketplaceCategory.movingAndDelivery;
      case 'kidsPetsAndCare':
        return MarketplaceCategory.kidsPetsAndCare;
      // Legacy migration mappings
      case 'services':
        return MarketplaceCategory.fixAndRepair;
      case 'goods':
        return MarketplaceCategory.everythingElse;
      case 'food':
        return MarketplaceCategory.foodAndDrinks;
      case 'gigs':
        return MarketplaceCategory.fixAndRepair;
      case 'groupBuys':
        return MarketplaceCategory.everythingElse;
      default:
        return MarketplaceCategory.everythingElse;
    }
  }
}
