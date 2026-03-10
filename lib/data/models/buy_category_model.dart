import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/buy_category.dart';

part 'buy_category_model.freezed.dart';

@freezed
class BuyCategoryModel with _$BuyCategoryModel {
  const factory BuyCategoryModel({
    required String id,
    required String name,
    required String iconEmoji,
    required int sortOrder,
    required bool isActive,
    @Default(false) bool isComingSoon,
    String? purchaseCategoryMapping,
    String? featureFlagKey,
    String? logoUrl,
    String? backgroundColor,
    @Default([]) List<BuySubcategory> subcategories,
  }) = _BuyCategoryModel;

  const BuyCategoryModel._();

  factory BuyCategoryModel.fromJson(Map<String, dynamic> json) {
    final rawSubs = json['subcategories'] as List<dynamic>?;
    final subcategories = rawSubs
            ?.map((s) =>
                BuySubcategory.fromJson(Map<String, dynamic>.from(s as Map)))
            .toList() ??
        [];

    return BuyCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      iconEmoji: json['iconEmoji'] as String? ?? '',
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? false,
      isComingSoon: json['isComingSoon'] as bool? ?? false,
      purchaseCategoryMapping: json['purchaseCategoryMapping'] as String?,
      featureFlagKey: json['featureFlagKey'] as String?,
      logoUrl: json['logoUrl'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      subcategories: subcategories,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'name': name,
      'iconEmoji': iconEmoji,
      'sortOrder': sortOrder,
      'isActive': isActive,
      'isComingSoon': isComingSoon,
      if (purchaseCategoryMapping != null)
        'purchaseCategoryMapping': purchaseCategoryMapping,
      if (featureFlagKey != null) 'featureFlagKey': featureFlagKey,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (backgroundColor != null) 'backgroundColor': backgroundColor,
      if (subcategories.isNotEmpty)
        'subcategories': subcategories
            .map((s) => {'id': s.id, 'name': s.name, 'iconEmoji': s.iconEmoji})
            .toList(),
    };
  }

  BuyCategory toEntity() {
    return BuyCategory(
      id: id,
      name: name,
      iconEmoji: iconEmoji,
      sortOrder: sortOrder,
      isActive: isActive,
      isComingSoon: isComingSoon,
      purchaseCategoryMapping: purchaseCategoryMapping,
      featureFlagKey: featureFlagKey,
      logoUrl: logoUrl,
      backgroundColor: backgroundColor,
      subcategories: subcategories,
    );
  }

  factory BuyCategoryModel.fromEntity(BuyCategory entity) {
    return BuyCategoryModel(
      id: entity.id,
      name: entity.name,
      iconEmoji: entity.iconEmoji,
      sortOrder: entity.sortOrder,
      isActive: entity.isActive,
      isComingSoon: entity.isComingSoon,
      purchaseCategoryMapping: entity.purchaseCategoryMapping,
      featureFlagKey: entity.featureFlagKey,
      logoUrl: entity.logoUrl,
      backgroundColor: entity.backgroundColor,
      subcategories: entity.subcategories,
    );
  }
}
