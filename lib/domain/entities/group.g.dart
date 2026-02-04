// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupSettingsImpl _$$GroupSettingsImplFromJson(Map<String, dynamic> json) =>
    _$GroupSettingsImpl(
      requireApprovalAbove: (json['requireApprovalAbove'] as num).toInt(),
      allowMemberWithdrawals: json['allowMemberWithdrawals'] as bool,
      contributionCycle: $enumDecode(
        _$ContributionCycleEnumMap,
        json['contributionCycle'],
      ),
      contributionAmount: (json['contributionAmount'] as num).toInt(),
      penaltyPercentage: (json['penaltyPercentage'] as num).toInt(),
    );

Map<String, dynamic> _$$GroupSettingsImplToJson(
  _$GroupSettingsImpl instance,
) => <String, dynamic>{
  'requireApprovalAbove': instance.requireApprovalAbove,
  'allowMemberWithdrawals': instance.allowMemberWithdrawals,
  'contributionCycle': _$ContributionCycleEnumMap[instance.contributionCycle]!,
  'contributionAmount': instance.contributionAmount,
  'penaltyPercentage': instance.penaltyPercentage,
};

const _$ContributionCycleEnumMap = {
  ContributionCycle.weekly: 'weekly',
  ContributionCycle.monthly: 'monthly',
  ContributionCycle.none: 'none',
};

_$StokvelSettingsImpl _$$StokvelSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$StokvelSettingsImpl(
  payoutType: $enumDecode(_$PayoutTypeEnumMap, json['payoutType']),
  payoutSchedule: json['payoutSchedule'] as String,
  currentPayoutRecipient: json['currentPayoutRecipient'] as String?,
  nextPayoutDate: json['nextPayoutDate'] == null
      ? null
      : DateTime.parse(json['nextPayoutDate'] as String),
  payoutOrder: (json['payoutOrder'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$StokvelSettingsImplToJson(
  _$StokvelSettingsImpl instance,
) => <String, dynamic>{
  'payoutType': _$PayoutTypeEnumMap[instance.payoutType]!,
  'payoutSchedule': instance.payoutSchedule,
  'currentPayoutRecipient': instance.currentPayoutRecipient,
  'nextPayoutDate': instance.nextPayoutDate?.toIso8601String(),
  'payoutOrder': instance.payoutOrder,
};

const _$PayoutTypeEnumMap = {
  PayoutType.rotating: 'rotating',
  PayoutType.lottery: 'lottery',
  PayoutType.fixedDate: 'fixed_date',
  PayoutType.goalReached: 'goal_reached',
};

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
  id: json['id'] as String,
  type: $enumDecode(_$GroupTypeEnumMap, json['type']),
  name: json['name'] as String,
  description: json['description'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  ownerId: json['ownerId'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  memberCount: (json['memberCount'] as num).toInt(),
  totalBalance: (json['totalBalance'] as num).toInt(),
  status: $enumDecode(_$GroupStatusEnumMap, json['status']),
  settings: GroupSettings.fromJson(json['settings'] as Map<String, dynamic>),
  stokvelSettings: json['stokvelSettings'] == null
      ? null
      : StokvelSettings.fromJson(
          json['stokvelSettings'] as Map<String, dynamic>,
        ),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$GroupTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'ownerId': instance.ownerId,
      'memberIds': instance.memberIds,
      'memberCount': instance.memberCount,
      'totalBalance': instance.totalBalance,
      'status': _$GroupStatusEnumMap[instance.status]!,
      'settings': instance.settings,
      'stokvelSettings': instance.stokvelSettings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$GroupTypeEnumMap = {
  GroupType.stokvel: 'stokvel',
  GroupType.family: 'family',
  GroupType.organization: 'organization',
  GroupType.club: 'club',
};

const _$GroupStatusEnumMap = {
  GroupStatus.active: 'active',
  GroupStatus.suspended: 'suspended',
  GroupStatus.closed: 'closed',
};
