// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  userId: json['userId'] as String,
  phoneNumber: json['phoneNumber'] as String,
  displayName: json['displayName'] as String,
  displayNameLower: json['displayNameLower'] as String?,
  username: json['username'] as String?,
  usernameLower: json['usernameLower'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  avatarColor: json['avatarColor'] as String?,
  gender: json['gender'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  province: json['province'] as String?,
  city: json['city'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  interests: (json['interests'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  selectedClusters: (json['selectedClusters'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  status: $enumDecode(_$UserStatusEnumMap, json['status']),
  referralCode: json['referralCode'] as String?,
  referredBy: json['referredBy'] as String?,
  hasAcceptedTerms: json['hasAcceptedTerms'] as bool,
  hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool,
  isPotEligible: json['isPotEligible'] as bool,
  potEligibleAt: json['potEligibleAt'] == null
      ? null
      : DateTime.parse(json['potEligibleAt'] as String),
  fcmToken: json['fcmToken'] as String?,
  riskScore: (json['riskScore'] as num?)?.toInt(),
  primaryDeviceId: json['primaryDeviceId'] as String?,
  riskLevel: json['riskLevel'] as String?,
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
  kycTier: json['kycTier'] as String? ?? 'none',
  privacy: json['privacy'] == null
      ? null
      : PrivacySettings.fromJson(json['privacy'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'phoneNumber': instance.phoneNumber,
      'displayName': instance.displayName,
      'displayNameLower': instance.displayNameLower,
      'username': instance.username,
      'usernameLower': instance.usernameLower,
      'avatarUrl': instance.avatarUrl,
      'avatarColor': instance.avatarColor,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'province': instance.province,
      'city': instance.city,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'languages': instance.languages,
      'interests': instance.interests,
      'selectedClusters': instance.selectedClusters,
      'status': _$UserStatusEnumMap[instance.status]!,
      'referralCode': instance.referralCode,
      'referredBy': instance.referredBy,
      'hasAcceptedTerms': instance.hasAcceptedTerms,
      'hasCompletedOnboarding': instance.hasCompletedOnboarding,
      'isPotEligible': instance.isPotEligible,
      'potEligibleAt': instance.potEligibleAt?.toIso8601String(),
      'fcmToken': instance.fcmToken,
      'riskScore': instance.riskScore,
      'primaryDeviceId': instance.primaryDeviceId,
      'riskLevel': instance.riskLevel,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'kycTier': instance.kycTier,
      'privacy': instance.privacy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
    };

const _$UserStatusEnumMap = {
  UserStatus.pending: 'pending',
  UserStatus.active: 'active',
  UserStatus.suspended: 'suspended',
  UserStatus.banned: 'banned',
};
