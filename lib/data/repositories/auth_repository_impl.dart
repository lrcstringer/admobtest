import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/user_status.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;
  final NetworkInfo _networkInfo;
  final AppDatabase _appDatabase;

  // Track OTP send time for local cooldown
  DateTime? _lastOtpSentAt;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._userRemoteDataSource,
    this._networkInfo,
    this._appDatabase,
  );

  @override
  Stream<User?> get authStateChanges {
    return _authRemoteDataSource.authStateChanges.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      final userModel = await _userRemoteDataSource.getUserById(firebaseUser.uid);
      return userModel?.toEntity();
    });
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final firebaseUser = _authRemoteDataSource.currentUser;
      if (firebaseUser == null) {
        return const Right(null);
      }

      final userModel = await _userRemoteDataSource.getUserById(firebaseUser.uid);
      return Right(userModel?.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendOtp({required String phoneNumber}) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    // Check local resend cooldown (60 seconds)
    if (_lastOtpSentAt != null &&
        DateTime.now().difference(_lastOtpSentAt!) < const Duration(seconds: 60)) {
      final remainingSeconds = 60 - DateTime.now().difference(_lastOtpSentAt!).inSeconds;
      return Left(Failure.auth(
        message: 'Please wait $remainingSeconds seconds before requesting a new code',
      ));
    }

    try {
      await _authRemoteDataSource.sendOtp(phoneNumber: phoneNumber);
      _lastOtpSentAt = DateTime.now();

      // Return phone number as the "verificationId" for compatibility with existing flow
      return Right(phoneNumber);
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(Failure.auth(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp({
    required String verificationId, // This is now the phone number
    required String otp,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final userCredential = await _authRemoteDataSource.verifyOtp(
        phoneNumber: verificationId, // Use verificationId which is phone number
        otp: otp,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return const Left(Failure.auth(message: 'Authentication failed'));
      }

      // Check if user exists
      var userModel = await _userRemoteDataSource.getUserById(firebaseUser.uid);

      // Create new user if doesn't exist
      // Note: hasAcceptedTerms defaults to true because users must accept
      // terms on the age consent screen before they can reach OTP verification.
      if (userModel == null) {
        userModel = UserModel(
          userId: firebaseUser.uid,
          phoneNumber: firebaseUser.phoneNumber ?? verificationId,
          displayName: 'iMali User',
          status: UserStatus.active,
          hasAcceptedTerms: true,
          hasCompletedOnboarding: false,
          isPotEligible: false,
          createdAt: DateTime.now(),
        );

        userModel = await _userRemoteDataSource.createUser(userModel);
      }

      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.auth(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      _lastOtpSentAt = null;
      return const Right(null);
    } catch (e) {
      return Left(Failure.auth(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _authRemoteDataSource.deleteAccount();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } catch (e) {
      return Left(Failure.auth(message: e.toString()));
    }
  }

  @override
  Future<bool> isSignedIn() async {
    return _authRemoteDataSource.currentUser != null;
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      await _authRemoteDataSource.getIdToken(forceRefresh: true);
      return const Right(null);
    } catch (e) {
      return Left(Failure.auth(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithCustomToken(String token) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final userCredential =
          await _authRemoteDataSource.signInWithCustomToken(token);

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return const Left(Failure.auth(message: 'Sign-in returned no user'));
      }

      // Fetch existing user profile from Firestore
      var userModel =
          await _userRemoteDataSource.getUserById(firebaseUser.uid);

      if (userModel == null) {
        // Create user if somehow doesn't exist
        // Note: hasAcceptedTerms defaults to true - terms accepted on age consent screen
        userModel = UserModel(
          userId: firebaseUser.uid,
          phoneNumber: firebaseUser.phoneNumber ?? '',
          displayName: 'iMali User',
          status: UserStatus.active,
          hasAcceptedTerms: true,
          hasCompletedOnboarding: false,
          isPotEligible: false,
          createdAt: DateTime.now(),
        );
        userModel = await _userRemoteDataSource.createUser(userModel);
      }

      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.auth(message: e.toString()));
    }
  }

  @override
  Future<void> clearLocalCache() async {
    await _appDatabase.clearAllData();
  }

  /// Map AuthException to appropriate Failure type
  Failure _mapAuthException(AuthException e) {
    final message = e.message?.toLowerCase() ?? '';

    if (message.contains('expired')) {
      return const Failure.otpExpired();
    }
    if (message.contains('invalid') && message.contains('code')) {
      return const Failure.invalidOtp();
    }
    if (message.contains('too many') || message.contains('attempts')) {
      return const Failure.tooManyAttempts();
    }
    if (message.contains('invalid') && message.contains('phone')) {
      return Failure.auth(message: e.message);
    }

    return Failure.auth(message: e.message);
  }
}
