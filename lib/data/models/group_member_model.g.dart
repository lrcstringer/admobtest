// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) =>
    _GroupMemberModel(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      userId: json['userId'] as String,
      role: json['role'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      status: json['status'] as String,
      contributionBalance: (json['contributionBalance'] as num).toInt(),
      joinedAt: const NullableTimestampConverter().fromJson(json['joinedAt']),
      invitedBy: json['invitedBy'] as String,
      invitedAt: const TimestampConverter().fromJson(json['invitedAt']),
    );

Map<String, dynamic> _$GroupMemberModelToJson(_GroupMemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'userId': instance.userId,
      'role': instance.role,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'status': instance.status,
      'contributionBalance': instance.contributionBalance,
      'joinedAt': const NullableTimestampConverter().toJson(instance.joinedAt),
      'invitedBy': instance.invitedBy,
      'invitedAt': const TimestampConverter().toJson(instance.invitedAt),
    };
