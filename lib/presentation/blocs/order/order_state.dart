part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingDetail,
    @Default(false) bool isProcessing,
    @Default([]) List<BuyOrder> buyerOrders,
    @Default([]) List<BuyOrder> sellerOrders,
    BuyOrder? selectedOrder,
    String? errorMessage,
    String? successMessage,
  }) = _OrderState;
}
