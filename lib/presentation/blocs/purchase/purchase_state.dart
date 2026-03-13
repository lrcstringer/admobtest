part of 'purchase_bloc.dart';

@freezed
abstract class PurchaseState with _$PurchaseState {
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
    /// When true, the UI should show an OTP input for step-up verification.
    @Default(false) bool isAwaitingOtp,
    /// Masked phone number to display alongside OTP prompt (e.g. "0**-***-5678").
    String? otpPhoneNumber,
    String? errorMessage,
    String? successMessage,
  }) = _PurchaseState;
}
