import '../../domain/entities/featured_item.dart';
import '../models/featured_item_model.dart';

/// Mapper for converting between [FeaturedItemModel] and [FeaturedItem].
class FeaturedItemMapper {
  static FeaturedItem toEntity(FeaturedItemModel model) {
    return FeaturedItem(
      id: model.id,
      title: model.title,
      subtitle: model.subtitle,
      imageUrl: model.imageUrl,
      videoUrl: model.videoUrl,
      type: model.type,
      deepLinkRoute: model.deepLinkRoute,
      brandId: model.brandId,
      communityIds: model.communityIds,
      isActive: model.isActive,
      sortOrder: model.sortOrder,
      scheduledStart: model.scheduledStart,
      scheduledEnd: model.scheduledEnd,
      bgGradientType: model.bgGradientType,
      brandName: model.brandName,
      ctaText: model.ctaText,
      bgColorHex: model.bgColorHex,
      colorIntensity: model.colorIntensity,
      imageOpacity: model.imageOpacity,
      imageLayout: model.imageLayout,
      isDeleted: model.isDeleted,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static FeaturedItemModel fromEntity(FeaturedItem entity) {
    return FeaturedItemModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      imageUrl: entity.imageUrl,
      videoUrl: entity.videoUrl,
      type: entity.type,
      deepLinkRoute: entity.deepLinkRoute,
      brandId: entity.brandId,
      communityIds: entity.communityIds,
      isActive: entity.isActive,
      sortOrder: entity.sortOrder,
      scheduledStart: entity.scheduledStart,
      scheduledEnd: entity.scheduledEnd,
      bgGradientType: entity.bgGradientType,
      brandName: entity.brandName,
      ctaText: entity.ctaText,
      bgColorHex: entity.bgColorHex,
      colorIntensity: entity.colorIntensity,
      imageOpacity: entity.imageOpacity,
      imageLayout: entity.imageLayout,
      isDeleted: entity.isDeleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
