// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketplaceListing _$MarketplaceListingFromJson(
  Map<String, dynamic> json,
) => _MarketplaceListing(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  category: $enumDecode(_$MarketplaceCategoryEnumMap, json['category']),
  subCategory: json['subCategory'] as String?,
  priceTokens: (json['priceTokens'] as num).toInt(),
  priceZar: (json['priceZar'] as num).toDouble(),
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
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
  locationData: json['locationData'] == null
      ? null
      : LocationData.fromJson(json['locationData'] as Map<String, dynamic>),
  serviceAreaType:
      $enumDecodeNullable(_$ServiceAreaTypeEnumMap, json['serviceAreaType']) ??
      ServiceAreaType.myLocationOnly,
  deliveryMethod:
      $enumDecodeNullable(_$DeliveryMethodEnumMap, json['deliveryMethod']) ??
      DeliveryMethod.collection,
  deliveryFee: (json['deliveryFee'] as num?)?.toInt(),
  geohash: json['geohash'] as String?,
  favouriteCount: (json['favouriteCount'] as num?)?.toInt() ?? 0,
  renewalCount: (json['renewalCount'] as num?)?.toInt() ?? 0,
  totalPausedDays: (json['totalPausedDays'] as num?)?.toInt() ?? 0,
  pausedAt: json['pausedAt'] == null
      ? null
      : DateTime.parse(json['pausedAt'] as String),
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
      'locationData': instance.locationData,
      'serviceAreaType': _$ServiceAreaTypeEnumMap[instance.serviceAreaType]!,
      'deliveryMethod': _$DeliveryMethodEnumMap[instance.deliveryMethod]!,
      'deliveryFee': instance.deliveryFee,
      'geohash': instance.geohash,
      'favouriteCount': instance.favouriteCount,
      'renewalCount': instance.renewalCount,
      'totalPausedDays': instance.totalPausedDays,
      'pausedAt': instance.pausedAt?.toIso8601String(),
    };

const _$MarketplaceCategoryEnumMap = {
  MarketplaceCategory.foodAndDrinks: 'foodAndDrinks',
  MarketplaceCategory.beautyAndWellness: 'beautyAndWellness',
  MarketplaceCategory.homeAndProperty: 'homeAndProperty',
  MarketplaceCategory.clothingAndFashion: 'clothingAndFashion',
  MarketplaceCategory.fixAndRepair: 'fixAndRepair',
  MarketplaceCategory.movingAndDelivery: 'movingAndDelivery',
  MarketplaceCategory.kidsPetsAndCare: 'kidsPetsAndCare',
  MarketplaceCategory.everythingElse: 'everythingElse',
};

const _$ListingStatusEnumMap = {
  ListingStatus.active: 'active',
  ListingStatus.paused: 'paused',
  ListingStatus.expired: 'expired',
  ListingStatus.flagged: 'flagged',
  ListingStatus.removed: 'removed',
  ListingStatus.sold: 'sold',
};

const _$ServiceAreaTypeEnumMap = {
  ServiceAreaType.myLocationOnly: 'myLocationOnly',
  ServiceAreaType.deliverNearby: 'deliverNearby',
  ServiceAreaType.nationwide: 'nationwide',
};

const _$DeliveryMethodEnumMap = {
  DeliveryMethod.collection: 'collection',
  DeliveryMethod.delivery: 'delivery',
  DeliveryMethod.both: 'both',
};
