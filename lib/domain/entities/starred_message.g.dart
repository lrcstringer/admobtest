// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starred_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StarredMessage _$StarredMessageFromJson(Map<String, dynamic> json) =>
    _StarredMessage(
      messageId: json['messageId'] as String,
      conversationId: json['conversationId'] as String,
      starredAt: DateTime.parse(json['starredAt'] as String),
      senderName: json['senderName'] as String,
      messageType: json['messageType'] as String,
      messagePreview: json['messagePreview'] as String?,
    );

Map<String, dynamic> _$StarredMessageToJson(_StarredMessage instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'conversationId': instance.conversationId,
      'starredAt': instance.starredAt.toIso8601String(),
      'senderName': instance.senderName,
      'messageType': instance.messageType,
      'messagePreview': instance.messagePreview,
    };
