import '../../domain/entities/brand_product.dart';
import '../models/brand_product_model.dart';

/// Mapper for converting between [BrandProductModel] and [BrandProduct].
class BrandProductMapper {
  static BrandProduct toEntity(BrandProductModel model) {
    return BrandProduct(
      id: model.id,
      brandId: model.brandId,
      name: model.name,
      description: model.description,
      priceZar: model.priceZar,
      priceTokens: model.priceTokens,
      imageUrl: model.imageUrl,
      category: model.category,
      isActive: model.isActive,
      isFeatured: model.isFeatured,
      sortOrder: model.sortOrder,
      stockCount: model.stockCount,
      fulfilmentType: model.fulfilmentType,
      contactMethod: model.contactMethod,
      voucherInstructions: model.voucherInstructions,
      collectionAddress: model.collectionAddress,
      deliveryInfo: model.deliveryInfo,
      createdAt: model.createdAt,
    );
  }

  static BrandProductModel fromEntity(BrandProduct entity) {
    return BrandProductModel(
      id: entity.id,
      brandId: entity.brandId,
      name: entity.name,
      description: entity.description,
      priceZar: entity.priceZar,
      priceTokens: entity.priceTokens,
      imageUrl: entity.imageUrl,
      category: entity.category,
      isActive: entity.isActive,
      isFeatured: entity.isFeatured,
      sortOrder: entity.sortOrder,
      stockCount: entity.stockCount,
      fulfilmentType: entity.fulfilmentType,
      contactMethod: entity.contactMethod,
      voucherInstructions: entity.voucherInstructions,
      collectionAddress: entity.collectionAddress,
      deliveryInfo: entity.deliveryInfo,
      createdAt: entity.createdAt,
    );
  }
}
