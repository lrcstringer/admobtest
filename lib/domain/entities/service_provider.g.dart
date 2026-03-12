// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceProvider _$ServiceProviderFromJson(Map<String, dynamic> json) =>
    _ServiceProvider(
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

Map<String, dynamic> _$ServiceProviderToJson(_ServiceProvider instance) =>
    <String, dynamic>{
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
  PurchaseCategory.marketplace: 'marketplace',
  PurchaseCategory.school: 'school',
  PurchaseCategory.municipal: 'municipal',
  PurchaseCategory.insurance: 'insurance',
  PurchaseCategory.funeral: 'funeral',
  PurchaseCategory.stokvel: 'stokvel',
  PurchaseCategory.gaming: 'gaming',
  PurchaseCategory.other: 'other',
};

_ServiceProduct _$ServiceProductFromJson(Map<String, dynamic> json) =>
    _ServiceProduct(
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

Map<String, dynamic> _$ServiceProductToJson(_ServiceProduct instance) =>
    <String, dynamic>{
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
