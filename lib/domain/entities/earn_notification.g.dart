// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarnNotification _$EarnNotificationFromJson(Map<String, dynamic> json) =>
    _EarnNotification(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'] as Map<String, dynamic>? ?? const {},
      read: json['read'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$EarnNotificationToJson(_EarnNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'data': instance.data,
      'read': instance.read,
      'createdAt': instance.createdAt.toIso8601String(),
    };
