// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupSettingsModel _$GroupSettingsModelFromJson(Map<String, dynamic> json) =>
    _GroupSettingsModel(
      requireApprovalAbove: (json['requireApprovalAbove'] as num).toInt(),
      allowMemberWithdrawals: json['allowMemberWithdrawals'] as bool,
      contributionCycle: json['contributionCycle'] as String,
      contributionAmount: (json['contributionAmount'] as num).toInt(),
      penaltyPercentage: (json['penaltyPercentage'] as num).toInt(),
    );

Map<String, dynamic> _$GroupSettingsModelToJson(_GroupSettingsModel instance) =>
    <String, dynamic>{
      'requireApprovalAbove': instance.requireApprovalAbove,
      'allowMemberWithdrawals': instance.allowMemberWithdrawals,
      'contributionCycle': instance.contributionCycle,
      'contributionAmount': instance.contributionAmount,
      'penaltyPercentage': instance.penaltyPercentage,
    };

_StokvelSettingsModel _$StokvelSettingsModelFromJson(
  Map<String, dynamic> json,
) => _StokvelSettingsModel(
  payoutType: json['payoutType'] as String,
  payoutSchedule: json['payoutSchedule'] as String,
  currentPayoutRecipient: json['currentPayoutRecipient'] as String?,
  nextPayoutDate: const NullableTimestampConverter().fromJson(
    json['nextPayoutDate'],
  ),
  payoutOrder: (json['payoutOrder'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$StokvelSettingsModelToJson(
  _StokvelSettingsModel instance,
) => <String, dynamic>{
  'payoutType': instance.payoutType,
  'payoutSchedule': instance.payoutSchedule,
  'currentPayoutRecipient': instance.currentPayoutRecipient,
  'nextPayoutDate': const NullableTimestampConverter().toJson(
    instance.nextPayoutDate,
  ),
  'payoutOrder': instance.payoutOrder,
};

_GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => _GroupModel(
  id: json['id'] as String,
  type: json['type'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  ownerId: json['ownerId'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  memberCount: (json['memberCount'] as num).toInt(),
  totalBalance: (json['totalBalance'] as num).toInt(),
  status: json['status'] as String,
  settings: GroupSettingsModel.fromJson(
    json['settings'] as Map<String, dynamic>,
  ),
  stokvelSettings: json['stokvelSettings'] == null
      ? null
      : StokvelSettingsModel.fromJson(
          json['stokvelSettings'] as Map<String, dynamic>,
        ),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$GroupModelToJson(_GroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'ownerId': instance.ownerId,
      'memberIds': instance.memberIds,
      'memberCount': instance.memberCount,
      'totalBalance': instance.totalBalance,
      'status': instance.status,
      'settings': instance.settings,
      'stokvelSettings': instance.stokvelSettings,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
