import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/user_status.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;
  final NetworkInfo _networkInfo;

  // Store verification ID temporarily
  String? _currentVerificationId;
  int? _resendToken;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._userRemoteDataSource,
    this._networkInfo,
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

    try {
      String? verificationId;
      String? errorMessage;

      await _authRemoteDataSource.sendOtp(
        phoneNumber: phoneNumber,
        forceResendingToken: _resendToken,
        onAutoVerify: (credential) async {
          // Auto verification on Android
          // Will be handled by the bloc
        },
        onCodeSent: (verId) {
          verificationId = verId;
          _currentVerificationId = verId;
        },
        onFailed: (e) {
          errorMessage = _mapFirebaseAuthError(e);
        },
      );

      // Wait a bit for callbacks
      await Future.delayed(const Duration(seconds: 2));

      if (errorMessage != null) {
        return Left(Failure.auth(message: errorMessage!));
      }

      if (verificationId == null && _currentVerificationId == null) {
        return const Left(Failure.auth(message: 'Failed to send OTP'));
      }

      return Right(verificationId ?? _currentVerificationId!);
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } catch (e) {
      return Left(Failure.auth(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final userCredential = await _authRemoteDataSource.verifyOtp(
        verificationId: verificationId,
        otp: otp,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return const Left(Failure.auth(message: 'Authentication failed'));
      }

      // Check if user exists
      var userModel = await _userRemoteDataSource.getUserById(firebaseUser.uid);

      // Create new user if doesn't exist
      if (userModel == null) {
        userModel = UserModel(
          oddienceUserId: firebaseUser.uid,
          phoneNumber: firebaseUser.phoneNumber ?? '',
          displayName: 'iMali User',
          status: UserStatus.active,
          hasAcceptedTerms: false,
          hasCompletedOnboarding: false,
          isPotEligible: false,
          createdAt: DateTime.now(),
        );

        userModel = await _userRemoteDataSource.createUser(userModel);
      }

      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
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
      _currentVerificationId = null;
      _resendToken = null;
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

  String _mapFirebaseAuthError(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Invalid phone number format';
      case 'too-many-requests':
        return 'Too many requests. Please try again later';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'operation-not-allowed':
        return 'Phone authentication is not enabled';
      default:
        return e.message ?? 'Authentication error occurred';
    }
  }
}
