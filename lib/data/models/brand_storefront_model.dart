import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/brand_storefront.dart';

part 'brand_storefront_model.freezed.dart';

@freezed
class BrandStorefrontModel with _$BrandStorefrontModel {
  const factory BrandStorefrontModel({
    required String id,
    required String brandId,
    required String brandName,
    String? brandLogoUrl,
    String? brandColor,
    String? coverImageUrl,
    String? tagline,
    @Default(true) bool isActive,
    @Default(false) bool isPremium,
    @Default([]) List<String> communityIds,
    @Default([]) List<StorefrontSection> sections,
    DateTime? createdAt,
  }) = _BrandStorefrontModel;

  const BrandStorefrontModel._();

  factory BrandStorefrontModel.fromJson(Map<String, dynamic> json) {
    return BrandStorefrontModel(
      id: json['id'] as String? ?? '',
      brandId: json['brandId'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      brandLogoUrl: json['brandLogoUrl'] as String?,
      brandColor: json['brandColor'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      tagline: json['tagline'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isPremium: json['isPremium'] as bool? ?? false,
      communityIds: (json['communityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) =>
                  StorefrontSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'brandId': brandId,
      'brandName': brandName,
      'brandLogoUrl': brandLogoUrl,
      'brandColor': brandColor,
      'coverImageUrl': coverImageUrl,
      'tagline': tagline,
      'isActive': isActive,
      'isPremium': isPremium,
      'communityIds': communityIds,
      'sections': sections
          .map((s) => {
                'type': s.type,
                'title': s.title,
                'data': s.data,
                'sortOrder': s.sortOrder,
                'isVisible': s.isVisible,
              })
          .toList(),
    };
  }

  BrandStorefront toEntity() {
    return BrandStorefront(
      id: id,
      brandId: brandId,
      brandName: brandName,
      brandLogoUrl: brandLogoUrl,
      brandColor: brandColor,
      coverImageUrl: coverImageUrl,
      tagline: tagline,
      isActive: isActive,
      isPremium: isPremium,
      communityIds: communityIds,
      sections: sections,
      createdAt: createdAt,
    );
  }

  factory BrandStorefrontModel.fromEntity(BrandStorefront entity) {
    return BrandStorefrontModel(
      id: entity.id,
      brandId: entity.brandId,
      brandName: entity.brandName,
      brandLogoUrl: entity.brandLogoUrl,
      brandColor: entity.brandColor,
      coverImageUrl: entity.coverImageUrl,
      tagline: entity.tagline,
      isActive: entity.isActive,
      isPremium: entity.isPremium,
      communityIds: entity.communityIds,
      sections: entity.sections,
      createdAt: entity.createdAt,
    );
  }
}
