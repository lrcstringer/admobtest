// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunitySettingsModelImpl _$$CommunitySettingsModelImplFromJson(
  Map<String, dynamic> json,
) => _$CommunitySettingsModelImpl(
  maxMembers: (json['maxMembers'] as num?)?.toInt() ?? 100,
  allowMemberInvites: json['allowMemberInvites'] as bool? ?? true,
  onlyAdminsPost: json['onlyAdminsPost'] as bool? ?? false,
  membersCanShareMedia: json['membersCanShareMedia'] as bool? ?? true,
  enableFinancials: json['enableFinancials'] as bool? ?? false,
  requireApprovalAbove: (json['requireApprovalAbove'] as num?)?.toInt() ?? 5000,
  allowMemberWithdrawals: json['allowMemberWithdrawals'] as bool? ?? false,
  contributionCycle: json['contributionCycle'] as String? ?? 'none',
  contributionAmount: (json['contributionAmount'] as num?)?.toInt() ?? 0,
  penaltyPercentage: (json['penaltyPercentage'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$CommunitySettingsModelImplToJson(
  _$CommunitySettingsModelImpl instance,
) => <String, dynamic>{
  'maxMembers': instance.maxMembers,
  'allowMemberInvites': instance.allowMemberInvites,
  'onlyAdminsPost': instance.onlyAdminsPost,
  'membersCanShareMedia': instance.membersCanShareMedia,
  'enableFinancials': instance.enableFinancials,
  'requireApprovalAbove': instance.requireApprovalAbove,
  'allowMemberWithdrawals': instance.allowMemberWithdrawals,
  'contributionCycle': instance.contributionCycle,
  'contributionAmount': instance.contributionAmount,
  'penaltyPercentage': instance.penaltyPercentage,
};

_$CommunityModelImpl _$$CommunityModelImplFromJson(Map<String, dynamic> json) =>
    _$CommunityModelImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      ownerId: json['ownerId'] as String,
      memberIds: (json['memberIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      adminIds: (json['adminIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      memberCount: (json['memberCount'] as num).toInt(),
      totalBalance: (json['totalBalance'] as num?)?.toInt() ?? 0,
      status: json['status'] as String,
      settings: CommunitySettingsModel.fromJson(
        json['settings'] as Map<String, dynamic>,
      ),
      stokvelSettings: json['stokvelSettings'] == null
          ? null
          : StokvelSettingsModel.fromJson(
              json['stokvelSettings'] as Map<String, dynamic>,
            ),
      lastMessageText: json['lastMessageText'] as String?,
      lastMessageSenderId: json['lastMessageSenderId'] as String?,
      lastMessageSenderName: json['lastMessageSenderName'] as String?,
      lastMessageType: json['lastMessageType'] as String?,
      lastMessageAt: const NullableTimestampConverter().fromJson(
        json['lastMessageAt'],
      ),
      unreadCounts:
          (json['unreadCounts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      muted:
          (json['muted'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      lastMessageEncryptedPreviews:
          (json['lastMessageEncryptedPreviews'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$CommunityModelImplToJson(
  _$CommunityModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'name': instance.name,
  'description': instance.description,
  'avatarUrl': instance.avatarUrl,
  'ownerId': instance.ownerId,
  'memberIds': instance.memberIds,
  'adminIds': instance.adminIds,
  'memberCount': instance.memberCount,
  'totalBalance': instance.totalBalance,
  'status': instance.status,
  'settings': instance.settings,
  'stokvelSettings': instance.stokvelSettings,
  'lastMessageText': instance.lastMessageText,
  'lastMessageSenderId': instance.lastMessageSenderId,
  'lastMessageSenderName': instance.lastMessageSenderName,
  'lastMessageType': instance.lastMessageType,
  'lastMessageAt': const NullableTimestampConverter().toJson(
    instance.lastMessageAt,
  ),
  'unreadCounts': instance.unreadCounts,
  'muted': instance.muted,
  'lastMessageEncryptedPreviews': instance.lastMessageEncryptedPreviews,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};
