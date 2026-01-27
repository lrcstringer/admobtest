part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    User? user,
    @Default(0) int lifetimeEarned,
    @Default(0) int lifetimeWithdrawn,
    @Default(false) bool isUpdating,
    @Default(false) bool isCheckingUsername,
    bool? usernameAvailable,
    @Default(false) bool updateSuccess,
    String? updateError,
    String? errorMessage,
  }) = _ProfileState;
}

extension ProfileStateX on ProfileState {
  bool get isLoading => status == ProfileStatus.loading;
  bool get isLoaded => status == ProfileStatus.loaded;
  bool get hasError => status == ProfileStatus.error;
  bool get hasUser => user != null;

  /// Get user display name
  String get displayName => user?.displayName ?? 'User';

  /// Get username
  String? get username => user?.profile?.username;

  /// Check if profile is complete
  bool get isProfileComplete => user?.profile?.isComplete ?? false;

  /// Check if user has accepted terms
  bool get hasAcceptedTerms => user?.hasAcceptedTerms ?? false;

  /// Check if user has completed onboarding
  bool get hasCompletedOnboarding => user?.hasCompletedOnboarding ?? false;

  /// Check if user needs onboarding
  bool get needsOnboarding => user?.needsOnboarding ?? true;

  /// Get user initials
  String get initials => user?.initials ?? '??';

  /// Get avatar URL
  String? get avatarUrl => user?.profile?.avatarUrl;

  /// Get user's referral code
  String? get referralCode => user?.referralCode;

  /// Check if user is pot eligible
  bool get isPotEligible => user?.isPotEligibleNow ?? false;

  /// Get days until cashout eligibility
  int get daysUntilCashout {
    if (user == null) return 7;
    final daysSinceSignup = DateTime.now().difference(user!.createdAt).inDays;
    return (7 - daysSinceSignup).clamp(0, 7);
  }

  /// Check if user can cashout
  bool get canCashout => user?.canCashout ?? false;
}
