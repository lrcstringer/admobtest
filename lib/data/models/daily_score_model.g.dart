// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyScoreModelImpl _$$DailyScoreModelImplFromJson(
  Map<String, dynamic> json,
) => _$DailyScoreModelImpl(
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
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$DailyScoreModelImplToJson(
  _$DailyScoreModelImpl instance,
) => <String, dynamic>{
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
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
