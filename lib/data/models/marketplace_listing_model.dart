import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/marketplace_listing.dart';
import '../../domain/entities/location_data.dart';
import '../../domain/enums/delivery_method.dart';
import '../../domain/enums/listing_status.dart';
import '../../domain/enums/marketplace_category.dart';
import '../../domain/enums/service_area_type.dart';

part 'marketplace_listing_model.freezed.dart';

@freezed
class MarketplaceListingModel with _$MarketplaceListingModel {
  const factory MarketplaceListingModel({
    required String id,
    required String title,
    required String description,
    required MarketplaceCategory category,
    String? subCategory,
    required int priceTokens,
    required double priceZar,
    @Default([]) List<String> images,
    String? thumbnailUrl,
    required String providerId,
    required String providerName,
    String? providerPhotoUrl,
    double? providerTrustScore,
    bool? providerIsVerified,
    String? communityId,
    String? location,
    required ListingStatus status,
    @Default(0) int viewCount,
    @Default(0) int reportCount,
    DateTime? expiresAt,
    required DateTime createdAt,
    // ── New fields (Spec §8.25) ──
    LocationData? locationData,
    @Default(ServiceAreaType.myLocationOnly) ServiceAreaType serviceAreaType,
    @Default(DeliveryMethod.collection) DeliveryMethod deliveryMethod,
    int? deliveryFee,
    String? geohash,
    @Default(0) int favouriteCount,
    @Default(0) int renewalCount,
    @Default(0) int totalPausedDays,
    DateTime? pausedAt,
  }) = _MarketplaceListingModel;

  const MarketplaceListingModel._();

