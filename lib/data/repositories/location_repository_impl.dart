import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/location_data.dart';
import '../../domain/entities/sa_location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/local/sa_location_datasource.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final SaLocationDatasource _localDatasource;

  LocationRepositoryImpl(this._localDatasource);

  @override
  Future<Either<Failure, List<SaLocation>>> searchLocations(
      String query) async {
    try {
      final trimmed = query.trim();
      if (trimmed.length < 2) return const Right([]);
      final results = await _localDatasource.searchByName(trimmed);
      return Right(results);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SaLocation>> getLocationById(String id) async {
    try {
      final location = await _localDatasource.getById(id);
      if (location == null) {
        return Left(Failure.serverError(
          code: 'NOT_FOUND',
          message: 'Location not found',
        ));
      }
      return Right(location);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SaLocation>>> getProvinces() async {
    try {
      final provinces = await _localDatasource.getProvinces();
      return Right(provinces);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SaLocation>>> getCitiesByProvince(
      String provinceId) async {
    try {
      final cities = await _localDatasource.getCitiesByProvince(provinceId);
      return Right(cities);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SaLocation>>> getSuburbsByCity(
      String cityId) async {
    try {
      final suburbs = await _localDatasource.getSuburbsByCity(cityId);
      return Right(suburbs);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationData>> buildLocationData(
      SaLocation selected) async {
    try {
      String? provinceId, provinceName;
      String? cityId, cityName;
      String? suburbId, suburbName;

      if (selected.isSuburb) {
        suburbId = selected.id;
        suburbName = selected.name;
        if (selected.parentId != null) {
          final city = await _localDatasource.getById(selected.parentId!);
          if (city != null) {
            cityId = city.id;
            cityName = city.name;
            if (city.parentId != null) {
              final province = await _localDatasource.getById(city.parentId!);
              if (province != null) {
                provinceId = province.id;
                provinceName = province.name;
              }
            }
          }
        }
      } else if (selected.isCity) {
        cityId = selected.id;
        cityName = selected.name;
        if (selected.parentId != null) {
          final province = await _localDatasource.getById(selected.parentId!);
          if (province != null) {
            provinceId = province.id;
            provinceName = province.name;
          }
        }
      } else if (selected.isProvince) {
        provinceId = selected.id;
        provinceName = selected.name;
      }

      return Right(LocationData(
        provinceId: provinceId,
        province: provinceName,
        cityId: cityId,
        city: cityName,
        suburbId: suburbId,
        suburb: suburbName,
        postalCode: selected.postalCode,
        latitude: selected.latitude,
        longitude: selected.longitude,
      ));
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }
}
