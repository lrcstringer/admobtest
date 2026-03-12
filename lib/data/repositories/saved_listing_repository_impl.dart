import 'package:injectable/injectable.dart';

import '../../domain/entities/saved_listing.dart';
import '../../domain/repositories/saved_listing_repository.dart';
import '../datasources/local/saved_listing_datasource.dart';

@LazySingleton(as: SavedListingRepository)
class SavedListingRepositoryImpl implements SavedListingRepository {
  final SavedListingDatasource _datasource;

  SavedListingRepositoryImpl(this._datasource);

  @override
  Future<List<SavedListing>> getAll() => _datasource.getAll();

  @override
  Future<void> save(SavedListing listing) => _datasource.save(listing);

  @override
  Future<void> remove(String listingId) => _datasource.remove(listingId);
}
