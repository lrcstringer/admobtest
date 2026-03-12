// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationData _$LocationDataFromJson(Map<String, dynamic> json) =>
    _LocationData(
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

Map<String, dynamic> _$LocationDataToJson(_LocationData instance) =>
    <String, dynamic>{
      'provinceId': instance.provinceId,
      'province': instance.province,
      'cityId': instance.cityId,
      'city': instance.city,
      'suburbId': instance.suburbId,
      'suburb': instance.suburb,
      'postalCode': instance.postalCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
