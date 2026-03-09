/// Categories for Intengiso Marketplace listings
enum MarketplaceCategory {
  services,
  goods,
  food,
  gigs,
  groupBuys,
}

extension MarketplaceCategoryX on MarketplaceCategory {
  String get displayName {
    switch (this) {
      case MarketplaceCategory.services:
        return 'Services';
      case MarketplaceCategory.goods:
        return 'Goods';
      case MarketplaceCategory.food:
        return 'Food';
      case MarketplaceCategory.gigs:
        return 'Gigs';
      case MarketplaceCategory.groupBuys:
        return 'Group Buys';
    }
  }

  String get emoji {
    switch (this) {
      case MarketplaceCategory.services:
        return '🔧';
      case MarketplaceCategory.goods:
        return '📦';
      case MarketplaceCategory.food:
        return '🍲';
      case MarketplaceCategory.gigs:
        return '💼';
      case MarketplaceCategory.groupBuys:
        return '🤝';
    }
  }
}
