import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/feature_flag.dart';
import '../../domain/repositories/feature_flag_repository.dart';
import '../datasources/remote/feature_flag_remote_datasource.dart';

@LazySingleton(as: FeatureFlagRepository)
class FeatureFlagRepositoryImpl implements FeatureFlagRepository {
  final FeatureFlagRemoteDataSource _remoteDataSource;

  FeatureFlagRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<FeatureFlag>>> getFeatureFlags() async {
    try {
      final models = await _remoteDataSource.getFeatureFlags();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFeatureEnabled(
    String featureKey, {
    String? communityId,
  }) async {
    try {
      final models = await _remoteDataSource.getFeatureFlags();
      final flag = models
          .map((m) => m.toEntity())
          .where((f) => f.featureKey == featureKey)
          .firstOrNull;

      if (flag == null) return const Right(false);
      if (!flag.isEnabled) return const Right(false);
      if (flag.isGlobal) return const Right(true);
      if (communityId != null) {
        return Right(flag.isEnabledForCommunity(communityId));
      }
      return const Right(false);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
