import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/engagement.dart';
import '../../domain/enums/engagement_status.dart';
import '../../domain/value_objects/engagement_evidence.dart';

part 'engagement_model.freezed.dart';

/// Type-discriminated survey response model
@freezed
abstract class SurveyResponseModel with _$SurveyResponseModel {
  const factory SurveyResponseModel({
    required String questionId,
    required String questionType,
    required DateTime answeredAt,

    // single_select
    String? selectedOption,

    // multi_select
    List<String>? selectedOptions,

    // text_input
    List<String>? textResponses,

    // likert
    int? likertValue,

    // star_tags
    int? starRating,
    List<String>? selectedTags,

    // slider
    double? sliderValue,

    // attention check result
    bool? isCorrect,
  }) = _SurveyResponseModel;

  const SurveyResponseModel._();

  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) {
    final answeredAt = json['answeredAt'];

    return SurveyResponseModel(
      questionId: json['questionId'] as String,
      questionType: json['questionType'] as String? ?? 'single_select',
      answeredAt: answeredAt is Timestamp
          ? answeredAt.toDate()
          : DateTime.parse(answeredAt as String),
      selectedOption: json['selectedOption'] as String?,
      selectedOptions: (json['selectedOptions'] as List?)
          ?.map((e) => e as String)
          .toList(),
      textResponses: (json['textResponses'] as List?)
          ?.map((e) => e as String)
          .toList(),
      likertValue: json['likertValue'] as int?,
      starRating: json['starRating'] as int?,
      selectedTags: (json['selectedTags'] as List?)
          ?.map((e) => e as String)
          .toList(),
      sliderValue: (json['sliderValue'] as num?)?.toDouble(),
      isCorrect: json['isCorrect'] as bool?,
    );
  }

  SurveyResponse toEntity() {
    return SurveyResponse(
      questionId: questionId,
      questionType: questionType,
      answeredAt: answeredAt,
      selectedOption: selectedOption,
      selectedOptions: selectedOptions,
      textResponses: textResponses,
      likertValue: likertValue,
      starRating: starRating,
      selectedTags: selectedTags,
      sliderValue: sliderValue,
      isCorrect: isCorrect,
    );
  }

  factory SurveyResponseModel.fromEntity(SurveyResponse entity) {
    return SurveyResponseModel(
      questionId: entity.questionId,
      questionType: entity.questionType,
      answeredAt: entity.answeredAt,
      selectedOption: entity.selectedOption,
      selectedOptions: entity.selectedOptions,
      textResponses: entity.textResponses,
      likertValue: entity.likertValue,
      starRating: entity.starRating,
      selectedTags: entity.selectedTags,
      sliderValue: entity.sliderValue,
      isCorrect: entity.isCorrect,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'questionId': questionId,
      'questionType': questionType,
      'answeredAt': Timestamp.fromDate(answeredAt),
      if (selectedOption != null) 'selectedOption': selectedOption,
      if (selectedOptions != null) 'selectedOptions': selectedOptions,
      if (textResponses != null) 'textResponses': textResponses,
      if (likertValue != null) 'likertValue': likertValue,
      if (starRating != null) 'starRating': starRating,
      if (selectedTags != null) 'selectedTags': selectedTags,
      if (sliderValue != null) 'sliderValue': sliderValue,
      if (isCorrect != null) 'isCorrect': isCorrect,
    };
  }
}

/// Legacy alias for backward compatibility
typedef EngagementAnswerModel = SurveyResponseModel;

@freezed
abstract class EngagementEvidenceModel with _$EngagementEvidenceModel {
  const factory EngagementEvidenceModel({
    required String deviceFingerprint,
    String? integrityToken,
    String? integrityNonce,
    required int watchDurationMs,
    required bool videoSeeked,
    required bool screenVisible,
    required bool appInForeground,
    required List<int> surveyResponseTimesMs,
    required DateTime videoStartedAt,
    required DateTime surveySubmittedAt,
    double? clientAttentionScore,
    // AdMob verification fields
    String? adTransactionId,
    bool? adFullyWatched,
    String? adResponseId,
    // Upload evidence fields
    List<Map<String, dynamic>>? uploadedFiles,
    String? uploadTextResponse,
    DateTime? uploadStartedAt,
    DateTime? uploadCompletedAt,
  }) = _EngagementEvidenceModel;

  const EngagementEvidenceModel._();

  factory EngagementEvidenceModel.fromJson(Map<String, dynamic> json) {
    final videoStartedAt = json['videoStartedAt'];
    final surveySubmittedAt = json['surveySubmittedAt'];

    return EngagementEvidenceModel(
      deviceFingerprint: json['deviceFingerprint'] as String,
      integrityToken: json['integrityToken'] as String?,
      integrityNonce: json['integrityNonce'] as String?,
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
      // AdMob verification fields
      adTransactionId: json['adTransactionId'] as String?,
      adFullyWatched: json['adFullyWatched'] as bool?,
      adResponseId: json['adResponseId'] as String?,
      // Upload evidence fields
      uploadedFiles: (json['uploadedFiles'] as List?)
          ?.map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      uploadTextResponse: json['uploadTextResponse'] as String?,
      uploadStartedAt: json['uploadStartedAt'] != null
          ? (json['uploadStartedAt'] is Timestamp
              ? (json['uploadStartedAt'] as Timestamp).toDate()
              : DateTime.parse(json['uploadStartedAt'] as String))
          : null,
      uploadCompletedAt: json['uploadCompletedAt'] != null
          ? (json['uploadCompletedAt'] is Timestamp
              ? (json['uploadCompletedAt'] as Timestamp).toDate()
              : DateTime.parse(json['uploadCompletedAt'] as String))
          : null,
    );
  }

