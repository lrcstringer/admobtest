import 'package:freezed_annotation/freezed_annotation.dart';

part 'sa_location.freezed.dart';
part 'sa_location.g.dart';

/// South African location entity for the shipped location database (~22K rows).
/// Used for location autocomplete and geohash-based proximity queries.
@freezed
class SaLocation with _$SaLocation {
  const factory SaLocation({
    required String id,
    required String name,
    required String type, // 'province', 'city', 'suburb'
    String? parentId,
    String? province,
    String? city,
    String? postalCode,
    double? latitude,
    double? longitude,
  }) = _SaLocation;

  const SaLocation._();

  factory SaLocation.fromJson(Map<String, dynamic> json) =>
      _$SaLocationFromJson(json);

  bool get isProvince => type == 'province';
  bool get isCity => type == 'city';
  bool get isSuburb => type == 'suburb';
  bool get hasCoordinates => latitude != null && longitude != null;
}
