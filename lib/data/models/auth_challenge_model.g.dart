// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthChallengeModelImpl _$$AuthChallengeModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthChallengeModelImpl(
  challengeId: json['challengeId'] as String,
  userId: json['userId'] as String,
  nonce: json['nonce'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  deviceId: json['deviceId'] as String?,
  respondedAt: json['respondedAt'] == null
      ? null
      : DateTime.parse(json['respondedAt'] as String),
);

Map<String, dynamic> _$$AuthChallengeModelImplToJson(
  _$AuthChallengeModelImpl instance,
) => <String, dynamic>{
  'challengeId': instance.challengeId,
  'userId': instance.userId,
  'nonce': instance.nonce,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'expiresAt': instance.expiresAt.toIso8601String(),
  'deviceId': instance.deviceId,
  'respondedAt': instance.respondedAt?.toIso8601String(),
};
