// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyScore _$DailyScoreFromJson(Map<String, dynamic> json) => _DailyScore(
  date: json['date'] as String,
  engagementsCompleted: (json['engagementsCompleted'] as num).toInt(),
  tokensEarned: (json['tokensEarned'] as num).toInt(),
  streakDay: (json['streakDay'] as num).toInt(),
  streakMultiplier: (json['streakMultiplier'] as num).toDouble(),
  assistScore: (json['assistScore'] as num).toInt(),
  finalScore: (json['finalScore'] as num).toInt(),
  displayName: json['displayName'] as String,
  username: json['username'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DailyScoreToJson(_DailyScore instance) =>
    <String, dynamic>{
      'date': instance.date,
      'engagementsCompleted': instance.engagementsCompleted,
      'tokensEarned': instance.tokensEarned,
      'streakDay': instance.streakDay,
      'streakMultiplier': instance.streakMultiplier,
      'assistScore': instance.assistScore,
      'finalScore': instance.finalScore,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
