import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/delivery_method.dart';
import '../enums/order_status.dart';
import '../enums/refund_type.dart';

part 'buy_order.freezed.dart';

@freezed
class BuyOrder with _$BuyOrder {
  const factory BuyOrder({
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
  }) = _BuyOrder;

  const BuyOrder._();


  /// Whether the order is active (not in a terminal state)
  bool get isActive => status.isActive;

  /// Whether the order is in a terminal state
  bool get isTerminal => status.isTerminal;

  /// Whether buyer can confirm receipt
  bool get canConfirmReceipt => status == OrderStatus.fulfilled;

  /// Whether seller can mark as fulfilled
  bool get canMarkFulfilled => status == OrderStatus.escrowed;

  /// Whether either party can dispute
  bool get canDispute =>
      status == OrderStatus.escrowed || status == OrderStatus.fulfilled;

  /// Total including delivery fee
  int get effectiveTotal => totalAmount > 0 ? totalAmount : amount + (deliveryFee ?? 0);

  /// Formatted amount
  String get formattedAmount => '$amount tokens';

  /// Formatted ZAR amount
  String get formattedZarAmount => 'R${amountZar.toStringAsFixed(2)}';

  /// Whether dispute has seller response
  bool get hasSellerDisputeResponse =>
      sellerDisputeResponse != null && sellerDisputeResponse!.isNotEmpty;
}
