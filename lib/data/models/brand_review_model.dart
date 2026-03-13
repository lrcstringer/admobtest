import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/brand_review.dart';

part 'brand_review_model.freezed.dart';

@freezed
class BrandReviewModel with _$BrandReviewModel {
  const factory BrandReviewModel({
    required String id,
    required String brandId,
    required String userId,
    required String userName,
    required String orderId,
    required int qualityRating,
    required int valueRating,
    required int serviceRating,
    required double overallRating,
    String? comment,
    @Default(false) bool isFiltered,
    @Default(false) bool isRemovedByAdmin,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _BrandReviewModel;

  const BrandReviewModel._();

  /// Whether all three rating dimensions have been provided (non-zero)
  bool get hasAllRatings =>
      qualityRating > 0 && valueRating > 0 && serviceRating > 0;

  factory BrandReviewModel.fromJson(Map<String, dynamic> json) {
    return BrandReviewModel(
      id: json['id'] as String? ?? '',
      brandId: json['brandId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      orderId: json['orderId'] as String? ?? '',
      qualityRating: ((json['qualityRating'] as num?)?.toInt() ?? 1).clamp(1, 5),
      valueRating: ((json['valueRating'] as num?)?.toInt() ?? 1).clamp(1, 5),
      serviceRating: ((json['serviceRating'] as num?)?.toInt() ?? 1).clamp(1, 5),
      overallRating: ((json['overallRating'] as num?)?.toDouble() ?? 1.0).clamp(1.0, 5.0),
      comment: json['comment'] as String?,
      isFiltered: json['isFiltered'] as bool? ?? false,
      isRemovedByAdmin: json['isRemovedByAdmin'] as bool? ?? false,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: json['updatedAt'] is Timestamp
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'brandId': brandId,
      'userId': userId,
      'userName': userName,
      'orderId': orderId,
      'qualityRating': qualityRating,
      'valueRating': valueRating,
      'serviceRating': serviceRating,
      'overallRating': overallRating,
      if (comment != null) 'comment': comment,
      'isFiltered': isFiltered,
      'isRemovedByAdmin': isRemovedByAdmin,
      'createdAt': Timestamp.fromDate(createdAt),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  BrandReview toEntity() {
    return BrandReview(
      id: id,
      brandId: brandId,
      userId: userId,
      userName: userName,
      orderId: orderId,
      qualityRating: qualityRating,
      valueRating: valueRating,
      serviceRating: serviceRating,
      overallRating: overallRating,
      comment: comment,
      isFiltered: isFiltered,
      isRemovedByAdmin: isRemovedByAdmin,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory BrandReviewModel.fromEntity(BrandReview entity) {
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
