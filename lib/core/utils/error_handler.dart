/// Global error handler for the app
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../error/failures.dart';

/// Global error handler singleton
@lazySingleton
class ErrorHandler {
  ErrorHandler();

  final _errorController = StreamController<AppError>.broadcast();

  /// Stream of errors for UI to listen to
  Stream<AppError> get errors => _errorController.stream;

  /// Report an error
  void report(dynamic error, [StackTrace? stackTrace]) {
    final appError = _convertToAppError(error, stackTrace);

    // Log error
    _logError(appError);

    // Emit to stream for UI
    _errorController.add(appError);

    // In production, send to crash reporting service
    if (!kDebugMode) {
      _sendToCrashReporting(appError);
    }
  }

  /// Report a failure
  void reportFailure(Failure failure) {
    final appError = AppError(
      message: failure.displayMessage,
      code: _getFailureCode(failure),
      isRecoverable: _isRecoverable(failure),
      originalError: failure,
    );

    _logError(appError);
    _errorController.add(appError);
  }

  AppError _convertToAppError(dynamic error, StackTrace? stackTrace) {
    if (error is Failure) {
      return AppError(
        message: error.displayMessage,
        code: _getFailureCode(error),
        isRecoverable: _isRecoverable(error),
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (error is Exception) {
      return AppError(
        message: error.toString(),
        code: 'EXCEPTION',
        isRecoverable: true,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    return AppError(
      message: error?.toString() ?? 'Unknown error',
      code: 'UNKNOWN',
      isRecoverable: false,
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  String _getFailureCode(Failure failure) {
    return failure.maybeWhen(
      network: (_) => 'NETWORK_ERROR',
      timeout: () => 'TIMEOUT_ERROR',
      noInternet: () => 'NO_INTERNET',
      auth: (_) => 'AUTH_ERROR',
      unauthenticated: () => 'UNAUTHENTICATED',
      invalidOtp: () => 'INVALID_OTP',
      otpExpired: () => 'OTP_EXPIRED',
      tooManyAttempts: () => 'TOO_MANY_ATTEMPTS',
      dailyCapReached: () => 'DAILY_CAP_REACHED',
      insufficientBalance: () => 'INSUFFICIENT_BALANCE',
      cashoutNotEligible: () => 'CASHOUT_NOT_ELIGIBLE',
      potNotEligible: () => 'POT_NOT_ELIGIBLE',
      userSuspended: () => 'USER_SUSPENDED',
      invalidPhone: () => 'INVALID_PHONE',
      invalidUsername: () => 'INVALID_USERNAME',
      invalidAmount: () => 'INVALID_AMOUNT',
      serverError: (_, __) => 'SERVER_ERROR',
      unknown: (_) => 'UNKNOWN_ERROR',
      cacheError: (_) => 'CACHE_ERROR',
      orElse: () => 'UNKNOWN',
    );
  }

  bool _isRecoverable(Failure failure) {
    return failure.maybeWhen(
      network: (_) => true,
      timeout: () => true,
      noInternet: () => true,
      auth: (_) => false,
      unauthenticated: () => false,
      invalidOtp: () => true,
      otpExpired: () => true,
      tooManyAttempts: () => false,
      dailyCapReached: () => false,
      insufficientBalance: () => true,
      cashoutNotEligible: () => false,
      potNotEligible: () => false,
      userSuspended: () => false,
      invalidPhone: () => true,
      invalidUsername: () => true,
      invalidAmount: () => true,
      serverError: (_, __) => true,
      unknown: (_) => false,
      cacheError: (_) => true,
      orElse: () => false,
    );
  }

  void _logError(AppError error) {
    if (kDebugMode) {
      debugPrint('=== APP ERROR ===');
      debugPrint('Message: ${error.message}');
      debugPrint('Code: ${error.code}');
      debugPrint('Recoverable: ${error.isRecoverable}');
      if (error.stackTrace != null) {
        debugPrint('Stack trace:\n${error.stackTrace}');
      }
      debugPrint('================');
    }
  }

  void _sendToCrashReporting(AppError error) {
    // Integrate with Firebase Crashlytics in production
    // FirebaseCrashlytics.instance.recordError(
    //   error.originalError,
    //   error.stackTrace,
    //   reason: error.message,
    // );
  }

  void dispose() {
    _errorController.close();
  }
}

/// App error model
class AppError {
  final String message;
  final String code;
  final bool isRecoverable;
  final dynamic originalError;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  AppError({
    required this.message,
    required this.code,
    required this.isRecoverable,
    this.originalError,
    this.stackTrace,
  }) : timestamp = DateTime.now();

  @override
  String toString() => 'AppError($code): $message';
}
