import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/trusted_device.dart';
import '../../domain/repositories/device_repository.dart';
import '../datasources/remote/device_remote_datasource.dart';

@LazySingleton(as: DeviceRepository)
class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  DeviceRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, TrustedDevice>> registerDevice({
    required String publicKeyPem,
    required String fcmToken,
    required String platform,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    required String manufacturer,
    required bool hardwareBacked,
    required bool strongBox,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.noInternet());
    }

    try {
      final model = await _remoteDataSource.registerDevice(
        publicKeyPem: publicKeyPem,
        fcmToken: fcmToken,
        platform: platform,
        deviceModel: deviceModel,
        osVersion: osVersion,
        appVersion: appVersion,
        manufacturer: manufacturer,
        hardwareBacked: hardwareBacked,
        strongBox: strongBox,
      );
      return Right(model.toEntity());
    } on FirebaseFunctionsException catch (e) {
      return Left(_mapFunctionsError(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isDeviceTrusted(String deviceId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.noInternet());
    }

    try {
      final isTrusted = await _remoteDataSource.isDeviceTrusted(deviceId);
      return Right(isTrusted);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrustedDevice>>> getUserDevices() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.noInternet());
    }

    try {
      final models = await _remoteDataSource.getUserDevices();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> revokeDevice(String deviceId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.noInternet());
    }

    try {
      await _remoteDataSource.revokeDevice(deviceId);
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(_mapFunctionsError(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFcmToken({
    required String deviceId,
    required String fcmToken,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.noInternet());
    }

    try {
      await _remoteDataSource.updateFcmToken(
        deviceId: deviceId,
        fcmToken: fcmToken,
      );
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(_mapFunctionsError(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  Failure _mapFunctionsError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'resource-exhausted':
        return const Failure.tooManyAttempts();
      case 'unauthenticated':
        return const Failure.unauthenticated();
      case 'not-found':
        return Failure.serverError(
            code: e.code, message: e.message ?? 'Device not found');
      default:
        return Failure.serverError(code: e.code, message: e.message);
    }
  }
}
