import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Represents all possible failure states in the application
@freezed
abstract class Failure with _$Failure {
  // Network failures
  const factory Failure.network({String? message}) = NetworkFailure;
  const factory Failure.timeout() = TimeoutFailure;
  const factory Failure.noInternet() = NoInternetFailure;

  // Auth failures
  const factory Failure.auth({String? message}) = AuthFailure;
  const factory Failure.unauthenticated() = UnauthenticatedFailure;
  const factory Failure.invalidOtp() = InvalidOtpFailure;
  const factory Failure.otpExpired() = OtpExpiredFailure;
  const factory Failure.tooManyAttempts() = TooManyAttemptsFailure;

  // Business Logic failures
  const factory Failure.dailyCapReached() = DailyCapReachedFailure;
  const factory Failure.insufficientBalance() = InsufficientBalanceFailure;
  const factory Failure.cashoutNotEligible() = CashoutNotEligibleFailure;
  const factory Failure.potNotEligible() = PotNotEligibleFailure;
  const factory Failure.userSuspended() = UserSuspendedFailure;

  // Validation failures
  const factory Failure.invalidPhone() = InvalidPhoneFailure;
  const factory Failure.invalidUsername() = InvalidUsernameFailure;
  const factory Failure.invalidAmount() = InvalidAmountFailure;

  // Server failures
  const factory Failure.serverError({String? code, String? message}) =
      ServerFailure;
  const factory Failure.unknown({String? message}) = UnknownFailure;

  // Device & Security failures
  const factory Failure.stepUpRequired({String? reason}) = StepUpRequiredFailure;
  const factory Failure.deviceNotTrusted() = DeviceNotTrustedFailure;
  const factory Failure.simChanged() = SimChangedFailure;
  const factory Failure.deviceBindingFailed({String? message}) =
      DeviceBindingFailedFailure;
  const factory Failure.sessionLocked() = SessionLockedFailure;

  // Cache failures
  const factory Failure.cacheError({String? message}) = CacheFailure;
}

/// Extension to get user-friendly error messages
extension FailureX on Failure {
  String get displayMessage => when(
        network: (message) => message ?? 'Network error occurred',
        timeout: () => 'Request timed out. Please try again.',
        noInternet: () => 'No internet connection. Please check your network.',
        auth: (message) => message ?? 'Authentication error occurred',
        unauthenticated: () => 'Please sign in to continue',
        invalidOtp: () => 'Invalid verification code. Please try again.',
        otpExpired: () => 'Verification code expired. Please request a new one.',
        tooManyAttempts: () => 'Too many attempts. Please try again later.',
        dailyCapReached: () =>
            'You\'ve reached your daily earning limit. Come back tomorrow!',
        insufficientBalance: () => 'Insufficient balance for this transaction.',
        cashoutNotEligible: () =>
            'You\'re not eligible for cashout yet. Keep earning!',
        potNotEligible: () =>
            'You\'re not eligible for pot participation yet.',
        userSuspended: () =>
            'Your account has been suspended. Please contact support.',
        invalidPhone: () => 'Please enter a valid South African phone number.',
        invalidUsername: () =>
            'Username must be 3-20 characters with no spaces.',
        invalidAmount: () => 'Please enter a valid amount.',
        stepUpRequired: (reason) =>
            reason ?? 'Additional verification required.',
        deviceNotTrusted: () =>
            'This device is not trusted. Please verify your identity.',
        simChanged: () =>
            'SIM card change detected. Please verify your identity.',
        deviceBindingFailed: (message) =>
            message ?? 'Device registration failed.',
        sessionLocked: () =>
            'Your session is locked. Please unlock to continue.',
        serverError: (code, message) =>
            (message != null && message != 'INTERNAL' && !message.startsWith('INTERNAL'))
                ? message
                : 'Something went wrong. Please try again.',
        unknown: (message) =>
            message ?? 'An unexpected error occurred. Please try again.',
        cacheError: (message) =>
            message ?? 'Failed to load cached data.',
      );

  bool get isAuthError => maybeWhen(
        auth: (_) => true,
        unauthenticated: () => true,
        invalidOtp: () => true,
        otpExpired: () => true,
        tooManyAttempts: () => true,
        orElse: () => false,
      );

  bool get isNetworkError => maybeWhen(
        network: (_) => true,
        timeout: () => true,
        noInternet: () => true,
        orElse: () => false,
      );
}
