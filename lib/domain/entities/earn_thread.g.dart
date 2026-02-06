// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarnThreadImpl _$$EarnThreadImplFromJson(
  Map<String, dynamic> json,
) => _$EarnThreadImpl(
  id: json['id'] as String,
  clientId: json['clientId'] as String,
  clientName: json['clientName'] as String,
  clientAvatarImage: json['clientAvatarImage'] as String?,
  clientAvatarColor: json['clientAvatarColor'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  isPinned: json['isPinned'] as bool,
  isFeatured: json['isFeatured'] as bool,
  isActive: json['isActive'] as bool,
  activeFrom: json['activeFrom'] == null
      ? null
      : DateTime.parse(json['activeFrom'] as String),
  activeTo: json['activeTo'] == null
      ? null
      : DateTime.parse(json['activeTo'] as String),
  tokenSourceSubAccountId: json['tokenSourceSubAccountId'] as String?,
  tokenDestAccountTypeId: json['tokenDestAccountTypeId'] as String?,
  availableOpportunities: (json['availableOpportunities'] as num).toInt(),
  completedOpportunities: (json['completedOpportunities'] as num).toInt(),
  completedUniqueUsers: (json['completedUniqueUsers'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastActivityAt: json['lastActivityAt'] == null
      ? null
      : DateTime.parse(json['lastActivityAt'] as String),
  targeting: json['targeting'] == null
      ? null
      : TargetingCriteria.fromJson(json['targeting'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$EarnThreadImplToJson(_$EarnThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientAvatarImage': instance.clientAvatarImage,
      'clientAvatarColor': instance.clientAvatarColor,
      'title': instance.title,
      'description': instance.description,
      'isPinned': instance.isPinned,
      'isFeatured': instance.isFeatured,
      'isActive': instance.isActive,
      'activeFrom': instance.activeFrom?.toIso8601String(),
      'activeTo': instance.activeTo?.toIso8601String(),
      'tokenSourceSubAccountId': instance.tokenSourceSubAccountId,
      'tokenDestAccountTypeId': instance.tokenDestAccountTypeId,
      'availableOpportunities': instance.availableOpportunities,
      'completedOpportunities': instance.completedOpportunities,
      'completedUniqueUsers': instance.completedUniqueUsers,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
      'targeting': instance.targeting,
    };
