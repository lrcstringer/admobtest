// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'targeting_criteria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TargetingCriteriaImpl _$$TargetingCriteriaImplFromJson(
  Map<String, dynamic> json,
) => _$TargetingCriteriaImpl(
  genders: (json['genders'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  ageMin: (json['ageMin'] as num?)?.toInt(),
  ageMax: (json['ageMax'] as num?)?.toInt(),
  provinces: (json['provinces'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  cities: (json['cities'] as List<dynamic>?)?.map((e) => e as String).toList(),
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  interests: (json['interests'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  devicePlatforms: (json['devicePlatforms'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  accountAgeMinDays: (json['accountAgeMinDays'] as num?)?.toInt(),
  accountAgeMaxDays: (json['accountAgeMaxDays'] as num?)?.toInt(),
  engagementLevel: (json['engagementLevel'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  previousBrandInteraction: json['previousBrandInteraction'] as String?,
  maxAudience: (json['maxAudience'] as num?)?.toInt(),
);

Map<String, dynamic> _$$TargetingCriteriaImplToJson(
  _$TargetingCriteriaImpl instance,
) => <String, dynamic>{
  'genders': instance.genders,
  'ageMin': instance.ageMin,
  'ageMax': instance.ageMax,
  'provinces': instance.provinces,
  'cities': instance.cities,
  'languages': instance.languages,
  'interests': instance.interests,
  'devicePlatforms': instance.devicePlatforms,
  'accountAgeMinDays': instance.accountAgeMinDays,
  'accountAgeMaxDays': instance.accountAgeMaxDays,
  'engagementLevel': instance.engagementLevel,
  'previousBrandInteraction': instance.previousBrandInteraction,
  'maxAudience': instance.maxAudience,
};