  EngagementEvidence toEntity() {
    return EngagementEvidence(
      deviceFingerprint: deviceFingerprint,
      integrityToken: integrityToken,
      integrityNonce: integrityNonce,
      watchDurationMs: watchDurationMs,
      videoSeeked: videoSeeked,
      screenVisible: screenVisible,
      appInForeground: appInForeground,
      surveyResponseTimesMs: surveyResponseTimesMs,
      videoStartedAt: videoStartedAt,
      surveySubmittedAt: surveySubmittedAt,
      clientAttentionScore: clientAttentionScore,
      adTransactionId: adTransactionId,
      adFullyWatched: adFullyWatched,
      adResponseId: adResponseId,
      uploadedFiles: uploadedFiles
          ?.map((f) => UploadedFileEvidence(
                url: f['url'] as String,
                type: f['type'] as String,
                sizeBytes: f['sizeBytes'] as int,
                mimeType: f['mimeType'] as String?,
                durationSeconds: f['durationSeconds'] as int?,
                width: f['width'] as int?,
                height: f['height'] as int?,
              ))
          .toList(),
      uploadTextResponse: uploadTextResponse,
      uploadStartedAt: uploadStartedAt,
      uploadCompletedAt: uploadCompletedAt,
    );
  }

  factory EngagementEvidenceModel.fromEntity(EngagementEvidence entity) {
    return EngagementEvidenceModel(
      deviceFingerprint: entity.deviceFingerprint,
      integrityToken: entity.integrityToken,
      integrityNonce: entity.integrityNonce,
      watchDurationMs: entity.watchDurationMs,
      videoSeeked: entity.videoSeeked,
      screenVisible: entity.screenVisible,
      appInForeground: entity.appInForeground,
      surveyResponseTimesMs: entity.surveyResponseTimesMs,
      videoStartedAt: entity.videoStartedAt,
      surveySubmittedAt: entity.surveySubmittedAt,
      clientAttentionScore: entity.clientAttentionScore,
      adTransactionId: entity.adTransactionId,
      adFullyWatched: entity.adFullyWatched,
      adResponseId: entity.adResponseId,
      uploadedFiles: entity.uploadedFiles
          ?.map((f) => {
                'url': f.url,
                'type': f.type,
                'sizeBytes': f.sizeBytes,
                if (f.mimeType != null) 'mimeType': f.mimeType,
                if (f.durationSeconds != null) 'durationSeconds': f.durationSeconds,
                if (f.width != null) 'width': f.width,
                if (f.height != null) 'height': f.height,
              })
          .toList(),
      uploadTextResponse: entity.uploadTextResponse,
      uploadStartedAt: entity.uploadStartedAt,
      uploadCompletedAt: entity.uploadCompletedAt,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'deviceFingerprint': deviceFingerprint,
      if (integrityToken != null) 'integrityToken': integrityToken,
      if (integrityNonce != null) 'integrityNonce': integrityNonce,
      'watchDurationMs': watchDurationMs,
      'videoSeeked': videoSeeked,
      'screenVisible': screenVisible,
      'appInForeground': appInForeground,
      'surveyResponseTimesMs': surveyResponseTimesMs,
      'videoStartedAt': Timestamp.fromDate(videoStartedAt),
      'surveySubmittedAt': Timestamp.fromDate(surveySubmittedAt),
      if (clientAttentionScore != null)
        'clientAttentionScore': clientAttentionScore,
      // AdMob verification fields
      if (adTransactionId != null) 'adTransactionId': adTransactionId,
      if (adFullyWatched != null) 'adFullyWatched': adFullyWatched,
      if (adResponseId != null) 'adResponseId': adResponseId,
      // Upload evidence fields
      if (uploadedFiles != null) 'uploadedFiles': uploadedFiles,
      if (uploadTextResponse != null) 'uploadTextResponse': uploadTextResponse,
      if (uploadStartedAt != null)
        'uploadStartedAt': Timestamp.fromDate(uploadStartedAt!),
      if (uploadCompletedAt != null)
        'uploadCompletedAt': Timestamp.fromDate(uploadCompletedAt!),
    };
  }
}

