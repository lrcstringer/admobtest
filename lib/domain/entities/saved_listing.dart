import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_listing.freezed.dart';
part 'saved_listing.g.dart';

/// A saved/favourited marketplace listing.
/// Stored locally in Drift and synced to Firestore `users/{uid}/favourites`.
@freezed
class SavedListing with _$SavedListing {
  const factory SavedListing({
    required String listingId,
    required DateTime savedAt,
    String? listingTitle,
    int? listingPrice,
    String? listingThumbnailUrl,
    String? listingStatus,
    String? sellerName,
  }) = _SavedListing;

  const SavedListing._();

  factory SavedListing.fromJson(Map<String, dynamic> json) =>
      _$SavedListingFromJson(json);

  /// Whether the listing is still available for purchase.
  bool get isStale =>
      listingStatus != null && listingStatus != 'active';
}
