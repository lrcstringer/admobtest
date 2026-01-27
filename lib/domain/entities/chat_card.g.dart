// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatCardImpl _$$ChatCardImplFromJson(Map<String, dynamic> json) =>
    _$ChatCardImpl(
      id: json['id'] as String,
      threadId: json['threadId'] as String,
      senderId: json['senderId'] as String,
      type: $enumDecode(_$ChatCardTypeEnumMap, json['type']),
      status: $enumDecode(_$ChatCardStatusEnumMap, json['status']),
      textContent: json['textContent'] as String?,
      tokenAmount: (json['tokenAmount'] as num?)?.toInt(),
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: json['mediaType'] as String?,
      actionData: json['actionData'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      actionedAt: json['actionedAt'] == null
          ? null
          : DateTime.parse(json['actionedAt'] as String),
      recipientId: json['recipientId'] as String?,
    );

Map<String, dynamic> _$$ChatCardImplToJson(_$ChatCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'threadId': instance.threadId,
      'senderId': instance.senderId,
      'type': _$ChatCardTypeEnumMap[instance.type]!,
      'status': _$ChatCardStatusEnumMap[instance.status]!,
      'textContent': instance.textContent,
      'tokenAmount': instance.tokenAmount,
      'mediaUrl': instance.mediaUrl,
      'mediaType': instance.mediaType,
      'actionData': instance.actionData,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'actionedAt': instance.actionedAt?.toIso8601String(),
      'recipientId': instance.recipientId,
    };

const _$ChatCardTypeEnumMap = {
  ChatCardType.text: 'text',
  ChatCardType.tokenSend: 'tokenSend',
  ChatCardType.tokenRequest: 'tokenRequest',
  ChatCardType.system: 'system',
  ChatCardType.image: 'image',
  ChatCardType.tokenReceived: 'tokenReceived',
};

const _$ChatCardStatusEnumMap = {
  ChatCardStatus.pending: 'pending',
  ChatCardStatus.paid: 'paid',
  ChatCardStatus.declined: 'declined',
  ChatCardStatus.expired: 'expired',
  ChatCardStatus.cancelled: 'cancelled',
};
