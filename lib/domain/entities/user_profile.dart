import 'package:freezed_annotation/freezed_annotation.dart';

import 'privacy_settings.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// User profile information
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? city,
    String? firstName,
    String? lastName,
    // Targeting fields
    /// Preferred languages (e.g. ['en', 'zu'])
    List<String>? languages,
    /// Interest categories (e.g. ['sports', 'tech'])
    List<String>? interests,
    /// Regional clusters the user has opted into (for group buy matching)
    List<String>? selectedClusters,
    // POPIA consent
    /// Whether user has consented to receiving reward items
    @Default(false) bool rewardConsent,
    // Privacy settings
    /// User's privacy configuration (null = use defaults)
    PrivacySettings? privacySettings,
  }) = _UserProfile;

  const UserProfile._();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Get full name
  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return displayName;
  }

  /// Get age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  /// Check if profile is complete
  bool get isComplete =>
      displayName.isNotEmpty &&
      username != null &&
      gender != null &&
      dateOfBirth != null;
}
