part of 'provider_registration_bloc.dart';

@freezed
abstract class ProviderRegistrationState with _$ProviderRegistrationState {
  const factory ProviderRegistrationState({
    @Default(0) int currentStep,
    @Default('') String displayName,
    @Default('') String bio,
    @Default('') String servicesDescription,
    MarketplaceCategory? selectedCategory,
    String? photoPath,
    @Default(false) bool isSubmitting,
    @Default(false) bool isComplete,
    String? errorMessage,
    String? successMessage,
  }) = _ProviderRegistrationState;
}
