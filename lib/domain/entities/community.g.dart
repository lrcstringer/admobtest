// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunitySettings _$CommunitySettingsFromJson(Map<String, dynamic> json) =>
    _CommunitySettings(
      maxMembers: (json['maxMembers'] as num?)?.toInt() ?? 100,
      allowMemberInvites: json['allowMemberInvites'] as bool? ?? true,
      onlyAdminsPost: json['onlyAdminsPost'] as bool? ?? false,
      membersCanShareMedia: json['membersCanShareMedia'] as bool? ?? true,
      enableFinancials: json['enableFinancials'] as bool? ?? false,
      requireApprovalAbove:
          (json['requireApprovalAbove'] as num?)?.toInt() ?? 5000,
      allowMemberWithdrawals: json['allowMemberWithdrawals'] as bool? ?? false,
      contributionCycle: json['contributionCycle'] as String? ?? 'none',
      contributionAmount: (json['contributionAmount'] as num?)?.toInt() ?? 0,
      penaltyPercentage: (json['penaltyPercentage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CommunitySettingsToJson(_CommunitySettings instance) =>
    <String, dynamic>{
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

_Community _$CommunityFromJson(Map<String, dynamic> json) => _Community(
  id: json['id'] as String,
  type: $enumDecode(_$CommunityTypeEnumMap, json['type']),
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
  totalBalance: (json['totalBalance'] as num).toInt(),
  status: $enumDecode(_$CommunityStatusEnumMap, json['status']),
  settings: CommunitySettings.fromJson(
    json['settings'] as Map<String, dynamic>,
  ),
  stokvelSettings: json['stokvelSettings'] == null
      ? null
      : StokvelSettings.fromJson(
          json['stokvelSettings'] as Map<String, dynamic>,
        ),
  lastMessageText: json['lastMessageText'] as String?,
  lastMessageSenderId: json['lastMessageSenderId'] as String?,
  lastMessageSenderName: json['lastMessageSenderName'] as String?,
  lastMessageType: json['lastMessageType'] as String?,
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
  unreadCounts: Map<String, int>.from(json['unreadCounts'] as Map),
  muted: Map<String, bool>.from(json['muted'] as Map),
  lastMessageEncryptedPreviews:
      (json['lastMessageEncryptedPreviews'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CommunityToJson(_Community instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CommunityTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'ownerId': instance.ownerId,
      'memberIds': instance.memberIds,
      'adminIds': instance.adminIds,
      'memberCount': instance.memberCount,
      'totalBalance': instance.totalBalance,
      'status': _$CommunityStatusEnumMap[instance.status]!,
      'settings': instance.settings,
      'stokvelSettings': instance.stokvelSettings,
      'lastMessageText': instance.lastMessageText,
      'lastMessageSenderId': instance.lastMessageSenderId,
      'lastMessageSenderName': instance.lastMessageSenderName,
      'lastMessageType': instance.lastMessageType,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'unreadCounts': instance.unreadCounts,
      'muted': instance.muted,
      'lastMessageEncryptedPreviews': instance.lastMessageEncryptedPreviews,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$CommunityTypeEnumMap = {
  CommunityType.regular: 'regular',
  CommunityType.stokvel: 'stokvel',
};

const _$CommunityStatusEnumMap = {
  CommunityStatus.active: 'active',
  CommunityStatus.suspended: 'suspended',
  CommunityStatus.closed: 'closed',
};
