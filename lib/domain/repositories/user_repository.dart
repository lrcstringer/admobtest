import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';

/// User repository interface
abstract class UserRepository {
  /// Get user by ID
  Future<Either<Failure, User>> getUserById(String userId);

  /// Get current user
  Future<Either<Failure, User>> getCurrentUser();

  /// Stream current user
  Stream<Either<Failure, User>> watchCurrentUser();

  /// Create user profile
  Future<Either<Failure, User>> createUser({
    required String oddienceUserId,
    required String phoneNumber,
    required String displayName,
  });

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    required String userId,
    String? displayName,
    String? username,
    String? avatarUrl,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? firstName,
    String? lastName,
  });

  /// Check if username is available
  Future<Either<Failure, bool>> isUsernameAvailable(String username);

  /// Search users by username
  Future<Either<Failure, List<User>>> searchByUsername(String query);

  /// Get user by phone number
  Future<Either<Failure, User?>> getUserByPhoneNumber(String phoneNumber);

  /// Update FCM token
  Future<Either<Failure, void>> updateFcmToken(String token);

  /// Update last active timestamp
  Future<Either<Failure, void>> updateLastActive();

  /// Accept terms and conditions
  Future<Either<Failure, void>> acceptTerms();

  /// Mark onboarding as completed
  Future<Either<Failure, void>> completeOnboarding();
}
