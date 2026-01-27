part of 'referral_bloc.dart';

@freezed
class ReferralState with _$ReferralState {
  const factory ReferralState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingReferrals,
    @Default(false) bool isLoadingLeaderboard,
    @Default(false) bool isApplying,
    @Default(false) bool isSharing,
    @Default(false) bool isValidating,
    ReferralStats? stats,
    @Default([]) List<Referral> referrals,
    @Default([]) List<ReferralStats> leaderboard,
    @Default(false) bool hasMoreReferrals,
    Referral? appliedReferral,
    bool? isCodeValid,
    String? errorMessage,
    String? successMessage,
  }) = _ReferralState;
}
