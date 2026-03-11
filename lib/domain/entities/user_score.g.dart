// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserScore _$UserScoreFromJson(Map<String, dynamic> json) => _UserScore(
  userId: json['userId'] as String,
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
  baseScore: (json['baseScore'] as num?)?.toInt() ?? 0,
  streakMultiplier: (json['streakMultiplier'] as num?)?.toDouble() ?? 1.0,
  assistScore: (json['assistScore'] as num?)?.toInt() ?? 0,
  referralQualityScore: (json['referralQualityScore'] as num?)?.toInt() ?? 0,
  finalScore: (json['finalScore'] as num?)?.toInt() ?? 0,
  firstCompletionAt: json['firstCompletionAt'] == null
      ? null
      : DateTime.parse(json['firstCompletionAt'] as String),
);

Map<String, dynamic> _$UserScoreToJson(_UserScore instance) =>
    <String, dynamic>{
      'userId': instance.userId,
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
      'baseScore': instance.baseScore,
      'streakMultiplier': instance.streakMultiplier,
      'assistScore': instance.assistScore,
      'referralQualityScore': instance.referralQualityScore,
      'finalScore': instance.finalScore,
      'firstCompletionAt': instance.firstCompletionAt?.toIso8601String(),
    };
