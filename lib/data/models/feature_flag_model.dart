import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/feature_flag.dart';

part 'feature_flag_model.freezed.dart';

@freezed
abstract class FeatureFlagModel with _$FeatureFlagModel {
  const factory FeatureFlagModel({
    required String id,
    required String featureKey,
    required bool isEnabled,
    required bool isGlobal,
    @Default([]) List<String> enabledCommunityIds,
    DateTime? updatedAt,
  }) = _FeatureFlagModel;

  const FeatureFlagModel._();

  factory FeatureFlagModel.fromJson(Map<String, dynamic> json) {
    final updatedAt = json['updatedAt'];
    return FeatureFlagModel(
      id: json['id'] as String? ?? '',
      featureKey: json['featureKey'] as String? ?? '',
      isEnabled: json['isEnabled'] as bool? ?? false,
      isGlobal: json['isGlobal'] as bool? ?? false,
      enabledCommunityIds: (json['enabledCommunityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      updatedAt: updatedAt is Timestamp
          ? updatedAt.toDate()
          : updatedAt is String
              ? DateTime.tryParse(updatedAt)
              : null,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'featureKey': featureKey,
      'isEnabled': isEnabled,
      'isGlobal': isGlobal,
      'enabledCommunityIds': enabledCommunityIds,
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  FeatureFlag toEntity() {
    return FeatureFlag(
      id: id,
      featureKey: featureKey,
      isEnabled: isEnabled,
      isGlobal: isGlobal,
      enabledCommunityIds: enabledCommunityIds,
      updatedAt: updatedAt,
    );
  }

  factory FeatureFlagModel.fromEntity(FeatureFlag entity) {
    return FeatureFlagModel(
      id: entity.id,
      featureKey: entity.featureKey,
      isEnabled: entity.isEnabled,
      isGlobal: entity.isGlobal,
      enabledCommunityIds: entity.enabledCommunityIds,
      updatedAt: entity.updatedAt,
    );
  }
}
