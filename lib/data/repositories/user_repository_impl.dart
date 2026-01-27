import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/user_status.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../models/user_model.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;

  UserRepositoryImpl(
    this._userRemoteDataSource,
    this._authRemoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final userModel = await _userRemoteDataSource.getUserById(userId);
      if (userModel == null) {
        return const Left(Failure.serverError(message: 'User not found'));
      }
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    final firebaseUser = _authRemoteDataSource.currentUser;
    if (firebaseUser == null) {
      return const Left(Failure.unauthenticated());
    }

    return getUserById(firebaseUser.uid);
  }

  @override
  Stream<Either<Failure, User>> watchCurrentUser() {
    final firebaseUser = _authRemoteDataSource.currentUser;
    if (firebaseUser == null) {
      return Stream.value(const Left(Failure.unauthenticated()));
    }

    return _userRemoteDataSource.watchUser(firebaseUser.uid).map((userModel) {
      if (userModel == null) {
        return const Left(Failure.serverError(message: 'User not found'));
      }
      return Right(userModel.toEntity());
    });
  }

  @override
  Future<Either<Failure, User>> createUser({
    required String oddienceUserId,
    required String phoneNumber,
    required String displayName,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final userModel = UserModel(
        oddienceUserId: oddienceUserId,
        phoneNumber: phoneNumber,
        displayName: displayName,
        status: UserStatus.active,
        hasAcceptedTerms: false,
        hasCompletedOnboarding: false,
        isPotEligible: false,
        createdAt: DateTime.now(),
      );

      final createdUser = await _userRemoteDataSource.createUser(userModel);
      return Right(createdUser.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
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
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      // Get current user
      final currentUserModel = await _userRemoteDataSource.getUserById(userId);
      if (currentUserModel == null) {
        return const Left(Failure.serverError(message: 'User not found'));
      }

      // Update fields
      final updatedUserModel = currentUserModel.copyWith(
        displayName: displayName ?? currentUserModel.displayName,
        username: username ?? currentUserModel.username,
        usernameLower: username?.toLowerCase() ?? currentUserModel.usernameLower,
        avatarUrl: avatarUrl ?? currentUserModel.avatarUrl,
        gender: gender ?? currentUserModel.gender,
        dateOfBirth: dateOfBirth ?? currentUserModel.dateOfBirth,
        province: province ?? currentUserModel.province,
        firstName: firstName ?? currentUserModel.firstName,
        lastName: lastName ?? currentUserModel.lastName,
        updatedAt: DateTime.now(),
      );

      final savedUser = await _userRemoteDataSource.updateUser(updatedUserModel);
      return Right(savedUser.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isUsernameAvailable(String username) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final available = await _userRemoteDataSource.isUsernameAvailable(username);
      return Right(available);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> searchByUsername(String query) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final users = await _userRemoteDataSource.searchByUsername(query);
      return Right(users.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getUserByPhoneNumber(String phoneNumber) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final userModel = await _userRemoteDataSource.getUserByPhoneNumber(phoneNumber);
      return Right(userModel?.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFcmToken(String token) async {
    final firebaseUser = _authRemoteDataSource.currentUser;
    if (firebaseUser == null) {
      return const Left(Failure.unauthenticated());
    }

    try {
      await _userRemoteDataSource.updateFcmToken(firebaseUser.uid, token);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateLastActive() async {
    final firebaseUser = _authRemoteDataSource.currentUser;
    if (firebaseUser == null) {
      return const Left(Failure.unauthenticated());
    }

    try {
      await _userRemoteDataSource.updateLastActive(firebaseUser.uid);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptTerms() async {
    final firebaseUser = _authRemoteDataSource.currentUser;
    if (firebaseUser == null) {
      return const Left(Failure.unauthenticated());
    }

    try {
      final currentUser = await _userRemoteDataSource.getUserById(firebaseUser.uid);
      if (currentUser == null) {
        return const Left(Failure.serverError(message: 'User not found'));
      }

      final updatedUser = currentUser.copyWith(
        hasAcceptedTerms: true,
        updatedAt: DateTime.now(),
      );

      await _userRemoteDataSource.updateUser(updatedUser);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
