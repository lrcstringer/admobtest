import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_product.freezed.dart';

enum FulfilmentType { digital, physical, catalog }

@freezed
abstract class BrandProduct with _$BrandProduct {
  const factory BrandProduct({
    required String id,
    required String brandId,
    required String name,
    String? description,
    required double priceZar,
    required int priceTokens,
    String? imageUrl,
    String? category,
    @Default(true) bool isActive,
    @Default(false) bool isFeatured,
    @Default(0) int sortOrder,

    /// null = unlimited stock
    int? stockCount,
    required FulfilmentType fulfilmentType,

    /// For catalog items — WhatsApp link, email, etc.
    String? contactMethod,

    /// For digital items — what user receives after purchase
    String? voucherInstructions,

    /// For physical items — store address if collection
    String? collectionAddress,

    /// For physical items — delivery terms/timeframes
    String? deliveryInfo,

    required DateTime createdAt,
  }) = _BrandProduct;

  const BrandProduct._();


  bool get isInStock => stockCount == null || stockCount! > 0;
}