@freezed
abstract class EngagementModel with _$EngagementModel {
  const factory EngagementModel({
    required String id,
    required String userId,
    String? audienceCampaignId,
    required String earnOpportunityId,
    required String status,
    required DateTime startedAt,
    DateTime? completedAt,
    required int watchDurationSeconds,
    required int requiredDurationSeconds,
    required List<SurveyResponseModel> answers,
    EngagementEvidenceModel? evidence,
    double? tokensEarned,
    double? totalTokensGenerated,
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
    // AdMob tracking fields
    @Default(false) bool adWatched,
    String? adTransactionId,
    DateTime? adCompletedAt,
    // Reward escrow fields
    String? rewardItemId,
    String? rewardCampaignName,
    String? rewardType,
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
      audienceCampaignId: json['audienceCampaignId'] as String?,
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
      watchDurationSeconds: (json['watchDurationSeconds'] as num?)?.toInt() ?? 0,
      requiredDurationSeconds: (json['requiredDurationSeconds'] as num?)?.toInt() ?? 0,
      answers: (json['answers'] as List?)
              ?.map((e) =>
                  SurveyResponseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      evidence: evidence is Map<String, dynamic>
          ? EngagementEvidenceModel.fromJson(evidence)
          : null,
      tokensEarned: (json['tokensEarned'] as num?)?.toDouble(),
      totalTokensGenerated: (json['totalTokensGenerated'] as num?)?.toDouble(),
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
      // AdMob tracking fields
      adWatched: json['adWatched'] as bool? ?? false,
      adTransactionId: json['adTransactionId'] as String?,
      adCompletedAt: _parseOptionalTimestamp(json['adCompletedAt']),
      // Reward escrow fields
      rewardItemId: json['rewardItemId'] as String?,
      rewardCampaignName: json['rewardCampaignName'] as String?,
      rewardType: json['rewardType'] as String?,
    );
  }

  static DateTime? _parseOptionalTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    return DateTime.parse(value as String);
  }

  Engagement toEntity() {
    return Engagement(
      id: id,
      userId: userId,
      audienceCampaignId: audienceCampaignId,
      earnOpportunityId: earnOpportunityId,
      status: _parseEngagementStatus(status),
      startedAt: startedAt,
      completedAt: completedAt,
      watchDurationSeconds: watchDurationSeconds,
      requiredDurationSeconds: requiredDurationSeconds,
      answers: answers.map((a) => a.toEntity()).toList(),
      evidence: evidence?.toEntity(),
      tokensEarned: tokensEarned,
      totalTokensGenerated: totalTokensGenerated,
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
      // AdMob tracking fields
      adWatched: adWatched,
      adTransactionId: adTransactionId,
      adCompletedAt: adCompletedAt,
      // Reward escrow fields
      rewardItemId: rewardItemId,
      rewardCampaignName: rewardCampaignName,
      rewardType: rewardType,
    );
  }

  factory EngagementModel.fromEntity(Engagement entity) {
    return EngagementModel(
      id: entity.id,
      userId: entity.userId,
      audienceCampaignId: entity.audienceCampaignId,
      earnOpportunityId: entity.earnOpportunityId,
      status: entity.status.name,
      startedAt: entity.startedAt,
      completedAt: entity.completedAt,
      watchDurationSeconds: entity.watchDurationSeconds,
      requiredDurationSeconds: entity.requiredDurationSeconds,
      answers:
          entity.answers.map((a) => SurveyResponseModel.fromEntity(a)).toList(),
      evidence: entity.evidence != null
          ? EngagementEvidenceModel.fromEntity(entity.evidence!)
          : null,
      tokensEarned: entity.tokensEarned,
      totalTokensGenerated: entity.totalTokensGenerated,
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
      // AdMob tracking fields
      adWatched: entity.adWatched,
      adTransactionId: entity.adTransactionId,
      adCompletedAt: entity.adCompletedAt,
      // Reward escrow fields
      rewardItemId: entity.rewardItemId,
      rewardCampaignName: entity.rewardCampaignName,
      rewardType: entity.rewardType,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'userId': userId,
      'audienceCampaignId': audienceCampaignId,
      'earnOpportunityId': earnOpportunityId,
      'status': status,
      'startedAt': Timestamp.fromDate(startedAt),
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
      'watchDurationSeconds': watchDurationSeconds,
      'requiredDurationSeconds': requiredDurationSeconds,
      'answers': answers.map((a) => a.toFirestoreJson()).toList(),
      if (evidence != null) 'evidence': evidence!.toFirestoreJson(),
      if (tokensEarned != null) 'tokensEarned': tokensEarned,
      if (totalTokensGenerated != null) 'totalTokensGenerated': totalTokensGenerated,
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
      // AdMob tracking fields
      'adWatched': adWatched,
      if (adTransactionId != null) 'adTransactionId': adTransactionId,
      if (adCompletedAt != null) 'adCompletedAt': Timestamp.fromDate(adCompletedAt!),
      // Reward escrow fields
      if (rewardItemId != null) 'rewardItemId': rewardItemId,
      if (rewardCampaignName != null) 'rewardCampaignName': rewardCampaignName,
      if (rewardType != null) 'rewardType': rewardType,
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
      case 'pending_review':
        return EngagementStatus.pendingReview;
      default:
        dev.log(
          'Unknown engagement status "$status" — defaulting to started',
          name: 'EngagementModel',
          level: 900, // WARNING level
        );
        return EngagementStatus.started;
    }
  }
}
