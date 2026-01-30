import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Get current user stream
  Stream<User?> get authStateChanges;

  /// Get current user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Send OTP to phone number
  Future<Either<Failure, String>> sendOtp({
    required String phoneNumber,
  });

  /// Verify OTP and sign in
  Future<Either<Failure, User>> verifyOtp({
    required String verificationId,
    required String otp,
  });

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Delete account
  Future<Either<Failure, void>> deleteAccount();

  /// Check if user is signed in
  Future<bool> isSignedIn();

  /// Refresh auth token
  Future<Either<Failure, void>> refreshToken();

  /// Sign in with a Firebase custom token (used by push-based login).
  Future<Either<Failure, User>> signInWithCustomToken(String token);
}
