// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedListing _$SavedListingFromJson(Map<String, dynamic> json) =>
    _SavedListing(
      listingId: json['listingId'] as String,
      savedAt: DateTime.parse(json['savedAt'] as String),
      listingTitle: json['listingTitle'] as String?,
      listingPrice: (json['listingPrice'] as num?)?.toInt(),
      listingThumbnailUrl: json['listingThumbnailUrl'] as String?,
      listingStatus: $enumDecodeNullable(
        _$ListingStatusEnumMap,
        json['listingStatus'],
      ),
      sellerName: json['sellerName'] as String?,
    );

Map<String, dynamic> _$SavedListingToJson(_SavedListing instance) =>
    <String, dynamic>{
      'listingId': instance.listingId,
      'savedAt': instance.savedAt.toIso8601String(),
      'listingTitle': instance.listingTitle,
      'listingPrice': instance.listingPrice,
      'listingThumbnailUrl': instance.listingThumbnailUrl,
      'listingStatus': _$ListingStatusEnumMap[instance.listingStatus],
      'sellerName': instance.sellerName,
    };

const _$ListingStatusEnumMap = {
  ListingStatus.active: 'active',
  ListingStatus.paused: 'paused',
  ListingStatus.expired: 'expired',
  ListingStatus.flagged: 'flagged',
  ListingStatus.removed: 'removed',
  ListingStatus.sold: 'sold',
};
