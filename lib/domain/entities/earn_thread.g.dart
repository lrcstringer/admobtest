// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarnThreadImpl _$$EarnThreadImplFromJson(Map<String, dynamic> json) =>
    _$EarnThreadImpl(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      avatarColor: json['avatarColor'] as String?,
      avatarImage: json['avatarImage'] as String?,
      isPinned: json['isPinned'] as bool,
      isActive: json['isActive'] as bool,
      availableOpportunities: (json['availableOpportunities'] as num).toInt(),
      completedOpportunities: (json['completedOpportunities'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActivityAt: json['lastActivityAt'] == null
          ? null
          : DateTime.parse(json['lastActivityAt'] as String),
    );

Map<String, dynamic> _$$EarnThreadImplToJson(_$EarnThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'brandName': instance.brandName,
      'avatarColor': instance.avatarColor,
      'avatarImage': instance.avatarImage,
      'isPinned': instance.isPinned,
      'isActive': instance.isActive,
      'availableOpportunities': instance.availableOpportunities,
      'completedOpportunities': instance.completedOpportunities,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
    };
