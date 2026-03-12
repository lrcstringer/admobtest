// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_dispute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketplaceDispute _$MarketplaceDisputeFromJson(Map<String, dynamic> json) =>
    _MarketplaceDispute(
      reason: $enumDecode(_$DisputeReasonEnumMap, json['reason']),
      details: json['details'] as String,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sellerResponse: json['sellerResponse'] as String?,
      sellerPhotos:
          (json['sellerPhotos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      proposedResolution: json['proposedResolution'] as String?,
      resolution: $enumDecodeNullable(
        _$DisputeResolutionEnumMap,
        json['resolution'],
      ),
      resolutionAmount: (json['resolutionAmount'] as num?)?.toInt(),
      resolutionNote: json['resolutionNote'] as String?,
      openedAt: json['openedAt'] == null
          ? null
          : DateTime.parse(json['openedAt'] as String),
      sellerRespondedAt: json['sellerRespondedAt'] == null
          ? null
          : DateTime.parse(json['sellerRespondedAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$MarketplaceDisputeToJson(_MarketplaceDispute instance) =>
    <String, dynamic>{
      'reason': _$DisputeReasonEnumMap[instance.reason]!,
      'details': instance.details,
      'photos': instance.photos,
      'sellerResponse': instance.sellerResponse,
      'sellerPhotos': instance.sellerPhotos,
      'proposedResolution': instance.proposedResolution,
      'resolution': _$DisputeResolutionEnumMap[instance.resolution],
      'resolutionAmount': instance.resolutionAmount,
      'resolutionNote': instance.resolutionNote,
      'openedAt': instance.openedAt?.toIso8601String(),
      'sellerRespondedAt': instance.sellerRespondedAt?.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

const _$DisputeReasonEnumMap = {
  DisputeReason.notReceived: 'notReceived',
  DisputeReason.notAsDescribed: 'notAsDescribed',
  DisputeReason.damaged: 'damaged',
  DisputeReason.sellerUnresponsive: 'sellerUnresponsive',
  DisputeReason.other: 'other',
};

const _$DisputeResolutionEnumMap = {
  DisputeResolution.refundBuyer: 'refundBuyer',
  DisputeResolution.releaseToSeller: 'releaseToSeller',
  DisputeResolution.partialRefund: 'partialRefund',
  DisputeResolution.requireReturn: 'requireReturn',
  DisputeResolution.split: 'split',
};
