/// Custom exceptions for the application
class ServerException implements Exception {
  final String? message;
  final String? code;

  const ServerException({this.message, this.code});

  @override
  String toString() => 'ServerException: $message (code: $code)';
}

class CacheException implements Exception {
  final String? message;

  const CacheException({this.message});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String? message;

  const NetworkException({this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String? message;

  const AuthException({this.message});

  @override
  String toString() => 'AuthException: $message';
}

class InvalidOtpException implements Exception {
  @override
  String toString() => 'InvalidOtpException: Invalid verification code';
}

class OtpExpiredException implements Exception {
  @override
  String toString() => 'OtpExpiredException: Verification code has expired';
}

class TooManyRequestsException implements Exception {
  @override
  String toString() => 'TooManyRequestsException: Too many attempts';
}

class InsufficientBalanceException implements Exception {
  @override
  String toString() => 'InsufficientBalanceException: Insufficient balance';
}

class DailyCapReachedException implements Exception {
  @override
  String toString() => 'DailyCapReachedException: Daily earning cap reached';
}

class UserSuspendedException implements Exception {
  @override
  String toString() => 'UserSuspendedException: User account is suspended';
}

class NotEligibleException implements Exception {
  final String? reason;

  const NotEligibleException({this.reason});

  @override
  String toString() => 'NotEligibleException: $reason';
}
