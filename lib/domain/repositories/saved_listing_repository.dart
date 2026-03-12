import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/saved_listing.dart';

/// Domain interface for local saved/favourite listings persistence.
abstract class SavedListingRepository {
  Future<Either<Failure, List<SavedListing>>> getAll();
  Future<Either<Failure, void>> save(SavedListing listing);
  Future<Either<Failure, void>> remove(String listingId);
}
