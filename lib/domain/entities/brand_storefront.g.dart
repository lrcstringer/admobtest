// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_storefront.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StorefrontSectionImpl _$$StorefrontSectionImplFromJson(
  Map<String, dynamic> json,
) => _$StorefrontSectionImpl(
  type: json['type'] as String,
  title: json['title'] as String?,
  data: json['data'] as Map<String, dynamic>? ?? const {},
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  isVisible: json['isVisible'] as bool? ?? true,
);

Map<String, dynamic> _$$StorefrontSectionImplToJson(
  _$StorefrontSectionImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'title': instance.title,
  'data': instance.data,
  'sortOrder': instance.sortOrder,
  'isVisible': instance.isVisible,
};

_$BrandStorefrontImpl _$$BrandStorefrontImplFromJson(
  Map<String, dynamic> json,
) => _$BrandStorefrontImpl(
  id: json['id'] as String,
  brandId: json['brandId'] as String,
  brandName: json['brandName'] as String,
  brandLogoUrl: json['brandLogoUrl'] as String?,
  brandColor: json['brandColor'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  tagline: json['tagline'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  isPremium: json['isPremium'] as bool? ?? false,
  communityIds:
      (json['communityIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sections:
      (json['sections'] as List<dynamic>?)
          ?.map((e) => StorefrontSection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$BrandStorefrontImplToJson(
  _$BrandStorefrontImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'brandId': instance.brandId,
  'brandName': instance.brandName,
  'brandLogoUrl': instance.brandLogoUrl,
  'brandColor': instance.brandColor,
  'coverImageUrl': instance.coverImageUrl,
  'tagline': instance.tagline,
  'isActive': instance.isActive,
  'isPremium': instance.isPremium,
  'communityIds': instance.communityIds,
  'sections': instance.sections,
  'createdAt': instance.createdAt?.toIso8601String(),
};
