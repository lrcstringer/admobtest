import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/trusted_device.dart';

/// Firestore data model for trusted devices.
///
/// Handles serialization/deserialization between Firestore documents
/// and the [TrustedDevice] domain entity.
class DeviceModel {
  final String deviceId;
  final String userId;
  final String publicKeyPem;
  final String platform;
  final bool trusted;
  final bool revoked;
  final DateTime registeredAt;
  final DateTime? lastUsedAt;
  final String? fcmToken;
  final String? deviceModel;
  final String? osVersion;
  final String? appVersion;
  final String? manufacturer;
  final bool? hardwareBacked;
  final bool? strongBox;

  const DeviceModel({
    required this.deviceId,
    required this.userId,
    required this.publicKeyPem,
    required this.platform,
    required this.trusted,
    required this.revoked,
    required this.registeredAt,
    this.lastUsedAt,
    this.fcmToken,
    this.deviceModel,
    this.osVersion,
    this.appVersion,
    this.manufacturer,
    this.hardwareBacked,
    this.strongBox,
  });

  /// Create from Firestore document snapshot.
  factory DeviceModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return DeviceModel(
      deviceId: doc.id,
      userId: data['userId'] as String,
      publicKeyPem: data['publicKeyPem'] as String,
      platform: data['platform'] as String,
      trusted: data['trusted'] as bool? ?? false,
      revoked: data['revoked'] as bool? ?? false,
      registeredAt: (data['registeredAt'] as Timestamp).toDate(),
      lastUsedAt: (data['lastUsedAt'] as Timestamp?)?.toDate(),
      fcmToken: data['fcmToken'] as String?,
      deviceModel: data['deviceModel'] as String?,
      osVersion: data['osVersion'] as String?,
      appVersion: data['appVersion'] as String?,
      manufacturer: data['manufacturer'] as String?,
      hardwareBacked: data['hardwareBacked'] as bool?,
      strongBox: data['strongBox'] as bool?,
    );
  }

  /// Create from Cloud Function response map.
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      deviceId: json['deviceId'] as String,
      userId: json['userId'] as String,
      publicKeyPem: json['publicKeyPem'] as String,
      platform: json['platform'] as String,
      trusted: json['trusted'] as bool? ?? false,
      revoked: json['revoked'] as bool? ?? false,
      registeredAt: json['registeredAt'] is Timestamp
          ? (json['registeredAt'] as Timestamp).toDate()
          : DateTime.parse(json['registeredAt'] as String),
      lastUsedAt: json['lastUsedAt'] != null
          ? (json['lastUsedAt'] is Timestamp
              ? (json['lastUsedAt'] as Timestamp).toDate()
              : DateTime.parse(json['lastUsedAt'] as String))
          : null,
      fcmToken: json['fcmToken'] as String?,
      deviceModel: json['deviceModel'] as String?,
      osVersion: json['osVersion'] as String?,
      appVersion: json['appVersion'] as String?,
      manufacturer: json['manufacturer'] as String?,
      hardwareBacked: json['hardwareBacked'] as bool?,
      strongBox: json['strongBox'] as bool?,
    );
  }

  /// Convert to Firestore document data.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'publicKeyPem': publicKeyPem,
      'platform': platform,
      'trusted': trusted,
      'revoked': revoked,
      'registeredAt': Timestamp.fromDate(registeredAt),
      'lastUsedAt': lastUsedAt != null ? Timestamp.fromDate(lastUsedAt!) : null,
      'fcmToken': fcmToken,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'manufacturer': manufacturer,
      'hardwareBacked': hardwareBacked,
      'strongBox': strongBox,
    };
  }

  /// Convert to domain entity.
  TrustedDevice toEntity() {
    return TrustedDevice(
      deviceId: deviceId,
      userId: userId,
      publicKeyPem: publicKeyPem,
      platform: platform,
      trusted: trusted,
      revoked: revoked,
      registeredAt: registeredAt,
      lastUsedAt: lastUsedAt,
      fcmToken: fcmToken,
      deviceModel: deviceModel,
      osVersion: osVersion,
      appVersion: appVersion,
      manufacturer: manufacturer,
      hardwareBacked: hardwareBacked,
      strongBox: strongBox,
    );
  }

  /// Create from domain entity.
  factory DeviceModel.fromEntity(TrustedDevice entity) {
    return DeviceModel(
      deviceId: entity.deviceId,
      userId: entity.userId,
      publicKeyPem: entity.publicKeyPem,
      platform: entity.platform,
      trusted: entity.trusted,
      revoked: entity.revoked,
      registeredAt: entity.registeredAt,
      lastUsedAt: entity.lastUsedAt,
      fcmToken: entity.fcmToken,
      deviceModel: entity.deviceModel,
      osVersion: entity.osVersion,
      appVersion: entity.appVersion,
      manufacturer: entity.manufacturer,
      hardwareBacked: entity.hardwareBacked,
      strongBox: entity.strongBox,
    );
  }
}
