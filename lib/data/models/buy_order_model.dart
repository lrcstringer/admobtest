import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/buy_order.dart';
import '../../domain/enums/delivery_method.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/enums/refund_type.dart';

part 'buy_order_model.freezed.dart';

@freezed
class BuyOrderModel with _$BuyOrderModel {
  const factory BuyOrderModel({
    required String id,
    required String buyerId,
    required String buyerName,
    required String sellerId,
    required String sellerName,
    required String listingId,
    required String listingTitle,
    required int amount,
    required double amountZar,
    required OrderStatus status,
    String? escrowJournalId,
    String? releaseJournalId,
    String? refundJournalId,
    String? disputeReason,
    String? disputeResolution,
    String? chatConversationId,
    String? thumbnailUrl,
    required DateTime createdAt,
    DateTime? escrowedAt,
    DateTime? fulfilledAt,
    DateTime? completedAt,
    DateTime? disputedAt,
    DateTime? resolvedAt,
    DateTime? cancelledAt,
    // ── New fields (Spec §8.25) ──
    int? deliveryFee,
    @Default(0) int totalAmount,
    DeliveryMethod? deliveryMethod,
    String? deliveredVia,
    String? trackingInfo,
    DateTime? deliveryDeadline,
    DateTime? buyerConfirmationDeadline,
    RefundType? refundType,
    String? disputeDetails,
    @Default([]) List<String> disputePhotos,
    String? offerId,
    String? sellerDisputeResponse,
    @Default([]) List<String> sellerDisputePhotos,
    String? sellerProposedResolution,
    int? disputeResolutionAmount,
    String? disputeResolutionNote,
    DateTime? sellerRespondedAt,
    @Default(false) bool adminReviewRequired,
    String? adminReviewReason,
    String? refundReason,
    DateTime? refundedAt,
    @Default(0) int version,
  }) = _BuyOrderModel;

  const BuyOrderModel._();

