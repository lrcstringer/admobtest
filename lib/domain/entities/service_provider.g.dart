// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceProviderImpl _$$ServiceProviderImplFromJson(
  Map<String, dynamic> json,
) => _$ServiceProviderImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  category: $enumDecode(_$PurchaseCategoryEnumMap, json['category']),
  logoUrl: json['logoUrl'] as String?,
  description: json['description'] as String?,
  isActive: json['isActive'] as bool,
  products: (json['products'] as List<dynamic>)
      .map((e) => ServiceProduct.fromJson(e as Map<String, dynamic>))
      .toList(),
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ServiceProviderImplToJson(
  _$ServiceProviderImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'category': _$PurchaseCategoryEnumMap[instance.category]!,
  'logoUrl': instance.logoUrl,
  'description': instance.description,
  'isActive': instance.isActive,
  'products': instance.products,
  'sortOrder': instance.sortOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$PurchaseCategoryEnumMap = {
  PurchaseCategory.airtime: 'airtime',
  PurchaseCategory.data: 'data',
  PurchaseCategory.electricity: 'electricity',
  PurchaseCategory.voucher: 'voucher',
  PurchaseCategory.other: 'other',
};

_$ServiceProductImpl _$$ServiceProductImplFromJson(Map<String, dynamic> json) =>
    _$ServiceProductImpl(
      id: json['id'] as String,
      providerId: json['providerId'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      priceTokens: (json['priceTokens'] as num).toInt(),
      priceZar: (json['priceZar'] as num).toDouble(),
      description: json['description'] as String?,
      validity: json['validity'] as String?,
      isActive: json['isActive'] as bool,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ServiceProductImplToJson(
  _$ServiceProductImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'providerId': instance.providerId,
  'name': instance.name,
  'code': instance.code,
  'priceTokens': instance.priceTokens,
  'priceZar': instance.priceZar,
  'description': instance.description,
  'validity': instance.validity,
  'isActive': instance.isActive,
  'sortOrder': instance.sortOrder,
  'metadata': instance.metadata,
};
