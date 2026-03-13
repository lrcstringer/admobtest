import 'package:freezed_annotation/freezed_annotation.dart';

part 'targeting_criteria.freezed.dart';
part 'targeting_criteria.g.dart';

/// Targeting criteria for audience filtering
/// Used on EarnThread and EarnOpportunity for server-side targeting
@freezed
abstract class TargetingCriteria with _$TargetingCriteria {
  const factory TargetingCriteria({
    /// Filter by gender(s)
    List<String>? genders,

    /// Minimum age (inclusive)
    int? ageMin,

    /// Maximum age (inclusive)
    int? ageMax,

    /// Filter by SA province(s)
    List<String>? provinces,

    /// Filter by city/cities
    List<String>? cities,

    /// Filter by preferred language(s) - ANY match
    List<String>? languages,

    /// Filter by interest categories - ANY match
    List<String>? interests,

    /// Filter by device platform (android/ios)
    List<String>? devicePlatforms,

    /// Minimum account age in days
    int? accountAgeMinDays,

    /// Maximum account age in days
    int? accountAgeMaxDays,

    /// Filter by engagement level (new/active/dormant)
    List<String>? engagementLevel,

    /// "include" = only returning users, "exclude" = only new users
    String? previousBrandInteraction,

    /// Maximum unique users who can engage with this thread
    int? maxAudience,
  }) = _TargetingCriteria;

  const TargetingCriteria._();

  factory TargetingCriteria.fromJson(Map<String, dynamic> json) =>
      _$TargetingCriteriaFromJson(json);

  /// Check if targeting is essentially empty (no filters)
  bool get isEmpty =>
      (genders == null || genders!.isEmpty) &&
      ageMin == null &&
      ageMax == null &&
      (provinces == null || provinces!.isEmpty) &&
      (cities == null || cities!.isEmpty) &&
      (languages == null || languages!.isEmpty) &&
      (interests == null || interests!.isEmpty) &&
      (devicePlatforms == null || devicePlatforms!.isEmpty) &&
      accountAgeMinDays == null &&
      accountAgeMaxDays == null &&
      (engagementLevel == null || engagementLevel!.isEmpty) &&
      previousBrandInteraction == null &&
      maxAudience == null;

  /// Get human-readable summary of targeting
  String get summary {
    final parts = <String>[];

    if (genders != null && genders!.isNotEmpty) {
      parts.add('${genders!.length} gender(s)');
    }
    if (ageMin != null || ageMax != null) {
      if (ageMin != null && ageMax != null) {
        parts.add('Age $ageMin-$ageMax');
      } else if (ageMin != null) {
        parts.add('Age $ageMin+');
      } else {
        parts.add('Age <$ageMax');
      }
    }
    if (provinces != null && provinces!.isNotEmpty) {
      parts.add('${provinces!.length} province(s)');
    }
    if (cities != null && cities!.isNotEmpty) {
      parts.add('${cities!.length} city/cities');
    }
    if (languages != null && languages!.isNotEmpty) {
      parts.add('${languages!.length} language(s)');
    }
    if (interests != null && interests!.isNotEmpty) {
      parts.add('${interests!.length} interest(s)');
    }
    if (devicePlatforms != null && devicePlatforms!.isNotEmpty) {
      parts.add(devicePlatforms!.join('/'));
    }
    if (engagementLevel != null && engagementLevel!.isNotEmpty) {
      parts.add('${engagementLevel!.join('/')} users');
    }
    if (previousBrandInteraction != null) {
      parts.add(previousBrandInteraction == 'include'
          ? 'Returning only'
          : 'New users only');
    }
    if (maxAudience != null) {
      parts.add('Max $maxAudience users');
    }

    return parts.isEmpty ? 'All users' : parts.join(', ');
  }
}
