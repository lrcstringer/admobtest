import '../../domain/entities/brand_review.dart';
import '../models/brand_review_model.dart';

/// Mapper for converting between [BrandReviewModel] and [BrandReview].
class BrandReviewMapper {
  static BrandReview toEntity(BrandReviewModel model) {
    return BrandReview(
      id: model.id,
      brandId: model.brandId,
      userId: model.userId,
      userName: model.userName,
      orderId: model.orderId,
      qualityRating: model.qualityRating,
      valueRating: model.valueRating,
      serviceRating: model.serviceRating,
      overallRating: model.overallRating,
      comment: model.comment,
      isFiltered: model.isFiltered,
      isRemovedByAdmin: model.isRemovedByAdmin,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static BrandReviewModel fromEntity(BrandReview entity) {
    return BrandReviewModel(
      id: entity.id,
      brandId: entity.brandId,
      userId: entity.userId,
      userName: entity.userName,
      orderId: entity.orderId,
      qualityRating: entity.qualityRating,
      valueRating: entity.valueRating,
      serviceRating: entity.serviceRating,
      overallRating: entity.overallRating,
      comment: entity.comment,
      isFiltered: entity.isFiltered,
      isRemovedByAdmin: entity.isRemovedByAdmin,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
