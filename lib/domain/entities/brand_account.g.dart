// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrandAccount _$BrandAccountFromJson(Map<String, dynamic> json) =>
    _BrandAccount(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String?,
      description: json['description'] as String?,
      avatarColor: json['avatarColor'] as String?,
      isFollowed: json['isFollowed'] as bool,
      followedAt: json['followedAt'] == null
          ? null
          : DateTime.parse(json['followedAt'] as String),
      followerCount: (json['followerCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BrandAccountToJson(_BrandAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'description': instance.description,
      'avatarColor': instance.avatarColor,
      'isFollowed': instance.isFollowed,
      'followedAt': instance.followedAt?.toIso8601String(),
      'followerCount': instance.followerCount,
    };
