// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Contact _$ContactFromJson(Map<String, dynamic> json) => _Contact(
  id: json['id'] as String,
  userId: json['userId'] as String,
  contactUserId: json['contactUserId'] as String,
  displayName: json['displayName'] as String,
  username: json['username'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  avatarColor: json['avatarColor'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  status: $enumDecode(_$ContactStatusEnumMap, json['status']),
  isFavorite: json['isFavorite'] as bool,
  nickname: json['nickname'] as String?,
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastInteractionAt: json['lastInteractionAt'] == null
      ? null
      : DateTime.parse(json['lastInteractionAt'] as String),
);

Map<String, dynamic> _$ContactToJson(_Contact instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'contactUserId': instance.contactUserId,
  'displayName': instance.displayName,
  'username': instance.username,
  'avatarUrl': instance.avatarUrl,
  'avatarColor': instance.avatarColor,
  'phoneNumber': instance.phoneNumber,
  'status': _$ContactStatusEnumMap[instance.status]!,
  'isFavorite': instance.isFavorite,
  'nickname': instance.nickname,
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastInteractionAt': instance.lastInteractionAt?.toIso8601String(),
};

const _$ContactStatusEnumMap = {
  ContactStatus.pending: 'pending',
  ContactStatus.accepted: 'accepted',
  ContactStatus.blocked: 'blocked',
};
