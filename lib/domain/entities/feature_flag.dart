import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flag.freezed.dart';
part 'feature_flag.g.dart';

@freezed
class FeatureFlag with _$FeatureFlag {
  const factory FeatureFlag({
    required String id,
    required String featureKey,
    required bool isEnabled,
    required bool isGlobal,
    @Default([]) List<String> enabledCommunityIds,
    DateTime? updatedAt,
  }) = _FeatureFlag;

  const FeatureFlag._();

  factory FeatureFlag.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagFromJson(json);

  /// Check if this flag is enabled for a specific community
  bool isEnabledForCommunity(String communityId) {
    if (!isEnabled) return false;
    if (isGlobal) return true;
    return enabledCommunityIds.contains(communityId);
  }
}
