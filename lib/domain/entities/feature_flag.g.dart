// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeatureFlagImpl _$$FeatureFlagImplFromJson(Map<String, dynamic> json) =>
    _$FeatureFlagImpl(
      id: json['id'] as String,
      featureKey: json['featureKey'] as String,
      isEnabled: json['isEnabled'] as bool,
      isGlobal: json['isGlobal'] as bool,
      enabledCommunityIds:
          (json['enabledCommunityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FeatureFlagImplToJson(_$FeatureFlagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'featureKey': instance.featureKey,
      'isEnabled': instance.isEnabled,
      'isGlobal': instance.isGlobal,
      'enabledCommunityIds': instance.enabledCommunityIds,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
