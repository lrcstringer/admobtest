import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/saved_listing.dart' as domain;
import 'app_database.dart';

/// Drift DAO for the local SavedListings table.
///
/// Provides offline-first favourite management with sync support (Spec §8.18).
@lazySingleton
class SavedListingDatasource {
  final AppDatabase _db;

  SavedListingDatasource(this._db);

  /// Get all saved listings, ordered by savedAt descending (newest first).
  Future<List<domain.SavedListing>> getAll() async {
    final rows = await (_db.select(_db.localSavedListings)
          ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
        .get();
    return rows.map(_rowToEntity).toList();
  }

  /// Check if a listing is saved.
  Future<bool> isSaved(String listingId) async {
    final row = await (_db.select(_db.localSavedListings)
          ..where((t) => t.listingId.equals(listingId)))
        .getSingleOrNull();
    return row != null;
  }

  /// Get all saved listing IDs (for quick lookups).
  Future<Set<String>> getSavedIds() async {
    final rows = await _db.select(_db.localSavedListings).get();
    return rows.map((r) => r.listingId).toSet();
  }

  /// Save a listing.
  Future<void> save(domain.SavedListing listing) async {
    await _db.into(_db.localSavedListings).insertOnConflictUpdate(
          LocalSavedListingsCompanion.insert(
            listingId: listing.listingId,
            savedAt: listing.savedAt,
            listingTitle: Value(listing.listingTitle),
            listingPrice: Value(listing.listingPrice),
            listingThumbnailUrl: Value(listing.listingThumbnailUrl),
            listingStatus: Value(listing.listingStatus),
            sellerName: Value(listing.sellerName),
          ),
        );
  }

  /// Remove a saved listing.
  Future<void> remove(String listingId) async {
    await (_db.delete(_db.localSavedListings)
          ..where((t) => t.listingId.equals(listingId)))
        .go();
  }

  /// Toggle save state. Returns true if now saved, false if removed.
  Future<bool> toggle(domain.SavedListing listing) async {
    final exists = await isSaved(listing.listingId);
    if (exists) {
      await remove(listing.listingId);
      return false;
    } else {
      await save(listing);
      return true;
    }
  }

  /// Batch replace all saved listings (used during sync from Firestore).
  Future<void> replaceAll(List<domain.SavedListing> listings) async {
    await _db.transaction(() async {
      await _db.delete(_db.localSavedListings).go();
      await _db.batch((batch) {
        batch.insertAll(
          _db.localSavedListings,
          listings
              .map((l) => LocalSavedListingsCompanion.insert(
                    listingId: l.listingId,
                    savedAt: l.savedAt,
                    listingTitle: Value(l.listingTitle),
                    listingPrice: Value(l.listingPrice),
                    listingThumbnailUrl: Value(l.listingThumbnailUrl),
                    listingStatus: Value(l.listingStatus),
                    sellerName: Value(l.sellerName),
                  ))
              .toList(),
        );
      });
    });
  }

  /// Count saved listings.
  Future<int> count() async {
    final countExp = _db.localSavedListings.listingId.count();
    final query = _db.selectOnly(_db.localSavedListings)..addColumns([countExp]);
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }

  domain.SavedListing _rowToEntity(LocalSavedListing row) {
    return domain.SavedListing(
      listingId: row.listingId,
      savedAt: row.savedAt,
      listingTitle: row.listingTitle,
      listingPrice: row.listingPrice,
      listingThumbnailUrl: row.listingThumbnailUrl,
      listingStatus: row.listingStatus,
      sellerName: row.sellerName,
    );
  }
}
