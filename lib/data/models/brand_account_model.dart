import '../../domain/entities/brand_account.dart';

/// Data model for BrandAccount, handling JSON parsing from Cloud Functions.
class BrandAccountModel {
  final String id;
  final String name;
  final String? logoUrl;
  final String? description;
  final String? avatarColor;
  final bool isFollowed;
  final int followerCount;

  const BrandAccountModel({
    required this.id,
    required this.name,
    this.logoUrl,
    this.description,
    this.avatarColor,
    required this.isFollowed,
    required this.followerCount,
  });

  factory BrandAccountModel.fromJson(Map<String, dynamic> json) {
    return BrandAccountModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Brand',
      logoUrl: json['logoUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
      description: json['description'] as String?,
      isFollowed: json['isFollowed'] as bool? ?? false,
      followerCount: json['followerCount'] as int? ?? 0,
    );
  }

  BrandAccount toEntity() {
    return BrandAccount(
      id: id,
      name: name,
      logoUrl: logoUrl,
      description: description,
      avatarColor: avatarColor,
      isFollowed: isFollowed,
      followerCount: followerCount,
    );
  }
}
