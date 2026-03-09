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
    @Default('campaign') String type,
    String? deepLinkRoute,
    String? brandId,
    @Default([]) List<String> communityIds,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    @Default('goldOrange') String bgGradientType,
  }) = _FeaturedItemModel;

  const FeaturedItemModel._();

  factory FeaturedItemModel.fromJson(Map<String, dynamic> json) {
    return FeaturedItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
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
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
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
    };
  }

  FeaturedItem toEntity() {
    return FeaturedItem(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      type: type,
      deepLinkRoute: deepLinkRoute,
      brandId: brandId,
      communityIds: communityIds,
      isActive: isActive,
      sortOrder: sortOrder,
      scheduledStart: scheduledStart,
      scheduledEnd: scheduledEnd,
      bgGradientType: bgGradientType,
    );
  }

  factory FeaturedItemModel.fromEntity(FeaturedItem entity) {
    return FeaturedItemModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      imageUrl: entity.imageUrl,
      type: entity.type,
      deepLinkRoute: entity.deepLinkRoute,
      brandId: entity.brandId,
      communityIds: entity.communityIds,
      isActive: entity.isActive,
      sortOrder: entity.sortOrder,
      scheduledStart: entity.scheduledStart,
      scheduledEnd: entity.scheduledEnd,
      bgGradientType: entity.bgGradientType,
    );
  }
}
