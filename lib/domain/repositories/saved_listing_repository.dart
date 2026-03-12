import '../entities/saved_listing.dart';

/// Domain interface for local saved/favourite listings persistence.
abstract class SavedListingRepository {
  Future<List<SavedListing>> getAll();
  Future<void> save(SavedListing listing);
  Future<void> remove(String listingId);
}
