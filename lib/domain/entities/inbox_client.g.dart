// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InboxClient _$InboxClientFromJson(Map<String, dynamic> json) => _InboxClient(
  clientId: json['clientId'] as String,
  clientName: json['clientName'] as String,
  clientAvatarImage: json['clientAvatarImage'] as String?,
  clientAvatarColor: json['clientAvatarColor'] as String?,
  isPinned: json['isPinned'] as bool,
  isFeatured: json['isFeatured'] as bool,
  activeThreadCount: (json['activeThreadCount'] as num).toInt(),
  threads: (json['threads'] as List<dynamic>)
      .map((e) => InboxThread.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$InboxClientToJson(_InboxClient instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientAvatarImage': instance.clientAvatarImage,
      'clientAvatarColor': instance.clientAvatarColor,
      'isPinned': instance.isPinned,
      'isFeatured': instance.isFeatured,
      'activeThreadCount': instance.activeThreadCount,
      'threads': instance.threads,
    };
