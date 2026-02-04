// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_engagement_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEngagementStatsImpl _$$UserEngagementStatsImplFromJson(
  Map<String, dynamic> json,
) => _$UserEngagementStatsImpl(
  userId: json['userId'] as String,
  currentStreak: (json['currentStreak'] as num).toInt(),
  longestStreak: (json['longestStreak'] as num).toInt(),
  streakStartedAt: json['streakStartedAt'] == null
      ? null
      : DateTime.parse(json['streakStartedAt'] as String),
  lastEarnedDate: json['lastEarnedDate'] as String?,
  totalEngagementsCompleted: (json['totalEngagementsCompleted'] as num).toInt(),
  totalTokensEarned: (json['totalTokensEarned'] as num).toInt(),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$UserEngagementStatsImplToJson(
  _$UserEngagementStatsImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'currentStreak': instance.currentStreak,
  'longestStreak': instance.longestStreak,
  'streakStartedAt': instance.streakStartedAt?.toIso8601String(),
  'lastEarnedDate': instance.lastEarnedDate,
  'totalEngagementsCompleted': instance.totalEngagementsCompleted,
  'totalTokensEarned': instance.totalTokensEarned,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
