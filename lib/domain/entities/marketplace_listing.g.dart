// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketplaceListing _$MarketplaceListingFromJson(Map<String, dynamic> json) =>
    _MarketplaceListing(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$MarketplaceCategoryEnumMap, json['category']),
      subCategory: json['subCategory'] as String?,
      priceTokens: (json['priceTokens'] as num).toInt(),
      priceZar: (json['priceZar'] as num).toDouble(),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      thumbnailUrl: json['thumbnailUrl'] as String?,
      providerId: json['providerId'] as String,
      providerName: json['providerName'] as String,
      providerPhotoUrl: json['providerPhotoUrl'] as String?,
      providerTrustScore: (json['providerTrustScore'] as num?)?.toDouble(),
      providerIsVerified: json['providerIsVerified'] as bool?,
      communityId: json['communityId'] as String?,
      location: json['location'] as String?,
      status: $enumDecode(_$ListingStatusEnumMap, json['status']),
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      reportCount: (json['reportCount'] as num?)?.toInt() ?? 0,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MarketplaceListingToJson(_MarketplaceListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$MarketplaceCategoryEnumMap[instance.category]!,
      'subCategory': instance.subCategory,
      'priceTokens': instance.priceTokens,
      'priceZar': instance.priceZar,
      'images': instance.images,
      'thumbnailUrl': instance.thumbnailUrl,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'providerPhotoUrl': instance.providerPhotoUrl,
      'providerTrustScore': instance.providerTrustScore,
      'providerIsVerified': instance.providerIsVerified,
      'communityId': instance.communityId,
      'location': instance.location,
      'status': _$ListingStatusEnumMap[instance.status]!,
      'viewCount': instance.viewCount,
      'reportCount': instance.reportCount,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MarketplaceCategoryEnumMap = {
  MarketplaceCategory.services: 'services',
  MarketplaceCategory.goods: 'goods',
  MarketplaceCategory.food: 'food',
  MarketplaceCategory.gigs: 'gigs',
  MarketplaceCategory.groupBuys: 'groupBuys',
};

const _$ListingStatusEnumMap = {
  ListingStatus.active: 'active',
  ListingStatus.flagged: 'flagged',
  ListingStatus.removed: 'removed',
  ListingStatus.soldOut: 'soldOut',
  ListingStatus.expired: 'expired',
};
