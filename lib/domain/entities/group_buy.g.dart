// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_buy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupBuyImpl _$$GroupBuyImplFromJson(Map<String, dynamic> json) =>
    _$GroupBuyImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      linkedListingId: json['linkedListingId'] as String?,
      organizerId: json['organizerId'] as String,
      organizerName: json['organizerName'] as String,
      communityId: json['communityId'] as String,
      targetAmount: (json['targetAmount'] as num).toInt(),
      currentAmount: (json['currentAmount'] as num?)?.toInt() ?? 0,
      minParticipants: (json['minParticipants'] as num?)?.toInt() ?? 1,
      maxParticipants: (json['maxParticipants'] as num?)?.toInt(),
      deadline: DateTime.parse(json['deadline'] as String),
      status: $enumDecode(_$GroupBuyStatusEnumMap, json['status']),
      participantCount: (json['participantCount'] as num?)?.toInt() ?? 0,
      sponsorType: json['sponsorType'] as String? ?? 'community',
      brandId: json['brandId'] as String?,
      brandName: json['brandName'] as String?,
      brandLogoUrl: json['brandLogoUrl'] as String?,
      discountPercent: (json['discountPercent'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$GroupBuyImplToJson(_$GroupBuyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'linkedListingId': instance.linkedListingId,
      'organizerId': instance.organizerId,
      'organizerName': instance.organizerName,
      'communityId': instance.communityId,
      'targetAmount': instance.targetAmount,
      'currentAmount': instance.currentAmount,
      'minParticipants': instance.minParticipants,
      'maxParticipants': instance.maxParticipants,
      'deadline': instance.deadline.toIso8601String(),
      'status': _$GroupBuyStatusEnumMap[instance.status]!,
      'participantCount': instance.participantCount,
      'sponsorType': instance.sponsorType,
      'brandId': instance.brandId,
      'brandName': instance.brandName,
      'brandLogoUrl': instance.brandLogoUrl,
      'discountPercent': instance.discountPercent,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$GroupBuyStatusEnumMap = {
  GroupBuyStatus.open: 'open',
  GroupBuyStatus.targetMet: 'targetMet',
  GroupBuyStatus.expired: 'expired',
  GroupBuyStatus.completed: 'completed',
  GroupBuyStatus.cancelled: 'cancelled',
};
