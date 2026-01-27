import 'package:freezed_annotation/freezed_annotation.dart';

part 'engagement_evidence.freezed.dart';
part 'engagement_evidence.g.dart';

/// Evidence collected during engagement for fraud prevention
@freezed
class EngagementEvidence with _$EngagementEvidence {
  const factory EngagementEvidence({
    /// Device fingerprint hash
    required String deviceFingerprint,

    /// Play Integrity token (Android) or Device Check token (iOS)
    String? integrityToken,

    /// Watch duration in milliseconds
    required int watchDurationMs,

    /// Video seeked (indicates skipping)
    required bool videoSeeked,

    /// Screen was visible during watch
    required bool screenVisible,

    /// App was in foreground
    required bool appInForeground,

    /// Response time for survey questions (ms per question)
    required List<int> surveyResponseTimesMs,

    /// Timestamp when video playback started
    required DateTime videoStartedAt,

    /// Timestamp when survey was submitted
    required DateTime surveySubmittedAt,

    /// Client-side calculated attention score (0-100)
    double? clientAttentionScore,
  }) = _EngagementEvidence;

  const EngagementEvidence._();

  factory EngagementEvidence.fromJson(Map<String, dynamic> json) =>
      _$EngagementEvidenceFromJson(json);

  /// Calculate average survey response time
  int get avgSurveyResponseTimeMs {
    if (surveyResponseTimesMs.isEmpty) return 0;
    return (surveyResponseTimesMs.reduce((a, b) => a + b) /
            surveyResponseTimesMs.length)
        .round();
  }

  /// Check if evidence suggests legitimate engagement
  bool get looksLegitimate {
    // Basic client-side validation
    if (watchDurationMs < 5000) return false; // Minimum 5 seconds
    if (avgSurveyResponseTimeMs < 1000) return false; // Minimum 1 second per question
    if (!screenVisible || !appInForeground) return false;
    return true;
  }
}
