enum SellerLevel {
  newSeller,
  active,
  trusted,
  star,
}

extension SellerLevelX on SellerLevel {
  String get displayName {
    switch (this) {
      case SellerLevel.newSeller:
        return 'New Seller';
      case SellerLevel.active:
        return 'Active Seller';
      case SellerLevel.trusted:
        return 'Trusted';
      case SellerLevel.star:
        return 'Star';
    }
  }

  int get sortOrder {
    switch (this) {
      case SellerLevel.newSeller:
        return 0;
      case SellerLevel.active:
        return 1;
      case SellerLevel.trusted:
        return 2;
      case SellerLevel.star:
        return 3;
    }
  }
}
