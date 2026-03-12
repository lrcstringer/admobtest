// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BuyOrder _$BuyOrderFromJson(Map<String, dynamic> json) => _BuyOrder(
  id: json['id'] as String,
  buyerId: json['buyerId'] as String,
  buyerName: json['buyerName'] as String,
  sellerId: json['sellerId'] as String,
  sellerName: json['sellerName'] as String,
  listingId: json['listingId'] as String,
  listingTitle: json['listingTitle'] as String,
  amount: (json['amount'] as num).toInt(),
  amountZar: (json['amountZar'] as num).toDouble(),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  escrowJournalId: json['escrowJournalId'] as String?,
  releaseJournalId: json['releaseJournalId'] as String?,
  refundJournalId: json['refundJournalId'] as String?,
  disputeReason: json['disputeReason'] as String?,
  disputeResolution: json['disputeResolution'] as String?,
  chatConversationId: json['chatConversationId'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  escrowedAt: json['escrowedAt'] == null
      ? null
      : DateTime.parse(json['escrowedAt'] as String),
  fulfilledAt: json['fulfilledAt'] == null
      ? null
      : DateTime.parse(json['fulfilledAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  disputedAt: json['disputedAt'] == null
      ? null
      : DateTime.parse(json['disputedAt'] as String),
  resolvedAt: json['resolvedAt'] == null
      ? null
      : DateTime.parse(json['resolvedAt'] as String),
  cancelledAt: json['cancelledAt'] == null
      ? null
      : DateTime.parse(json['cancelledAt'] as String),
  deliveryFee: (json['deliveryFee'] as num?)?.toInt(),
  totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
  deliveryMethod: json['deliveryMethod'] as String?,
  deliveredVia: json['deliveredVia'] as String?,
  trackingInfo: json['trackingInfo'] as String?,
  deliveryDeadline: json['deliveryDeadline'] == null
      ? null
      : DateTime.parse(json['deliveryDeadline'] as String),
  buyerConfirmationDeadline: json['buyerConfirmationDeadline'] == null
      ? null
      : DateTime.parse(json['buyerConfirmationDeadline'] as String),
  refundType: json['refundType'] as String?,
  disputeDetails: json['disputeDetails'] as String?,
  disputePhotos:
      (json['disputePhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sellerDisputeResponse: json['sellerDisputeResponse'] as String?,
  sellerDisputePhotos:
      (json['sellerDisputePhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sellerProposedResolution: json['sellerProposedResolution'] as String?,
  disputeResolutionAmount: (json['disputeResolutionAmount'] as num?)?.toInt(),
  disputeResolutionNote: json['disputeResolutionNote'] as String?,
  refundedAt: json['refundedAt'] == null
      ? null
      : DateTime.parse(json['refundedAt'] as String),
  version: (json['version'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BuyOrderToJson(_BuyOrder instance) => <String, dynamic>{
  'id': instance.id,
  'buyerId': instance.buyerId,
  'buyerName': instance.buyerName,
  'sellerId': instance.sellerId,
  'sellerName': instance.sellerName,
  'listingId': instance.listingId,
  'listingTitle': instance.listingTitle,
  'amount': instance.amount,
  'amountZar': instance.amountZar,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'escrowJournalId': instance.escrowJournalId,
  'releaseJournalId': instance.releaseJournalId,
  'refundJournalId': instance.refundJournalId,
  'disputeReason': instance.disputeReason,
  'disputeResolution': instance.disputeResolution,
  'chatConversationId': instance.chatConversationId,
  'thumbnailUrl': instance.thumbnailUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'escrowedAt': instance.escrowedAt?.toIso8601String(),
  'fulfilledAt': instance.fulfilledAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'disputedAt': instance.disputedAt?.toIso8601String(),
  'resolvedAt': instance.resolvedAt?.toIso8601String(),
  'cancelledAt': instance.cancelledAt?.toIso8601String(),
  'deliveryFee': instance.deliveryFee,
  'totalAmount': instance.totalAmount,
  'deliveryMethod': instance.deliveryMethod,
  'deliveredVia': instance.deliveredVia,
  'trackingInfo': instance.trackingInfo,
  'deliveryDeadline': instance.deliveryDeadline?.toIso8601String(),
  'buyerConfirmationDeadline': instance.buyerConfirmationDeadline
      ?.toIso8601String(),
  'refundType': instance.refundType,
  'disputeDetails': instance.disputeDetails,
  'disputePhotos': instance.disputePhotos,
  'sellerDisputeResponse': instance.sellerDisputeResponse,
  'sellerDisputePhotos': instance.sellerDisputePhotos,
  'sellerProposedResolution': instance.sellerProposedResolution,
  'disputeResolutionAmount': instance.disputeResolutionAmount,
  'disputeResolutionNote': instance.disputeResolutionNote,
  'refundedAt': instance.refundedAt?.toIso8601String(),
  'version': instance.version,
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.escrowed: 'escrowed',
  OrderStatus.fulfilled: 'fulfilled',
  OrderStatus.completed: 'completed',
  OrderStatus.disputed: 'disputed',
  OrderStatus.refunded: 'refunded',
  OrderStatus.cancelled: 'cancelled',
};
