// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) => _GroupMember(
  id: json['id'] as String,
  groupId: json['groupId'] as String,
  userId: json['userId'] as String,
  role: $enumDecode(_$GroupRoleEnumMap, json['role']),
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  status: $enumDecode(_$GroupMemberStatusEnumMap, json['status']),
  contributionBalance: (json['contributionBalance'] as num).toInt(),
  joinedAt: json['joinedAt'] == null
      ? null
      : DateTime.parse(json['joinedAt'] as String),
  invitedBy: json['invitedBy'] as String,
  invitedAt: DateTime.parse(json['invitedAt'] as String),
);

Map<String, dynamic> _$GroupMemberToJson(_GroupMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'userId': instance.userId,
      'role': _$GroupRoleEnumMap[instance.role]!,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'status': _$GroupMemberStatusEnumMap[instance.status]!,
      'contributionBalance': instance.contributionBalance,
      'joinedAt': instance.joinedAt?.toIso8601String(),
      'invitedBy': instance.invitedBy,
      'invitedAt': instance.invitedAt.toIso8601String(),
    };

const _$GroupRoleEnumMap = {
  GroupRole.owner: 'owner',
  GroupRole.admin: 'admin',
  GroupRole.treasurer: 'treasurer',
  GroupRole.member: 'member',
  GroupRole.viewer: 'viewer',
};

const _$GroupMemberStatusEnumMap = {
  GroupMemberStatus.active: 'active',
  GroupMemberStatus.invited: 'invited',
  GroupMemberStatus.blocked: 'blocked',
};
