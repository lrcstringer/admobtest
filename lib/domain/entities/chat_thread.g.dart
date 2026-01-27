// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatThreadImpl _$$ChatThreadImplFromJson(Map<String, dynamic> json) =>
    _$ChatThreadImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ChatThreadTypeEnumMap, json['type']),
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
      lastMessagePreview: json['lastMessagePreview'] as String?,
      lastMessageAt: json['lastMessageAt'] == null
          ? null
          : DateTime.parse(json['lastMessageAt'] as String),
      unreadCount: (json['unreadCount'] as num).toInt(),
      isPinned: json['isPinned'] as bool,
      isMuted: json['isMuted'] as bool,
      isArchived: json['isArchived'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ChatThreadImplToJson(_$ChatThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ChatThreadTypeEnumMap[instance.type]!,
      'participantIds': instance.participantIds,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'avatarColor': instance.avatarColor,
      'lastMessagePreview': instance.lastMessagePreview,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'unreadCount': instance.unreadCount,
      'isPinned': instance.isPinned,
      'isMuted': instance.isMuted,
      'isArchived': instance.isArchived,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ChatThreadTypeEnumMap = {
  ChatThreadType.p2p: 'p2p',
  ChatThreadType.brand: 'brand',
  ChatThreadType.system: 'system',
};
