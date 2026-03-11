// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  phoneNumber: json['phoneNumber'] as String,
  status: $enumDecode(_$UserStatusEnumMap, json['status']),
  isPotEligible: json['isPotEligible'] as bool,
  hasAcceptedTerms: json['hasAcceptedTerms'] as bool,
  hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
  potEligibleAt: json['potEligibleAt'] == null
      ? null
      : DateTime.parse(json['potEligibleAt'] as String),
  referralCode: json['referralCode'] as String?,
  referredBy: json['referredBy'] as String?,
  currentVisitorId: json['currentVisitorId'] as String?,
  profile: json['profile'] == null
      ? null
      : UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
  riskScore: (json['riskScore'] as num?)?.toInt(),
  primaryDeviceId: json['primaryDeviceId'] as String?,
  riskLevel: json['riskLevel'] as String?,
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
  kycTier: json['kycTier'] as String? ?? 'none',
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'status': _$UserStatusEnumMap[instance.status]!,
  'isPotEligible': instance.isPotEligible,
  'hasAcceptedTerms': instance.hasAcceptedTerms,
  'hasCompletedOnboarding': instance.hasCompletedOnboarding,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
  'potEligibleAt': instance.potEligibleAt?.toIso8601String(),
  'referralCode': instance.referralCode,
  'referredBy': instance.referredBy,
  'currentVisitorId': instance.currentVisitorId,
  'profile': instance.profile,
  'riskScore': instance.riskScore,
  'primaryDeviceId': instance.primaryDeviceId,
  'riskLevel': instance.riskLevel,
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
  'kycTier': instance.kycTier,
};

const _$UserStatusEnumMap = {
  UserStatus.pending: 'pending',
  UserStatus.active: 'active',
  UserStatus.suspended: 'suspended',
  UserStatus.banned: 'banned',
};
