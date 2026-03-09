part of 'brand_storefront_bloc.dart';

@freezed
class BrandStorefrontState with _$BrandStorefrontState {
  const factory BrandStorefrontState({
    @Default(false) bool isLoading,
    BrandStorefront? storefront,
    String? errorMessage,
  }) = _BrandStorefrontState;
}
