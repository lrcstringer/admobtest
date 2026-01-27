// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserScoreImpl _$$UserScoreImplFromJson(Map<String, dynamic> json) =>
    _$UserScoreImpl(
      oddienceUserId: json['oddienceUserId'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
      totalTokensEarned: (json['totalTokensEarned'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      previousRank: (json['previousRank'] as num?)?.toInt(),
      engagementsCompleted: (json['engagementsCompleted'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserScoreImplToJson(_$UserScoreImpl instance) =>
    <String, dynamic>{
      'oddienceUserId': instance.oddienceUserId,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'avatarColor': instance.avatarColor,
      'totalTokensEarned': instance.totalTokensEarned,
      'rank': instance.rank,
      'previousRank': instance.previousRank,
      'engagementsCompleted': instance.engagementsCompleted,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
