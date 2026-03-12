import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/sa_location.dart' as domain;
import 'app_database.dart';

/// Drift DAO for the local SA locations table (~22K rows).
///
/// Provides efficient text search, hierarchical lookups, and
/// coordinate queries for the location autocomplete system (Spec §8.17).
@lazySingleton
class SaLocationDatasource {
  final AppDatabase _db;

  SaLocationDatasource(this._db);

  /// Full-text search by name prefix (case-insensitive).
  /// Returns up to [limit] results ordered by type priority
  /// (suburb first, then city, then province) and name.
  Future<List<domain.SaLocation>> searchByName(
    String query, {
    int limit = 20,
  }) async {
    final pattern = '%${query.toLowerCase()}%';
    final rows = await (_db.select(_db.localSaLocations)
          ..where((t) => t.name.lower().like(pattern))
          ..orderBy([
            // Suburbs first (most specific), then cities, then provinces
            (t) => OrderingTerm.asc(
                  t.type.equals('suburb').caseMatch<int>(
                    when: {const Constant(true): const Constant(0)},
                    orElse: t.type.equals('city').caseMatch<int>(
                      when: {const Constant(true): const Constant(1)},
                      orElse: const Constant(2),
                    ),
                  ),
                ),
            (t) => OrderingTerm.asc(t.name),
          ])
          ..limit(limit))
        .get();

    return rows.map(_rowToEntity).toList();
  }

  /// Get a single location by its ID.
  Future<domain.SaLocation?> getById(String id) async {
    final row = await (_db.select(_db.localSaLocations)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();

    return row == null ? null : _rowToEntity(row);
  }

  /// Get all provinces (type == 'province'), alphabetically.
  Future<List<domain.SaLocation>> getProvinces() async {
    final rows = await (_db.select(_db.localSaLocations)
          ..where((t) => t.type.equals('province'))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();

    return rows.map(_rowToEntity).toList();
  }

  /// Get all cities within a given province (by parentId).
  Future<List<domain.SaLocation>> getCitiesByProvince(
      String provinceId) async {
    final rows = await (_db.select(_db.localSaLocations)
          ..where(
              (t) => t.parentId.equals(provinceId) & t.type.equals('city'))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();

    return rows.map(_rowToEntity).toList();
  }

  /// Get all suburbs within a given city (by parentId).
  Future<List<domain.SaLocation>> getSuburbsByCity(String cityId) async {
    final rows = await (_db.select(_db.localSaLocations)
          ..where(
              (t) => t.parentId.equals(cityId) & t.type.equals('suburb'))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();

    return rows.map(_rowToEntity).toList();
  }

  /// Count total rows in the table (for seed verification).
  Future<int> count() async {
    final countExp = _db.localSaLocations.id.count();
    final query = _db.selectOnly(_db.localSaLocations)..addColumns([countExp]);
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }

  /// Batch insert locations (used during initial seed).
  Future<void> insertAll(List<domain.SaLocation> locations) async {
    await _db.batch((batch) {
      batch.insertAll(
        _db.localSaLocations,
        locations
            .map((loc) => LocalSaLocationsCompanion.insert(
                  id: loc.id,
                  name: loc.name,
                  type: loc.type,
                  parentId: Value(loc.parentId),
                  province: Value(loc.province),
                  city: Value(loc.city),
                  postalCode: Value(loc.postalCode),
                  latitude: Value(loc.latitude),
                  longitude: Value(loc.longitude),
                ))
            .toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  /// Check whether the table has been seeded.
  Future<bool> isSeeded() async {
    final c = await count();
    return c > 0;
  }

  /// Convert a Drift data row to a domain entity.
  domain.SaLocation _rowToEntity(LocalSaLocation row) {
    return domain.SaLocation(
      id: row.id,
      name: row.name,
      type: row.type,
      parentId: row.parentId,
      province: row.province,
      city: row.city,
      postalCode: row.postalCode,
      latitude: row.latitude,
      longitude: row.longitude,
    );
  }
}
