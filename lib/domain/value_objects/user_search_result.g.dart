// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSearchResultImpl _$$UserSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$UserSearchResultImpl(
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  username: json['username'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  avatarColor: json['avatarColor'] as String?,
);

Map<String, dynamic> _$$UserSearchResultImplToJson(
  _$UserSearchResultImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'displayName': instance.displayName,
  'username': instance.username,
  'avatarUrl': instance.avatarUrl,
  'avatarColor': instance.avatarColor,
};
