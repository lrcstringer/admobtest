// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSearchResult _$UserSearchResultFromJson(Map<String, dynamic> json) =>
    _UserSearchResult(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
    );

Map<String, dynamic> _$UserSearchResultToJson(_UserSearchResult instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'avatarColor': instance.avatarColor,
    };
