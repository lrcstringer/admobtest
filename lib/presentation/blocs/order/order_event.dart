part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  /// Load orders where user is the buyer
  const factory OrderEvent.loadBuyerOrders() = _LoadBuyerOrders;

  /// Load orders where user is the seller
  const factory OrderEvent.loadSellerOrders() = _LoadSellerOrders;

  /// Select and load a specific order's details
  const factory OrderEvent.selectOrder(String orderId) = _SelectOrder;

  /// Buy a marketplace item (creates escrow)
  const factory OrderEvent.buyItem({
    required String listingId,
    required String walletId,
  }) = _BuyItem;

  /// Seller marks order as fulfilled
  const factory OrderEvent.confirmFulfilment(String orderId) =
      _ConfirmFulfilment;

  /// Buyer confirms receipt (releases escrow to seller)
  const factory OrderEvent.confirmReceipt(String orderId) = _ConfirmReceipt;

  /// Cancel an order (refunds escrow to buyer)
  const factory OrderEvent.cancelOrder(String orderId) = _CancelOrder;

  /// Raise a dispute on an order
  const factory OrderEvent.disputeOrder({
    required String orderId,
    required String reason,
  }) = _DisputeOrder;

  /// Vouch for a provider after completed order
  const factory OrderEvent.vouchForProvider({
    required String providerId,
    required String orderId,
    required int rating,
    String? comment,
  }) = _VouchForProvider;

  /// Clear any success/error messages
  const factory OrderEvent.clearMessages() = _ClearMessages;
}
