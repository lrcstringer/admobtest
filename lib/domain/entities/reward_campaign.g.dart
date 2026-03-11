// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardCampaign _$RewardCampaignFromJson(Map<String, dynamic> json) =>
    _RewardCampaign(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String?,
      clientAvatarImage: json['clientAvatarImage'] as String?,
      clientAvatarColor: json['clientAvatarColor'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      rewardType: $enumDecode(_$RewardTypeEnumMap, json['rewardType']),
      status: $enumDecode(_$CampaignStatusEnumMap, json['status']),
      totalQuantity: (json['totalQuantity'] as num).toInt(),
      remainingQuantity: (json['remainingQuantity'] as num).toInt(),
      allocatedQuantity: (json['allocatedQuantity'] as num?)?.toInt() ?? 0,
      redeemedQuantity: (json['redeemedQuantity'] as num?)?.toInt() ?? 0,
      maxPerUser: (json['maxPerUser'] as num?)?.toInt() ?? 1,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      itemExpiresAt: json['itemExpiresAt'] == null
          ? null
          : DateTime.parse(json['itemExpiresAt'] as String),
      displayImageUrl: json['displayImageUrl'] as String?,
      displayPriority: (json['displayPriority'] as num?)?.toInt() ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      linkedOpportunityIds:
          (json['linkedOpportunityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RewardCampaignToJson(_RewardCampaign instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientAvatarImage': instance.clientAvatarImage,
      'clientAvatarColor': instance.clientAvatarColor,
      'name': instance.name,
      'description': instance.description,
      'rewardType': _$RewardTypeEnumMap[instance.rewardType]!,
      'status': _$CampaignStatusEnumMap[instance.status]!,
      'totalQuantity': instance.totalQuantity,
      'remainingQuantity': instance.remainingQuantity,
      'allocatedQuantity': instance.allocatedQuantity,
      'redeemedQuantity': instance.redeemedQuantity,
      'maxPerUser': instance.maxPerUser,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'itemExpiresAt': instance.itemExpiresAt?.toIso8601String(),
      'displayImageUrl': instance.displayImageUrl,
      'displayPriority': instance.displayPriority,
      'metadata': instance.metadata,
      'linkedOpportunityIds': instance.linkedOpportunityIds,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$RewardTypeEnumMap = {
  RewardType.qrCode: 'qrCode',
  RewardType.voucherCode: 'voucherCode',
  RewardType.discountCode: 'discountCode',
  RewardType.digitalContent: 'digitalContent',
};

const _$CampaignStatusEnumMap = {
  CampaignStatus.draft: 'draft',
  CampaignStatus.active: 'active',
  CampaignStatus.paused: 'paused',
  CampaignStatus.exhausted: 'exhausted',
  CampaignStatus.expired: 'expired',
  CampaignStatus.cancelled: 'cancelled',
};
