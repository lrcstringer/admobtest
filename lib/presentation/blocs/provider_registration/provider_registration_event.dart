part of 'provider_registration_bloc.dart';

@freezed
class ProviderRegistrationEvent with _$ProviderRegistrationEvent {
  /// Update display name
  const factory ProviderRegistrationEvent.updateName(String name) = _UpdateName;

  /// Update bio
  const factory ProviderRegistrationEvent.updateBio(String bio) = _UpdateBio;

  /// Update services description
  const factory ProviderRegistrationEvent.updateServices(String services) =
      _UpdateServices;

  /// Update selected category
  const factory ProviderRegistrationEvent.updateCategory(
    MarketplaceCategory category,
  ) = _UpdateCategory;

  /// Set photo file path (local)
  const factory ProviderRegistrationEvent.setPhoto(String photoPath) =
      _SetPhoto;

  /// Advance to next step
  const factory ProviderRegistrationEvent.nextStep() = _NextStep;

  /// Go back to previous step
  const factory ProviderRegistrationEvent.previousStep() = _PreviousStep;

  /// Submit the registration
  const factory ProviderRegistrationEvent.submit() = _Submit;
}
