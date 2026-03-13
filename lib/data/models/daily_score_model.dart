import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/daily_score.dart';
import '../../core/utils/firestore_helpers.dart';

part 'daily_score_model.freezed.dart';
part 'daily_score_model.g.dart';

/// Data model for DailyScore
///
/// Maps between Firestore document and DailyScore entity.
/// Collection: users/{userId}/dailyScores/{YYYY-MM-DD}
@freezed
abstract class DailyScoreModel with _$DailyScoreModel {
  const factory DailyScoreModel({
    required String date,
    required int engagementsCompleted,
    required int tokensEarned,
    required int streakDay,
    required double streakMultiplier,
    required int assistScore,
    required int finalScore,
    required String displayName,
    String? username,
    String? avatarUrl,
    @TimestampConverter() required DateTime updatedAt,
  }) = _DailyScoreModel;

  const DailyScoreModel._();

  factory DailyScoreModel.fromJson(Map<String, dynamic> json) =>
      _$DailyScoreModelFromJson(json);

  /// Create from Firestore document
  factory DailyScoreModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    return DailyScoreModel.fromJson({
      ...data,
      'date': doc.id, // Document ID is the date
    });
  }

  /// Convert to domain entity
  DailyScore toEntity() => DailyScore(
        date: date,
        engagementsCompleted: engagementsCompleted,
        tokensEarned: tokensEarned,
        streakDay: streakDay,
        streakMultiplier: streakMultiplier,
        assistScore: assistScore,
        finalScore: finalScore,
        displayName: displayName,
        username: username,
        avatarUrl: avatarUrl,
        updatedAt: updatedAt,
      );

  /// Create from domain entity
  factory DailyScoreModel.fromEntity(DailyScore entity) => DailyScoreModel(
        date: entity.date,
        engagementsCompleted: entity.engagementsCompleted,
        tokensEarned: entity.tokensEarned,
        streakDay: entity.streakDay,
        streakMultiplier: entity.streakMultiplier,
        assistScore: entity.assistScore,
        finalScore: entity.finalScore,
        displayName: entity.displayName,
        username: entity.username,
        avatarUrl: entity.avatarUrl,
        updatedAt: entity.updatedAt,
      );
}
