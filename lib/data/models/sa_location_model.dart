import '../../domain/entities/sa_location.dart';

class SaLocationModel {
  final String id;
  final String name;
  final String type;
  final String? parentId;
  final String? province;
  final String? city;
  final String? postalCode;
  final double? latitude;
  final double? longitude;

  const SaLocationModel({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
    this.province,
    this.city,
    this.postalCode,
    this.latitude,
    this.longitude,
  });

  factory SaLocationModel.fromJson(Map<String, dynamic> json) {
    return SaLocationModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? 'suburb',
      parentId: json['parentId'] as String?,
      province: json['province'] as String?,
      city: json['city'] as String?,
      postalCode: json['postalCode'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      if (parentId != null) 'parentId': parentId,
      if (province != null) 'province': province,
      if (city != null) 'city': city,
      if (postalCode != null) 'postalCode': postalCode,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }

  SaLocation toEntity() {
    return SaLocation(
      id: id,
      name: name,
      type: type,
      parentId: parentId,
      province: province,
      city: city,
      postalCode: postalCode,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory SaLocationModel.fromEntity(SaLocation entity) {
    return SaLocationModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      parentId: entity.parentId,
      province: entity.province,
      city: entity.city,
      postalCode: entity.postalCode,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
