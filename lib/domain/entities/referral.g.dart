// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Referral _$ReferralFromJson(Map<String, dynamic> json) => _Referral(
  id: json['id'] as String,
  referrerUserId: json['referrerUserId'] as String,
  refereeUserId: json['refereeUserId'] as String,
  refereeDisplayName: json['refereeDisplayName'] as String?,
  refereeUsername: json['refereeUsername'] as String?,
  refereeAvatarUrl: json['refereeAvatarUrl'] as String?,
  status: $enumDecode(_$ReferralStatusEnumMap, json['status']),
  referralCode: json['referralCode'] as String,
  referrerReward: (json['referrerReward'] as num?)?.toInt(),
  refereeReward: (json['refereeReward'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  registeredAt: json['registeredAt'] == null
      ? null
      : DateTime.parse(json['registeredAt'] as String),
  qualifiedAt: json['qualifiedAt'] == null
      ? null
      : DateTime.parse(json['qualifiedAt'] as String),
  rewardedAt: json['rewardedAt'] == null
      ? null
      : DateTime.parse(json['rewardedAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$ReferralToJson(_Referral instance) => <String, dynamic>{
  'id': instance.id,
  'referrerUserId': instance.referrerUserId,
  'refereeUserId': instance.refereeUserId,
  'refereeDisplayName': instance.refereeDisplayName,
  'refereeUsername': instance.refereeUsername,
  'refereeAvatarUrl': instance.refereeAvatarUrl,
  'status': _$ReferralStatusEnumMap[instance.status]!,
  'referralCode': instance.referralCode,
  'referrerReward': instance.referrerReward,
  'refereeReward': instance.refereeReward,
  'createdAt': instance.createdAt.toIso8601String(),
  'registeredAt': instance.registeredAt?.toIso8601String(),
  'qualifiedAt': instance.qualifiedAt?.toIso8601String(),
  'rewardedAt': instance.rewardedAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
};

const _$ReferralStatusEnumMap = {
  ReferralStatus.pending: 'pending',
  ReferralStatus.registered: 'registered',
  ReferralStatus.qualified: 'qualified',
  ReferralStatus.rewarded: 'rewarded',
  ReferralStatus.expired: 'expired',
};

_ReferralStats _$ReferralStatsFromJson(Map<String, dynamic> json) =>
    _ReferralStats(
      totalReferrals: (json['totalReferrals'] as num).toInt(),
      pendingReferrals: (json['pendingReferrals'] as num).toInt(),
      completedReferrals: (json['completedReferrals'] as num).toInt(),
      totalEarned: (json['totalEarned'] as num).toInt(),
      referralCode: json['referralCode'] as String,
      referralLink: json['referralLink'] as String,
    );

Map<String, dynamic> _$ReferralStatsToJson(_ReferralStats instance) =>
    <String, dynamic>{
      'totalReferrals': instance.totalReferrals,
      'pendingReferrals': instance.pendingReferrals,
      'completedReferrals': instance.completedReferrals,
      'totalEarned': instance.totalEarned,
      'referralCode': instance.referralCode,
      'referralLink': instance.referralLink,
    };
