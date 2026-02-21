// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParticipantInfoImpl _$$ParticipantInfoImplFromJson(
  Map<String, dynamic> json,
) => _$ParticipantInfoImpl(
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$$ParticipantInfoImplToJson(
  _$ParticipantInfoImpl instance,
) => <String, dynamic>{
  'displayName': instance.displayName,
  'avatarUrl': instance.avatarUrl,
};

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ConversationTypeEnumMap, json['type']),
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participants: (json['participants'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ParticipantInfo.fromJson(e as Map<String, dynamic>)),
      ),
      lastMessageText: json['lastMessageText'] as String?,
      lastMessageSenderId: json['lastMessageSenderId'] as String?,
      lastMessageSenderName: json['lastMessageSenderName'] as String?,
      lastMessageType: json['lastMessageType'] as String?,
      lastMessageAt: json['lastMessageAt'] == null
          ? null
          : DateTime.parse(json['lastMessageAt'] as String),
      unreadCounts: Map<String, int>.from(json['unreadCounts'] as Map),
      archived: Map<String, bool>.from(json['archived'] as Map),
      pinned: Map<String, bool>.from(json['pinned'] as Map),
      muted: Map<String, bool>.from(json['muted'] as Map),
      lastMessageEncryptedPreviews:
          (json['lastMessageEncryptedPreviews'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      chatClearedAt:
          (json['chatClearedAt'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, DateTime.parse(e as String)),
          ) ??
          const {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ConversationTypeEnumMap[instance.type]!,
      'participantIds': instance.participantIds,
      'participants': instance.participants,
      'lastMessageText': instance.lastMessageText,
      'lastMessageSenderId': instance.lastMessageSenderId,
      'lastMessageSenderName': instance.lastMessageSenderName,
      'lastMessageType': instance.lastMessageType,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'unreadCounts': instance.unreadCounts,
      'archived': instance.archived,
      'pinned': instance.pinned,
      'muted': instance.muted,
      'lastMessageEncryptedPreviews': instance.lastMessageEncryptedPreviews,
      'chatClearedAt': instance.chatClearedAt.map(
        (k, e) => MapEntry(k, e.toIso8601String()),
      ),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ConversationTypeEnumMap = {
  ConversationType.p2p: 'p2p',
  ConversationType.brand: 'brand',
  ConversationType.system: 'system',
};
