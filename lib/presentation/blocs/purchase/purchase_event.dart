part of 'purchase_bloc.dart';

@freezed
class PurchaseEvent with _$PurchaseEvent {
  /// Load all service providers
  const factory PurchaseEvent.loadProviders() = _LoadProviders;

  /// Load providers by category
  const factory PurchaseEvent.loadProvidersByCategory(PurchaseCategory category) =
      _LoadProvidersByCategory;

  /// Select a category
  const factory PurchaseEvent.selectCategory(PurchaseCategory? category) =
      _SelectCategory;

  /// Select a provider
  const factory PurchaseEvent.selectProvider(ServiceProvider provider) =
      _SelectProvider;

  /// Load products for selected provider
  const factory PurchaseEvent.loadProducts(String providerId) = _LoadProducts;

  /// Select a product
  const factory PurchaseEvent.selectProduct(ServiceProduct product) =
      _SelectProduct;

  /// Set recipient number
  const factory PurchaseEvent.setRecipientNumber(String number) =
      _SetRecipientNumber;

  /// Validate recipient number
  const factory PurchaseEvent.validateRecipient() = _ValidateRecipient;

  /// Make a purchase
  const factory PurchaseEvent.makePurchase() = _MakePurchase;

  /// Load purchase history
  const factory PurchaseEvent.loadHistory({
    PurchaseCategory? category,
    int? limit,
    DateTime? startAfter,
  }) = _LoadHistory;

  /// Load recent recipients
  const factory PurchaseEvent.loadRecentRecipients({
    PurchaseCategory? category,
  }) = _LoadRecentRecipients;

  /// Select a recent recipient
  const factory PurchaseEvent.selectRecentRecipient(String number) =
      _SelectRecentRecipient;

  /// Reset selection (go back to provider list)
  const factory PurchaseEvent.resetSelection() = _ResetSelection;

  /// Clear error
  const factory PurchaseEvent.clearError() = _ClearError;

  /// Clear success
  const factory PurchaseEvent.clearSuccess() = _ClearSuccess;
}
