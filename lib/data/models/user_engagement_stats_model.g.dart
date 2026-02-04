// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_engagement_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEngagementStatsModelImpl _$$UserEngagementStatsModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserEngagementStatsModelImpl(
  userId: json['userId'] as String,
  currentStreak: (json['currentStreak'] as num).toInt(),
  longestStreak: (json['longestStreak'] as num).toInt(),
  streakStartedAt: const NullableTimestampConverter().fromJson(
    json['streakStartedAt'],
  ),
  lastEarnedDate: json['lastEarnedDate'] as String?,
  totalEngagementsCompleted: (json['totalEngagementsCompleted'] as num).toInt(),
  totalTokensEarned: (json['totalTokensEarned'] as num).toInt(),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$UserEngagementStatsModelImplToJson(
  _$UserEngagementStatsModelImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'currentStreak': instance.currentStreak,
  'longestStreak': instance.longestStreak,
  'streakStartedAt': const NullableTimestampConverter().toJson(
    instance.streakStartedAt,
  ),
  'lastEarnedDate': instance.lastEarnedDate,
  'totalEngagementsCompleted': instance.totalEngagementsCompleted,
  'totalTokensEarned': instance.totalTokensEarned,
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
