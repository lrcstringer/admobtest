// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityMemberImpl _$$CommunityMemberImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityMemberImpl(
  id: json['id'] as String,
  communityId: json['communityId'] as String,
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  role: $enumDecode(_$MemberRoleEnumMap, json['role']),
  status: $enumDecode(_$MemberStatusEnumMap, json['status']),
  contributionBalance: (json['contributionBalance'] as num?)?.toInt() ?? 0,
  joinedAt: json['joinedAt'] == null
      ? null
      : DateTime.parse(json['joinedAt'] as String),
  invitedBy: json['invitedBy'] as String,
  invitedAt: DateTime.parse(json['invitedAt'] as String),
  lastReadAt: json['lastReadAt'] == null
      ? null
      : DateTime.parse(json['lastReadAt'] as String),
);

Map<String, dynamic> _$$CommunityMemberImplToJson(
  _$CommunityMemberImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'userId': instance.userId,
  'displayName': instance.displayName,
  'avatarUrl': instance.avatarUrl,
  'role': _$MemberRoleEnumMap[instance.role]!,
  'status': _$MemberStatusEnumMap[instance.status]!,
  'contributionBalance': instance.contributionBalance,
  'joinedAt': instance.joinedAt?.toIso8601String(),
  'invitedBy': instance.invitedBy,
  'invitedAt': instance.invitedAt.toIso8601String(),
  'lastReadAt': instance.lastReadAt?.toIso8601String(),
};

const _$MemberRoleEnumMap = {
  MemberRole.owner: 'owner',
  MemberRole.admin: 'admin',
  MemberRole.treasurer: 'treasurer',
  MemberRole.member: 'member',
  MemberRole.viewer: 'viewer',
};

const _$MemberStatusEnumMap = {
  MemberStatus.active: 'active',
  MemberStatus.invited: 'invited',
  MemberStatus.blocked: 'blocked',
};
