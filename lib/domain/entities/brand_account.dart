import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_account.freezed.dart';
part 'brand_account.g.dart';

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

  factory BrandAccount.fromJson(Map<String, dynamic> json) =>
      _$BrandAccountFromJson(json);

  /// Get initials for avatar
  String get initials {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }
}
