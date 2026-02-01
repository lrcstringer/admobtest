import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// User profile information
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String displayName,
    String? username,
    String? avatarUrl,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? city,
    String? firstName,
    String? lastName,
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
