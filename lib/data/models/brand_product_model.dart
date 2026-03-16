import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/brand_product.dart';
import '../mappers/brand_product_mapper.dart';

part 'brand_product_model.freezed.dart';

@freezed
abstract class BrandProductModel with _$BrandProductModel {
  const factory BrandProductModel({
    required String id,
    required String brandId,
    required String name,
    String? description,
    required double priceZar,
    required int priceTokens,
    String? imageUrl,
    String? category,
    @Default(true) bool isActive,
    @Default(false) bool isFeatured,
    @Default(0) int sortOrder,
    int? stockCount,
    required FulfilmentType fulfilmentType,
    String? contactMethod,
    String? voucherInstructions,
    String? collectionAddress,
    String? deliveryInfo,
    String? externalUrl,
    required DateTime createdAt,
  }) = _BrandProductModel;

  const BrandProductModel._();

  factory BrandProductModel.fromJson(Map<String, dynamic> json) {
    return BrandProductModel(
      id: json['id'] as String? ?? '',
      brandId: json['brandId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      priceZar: (json['priceZar'] as num?)?.toDouble() ?? 0,
      priceTokens: (json['priceTokens'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      stockCount: (json['stockCount'] as num?)?.toInt(),
      fulfilmentType: _parseFulfilmentType(json['fulfilmentType'] as String?),
      contactMethod: json['contactMethod'] as String?,
      voucherInstructions: json['voucherInstructions'] as String?,
      collectionAddress: json['collectionAddress'] as String?,
      deliveryInfo: json['deliveryInfo'] as String?,
      externalUrl: json['externalUrl'] as String?,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'brandId': brandId,
      'name': name,
      if (description != null) 'description': description,
      'priceZar': priceZar,
      'priceTokens': priceTokens,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (category != null) 'category': category,
      'isActive': isActive,
      'isFeatured': isFeatured,
      'sortOrder': sortOrder,
      if (stockCount != null) 'stockCount': stockCount,
      'fulfilmentType': fulfilmentType.name,
      if (contactMethod != null) 'contactMethod': contactMethod,
      if (voucherInstructions != null)
        'voucherInstructions': voucherInstructions,
      if (collectionAddress != null) 'collectionAddress': collectionAddress,
      if (deliveryInfo != null) 'deliveryInfo': deliveryInfo,
      if (externalUrl != null) 'externalUrl': externalUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  BrandProduct toEntity() => BrandProductMapper.toEntity(this);

  factory BrandProductModel.fromEntity(BrandProduct entity) =>
      BrandProductMapper.fromEntity(entity);

  static FulfilmentType _parseFulfilmentType(String? value) {
    if (value == null) return FulfilmentType.digital;
    return FulfilmentType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => FulfilmentType.digital,
    );
  }
}
