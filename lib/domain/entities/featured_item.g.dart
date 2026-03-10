// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeaturedItemImpl _$$FeaturedItemImplFromJson(Map<String, dynamic> json) =>
    _$FeaturedItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      type: json['type'] as String? ?? 'campaign',
      deepLinkRoute: json['deepLinkRoute'] as String?,
      brandId: json['brandId'] as String?,
      communityIds:
          (json['communityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      scheduledStart: json['scheduledStart'] == null
          ? null
          : DateTime.parse(json['scheduledStart'] as String),
      scheduledEnd: json['scheduledEnd'] == null
          ? null
          : DateTime.parse(json['scheduledEnd'] as String),
      bgGradientType: json['bgGradientType'] as String? ?? 'goldOrange',
      brandName: json['brandName'] as String?,
      ctaText: json['ctaText'] as String?,
      bgColorHex: json['bgColorHex'] as String?,
      colorIntensity: (json['colorIntensity'] as num?)?.toDouble() ?? 0.4,
      imageOpacity: (json['imageOpacity'] as num?)?.toDouble() ?? 0.3,
      imageLayout: json['imageLayout'] as String? ?? 'right',
    );

Map<String, dynamic> _$$FeaturedItemImplToJson(_$FeaturedItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'type': instance.type,
      'deepLinkRoute': instance.deepLinkRoute,
      'brandId': instance.brandId,
      'communityIds': instance.communityIds,
      'isActive': instance.isActive,
      'sortOrder': instance.sortOrder,
      'scheduledStart': instance.scheduledStart?.toIso8601String(),
      'scheduledEnd': instance.scheduledEnd?.toIso8601String(),
      'bgGradientType': instance.bgGradientType,
      'brandName': instance.brandName,
      'ctaText': instance.ctaText,
      'bgColorHex': instance.bgColorHex,
      'colorIntensity': instance.colorIntensity,
      'imageOpacity': instance.imageOpacity,
      'imageLayout': instance.imageLayout,
    };