  factory BuyOrderModel.fromJson(Map<String, dynamic> json) {
    return BuyOrderModel(
      id: json['id'] as String? ?? '',
      buyerId: json['buyerId'] as String? ?? '',
      buyerName: json['buyerName'] as String? ?? '',
      sellerId: json['sellerId'] as String? ?? '',
      sellerName: json['sellerName'] as String? ?? '',
      listingId: json['listingId'] as String? ?? '',
      listingTitle: json['listingTitle'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      amountZar: (json['amountZar'] as num?)?.toDouble() ?? 0.0,
      status: _parseOrderStatus(json['status'] as String?),
      escrowJournalId: json['escrowJournalId'] as String?,
      releaseJournalId: json['releaseJournalId'] as String?,
      refundJournalId: json['refundJournalId'] as String?,
      disputeReason: json['disputeReason'] as String?,
      disputeResolution: json['disputeResolution'] as String?,
      chatConversationId: json['chatConversationId'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      createdAt: _parseDateTime(json['createdAt']),
      escrowedAt: _parseDateTimeNullable(json['escrowedAt']),
      fulfilledAt: _parseDateTimeNullable(json['fulfilledAt']),
      completedAt: _parseDateTimeNullable(json['completedAt']),
      disputedAt: _parseDateTimeNullable(json['disputedAt']),
      resolvedAt: _parseDateTimeNullable(json['resolvedAt']),
      cancelledAt: _parseDateTimeNullable(json['cancelledAt']),
      // New fields (Spec §8.25)
      deliveryFee: (json['deliveryFee'] as num?)?.toInt(),
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
      deliveryMethod: _parseDeliveryMethod(json['deliveryMethod'] as String?),
      deliveredVia: json['deliveredVia'] as String?,
      trackingInfo: json['trackingInfo'] as String?,
      deliveryDeadline: _parseDateTimeNullable(json['deliveryDeadline']),
      buyerConfirmationDeadline:
          _parseDateTimeNullable(json['buyerConfirmationDeadline']),
      refundType: _parseRefundType(json['refundType'] as String?),
      disputeDetails: json['disputeDetails'] as String?,
      disputePhotos: (json['disputePhotos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      offerId: json['offerId'] as String?,
      sellerDisputeResponse: json['sellerDisputeResponse'] as String?,
      sellerDisputePhotos: (json['sellerDisputePhotos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sellerProposedResolution: json['sellerProposedResolution'] as String?,
      disputeResolutionAmount:
          (json['disputeResolutionAmount'] as num?)?.toInt(),
      disputeResolutionNote: json['disputeResolutionNote'] as String?,
      sellerRespondedAt: _parseDateTimeNullable(json['sellerRespondedAt']),
      adminReviewRequired: json['adminReviewRequired'] as bool? ?? false,
      adminReviewReason: json['adminReviewReason'] as String?,
      refundReason: json['refundReason'] as String?,
      refundedAt: _parseDateTimeNullable(json['refundedAt']),
      version: (json['version'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'buyerId': buyerId,
      'buyerName': buyerName,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'listingId': listingId,
      'listingTitle': listingTitle,
      'amount': amount,
      'amountZar': amountZar,
      'status': status.name,
      if (escrowJournalId != null) 'escrowJournalId': escrowJournalId,
      if (releaseJournalId != null) 'releaseJournalId': releaseJournalId,
      if (refundJournalId != null) 'refundJournalId': refundJournalId,
      if (disputeReason != null) 'disputeReason': disputeReason,
      if (disputeResolution != null) 'disputeResolution': disputeResolution,
      if (chatConversationId != null) 'chatConversationId': chatConversationId,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      if (escrowedAt != null) 'escrowedAt': Timestamp.fromDate(escrowedAt!),
      if (fulfilledAt != null) 'fulfilledAt': Timestamp.fromDate(fulfilledAt!),
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
      if (disputedAt != null) 'disputedAt': Timestamp.fromDate(disputedAt!),
      if (resolvedAt != null) 'resolvedAt': Timestamp.fromDate(resolvedAt!),
      if (cancelledAt != null) 'cancelledAt': Timestamp.fromDate(cancelledAt!),
      // New fields (Spec §8.25)
      if (deliveryFee != null) 'deliveryFee': deliveryFee,
      if (totalAmount > 0) 'totalAmount': totalAmount,
      if (deliveryMethod != null) 'deliveryMethod': deliveryMethod!.name,
      if (deliveredVia != null) 'deliveredVia': deliveredVia,
      if (trackingInfo != null) 'trackingInfo': trackingInfo,
      if (deliveryDeadline != null)
        'deliveryDeadline': Timestamp.fromDate(deliveryDeadline!),
      if (buyerConfirmationDeadline != null)
        'buyerConfirmationDeadline':
            Timestamp.fromDate(buyerConfirmationDeadline!),
      if (refundType != null) 'refundType': refundType!.name,
      if (disputeDetails != null) 'disputeDetails': disputeDetails,
      if (disputePhotos.isNotEmpty) 'disputePhotos': disputePhotos,
      if (sellerDisputeResponse != null)
        'sellerDisputeResponse': sellerDisputeResponse,
      if (sellerDisputePhotos.isNotEmpty)
        'sellerDisputePhotos': sellerDisputePhotos,
      if (sellerProposedResolution != null)
        'sellerProposedResolution': sellerProposedResolution,
      if (disputeResolutionAmount != null)
        'disputeResolutionAmount': disputeResolutionAmount,
      if (disputeResolutionNote != null)
        'disputeResolutionNote': disputeResolutionNote,
      if (offerId != null) 'offerId': offerId,
      if (sellerRespondedAt != null)
        'sellerRespondedAt': Timestamp.fromDate(sellerRespondedAt!),
      if (adminReviewRequired) 'adminReviewRequired': adminReviewRequired,
      if (adminReviewReason != null) 'adminReviewReason': adminReviewReason,
      if (refundReason != null) 'refundReason': refundReason,
      if (refundedAt != null) 'refundedAt': Timestamp.fromDate(refundedAt!),
      'version': version,
    };
  }

  BuyOrder toEntity() {
    return BuyOrder(
      id: id,
      buyerId: buyerId,
      buyerName: buyerName,
      sellerId: sellerId,
      sellerName: sellerName,
      listingId: listingId,
      listingTitle: listingTitle,
      amount: amount,
      amountZar: amountZar,
      status: status,
      escrowJournalId: escrowJournalId,
      releaseJournalId: releaseJournalId,
      refundJournalId: refundJournalId,
      disputeReason: disputeReason,
      disputeResolution: disputeResolution,
      chatConversationId: chatConversationId,
      thumbnailUrl: thumbnailUrl,
      createdAt: createdAt,
      escrowedAt: escrowedAt,
      fulfilledAt: fulfilledAt,
      completedAt: completedAt,
      disputedAt: disputedAt,
      resolvedAt: resolvedAt,
      cancelledAt: cancelledAt,
      deliveryFee: deliveryFee,
      totalAmount: totalAmount,
      deliveryMethod: deliveryMethod,
      deliveredVia: deliveredVia,
      trackingInfo: trackingInfo,
      deliveryDeadline: deliveryDeadline,
      buyerConfirmationDeadline: buyerConfirmationDeadline,
      refundType: refundType,
      disputeDetails: disputeDetails,
      disputePhotos: disputePhotos,
      offerId: offerId,
      sellerDisputeResponse: sellerDisputeResponse,
      sellerDisputePhotos: sellerDisputePhotos,
      sellerProposedResolution: sellerProposedResolution,
      disputeResolutionAmount: disputeResolutionAmount,
      disputeResolutionNote: disputeResolutionNote,
      sellerRespondedAt: sellerRespondedAt,
      adminReviewRequired: adminReviewRequired,
      adminReviewReason: adminReviewReason,
      refundReason: refundReason,
      refundedAt: refundedAt,
      version: version,
    );
  }

  factory BuyOrderModel.fromEntity(BuyOrder entity) {
    return BuyOrderModel(
      id: entity.id,
      buyerId: entity.buyerId,
      buyerName: entity.buyerName,
      sellerId: entity.sellerId,
      sellerName: entity.sellerName,
      listingId: entity.listingId,
      listingTitle: entity.listingTitle,
      amount: entity.amount,
      amountZar: entity.amountZar,
      status: entity.status,
      escrowJournalId: entity.escrowJournalId,
      releaseJournalId: entity.releaseJournalId,
      refundJournalId: entity.refundJournalId,
      disputeReason: entity.disputeReason,
      disputeResolution: entity.disputeResolution,
      chatConversationId: entity.chatConversationId,
      thumbnailUrl: entity.thumbnailUrl,
      createdAt: entity.createdAt,
      escrowedAt: entity.escrowedAt,
      fulfilledAt: entity.fulfilledAt,
      completedAt: entity.completedAt,
      disputedAt: entity.disputedAt,
      resolvedAt: entity.resolvedAt,
      cancelledAt: entity.cancelledAt,
      deliveryFee: entity.deliveryFee,
      totalAmount: entity.totalAmount,
      deliveryMethod: entity.deliveryMethod,
      deliveredVia: entity.deliveredVia,
      trackingInfo: entity.trackingInfo,
      deliveryDeadline: entity.deliveryDeadline,
      buyerConfirmationDeadline: entity.buyerConfirmationDeadline,
      refundType: entity.refundType,
      disputeDetails: entity.disputeDetails,
      disputePhotos: entity.disputePhotos,
      offerId: entity.offerId,
      sellerDisputeResponse: entity.sellerDisputeResponse,
      sellerDisputePhotos: entity.sellerDisputePhotos,
      sellerProposedResolution: entity.sellerProposedResolution,
      disputeResolutionAmount: entity.disputeResolutionAmount,
      disputeResolutionNote: entity.disputeResolutionNote,
      sellerRespondedAt: entity.sellerRespondedAt,
      adminReviewRequired: entity.adminReviewRequired,
      adminReviewReason: entity.adminReviewReason,
      refundReason: entity.refundReason,
      refundedAt: entity.refundedAt,
      version: entity.version,
    );
  }
}

OrderStatus _parseOrderStatus(String? value) {
  switch (value) {
    case 'pending':
      return OrderStatus.pending;
    case 'escrowed':
      return OrderStatus.escrowed;
    case 'fulfilled':
      return OrderStatus.fulfilled;
    case 'completed':
      return OrderStatus.completed;
    case 'disputed':
      return OrderStatus.disputed;
    case 'refunding':
      return OrderStatus.refunding;
    case 'refunded':
      return OrderStatus.refunded;
    case 'cancelled':
      return OrderStatus.cancelled;
    case 'failed':
      return OrderStatus.failed;
    default:
      return OrderStatus.pending;
  }
}

DateTime _parseDateTime(dynamic value) {
  if (value is Timestamp) return value.toDate();
  if (value is String) {
    final parsed = DateTime.tryParse(value);
    if (parsed != null) return parsed;
  }
  // Fail loudly for required fields — callers must provide valid data
  throw FormatException('Cannot parse DateTime from: $value');
}

DateTime? _parseDateTimeNullable(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

DeliveryMethod? _parseDeliveryMethod(String? value) {
  if (value == null) return null;
  return DeliveryMethod.values.firstWhere(
    (e) => e.name == value,
    orElse: () => DeliveryMethod.collection,
  );
}

RefundType? _parseRefundType(String? value) {
  if (value == null) return null;
  // Handle snake_case from backend
  if (value == 'auto_unresponsive_seller') {
    return RefundType.autoUnresponsiveSeller;
  }
  if (value == 'seller_initiated') {
    return RefundType.sellerInitiated;
  }
  return RefundType.values.firstWhere(
    (e) => e.name == value,
    orElse: () => RefundType.buyerDispute,
  );
}
