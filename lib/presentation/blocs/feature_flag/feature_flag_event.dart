part of 'feature_flag_bloc.dart';

@freezed
abstract class FeatureFlagEvent with _$FeatureFlagEvent {
  /// Load all feature flags from remote
  const factory FeatureFlagEvent.loadFeatureFlags() = _LoadFeatureFlags;

  /// Check if a specific feature is enabled for a community
  const factory FeatureFlagEvent.checkFeature({
    required String featureKey,
    String? communityId,
  }) = _CheckFeature;
}
