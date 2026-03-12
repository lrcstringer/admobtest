import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_data.freezed.dart';
part 'location_data.g.dart';

/// Structured location value object used by marketplace listings and user profiles.
/// Represents a specific location within South Africa's province → city → suburb hierarchy.
@freezed
class LocationData with _$LocationData {
  const factory LocationData({
    String? provinceId,
    String? province,
    String? cityId,
    String? city,
    String? suburbId,
    String? suburb,
    String? postalCode,
    double? latitude,
    double? longitude,
  }) = _LocationData;

  const LocationData._();

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  /// Short display: "Suburb, City" or "City, Province" or just "Province".
  String get shortDisplay {
    if (suburb != null && city != null) return '$suburb, $city';
    if (city != null && province != null) return '$city, $province';
    if (province != null) return province!;
    return '';
  }

  /// Full display: "Suburb, City, Province".
  String get fullDisplay {
    final parts = [suburb, city, province].whereType<String>();
    return parts.join(', ');
  }

  bool get hasCoordinates => latitude != null && longitude != null;
  bool get isEmpty =>
      province == null && city == null && suburb == null;
}
