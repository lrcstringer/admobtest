// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrandProduct _$BrandProductFromJson(Map<String, dynamic> json) =>
    _BrandProduct(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      priceZar: (json['priceZar'] as num).toDouble(),
      priceTokens: (json['priceTokens'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      stockCount: (json['stockCount'] as num?)?.toInt(),
      fulfilmentType: $enumDecode(
        _$FulfilmentTypeEnumMap,
        json['fulfilmentType'],
      ),
      contactMethod: json['contactMethod'] as String?,
      voucherInstructions: json['voucherInstructions'] as String?,
      collectionAddress: json['collectionAddress'] as String?,
      deliveryInfo: json['deliveryInfo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BrandProductToJson(_BrandProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'name': instance.name,
      'description': instance.description,
      'priceZar': instance.priceZar,
      'priceTokens': instance.priceTokens,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'isActive': instance.isActive,
      'isFeatured': instance.isFeatured,
      'sortOrder': instance.sortOrder,
      'stockCount': instance.stockCount,
      'fulfilmentType': _$FulfilmentTypeEnumMap[instance.fulfilmentType]!,
      'contactMethod': instance.contactMethod,
      'voucherInstructions': instance.voucherInstructions,
      'collectionAddress': instance.collectionAddress,
      'deliveryInfo': instance.deliveryInfo,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$FulfilmentTypeEnumMap = {
  FulfilmentType.digital: 'digital',
  FulfilmentType.physical: 'physical',
  FulfilmentType.catalog: 'catalog',
};
