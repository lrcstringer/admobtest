// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BuySubcategory _$BuySubcategoryFromJson(Map<String, dynamic> json) =>
    _BuySubcategory(
      id: json['id'] as String,
      name: json['name'] as String,
      iconEmoji: json['iconEmoji'] as String? ?? '',
    );

Map<String, dynamic> _$BuySubcategoryToJson(_BuySubcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconEmoji': instance.iconEmoji,
    };

_BuyCategory _$BuyCategoryFromJson(Map<String, dynamic> json) => _BuyCategory(
  id: json['id'] as String,
  name: json['name'] as String,
  iconEmoji: json['iconEmoji'] as String,
  sortOrder: (json['sortOrder'] as num).toInt(),
  isActive: json['isActive'] as bool,
  isComingSoon: json['isComingSoon'] as bool? ?? false,
  purchaseCategoryMapping: json['purchaseCategoryMapping'] as String?,
  featureFlagKey: json['featureFlagKey'] as String?,
  logoUrl: json['logoUrl'] as String?,
  backgroundColor: json['backgroundColor'] as String?,
  subcategories:
      (json['subcategories'] as List<dynamic>?)
          ?.map((e) => BuySubcategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$BuyCategoryToJson(_BuyCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconEmoji': instance.iconEmoji,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'isComingSoon': instance.isComingSoon,
      'purchaseCategoryMapping': instance.purchaseCategoryMapping,
      'featureFlagKey': instance.featureFlagKey,
      'logoUrl': instance.logoUrl,
      'backgroundColor': instance.backgroundColor,
      'subcategories': instance.subcategories,
    };
