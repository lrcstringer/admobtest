// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoolContributionImpl _$$PoolContributionImplFromJson(
  Map<String, dynamic> json,
) => _$PoolContributionImpl(
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  totalAmount: (json['totalAmount'] as num).toInt(),
  contributionCount: (json['contributionCount'] as num).toInt(),
  anonymous: json['anonymous'] as bool,
  lastContributedAt: DateTime.parse(json['lastContributedAt'] as String),
);

Map<String, dynamic> _$$PoolContributionImplToJson(
  _$PoolContributionImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'displayName': instance.displayName,
  'totalAmount': instance.totalAmount,
  'contributionCount': instance.contributionCount,
  'anonymous': instance.anonymous,
  'lastContributedAt': instance.lastContributedAt.toIso8601String(),
};

_$PoolPayoutImpl _$$PoolPayoutImplFromJson(Map<String, dynamic> json) =>
    _$PoolPayoutImpl(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$$PoolPayoutImplToJson(_$PoolPayoutImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'amount': instance.amount,
    };

_$TokenPoolImpl _$$TokenPoolImplFromJson(Map<String, dynamic> json) =>
    _$TokenPoolImpl(
      id: json['id'] as String,
      mode: $enumDecode(_$PoolModeEnumMap, json['mode']),
      status: $enumDecode(_$PoolStatusEnumMap, json['status']),
      organizerId: json['organizerId'] as String,
      organizerName: json['organizerName'] as String,
      recipientId: json['recipientId'] as String?,
      recipientName: json['recipientName'] as String?,
      conversationId: json['conversationId'] as String,
      title: json['title'] as String,
      purpose: json['purpose'] as String? ?? '',
      message: json['message'] as String? ?? '',
      style: $enumDecode(_$GiftStyleEnumMap, json['style']),
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
      contributionCount: (json['contributionCount'] as num?)?.toInt() ?? 0,
      contributorCount: (json['contributorCount'] as num?)?.toInt() ?? 0,
      contributions:
          (json['contributions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              PoolContribution.fromJson(e as Map<String, dynamic>),
            ),
          ) ??
          const {},
      payouts:
          (json['payouts'] as List<dynamic>?)
              ?.map((e) => PoolPayout.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      giftMessageId: json['giftMessageId'] as String?,
      giftConversationId: json['giftConversationId'] as String?,
      inviteeIds:
          (json['inviteeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      openedAt: json['openedAt'] == null
          ? null
          : DateTime.parse(json['openedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      groupAccountId: json['groupAccountId'] as String,
      reminderSent: json['reminderSent'] as bool? ?? false,
    );

Map<String, dynamic> _$$TokenPoolImplToJson(_$TokenPoolImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mode': _$PoolModeEnumMap[instance.mode]!,
      'status': _$PoolStatusEnumMap[instance.status]!,
      'organizerId': instance.organizerId,
      'organizerName': instance.organizerName,
      'recipientId': instance.recipientId,
      'recipientName': instance.recipientName,
      'conversationId': instance.conversationId,
      'title': instance.title,
      'purpose': instance.purpose,
      'message': instance.message,
      'style': _$GiftStyleEnumMap[instance.style]!,
      'totalAmount': instance.totalAmount,
      'contributionCount': instance.contributionCount,
      'contributorCount': instance.contributorCount,
      'contributions': instance.contributions,
      'payouts': instance.payouts,
      'giftMessageId': instance.giftMessageId,
      'giftConversationId': instance.giftConversationId,
      'inviteeIds': instance.inviteeIds,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
      'openedAt': instance.openedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'groupAccountId': instance.groupAccountId,
      'reminderSent': instance.reminderSent,
    };

const _$PoolModeEnumMap = {PoolMode.sasaza: 'sasaza', PoolMode.save: 'save'};

const _$PoolStatusEnumMap = {
  PoolStatus.collecting: 'collecting',
  PoolStatus.sent: 'sent',
  PoolStatus.completed: 'completed',
  PoolStatus.cancelled: 'cancelled',
  PoolStatus.expired: 'expired',
};

const _$GiftStyleEnumMap = {
  GiftStyle.ndlovukazi: 'ndlovukazi',
  GiftStyle.celebration: 'celebration',
  GiftStyle.love: 'love',
  GiftStyle.birthday: 'birthday',
  GiftStyle.professional: 'professional',
};
