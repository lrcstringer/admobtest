import '../../domain/entities/location_data.dart';

class LocationDataModel {
  final String? provinceId;
  final String? province;
  final String? cityId;
  final String? city;
  final String? suburbId;
  final String? suburb;
  final String? postalCode;
  final double? latitude;
  final double? longitude;

  const LocationDataModel({
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.suburbId,
    this.suburb,
    this.postalCode,
    this.latitude,
    this.longitude,
  });

  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      provinceId: json['provinceId'] as String?,
      province: json['province'] as String?,
      cityId: json['cityId'] as String?,
      city: json['city'] as String?,
      suburbId: json['suburbId'] as String?,
      suburb: json['suburb'] as String?,
      postalCode: json['postalCode'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (provinceId != null) 'provinceId': provinceId,
      if (province != null) 'province': province,
      if (cityId != null) 'cityId': cityId,
      if (city != null) 'city': city,
      if (suburbId != null) 'suburbId': suburbId,
      if (suburb != null) 'suburb': suburb,
      if (postalCode != null) 'postalCode': postalCode,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }

  LocationData toEntity() {
    return LocationData(
      provinceId: provinceId,
      province: province,
      cityId: cityId,
      city: city,
      suburbId: suburbId,
      suburb: suburb,
      postalCode: postalCode,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory LocationDataModel.fromEntity(LocationData entity) {
    return LocationDataModel(
      provinceId: entity.provinceId,
      province: entity.province,
      cityId: entity.cityId,
      city: entity.city,
      suburbId: entity.suburbId,
      suburb: entity.suburb,
      postalCode: entity.postalCode,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
