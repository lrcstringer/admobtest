part of 'feature_flag_bloc.dart';

@freezed
class FeatureFlagState with _$FeatureFlagState {
  const factory FeatureFlagState({
    @Default(false) bool isLoading,
    @Default([]) List<FeatureFlag> flags,
    @Default({}) Map<String, FeatureFlag> flagMap,
    @Default({}) Map<String, bool> featureChecks,
    String? errorMessage,
  }) = _FeatureFlagState;
}
