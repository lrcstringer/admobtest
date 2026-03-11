// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trusted_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrustedDevice _$TrustedDeviceFromJson(Map<String, dynamic> json) =>
    _TrustedDevice(
      deviceId: json['deviceId'] as String,
      userId: json['userId'] as String,
      publicKeyPem: json['publicKeyPem'] as String,
      platform: json['platform'] as String,
      trusted: json['trusted'] as bool,
      revoked: json['revoked'] as bool,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
      fcmToken: json['fcmToken'] as String?,
      deviceModel: json['deviceModel'] as String?,
      osVersion: json['osVersion'] as String?,
      appVersion: json['appVersion'] as String?,
      manufacturer: json['manufacturer'] as String?,
      hardwareBacked: json['hardwareBacked'] as bool?,
      strongBox: json['strongBox'] as bool?,
    );

Map<String, dynamic> _$TrustedDeviceToJson(_TrustedDevice instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'userId': instance.userId,
      'publicKeyPem': instance.publicKeyPem,
      'platform': instance.platform,
      'trusted': instance.trusted,
      'revoked': instance.revoked,
      'registeredAt': instance.registeredAt.toIso8601String(),
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'fcmToken': instance.fcmToken,
      'deviceModel': instance.deviceModel,
      'osVersion': instance.osVersion,
      'appVersion': instance.appVersion,
      'manufacturer': instance.manufacturer,
      'hardwareBacked': instance.hardwareBacked,
      'strongBox': instance.strongBox,
    };
