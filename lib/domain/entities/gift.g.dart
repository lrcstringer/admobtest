// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GiftImpl _$$GiftImplFromJson(Map<String, dynamic> json) => _$GiftImpl(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  senderName: json['senderName'] as String,
  recipientId: json['recipientId'] as String,
  recipientName: json['recipientName'] as String,
  amount: (json['amount'] as num).toInt(),
  conversationId: json['conversationId'] as String?,
  communityId: json['communityId'] as String?,
  messageId: json['messageId'] as String,
  message: json['message'] as String,
  style: $enumDecode(_$GiftStyleEnumMap, json['style']),
  status: $enumDecode(_$GiftStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  openedAt: json['openedAt'] == null
      ? null
      : DateTime.parse(json['openedAt'] as String),
  claimedAt: json['claimedAt'] == null
      ? null
      : DateTime.parse(json['claimedAt'] as String),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  debitTransactionId: json['debitTransactionId'] as String?,
  creditTransactionId: json['creditTransactionId'] as String?,
);

Map<String, dynamic> _$$GiftImplToJson(_$GiftImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'recipientId': instance.recipientId,
      'recipientName': instance.recipientName,
      'amount': instance.amount,
      'conversationId': instance.conversationId,
      'communityId': instance.communityId,
      'messageId': instance.messageId,
      'message': instance.message,
      'style': _$GiftStyleEnumMap[instance.style]!,
      'status': _$GiftStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'openedAt': instance.openedAt?.toIso8601String(),
      'claimedAt': instance.claimedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'debitTransactionId': instance.debitTransactionId,
      'creditTransactionId': instance.creditTransactionId,
    };

const _$GiftStyleEnumMap = {
  GiftStyle.ndlovukazi: 'ndlovukazi',
  GiftStyle.celebration: 'celebration',
  GiftStyle.love: 'love',
  GiftStyle.birthday: 'birthday',
  GiftStyle.professional: 'professional',
};

const _$GiftStatusEnumMap = {
  GiftStatus.pending: 'pending',
  GiftStatus.opened: 'opened',
  GiftStatus.claimed: 'claimed',
  GiftStatus.expired: 'expired',
};

_$GiftStatsImpl _$$GiftStatsImplFromJson(Map<String, dynamic> json) =>
    _$GiftStatsImpl(
      totalSent: (json['totalSent'] as num).toInt(),
      totalReceived: (json['totalReceived'] as num).toInt(),
      totalAmountSent: (json['totalAmountSent'] as num).toInt(),
      totalAmountReceived: (json['totalAmountReceived'] as num).toInt(),
    );

Map<String, dynamic> _$$GiftStatsImplToJson(_$GiftStatsImpl instance) =>
    <String, dynamic>{
      'totalSent': instance.totalSent,
      'totalReceived': instance.totalReceived,
      'totalAmountSent': instance.totalAmountSent,
      'totalAmountReceived': instance.totalAmountReceived,
    };
