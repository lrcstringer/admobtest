/// Status of an engagement (ad view + survey completion)
enum EngagementStatus {
  /// Engagement started, video not yet watched
  started,

  /// Watching video
  watching,

  /// Video completed, answering survey
  surveying,

  /// Engagement completed successfully
  completed,

  /// Engagement failed validation
  failed,

  /// Engagement was abandoned
  abandoned,

  /// Reward has been credited
  rewarded,

  /// Engagement was rejected
  rejected,

  /// Upload submitted, awaiting admin review
  pendingReview,
}

extension EngagementStatusX on EngagementStatus {
  bool get isComplete =>
      this == EngagementStatus.completed ||
      this == EngagementStatus.rewarded ||
      this == EngagementStatus.pendingReview;

  bool get isInProgress =>
      this == EngagementStatus.started ||
      this == EngagementStatus.watching ||
      this == EngagementStatus.surveying;

  bool get isRewarded => this == EngagementStatus.rewarded;

  bool get isFailed =>
      this == EngagementStatus.failed ||
      this == EngagementStatus.rejected ||
      this == EngagementStatus.abandoned;

  bool get canSubmitSurvey => this == EngagementStatus.surveying;

  String get displayName {
    switch (this) {
      case EngagementStatus.started:
        return 'Started';
      case EngagementStatus.watching:
        return 'Watching';
      case EngagementStatus.surveying:
        return 'Answering Survey';
      case EngagementStatus.completed:
        return 'Completed';
      case EngagementStatus.failed:
        return 'Failed';
      case EngagementStatus.abandoned:
        return 'Abandoned';
      case EngagementStatus.rewarded:
        return 'Rewarded';
      case EngagementStatus.rejected:
        return 'Rejected';
      case EngagementStatus.pendingReview:
        return 'Under Review';
    }
  }
}
