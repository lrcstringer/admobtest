// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sa_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaLocation _$SaLocationFromJson(Map<String, dynamic> json) => _SaLocation(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  parentId: json['parentId'] as String?,
  province: json['province'] as String?,
  city: json['city'] as String?,
  postalCode: json['postalCode'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$SaLocationToJson(_SaLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'parentId': instance.parentId,
      'province': instance.province,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
