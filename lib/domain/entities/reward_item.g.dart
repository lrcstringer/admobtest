// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RewardItemImpl _$$RewardItemImplFromJson(Map<String, dynamic> json) =>
    _$RewardItemImpl(
      id: json['id'] as String,
      campaignId: json['campaignId'] as String,
      campaignName: json['campaignName'] as String?,
      clientName: json['clientName'] as String?,
      clientAvatarImage: json['clientAvatarImage'] as String?,
      clientAvatarColor: json['clientAvatarColor'] as String?,
      rewardType: $enumDecodeNullable(_$RewardTypeEnumMap, json['rewardType']),
      status: $enumDecode(_$RewardItemStatusEnumMap, json['status']),
      codeValue: json['codeValue'] as String?,
      allocatedAt: json['allocatedAt'] == null
          ? null
          : DateTime.parse(json['allocatedAt'] as String),
      redeemedAt: json['redeemedAt'] == null
          ? null
          : DateTime.parse(json['redeemedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      redemptionLocation: json['redemptionLocation'] as String?,
      campaignMetadata:
          json['campaignMetadata'] as Map<String, dynamic>? ?? const {},
      itemMetadata: json['itemMetadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RewardItemImplToJson(_$RewardItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaignId': instance.campaignId,
      'campaignName': instance.campaignName,
      'clientName': instance.clientName,
      'clientAvatarImage': instance.clientAvatarImage,
      'clientAvatarColor': instance.clientAvatarColor,
      'rewardType': _$RewardTypeEnumMap[instance.rewardType],
      'status': _$RewardItemStatusEnumMap[instance.status]!,
      'codeValue': instance.codeValue,
      'allocatedAt': instance.allocatedAt?.toIso8601String(),
      'redeemedAt': instance.redeemedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'redemptionLocation': instance.redemptionLocation,
      'campaignMetadata': instance.campaignMetadata,
      'itemMetadata': instance.itemMetadata,
    };

const _$RewardTypeEnumMap = {
  RewardType.qrCode: 'qrCode',
  RewardType.voucherCode: 'voucherCode',
  RewardType.discountCode: 'discountCode',
  RewardType.digitalContent: 'digitalContent',
};

const _$RewardItemStatusEnumMap = {
  RewardItemStatus.available: 'available',
  RewardItemStatus.allocated: 'allocated',
  RewardItemStatus.redeemed: 'redeemed',
  RewardItemStatus.expired: 'expired',
  RewardItemStatus.revoked: 'revoked',
};
