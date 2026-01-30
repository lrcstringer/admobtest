part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  /// Check initial authentication state
  const factory AuthEvent.checkAuthStatus() = _CheckAuthStatus;

  /// Send OTP to phone number
  const factory AuthEvent.sendOtp({required String phoneNumber}) = _SendOtp;

  /// Verify OTP code
  const factory AuthEvent.verifyOtp({
    required String verificationId,
    required String otp,
  }) = _VerifyOtp;

  /// Resend OTP
  const factory AuthEvent.resendOtp({required String phoneNumber}) = _ResendOtp;

  /// Sign out
  const factory AuthEvent.signOut() = _SignOut;

  /// Delete account
  const factory AuthEvent.deleteAccount() = _DeleteAccount;

  /// Accept terms and conditions
  const factory AuthEvent.acceptTerms() = _AcceptTerms;

  /// Complete onboarding
  const factory AuthEvent.completeOnboarding() = _CompleteOnboarding;

  /// Bind the current device after OTP verification (non-blocking)
  const factory AuthEvent.bindDevice() = _BindDevice;

  /// Lock the session (triggered by lifecycle observer)
  const factory AuthEvent.lockSession() = _LockSession;

  /// Unlock the session (after successful biometric/PIN/credential unlock)
  const factory AuthEvent.unlockSession() = _UnlockSession;

  /// Force full re-authentication (session expired beyond threshold)
  const factory AuthEvent.forceReauth() = _ForceReauth;

  /// Authenticate using a custom token from push-based login approval.
  const factory AuthEvent.authenticateWithPushToken({
    required String customToken,
  }) = _AuthenticateWithPushToken;
}
