part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    User? user,
    String? verificationId,
    String? phoneNumber,
    String? errorMessage,
    @Default(false) bool isLoading,
    @Default(0) int resendCountdown,
    @Default(false) bool isDeviceBound,
    String? deviceId,
  }) = _AuthState;

  const AuthState._();

  /// Check if user is authenticated
  bool get isAuthenticated => user != null;

  /// Check if user needs onboarding
  bool get needsOnboarding =>
      user != null && (user!.needsOnboarding || !user!.hasAcceptedTerms);

  /// Check if OTP was sent
  bool get otpSent => verificationId != null;
}

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  otpSent,
  otpVerified,
  onboardingRequired,
  sessionLocked,
  error,
}
