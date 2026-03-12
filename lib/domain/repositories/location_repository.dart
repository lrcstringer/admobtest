import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/location_data.dart';
import '../entities/sa_location.dart';

/// Repository for SA location lookups (Spec §8.17).
abstract class LocationRepository {
  /// Full-text search across provinces, cities, and suburbs.
  Future<Either<Failure, List<SaLocation>>> searchLocations(String query);

  /// Get a single location by ID.
  Future<Either<Failure, SaLocation>> getLocationById(String id);

  /// Get all 9 SA provinces.
  Future<Either<Failure, List<SaLocation>>> getProvinces();

  /// Get cities within a province.
  Future<Either<Failure, List<SaLocation>>> getCitiesByProvince(
      String provinceId);

  /// Get suburbs within a city.
  Future<Either<Failure, List<SaLocation>>> getSuburbsByCity(String cityId);

  /// Build a [LocationData] value object from a selected [SaLocation].
  /// Walks up the hierarchy (suburb → city → province) to fill all fields.
  Future<Either<Failure, LocationData>> buildLocationData(
      SaLocation selected);
}
