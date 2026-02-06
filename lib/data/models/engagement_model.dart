import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/engagement.dart';
import '../../domain/enums/engagement_status.dart';
import '../../domain/value_objects/engagement_evidence.dart';

part 'engagement_model.freezed.dart';

@freezed
class EngagementAnswerModel with _$EngagementAnswerModel {
  const factory EngagementAnswerModel({
    required String questionId,
    required String selectedOption,
    required DateTime answeredAt,
    bool? isCorrect,
  }) = _EngagementAnswerModel;

  const EngagementAnswerModel._();

  factory EngagementAnswerModel.fromJson(Map<String, dynamic> json) {
    final answeredAt = json['answeredAt'];

    return EngagementAnswerModel(
      questionId: json['questionId'] as String,
      selectedOption: json['selectedOption'] as String,
      answeredAt: answeredAt is Timestamp
          ? answeredAt.toDate()
          : DateTime.parse(answeredAt as String),
      isCorrect: json['isCorrect'] as bool?,
    );
  }

  EngagementAnswer toEntity() {
    return EngagementAnswer(
      questionId: questionId,
      selectedOption: selectedOption,
      answeredAt: answeredAt,
      isCorrect: isCorrect,
    );
  }

  factory EngagementAnswerModel.fromEntity(EngagementAnswer entity) {
    return EngagementAnswerModel(
      questionId: entity.questionId,
      selectedOption: entity.selectedOption,
      answeredAt: entity.answeredAt,
      isCorrect: entity.isCorrect,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'questionId': questionId,
      'selectedOption': selectedOption,
      'answeredAt': Timestamp.fromDate(answeredAt),
      if (isCorrect != null) 'isCorrect': isCorrect,
    };
  }
}

@freezed
class EngagementEvidenceModel with _$EngagementEvidenceModel {
  const factory EngagementEvidenceModel({
    required String deviceFingerprint,
    String? integrityToken,
    required int watchDurationMs,
    required bool videoSeeked,
    required bool screenVisible,
    required bool appInForeground,
    required List<int> surveyResponseTimesMs,
    required DateTime videoStartedAt,
    required DateTime surveySubmittedAt,
    double? clientAttentionScore,
  }) = _EngagementEvidenceModel;

  const EngagementEvidenceModel._();

  factory EngagementEvidenceModel.fromJson(Map<String, dynamic> json) {
    final videoStartedAt = json['videoStartedAt'];
    final surveySubmittedAt = json['surveySubmittedAt'];

    return EngagementEvidenceModel(
      deviceFingerprint: json['deviceFingerprint'] as String,
      integrityToken: json['integrityToken'] as String?,
      watchDurationMs: json['watchDurationMs'] as int,
      videoSeeked: json['videoSeeked'] as bool,
      screenVisible: json['screenVisible'] as bool,
      appInForeground: json['appInForeground'] as bool,
      surveyResponseTimesMs:
          (json['surveyResponseTimesMs'] as List).map((e) => e as int).toList(),
      videoStartedAt: videoStartedAt is Timestamp
          ? videoStartedAt.toDate()
          : DateTime.parse(videoStartedAt as String),
      surveySubmittedAt: surveySubmittedAt is Timestamp
          ? surveySubmittedAt.toDate()
          : DateTime.parse(surveySubmittedAt as String),
      clientAttentionScore: (json['clientAttentionScore'] as num?)?.toDouble(),
    );
  }

  EngagementEvidence toEntity() {
    return EngagementEvidence(
      deviceFingerprint: deviceFingerprint,
      integrityToken: integrityToken,
      watchDurationMs: watchDurationMs,
      videoSeeked: videoSeeked,
      screenVisible: screenVisible,
      appInForeground: appInForeground,
      surveyResponseTimesMs: surveyResponseTimesMs,
      videoStartedAt: videoStartedAt,
      surveySubmittedAt: surveySubmittedAt,
      clientAttentionScore: clientAttentionScore,
    );
  }

  factory EngagementEvidenceModel.fromEntity(EngagementEvidence entity) {
    return EngagementEvidenceModel(
      deviceFingerprint: entity.deviceFingerprint,
      integrityToken: entity.integrityToken,
      watchDurationMs: entity.watchDurationMs,
      videoSeeked: entity.videoSeeked,
      screenVisible: entity.screenVisible,
      appInForeground: entity.appInForeground,
      surveyResponseTimesMs: entity.surveyResponseTimesMs,
      videoStartedAt: entity.videoStartedAt,
      surveySubmittedAt: entity.surveySubmittedAt,
      clientAttentionScore: entity.clientAttentionScore,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'deviceFingerprint': deviceFingerprint,
      if (integrityToken != null) 'integrityToken': integrityToken,
      'watchDurationMs': watchDurationMs,
      'videoSeeked': videoSeeked,
      'screenVisible': screenVisible,
      'appInForeground': appInForeground,
      'surveyResponseTimesMs': surveyResponseTimesMs,
      'videoStartedAt': Timestamp.fromDate(videoStartedAt),
      'surveySubmittedAt': Timestamp.fromDate(surveySubmittedAt),
      if (clientAttentionScore != null)
        'clientAttentionScore': clientAttentionScore,
    };
  }
}

@freezed
class EngagementModel with _$EngagementModel {
  const factory EngagementModel({
    required String id,
    required String userId,
    required String oddienceCampaignId,
    required String earnOpportunityId,
    required String status,
    required DateTime startedAt,
    DateTime? completedAt,
    required int watchDurationSeconds,
    required int requiredDurationSeconds,
    required List<EngagementAnswerModel> answers,
    EngagementEvidenceModel? evidence,
    int? tokensEarned,
    String? failureReason,
    required int attemptNumber,
    required DateTime createdAt,
    DateTime? updatedAt,
    // Denormalized fields for targeting queries
    String? threadId,
    String? clientId,
    // Streak audit fields
    int? streakDayAtCompletion,
    double? multiplierApplied,
  }) = _EngagementModel;

