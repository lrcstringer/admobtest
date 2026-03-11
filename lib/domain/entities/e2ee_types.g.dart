// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e2ee_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KeyBundle _$KeyBundleFromJson(Map<String, dynamic> json) => _KeyBundle(
  identityKeyPair: json['identityKeyPair'] as String,
  signedPreKey: json['signedPreKey'] as String,
  signedPreKeySignature: json['signedPreKeySignature'] as String,
  oneTimePreKeys: (json['oneTimePreKeys'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  registrationId: (json['registrationId'] as num).toInt(),
  ed25519IdentityKeyPair: json['ed25519IdentityKeyPair'] as String?,
  ed25519Signature: json['ed25519Signature'] as String?,
  signedPreKeyId: (json['signedPreKeyId'] as num?)?.toInt(),
  nextOneTimePreKeyId: (json['nextOneTimePreKeyId'] as num?)?.toInt(),
  protocolVersion: (json['protocolVersion'] as num?)?.toInt() ?? 2,
  previousSignedPreKey: json['previousSignedPreKey'] as String?,
  previousSignedPreKeyId: (json['previousSignedPreKeyId'] as num?)?.toInt(),
  previousSignedPreKeySignature:
      json['previousSignedPreKeySignature'] as String?,
  signedPreKeyTimestamp: json['signedPreKeyTimestamp'] == null
      ? null
      : DateTime.parse(json['signedPreKeyTimestamp'] as String),
  previousSignedPreKeyTimestamp: json['previousSignedPreKeyTimestamp'] == null
      ? null
      : DateTime.parse(json['previousSignedPreKeyTimestamp'] as String),
);

Map<String, dynamic> _$KeyBundleToJson(
  _KeyBundle instance,
) => <String, dynamic>{
  'identityKeyPair': instance.identityKeyPair,
  'signedPreKey': instance.signedPreKey,
  'signedPreKeySignature': instance.signedPreKeySignature,
  'oneTimePreKeys': instance.oneTimePreKeys,
  'registrationId': instance.registrationId,
  'ed25519IdentityKeyPair': instance.ed25519IdentityKeyPair,
  'ed25519Signature': instance.ed25519Signature,
  'signedPreKeyId': instance.signedPreKeyId,
  'nextOneTimePreKeyId': instance.nextOneTimePreKeyId,
  'protocolVersion': instance.protocolVersion,
  'previousSignedPreKey': instance.previousSignedPreKey,
  'previousSignedPreKeyId': instance.previousSignedPreKeyId,
  'previousSignedPreKeySignature': instance.previousSignedPreKeySignature,
  'signedPreKeyTimestamp': instance.signedPreKeyTimestamp?.toIso8601String(),
  'previousSignedPreKeyTimestamp': instance.previousSignedPreKeyTimestamp
      ?.toIso8601String(),
};

_PublicKeyBundle _$PublicKeyBundleFromJson(Map<String, dynamic> json) =>
    _PublicKeyBundle(
      identityKey: json['identityKey'] as String,
      signedPreKey: json['signedPreKey'] as String,
      signedPreKeySignature: json['signedPreKeySignature'] as String,
      oneTimePreKeys: (json['oneTimePreKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      registrationId: (json['registrationId'] as num).toInt(),
      userId: json['userId'] as String,
      ed25519IdentityKey: json['ed25519IdentityKey'] as String?,
      ed25519Signature: json['ed25519Signature'] as String?,
      signedPreKeyId: (json['signedPreKeyId'] as num?)?.toInt(),
      oneTimePreKeyId: (json['oneTimePreKeyId'] as num?)?.toInt(),
      protocolVersion: (json['protocolVersion'] as num?)?.toInt() ?? 2,
    );

Map<String, dynamic> _$PublicKeyBundleToJson(_PublicKeyBundle instance) =>
    <String, dynamic>{
      'identityKey': instance.identityKey,
      'signedPreKey': instance.signedPreKey,
      'signedPreKeySignature': instance.signedPreKeySignature,
      'oneTimePreKeys': instance.oneTimePreKeys,
      'registrationId': instance.registrationId,
      'userId': instance.userId,
      'ed25519IdentityKey': instance.ed25519IdentityKey,
      'ed25519Signature': instance.ed25519Signature,
      'signedPreKeyId': instance.signedPreKeyId,
      'oneTimePreKeyId': instance.oneTimePreKeyId,
      'protocolVersion': instance.protocolVersion,
    };

_BackupMetadata _$BackupMetadataFromJson(Map<String, dynamic> json) =>
    _BackupMetadata(
      backupExists: json['backupExists'] as bool,
      lastBackupAt: json['lastBackupAt'] == null
          ? null
          : DateTime.parse(json['lastBackupAt'] as String),
      backupVersion: (json['backupVersion'] as num?)?.toInt(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$BackupMetadataToJson(_BackupMetadata instance) =>
    <String, dynamic>{
      'backupExists': instance.backupExists,
      'lastBackupAt': instance.lastBackupAt?.toIso8601String(),
      'backupVersion': instance.backupVersion,
      'userId': instance.userId,
    };
