// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gooi_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GooiMember _$GooiMemberFromJson(Map<String, dynamic> json) => _GooiMember(
  id: json['id'] as String,
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  position: (json['position'] as num?)?.toInt() ?? 0,
  role: $enumDecode(_$GooiMemberRoleEnumMap, json['role']),
  status: $enumDecode(_$GooiMemberStatusEnumMap, json['status']),
  contributedCycles: (json['contributedCycles'] as num?)?.toInt() ?? 0,
  missedCycles: (json['missedCycles'] as num?)?.toInt() ?? 0,
  outstandingDebt: (json['outstandingDebt'] as num?)?.toInt() ?? 0,
  autoContribute: json['autoContribute'] as bool? ?? false,
  autoContributeSubAccountId: json['autoContributeSubAccountId'] as String?,
  preferredSubAccountId: json['preferredSubAccountId'] as String?,
  delegationExpiresAt: json['delegationExpiresAt'] == null
      ? null
      : DateTime.parse(json['delegationExpiresAt'] as String),
  joinedAt: json['joinedAt'] == null
      ? null
      : DateTime.parse(json['joinedAt'] as String),
  invitedAt: DateTime.parse(json['invitedAt'] as String),
);

Map<String, dynamic> _$GooiMemberToJson(_GooiMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'position': instance.position,
      'role': _$GooiMemberRoleEnumMap[instance.role]!,
      'status': _$GooiMemberStatusEnumMap[instance.status]!,
      'contributedCycles': instance.contributedCycles,
      'missedCycles': instance.missedCycles,
      'outstandingDebt': instance.outstandingDebt,
      'autoContribute': instance.autoContribute,
      'autoContributeSubAccountId': instance.autoContributeSubAccountId,
      'preferredSubAccountId': instance.preferredSubAccountId,
      'delegationExpiresAt': instance.delegationExpiresAt?.toIso8601String(),
      'joinedAt': instance.joinedAt?.toIso8601String(),
      'invitedAt': instance.invitedAt.toIso8601String(),
    };

const _$GooiMemberRoleEnumMap = {
  GooiMemberRole.initiator: 'initiator',
  GooiMemberRole.member: 'member',
  GooiMemberRole.triggerDelegate: 'triggerDelegate',
};

const _$GooiMemberStatusEnumMap = {
  GooiMemberStatus.invited: 'invited',
  GooiMemberStatus.accepted: 'accepted',
  GooiMemberStatus.active: 'active',
  GooiMemberStatus.suspended: 'suspended',
  GooiMemberStatus.removed: 'removed',
};
