import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/saved_listing.dart';
import '../../domain/repositories/saved_listing_repository.dart';
import '../datasources/local/saved_listing_datasource.dart';

@LazySingleton(as: SavedListingRepository)
class SavedListingRepositoryImpl implements SavedListingRepository {
  final SavedListingDatasource _datasource;

  SavedListingRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<SavedListing>>> getAll() async {
    try {
      final items = await _datasource.getAll();
      return Right(items);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> save(SavedListing listing) async {
    try {
      await _datasource.save(listing);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> remove(String listingId) async {
    try {
      await _datasource.remove(listingId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
