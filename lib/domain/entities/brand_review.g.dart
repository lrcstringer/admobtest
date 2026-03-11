// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrandReview _$BrandReviewFromJson(Map<String, dynamic> json) => _BrandReview(
  id: json['id'] as String,
  brandId: json['brandId'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  orderId: json['orderId'] as String,
  qualityRating: (json['qualityRating'] as num).toInt(),
  valueRating: (json['valueRating'] as num).toInt(),
  serviceRating: (json['serviceRating'] as num).toInt(),
  overallRating: (json['overallRating'] as num).toDouble(),
  comment: json['comment'] as String?,
  isFiltered: json['isFiltered'] as bool? ?? false,
  isRemovedByAdmin: json['isRemovedByAdmin'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$BrandReviewToJson(_BrandReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'userId': instance.userId,
      'userName': instance.userName,
      'orderId': instance.orderId,
      'qualityRating': instance.qualityRating,
      'valueRating': instance.valueRating,
      'serviceRating': instance.serviceRating,
      'overallRating': instance.overallRating,
      'comment': instance.comment,
      'isFiltered': instance.isFiltered,
      'isRemovedByAdmin': instance.isRemovedByAdmin,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
