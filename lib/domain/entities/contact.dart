import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

/// Contact relationship status
enum ContactStatus {
  pending,
  accepted,
  blocked,
}

/// Contact entity representing a user connection
@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String userId,
    required String contactUserId,
    required String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    String? phoneNumber,
    required ContactStatus status,
    required bool isFavorite,
    String? nickname,
    String? notes,
    required DateTime createdAt,
    DateTime? lastInteractionAt,
  }) = _Contact;

  const Contact._();

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  /// Get display name (nickname if set, otherwise displayName)
  String get effectiveDisplayName => nickname ?? displayName;

  /// Get initials for avatar
  String get initials {
    final name = effectiveDisplayName;
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }

  /// Check if contact is active
  bool get isActive => status == ContactStatus.accepted;

  /// Check if contact is blocked
  bool get isBlocked => status == ContactStatus.blocked;
}