  const EngagementModel._();

  factory EngagementModel.fromJson(Map<String, dynamic> json) {
    final startedAt = json['startedAt'];
    final completedAt = json['completedAt'];
    final createdAt = json['createdAt'];
    final updatedAt = json['updatedAt'];
    final evidence = json['evidence'];

    return EngagementModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      oddienceCampaignId: json['oddienceCampaignId'] as String,
      earnOpportunityId: json['earnOpportunityId'] as String,
      status: json['status'] as String,
      startedAt: startedAt is Timestamp
          ? startedAt.toDate()
          : DateTime.parse(startedAt as String),
      completedAt: completedAt == null
          ? null
          : completedAt is Timestamp
              ? completedAt.toDate()
              : DateTime.parse(completedAt as String),
      watchDurationSeconds: json['watchDurationSeconds'] as int? ?? 0,
      requiredDurationSeconds: json['requiredDurationSeconds'] as int,
      answers: (json['answers'] as List?)
              ?.map((e) =>
                  EngagementAnswerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      evidence: evidence != null
          ? EngagementEvidenceModel.fromJson(evidence as Map<String, dynamic>)
          : null,
      tokensEarned: json['tokensEarned'] as int?,
      failureReason: json['failureReason'] as String?,
      attemptNumber: json['attemptNumber'] as int? ?? 1,
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      updatedAt: updatedAt == null
          ? null
          : updatedAt is Timestamp
              ? updatedAt.toDate()
              : DateTime.parse(updatedAt as String),
      // Denormalized fields
      threadId: json['threadId'] as String?,
      clientId: json['clientId'] as String?,
      // Streak audit fields
      streakDayAtCompletion: json['streakDayAtCompletion'] as int?,
      multiplierApplied: (json['multiplierApplied'] as num?)?.toDouble(),
    );
  }

  Engagement toEntity() {
    return Engagement(
      id: id,
      userId: userId,
      oddienceCampaignId: oddienceCampaignId,
      earnOpportunityId: earnOpportunityId,
      status: _parseEngagementStatus(status),
      startedAt: startedAt,
      completedAt: completedAt,
      watchDurationSeconds: watchDurationSeconds,
      requiredDurationSeconds: requiredDurationSeconds,
      answers: answers.map((a) => a.toEntity()).toList(),
      evidence: evidence?.toEntity(),
      tokensEarned: tokensEarned,
      failureReason: failureReason,
      attemptNumber: attemptNumber,
      createdAt: createdAt,
      updatedAt: updatedAt,
      // Denormalized fields
      threadId: threadId,
      clientId: clientId,
      // Streak audit fields
      streakDayAtCompletion: streakDayAtCompletion,
      multiplierApplied: multiplierApplied,
    );
  }

  factory EngagementModel.fromEntity(Engagement entity) {
    return EngagementModel(
      id: entity.id,
      userId: entity.userId,
      oddienceCampaignId: entity.oddienceCampaignId,
      earnOpportunityId: entity.earnOpportunityId,
      status: entity.status.name,
      startedAt: entity.startedAt,
      completedAt: entity.completedAt,
      watchDurationSeconds: entity.watchDurationSeconds,
      requiredDurationSeconds: entity.requiredDurationSeconds,
      answers:
          entity.answers.map((a) => EngagementAnswerModel.fromEntity(a)).toList(),
      evidence: entity.evidence != null
          ? EngagementEvidenceModel.fromEntity(entity.evidence!)
          : null,
      tokensEarned: entity.tokensEarned,
      failureReason: entity.failureReason,
      attemptNumber: entity.attemptNumber,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Denormalized fields
      threadId: entity.threadId,
      clientId: entity.clientId,
      // Streak audit fields
      streakDayAtCompletion: entity.streakDayAtCompletion,
      multiplierApplied: entity.multiplierApplied,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'userId': userId,
      'oddienceCampaignId': oddienceCampaignId,
      'earnOpportunityId': earnOpportunityId,
      'status': status,
      'startedAt': Timestamp.fromDate(startedAt),
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
      'watchDurationSeconds': watchDurationSeconds,
      'requiredDurationSeconds': requiredDurationSeconds,
      'answers': answers.map((a) => a.toFirestoreJson()).toList(),
      if (evidence != null) 'evidence': evidence!.toFirestoreJson(),
      if (tokensEarned != null) 'tokensEarned': tokensEarned,
      if (failureReason != null) 'failureReason': failureReason,
      'attemptNumber': attemptNumber,
      'createdAt': Timestamp.fromDate(createdAt),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
      // Denormalized fields
      if (threadId != null) 'threadId': threadId,
      if (clientId != null) 'clientId': clientId,
      // Streak audit fields
      if (streakDayAtCompletion != null)
        'streakDayAtCompletion': streakDayAtCompletion,
      if (multiplierApplied != null) 'multiplierApplied': multiplierApplied,
    };
  }

  static EngagementStatus _parseEngagementStatus(String status) {
    switch (status) {
      case 'started':
        return EngagementStatus.started;
      case 'watching':
        return EngagementStatus.watching;
      case 'surveying':
        return EngagementStatus.surveying;
      case 'completed':
        return EngagementStatus.completed;
      case 'failed':
        return EngagementStatus.failed;
      case 'abandoned':
        return EngagementStatus.abandoned;
      case 'rewarded':
        return EngagementStatus.rewarded;
      case 'rejected':
        return EngagementStatus.rejected;
      default:
        return EngagementStatus.started;
    }
  }
}
