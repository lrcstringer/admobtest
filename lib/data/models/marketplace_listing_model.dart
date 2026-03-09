import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/marketplace_listing.dart';
import '../../domain/enums/listing_status.dart';
import '../../domain/enums/marketplace_category.dart';

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
              : DateTime.now(),
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
    );
  }
}

MarketplaceCategory _parseMarketplaceCategory(String? value) {
  switch (value) {
    case 'goods':
      return MarketplaceCategory.goods;
    case 'food':
      return MarketplaceCategory.food;
    case 'gigs':
      return MarketplaceCategory.gigs;
    case 'groupBuys':
      return MarketplaceCategory.groupBuys;
    default:
      return MarketplaceCategory.services;
  }
}

ListingStatus _parseListingStatus(String? value) {
  switch (value) {
    case 'flagged':
      return ListingStatus.flagged;
    case 'removed':
      return ListingStatus.removed;
    case 'soldOut':
      return ListingStatus.soldOut;
    case 'expired':
      return ListingStatus.expired;
    default:
      return ListingStatus.active;
  }
}
