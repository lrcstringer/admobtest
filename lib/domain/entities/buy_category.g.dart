// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BuyCategoryImpl _$$BuyCategoryImplFromJson(Map<String, dynamic> json) =>
    _$BuyCategoryImpl(
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
    );

Map<String, dynamic> _$$BuyCategoryImplToJson(_$BuyCategoryImpl instance) =>
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
    };
