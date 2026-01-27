part of 'referral_bloc.dart';

@freezed
class ReferralEvent with _$ReferralEvent {
  /// Load referral stats
  const factory ReferralEvent.loadStats() = _LoadStats;

  /// Load referral list
  const factory ReferralEvent.loadReferrals({
    ReferralStatus? status,
    int? limit,
    DateTime? startAfter,
  }) = _LoadReferrals;

  /// Watch referrals for real-time updates
  const factory ReferralEvent.watchReferrals() = _WatchReferrals;

  /// Referrals updated from stream
  const factory ReferralEvent.referralsUpdated(List<Referral> referrals) =
      _ReferralsUpdated;

  /// Apply a referral code
  const factory ReferralEvent.applyCode(String code) = _ApplyCode;

  /// Share referral
  const factory ReferralEvent.shareReferral({
    required String platform,
    String? customMessage,
  }) = _ShareReferral;

  /// Copy referral code
  const factory ReferralEvent.copyCode() = _CopyCode;

  /// Validate a referral code
  const factory ReferralEvent.validateCode(String code) = _ValidateCode;

  /// Load referral leaderboard
  const factory ReferralEvent.loadLeaderboard({int? limit}) = _LoadLeaderboard;

  /// Clear error
  const factory ReferralEvent.clearError() = _ClearError;

  /// Clear success message
  const factory ReferralEvent.clearSuccess() = _ClearSuccess;
}
