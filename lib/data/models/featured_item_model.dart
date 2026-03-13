import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/featured_item.dart';

part 'featured_item_model.freezed.dart';

@freezed
class FeaturedItemModel with _$FeaturedItemModel {
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
    @Default(false) bool isDeleted,
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
      imageOpacity: (json['imageOpacity'] as num?)?.toDouble()
          ?? (json['opacity'] as num?)?.toDouble()
          ?? 1.0,
      imageLayout: json['imageLayout'] as String? ?? 'right',
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'type': type,
      'deepLinkRoute': deepLinkRoute,
      'brandId': brandId,
      'communityIds': communityIds,
      'isActive': isActive,
      'sortOrder': sortOrder,
      if (scheduledStart != null)
        'scheduledStart': Timestamp.fromDate(scheduledStart!),
      if (scheduledEnd != null)
        'scheduledEnd': Timestamp.fromDate(scheduledEnd!),
      'bgGradientType': bgGradientType,
      'brandName': brandName,
      'ctaText': ctaText,
      'bgColorHex': bgColorHex,
      'colorIntensity': colorIntensity,
      'imageOpacity': imageOpacity,
      'imageLayout': imageLayout,
      'isDeleted': isDeleted,
    };
  }

  FeaturedItem toEntity() {
    return FeaturedItem(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      type: type,
      deepLinkRoute: deepLinkRoute,
      brandId: brandId,
      communityIds: communityIds,
      isActive: isActive,
      sortOrder: sortOrder,
      scheduledStart: scheduledStart,
      scheduledEnd: scheduledEnd,
      bgGradientType: bgGradientType,
      brandName: brandName,
      ctaText: ctaText,
      bgColorHex: bgColorHex,
      colorIntensity: colorIntensity,
      imageOpacity: imageOpacity,
      imageLayout: imageLayout,
      isDeleted: isDeleted,
    );
  }

  factory FeaturedItemModel.fromEntity(FeaturedItem entity) {
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
    );
  }
}