  factory MarketplaceListingModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceListingModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: _parseMarketplaceCategory(json['category'] as String?),
      subCategory: json['subCategory'] as String?,
      priceTokens: (json['priceTokens'] as num?)?.toInt() ?? 0,
      priceZar: (json['priceZar'] as num?)?.toDouble() ?? 0.0,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      thumbnailUrl: json['thumbnailUrl'] as String?,
      providerId: json['providerId'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      providerPhotoUrl: json['providerPhotoUrl'] as String?,
      providerTrustScore: (json['providerTrustScore'] as num?)?.toDouble(),
      providerIsVerified: json['providerIsVerified'] as bool?,
      communityId: json['communityId'] as String?,
      location: json['location'] as String?,
      status: _parseListingStatus(json['status'] as String?),
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      reportCount: (json['reportCount'] as num?)?.toInt() ?? 0,
      expiresAt: json['expiresAt'] is Timestamp
          ? (json['expiresAt'] as Timestamp).toDate()
          : json['expiresAt'] is String
              ? DateTime.tryParse(json['expiresAt'] as String)
              : null,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : json['createdAt'] is String
              ? DateTime.parse(json['createdAt'] as String)
              : DateTime.fromMillisecondsSinceEpoch(0),
      // New fields (Spec §8.25)
      locationData: json['locationData'] is Map<String, dynamic>
          ? LocationData.fromJson(
              json['locationData'] as Map<String, dynamic>)
          : null,
      serviceAreaType: _parseServiceAreaType(json['serviceAreaType'] as String?),
      deliveryMethod: _parseDeliveryMethod(json['deliveryMethod'] as String?),
      deliveryFee: (json['deliveryFee'] as num?)?.toInt(),
      geohash: json['geohash'] as String?,
      favouriteCount: (json['favouriteCount'] as num?)?.toInt() ?? 0,
      renewalCount: (json['renewalCount'] as num?)?.toInt() ?? 0,
      totalPausedDays: (json['totalPausedDays'] as num?)?.toInt() ?? 0,
      pausedAt: json['pausedAt'] is Timestamp
          ? (json['pausedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'title': title,
      'description': description,
      'category': category.name,
      if (subCategory != null) 'subCategory': subCategory,
      'priceTokens': priceTokens,
      'priceZar': priceZar,
      'images': images,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'providerId': providerId,
      'providerName': providerName,
      if (providerPhotoUrl != null) 'providerPhotoUrl': providerPhotoUrl,
      if (providerTrustScore != null) 'providerTrustScore': providerTrustScore,
      if (providerIsVerified != null) 'providerIsVerified': providerIsVerified,
      if (communityId != null) 'communityId': communityId,
      if (location != null) 'location': location,
      'status': status.name,
      'viewCount': viewCount,
      'reportCount': reportCount,
      if (expiresAt != null) 'expiresAt': Timestamp.fromDate(expiresAt!),
      'createdAt': Timestamp.fromDate(createdAt),
      // New fields (Spec §8.25)
      if (locationData != null) 'locationData': locationData!.toJson(),
      'serviceAreaType': serviceAreaType.name,
      'deliveryMethod': deliveryMethod.name,
      if (deliveryFee != null) 'deliveryFee': deliveryFee,
      if (geohash != null) 'geohash': geohash,
      'favouriteCount': favouriteCount,
      'renewalCount': renewalCount,
      'totalPausedDays': totalPausedDays,
      if (pausedAt != null) 'pausedAt': Timestamp.fromDate(pausedAt!),
    };
  }

  MarketplaceListing toEntity() {
    return MarketplaceListing(
      id: id,
      title: title,
      description: description,
      category: category,
      subCategory: subCategory,
      priceTokens: priceTokens,
      priceZar: priceZar,
      images: images,
      thumbnailUrl: thumbnailUrl,
      providerId: providerId,
      providerName: providerName,
      providerPhotoUrl: providerPhotoUrl,
      providerTrustScore: providerTrustScore,
      providerIsVerified: providerIsVerified,
      communityId: communityId,
      location: location,
      status: status,
      viewCount: viewCount,
      reportCount: reportCount,
      expiresAt: expiresAt,
      createdAt: createdAt,
      locationData: locationData,
      serviceAreaType: serviceAreaType,
      deliveryMethod: deliveryMethod,
      deliveryFee: deliveryFee,
      geohash: geohash,
      favouriteCount: favouriteCount,
      renewalCount: renewalCount,
      totalPausedDays: totalPausedDays,
      pausedAt: pausedAt,
    );
  }

  factory MarketplaceListingModel.fromEntity(MarketplaceListing entity) {
    return MarketplaceListingModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      subCategory: entity.subCategory,
      priceTokens: entity.priceTokens,
      priceZar: entity.priceZar,
      images: entity.images,
      thumbnailUrl: entity.thumbnailUrl,
      providerId: entity.providerId,
      providerName: entity.providerName,
      providerPhotoUrl: entity.providerPhotoUrl,
      providerTrustScore: entity.providerTrustScore,
      providerIsVerified: entity.providerIsVerified,
      communityId: entity.communityId,
      location: entity.location,
      status: entity.status,
      viewCount: entity.viewCount,
      reportCount: entity.reportCount,
      expiresAt: entity.expiresAt,
      createdAt: entity.createdAt,
      locationData: entity.locationData,
      serviceAreaType: entity.serviceAreaType,
      deliveryMethod: entity.deliveryMethod,
      deliveryFee: entity.deliveryFee,
      geohash: entity.geohash,
      favouriteCount: entity.favouriteCount,
      renewalCount: entity.renewalCount,
      totalPausedDays: entity.totalPausedDays,
      pausedAt: entity.pausedAt,
    );
  }
}

MarketplaceCategory _parseMarketplaceCategory(String? value) {
  return MarketplaceCategoryX.fromString(value ?? 'everythingElse');
}

ListingStatus _parseListingStatus(String? value) {
  return ListingStatusX.fromString(value ?? 'active');
}

ServiceAreaType _parseServiceAreaType(String? value) {
  if (value == null) return ServiceAreaType.myLocationOnly;
  return ServiceAreaType.values.firstWhere(
    (e) => e.name == value,
    orElse: () => ServiceAreaType.myLocationOnly,
  );
}

DeliveryMethod _parseDeliveryMethod(String? value) {
  if (value == null) return DeliveryMethod.collection;
  return DeliveryMethod.values.firstWhere(
    (e) => e.name == value,
    orElse: () => DeliveryMethod.collection,
  );
}
