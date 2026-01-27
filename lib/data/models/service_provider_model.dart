import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/purchase.dart';
import '../../domain/entities/service_provider.dart';

part 'service_provider_model.freezed.dart';

@freezed
class ServiceProviderModel with _$ServiceProviderModel {
  const factory ServiceProviderModel({
    required String id,
    required String name,
    required String code,
    required String category,
    String? logoUrl,
    String? description,
    required bool isActive,
    required List<ServiceProductModel> products,
    int? sortOrder,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ServiceProviderModel;

  const ServiceProviderModel._();

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final updatedAt = json['updatedAt'];
    final products = json['products'] as List?;

    return ServiceProviderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      category: json['category'] as String? ?? 'airtime',
      logoUrl: json['logoUrl'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      products: products
              ?.map((p) => ServiceProductModel.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
      sortOrder: json['sortOrder'] as int?,
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      updatedAt: updatedAt == null
          ? null
          : updatedAt is Timestamp
              ? updatedAt.toDate()
              : DateTime.parse(updatedAt as String),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'name': name,
      'code': code,
      'category': category,
      'logoUrl': logoUrl,
      'description': description,
      'isActive': isActive,
      'products': products.map((p) => p.toFirestoreJson()).toList(),
      'sortOrder': sortOrder,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  ServiceProvider toEntity() {
    return ServiceProvider(
      id: id,
      name: name,
      code: code,
      category: _parseCategory(category),
      logoUrl: logoUrl,
      description: description,
      isActive: isActive,
      products: products.map((p) => p.toEntity()).toList(),
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ServiceProviderModel.fromEntity(ServiceProvider entity) {
    return ServiceProviderModel(
      id: entity.id,
      name: entity.name,
      code: entity.code,
      category: entity.category.name,
      logoUrl: entity.logoUrl,
      description: entity.description,
      isActive: entity.isActive,
      products:
          entity.products.map((p) => ServiceProductModel.fromEntity(p)).toList(),
      sortOrder: entity.sortOrder,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static PurchaseCategory _parseCategory(String category) {
    switch (category) {
      case 'airtime':
        return PurchaseCategory.airtime;
      case 'data':
        return PurchaseCategory.data;
      case 'electricity':
        return PurchaseCategory.electricity;
      case 'voucher':
        return PurchaseCategory.voucher;
      default:
        return PurchaseCategory.other;
    }
  }
}

@freezed
class ServiceProductModel with _$ServiceProductModel {
  const factory ServiceProductModel({
    required String id,
    required String providerId,
    required String name,
    required String code,
    required int priceTokens,
    required double priceZar,
    String? description,
    String? validity,
    required bool isActive,
    int? sortOrder,
    Map<String, dynamic>? metadata,
  }) = _ServiceProductModel;

  const ServiceProductModel._();

  factory ServiceProductModel.fromJson(Map<String, dynamic> json) {
    return ServiceProductModel(
      id: json['id'] as String,
      providerId: json['providerId'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      priceTokens: json['priceTokens'] as int? ?? 0,
      priceZar: (json['priceZar'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String?,
      validity: json['validity'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      sortOrder: json['sortOrder'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'providerId': providerId,
      'name': name,
      'code': code,
      'priceTokens': priceTokens,
      'priceZar': priceZar,
      'description': description,
      'validity': validity,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'metadata': metadata,
    };
  }

  ServiceProduct toEntity() {
    return ServiceProduct(
      id: id,
      providerId: providerId,
      name: name,
      code: code,
      priceTokens: priceTokens,
      priceZar: priceZar,
      description: description,
      validity: validity,
      isActive: isActive,
      sortOrder: sortOrder,
      metadata: metadata,
    );
  }

  factory ServiceProductModel.fromEntity(ServiceProduct entity) {
    return ServiceProductModel(
      id: entity.id,
      providerId: entity.providerId,
      name: entity.name,
      code: entity.code,
      priceTokens: entity.priceTokens,
      priceZar: entity.priceZar,
      description: entity.description,
      validity: entity.validity,
      isActive: entity.isActive,
      sortOrder: entity.sortOrder,
      metadata: entity.metadata,
    );
  }
}
