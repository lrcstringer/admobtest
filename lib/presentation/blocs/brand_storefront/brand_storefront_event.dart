part of 'brand_storefront_bloc.dart';

@freezed
class BrandStorefrontEvent with _$BrandStorefrontEvent {
  /// Load a single brand storefront by ID
  const factory BrandStorefrontEvent.loadStorefront(String id) =
      _LoadStorefront;
}
