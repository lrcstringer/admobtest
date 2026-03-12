import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_account.freezed.dart';

/// Brand account entity representing a client brand that users can follow.
@freezed
class BrandAccount with _$BrandAccount {
  const factory BrandAccount({
    required String id,
    required String name,
    String? logoUrl,
    String? description,
    String? avatarColor,
    required bool isFollowed,
    DateTime? followedAt,
    @Default(0) int followerCount,
  }) = _BrandAccount;

  const BrandAccount._();


  /// Get initials for avatar
  String get initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '??';
    final words = trimmed.split(' ').where((w) => w.isNotEmpty).toList();
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return trimmed.substring(0, trimmed.length.clamp(0, 2)).toUpperCase();
  }
}
