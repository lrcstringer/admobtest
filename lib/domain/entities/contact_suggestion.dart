import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_suggestion.freezed.dart';
part 'contact_suggestion.g.dart';

/// Source of the contact suggestion
enum SuggestionSource {
  phoneContact,
  mutualFriend,
  communityMember,
}

/// A suggested contact the user may know
@freezed
class ContactSuggestion with _$ContactSuggestion {
  const factory ContactSuggestion({
    required String userId,
    required String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    required String reason,
    required SuggestionSource source,
  }) = _ContactSuggestion;

  factory ContactSuggestion.fromJson(Map<String, dynamic> json) =>
      _$ContactSuggestionFromJson(json);
}
