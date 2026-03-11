// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContactSuggestion _$ContactSuggestionFromJson(Map<String, dynamic> json) =>
    _ContactSuggestion(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
      reason: json['reason'] as String,
      source: $enumDecode(_$SuggestionSourceEnumMap, json['source']),
    );

Map<String, dynamic> _$ContactSuggestionToJson(_ContactSuggestion instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'avatarColor': instance.avatarColor,
      'reason': instance.reason,
      'source': _$SuggestionSourceEnumMap[instance.source]!,
    };

const _$SuggestionSourceEnumMap = {
  SuggestionSource.phoneContact: 'phoneContact',
  SuggestionSource.mutualFriend: 'mutualFriend',
  SuggestionSource.communityMember: 'communityMember',
};
