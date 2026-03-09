import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/feature_flag.dart';

abstract class FeatureFlagRepository {
  /// Get all feature flags
  Future<Either<Failure, List<FeatureFlag>>> getFeatureFlags();

  /// Check if a feature is enabled for a specific community
  Future<Either<Failure, bool>> isFeatureEnabled(
    String featureKey, {
    String? communityId,
  });
}
