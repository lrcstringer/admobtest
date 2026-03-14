import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/featured_item.dart';
import '../mappers/featured_item_mapper.dart';

part 'featured_item_model.freezed.dart';

@freezed
abstract class FeaturedItemModel with _$FeaturedItemModel {
  const factory FeaturedItemModel({
    required String id,
    required String title,
    String? subtitle,
    String? imageUrl,
    String? videoUrl,
    @Default('campaign') String type,
    String? deepLinkRoute,
    String? brandId,
    @Default([]) List<String> communityIds,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    @Default('goldOrange') String bgGradientType,
    String? brandName,
    String? ctaText,
    String? bgColorHex,
    @Default(0.4) double colorIntensity,
    @Default(1.0) double imageOpacity,
    @Default('right') String imageLayout,
    @Default(true) bool showTitle,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeaturedItemModel;

  const FeaturedItemModel._();

  factory FeaturedItemModel.fromJson(Map<String, dynamic> json) {
    return FeaturedItemModel(
      id: json['id'] as String? ?? (throw ArgumentError('FeaturedItemModel.fromJson: missing required field "id"')),
      title: json['title'] as String? ?? '[Untitled]',
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      type: json['type'] as String? ?? 'campaign',
      deepLinkRoute: json['deepLinkRoute'] as String?,
      brandId: json['brandId'] as String?,
      communityIds: (json['communityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isActive: json['isActive'] as bool? ?? true,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      scheduledStart: json['scheduledStart'] is Timestamp
          ? (json['scheduledStart'] as Timestamp).toDate()
          : json['scheduledStart'] is String
              ? DateTime.tryParse(json['scheduledStart'] as String)
              : null,
      scheduledEnd: json['scheduledEnd'] is Timestamp
          ? (json['scheduledEnd'] as Timestamp).toDate()
          : json['scheduledEnd'] is String
              ? DateTime.tryParse(json['scheduledEnd'] as String)
              : null,
      bgGradientType: json['bgGradientType'] as String? ?? 'goldOrange',
      brandName: json['brandName'] as String?,
      ctaText: json['ctaText'] as String?,
      bgColorHex: json['bgColorHex'] as String?,
      colorIntensity: (json['colorIntensity'] as num?)?.toDouble() ?? 0.4,
      // Legacy field migration: 'opacity' -> 'imageOpacity'
      imageOpacity: (json['imageOpacity'] as num?)?.toDouble()
          ?? (json['opacity'] as num?)?.toDouble()
          ?? 1.0,
      imageLayout: json['imageLayout'] as String? ?? 'right',
      showTitle: json['showTitle'] as bool? ?? true,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : json['createdAt'] is String
              ? DateTime.tryParse(json['createdAt'] as String)
              : null,
      updatedAt: json['updatedAt'] is Timestamp
          ? (json['updatedAt'] as Timestamp).toDate()
          : json['updatedAt'] is String
              ? DateTime.tryParse(json['updatedAt'] as String)
              : null,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      'type': type,
      if (deepLinkRoute != null) 'deepLinkRoute': deepLinkRoute,
      if (brandId != null) 'brandId': brandId,
      'communityIds': communityIds,
      'isActive': isActive,
      'sortOrder': sortOrder,
      if (scheduledStart != null)
        'scheduledStart': Timestamp.fromDate(scheduledStart!),
      if (scheduledEnd != null)
        'scheduledEnd': Timestamp.fromDate(scheduledEnd!),
      'bgGradientType': bgGradientType,
      if (brandName != null) 'brandName': brandName,
      if (ctaText != null) 'ctaText': ctaText,
      if (bgColorHex != null) 'bgColorHex': bgColorHex,
      'colorIntensity': colorIntensity,
      'imageOpacity': imageOpacity,
      'imageLayout': imageLayout,
      'showTitle': showTitle,
      'isDeleted': isDeleted,
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  FeaturedItem toEntity() => FeaturedItemMapper.toEntity(this);

  factory FeaturedItemModel.fromEntity(FeaturedItem entity) =>
      FeaturedItemMapper.fromEntity(entity);
}
