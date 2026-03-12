import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/saved_listing.dart';
import '../../domain/enums/listing_status.dart';

part 'saved_listing_model.freezed.dart';

@freezed
class SavedListingModel with _$SavedListingModel {
  const factory SavedListingModel({
    required String listingId,
    required DateTime savedAt,
    String? listingTitle,
    int? listingPrice,
    String? listingThumbnailUrl,
    String? listingStatus,
    String? sellerName,
  }) = _SavedListingModel;

  const SavedListingModel._();

  factory SavedListingModel.fromJson(Map<String, dynamic> json) {
    return SavedListingModel(
      listingId: json['listingId'] as String? ?? '',
      savedAt: _parseDateTime(json['savedAt']),
      listingTitle: json['listingTitle'] as String?,
      listingPrice: (json['listingPrice'] as num?)?.toInt(),
      listingThumbnailUrl: json['listingThumbnailUrl'] as String?,
      listingStatus: json['listingStatus'] as String?,
      sellerName: json['sellerName'] as String?,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'listingId': listingId,
      'savedAt': Timestamp.fromDate(savedAt),
      if (listingTitle != null) 'listingTitle': listingTitle,
      if (listingPrice != null) 'listingPrice': listingPrice,
      if (listingThumbnailUrl != null)
        'listingThumbnailUrl': listingThumbnailUrl,
      if (listingStatus != null) 'listingStatus': listingStatus,
      if (sellerName != null) 'sellerName': sellerName,
    };
  }

  SavedListing toEntity() {
    return SavedListing(
      listingId: listingId,
      savedAt: savedAt,
      listingTitle: listingTitle,
      listingPrice: listingPrice,
      listingThumbnailUrl: listingThumbnailUrl,
      listingStatus: listingStatus != null
          ? ListingStatusX.fromString(listingStatus!)
          : null,
      sellerName: sellerName,
    );
  }

  factory SavedListingModel.fromEntity(SavedListing entity) {
    return SavedListingModel(
      listingId: entity.listingId,
      savedAt: entity.savedAt,
      listingTitle: entity.listingTitle,
      listingPrice: entity.listingPrice,
      listingThumbnailUrl: entity.listingThumbnailUrl,
      listingStatus: entity.listingStatus?.name,
      sellerName: entity.sellerName,
    );
  }
}

DateTime _parseDateTime(dynamic value) {
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}
