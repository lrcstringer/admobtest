part of 'purchase_bloc.dart';

@freezed
class PurchaseState with _$PurchaseState {
  const factory PurchaseState({
    @Default(false) bool isLoadingProviders,
    @Default(false) bool isLoadingProducts,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool isPurchasing,
    @Default(false) bool isValidating,
    @Default([]) List<ServiceProvider> providers,
    @Default([]) List<ServiceProduct> products,
    @Default([]) List<Purchase> history,
    @Default([]) List<String> recentRecipients,
    PurchaseCategory? selectedCategory,
    ServiceProvider? selectedProvider,
    ServiceProduct? selectedProduct,
    String? recipientNumber,
    bool? isRecipientValid,
    Purchase? lastPurchase,
    @Default(false) bool hasMoreHistory,
    String? errorMessage,
    String? successMessage,
  }) = _PurchaseState;
}
