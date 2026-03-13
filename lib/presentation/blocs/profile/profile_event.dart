part of 'profile_bloc.dart';

@freezed
abstract class ProfileEvent with _$ProfileEvent {
  /// Load user profile
  const factory ProfileEvent.loadProfile() = _LoadProfile;

  /// Start watching profile updates
  const factory ProfileEvent.watchProfile() = _WatchProfile;

  /// User was updated
  const factory ProfileEvent.userUpdated(User user) = _UserUpdated;

  /// Update profile information
  const factory ProfileEvent.updateProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? avatarUrl,
    List<String>? selectedClusters,
  }) = _UpdateProfile;

  /// Update username
  const factory ProfileEvent.updateUsername(String username) = _UpdateUsername;

  /// Check if username is available
  const factory ProfileEvent.checkUsername(String username) = _CheckUsername;

  /// Accept terms and conditions
  const factory ProfileEvent.acceptTerms() = _AcceptTerms;

  /// Update a single privacy setting
  const factory ProfileEvent.updatePrivacySetting({
    required String key,
    required dynamic value,
  }) = _UpdatePrivacySetting;
}
