// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e2ee_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeyBundleImpl _$$KeyBundleImplFromJson(Map<String, dynamic> json) =>
    _$KeyBundleImpl(
      identityKeyPair: json['identityKeyPair'] as String,
      signedPreKey: json['signedPreKey'] as String,
      signedPreKeySignature: json['signedPreKeySignature'] as String,
      oneTimePreKeys: (json['oneTimePreKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      registrationId: (json['registrationId'] as num).toInt(),
    );

Map<String, dynamic> _$$KeyBundleImplToJson(_$KeyBundleImpl instance) =>
    <String, dynamic>{
      'identityKeyPair': instance.identityKeyPair,
      'signedPreKey': instance.signedPreKey,
      'signedPreKeySignature': instance.signedPreKeySignature,
      'oneTimePreKeys': instance.oneTimePreKeys,
      'registrationId': instance.registrationId,
    };

_$PublicKeyBundleImpl _$$PublicKeyBundleImplFromJson(
  Map<String, dynamic> json,
) => _$PublicKeyBundleImpl(
  identityKey: json['identityKey'] as String,
  signedPreKey: json['signedPreKey'] as String,
  signedPreKeySignature: json['signedPreKeySignature'] as String,
  oneTimePreKeys: (json['oneTimePreKeys'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  registrationId: (json['registrationId'] as num).toInt(),
  userId: json['userId'] as String,
);

Map<String, dynamic> _$$PublicKeyBundleImplToJson(
  _$PublicKeyBundleImpl instance,
) => <String, dynamic>{
  'identityKey': instance.identityKey,
  'signedPreKey': instance.signedPreKey,
  'signedPreKeySignature': instance.signedPreKeySignature,
  'oneTimePreKeys': instance.oneTimePreKeys,
  'registrationId': instance.registrationId,
  'userId': instance.userId,
};

_$BackupMetadataImpl _$$BackupMetadataImplFromJson(Map<String, dynamic> json) =>
    _$BackupMetadataImpl(
      backupExists: json['backupExists'] as bool,
      lastBackupAt: json['lastBackupAt'] == null
          ? null
          : DateTime.parse(json['lastBackupAt'] as String),
      backupVersion: (json['backupVersion'] as num?)?.toInt(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$BackupMetadataImplToJson(
  _$BackupMetadataImpl instance,
) => <String, dynamic>{
  'backupExists': instance.backupExists,
  'lastBackupAt': instance.lastBackupAt?.toIso8601String(),
  'backupVersion': instance.backupVersion,
  'userId': instance.userId,
};
