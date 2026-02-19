// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityMemberModelImpl _$$CommunityMemberModelImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityMemberModelImpl(
  id: json['id'] as String,
  communityId: json['communityId'] as String,
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  role: json['role'] as String,
  status: json['status'] as String,
  contributionBalance: (json['contributionBalance'] as num?)?.toInt() ?? 0,
  joinedAt: const NullableTimestampConverter().fromJson(json['joinedAt']),
  invitedBy: json['invitedBy'] as String,
  invitedAt: const TimestampConverter().fromJson(json['invitedAt']),
  lastReadAt: const NullableTimestampConverter().fromJson(json['lastReadAt']),
);

Map<String, dynamic> _$$CommunityMemberModelImplToJson(
  _$CommunityMemberModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'userId': instance.userId,
  'displayName': instance.displayName,
  'avatarUrl': instance.avatarUrl,
  'role': instance.role,
  'status': instance.status,
  'contributionBalance': instance.contributionBalance,
  'joinedAt': const NullableTimestampConverter().toJson(instance.joinedAt),
  'invitedBy': instance.invitedBy,
  'invitedAt': const TimestampConverter().toJson(instance.invitedAt),
  'lastReadAt': const NullableTimestampConverter().toJson(instance.lastReadAt),
};
