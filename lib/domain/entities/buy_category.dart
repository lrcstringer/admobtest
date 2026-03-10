import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_category.freezed.dart';
part 'buy_category.g.dart';

@freezed
class BuySubcategory with _$BuySubcategory {
  const factory BuySubcategory({
    required String id,
    required String name,
    @Default('') String iconEmoji,
  }) = _BuySubcategory;

  factory BuySubcategory.fromJson(Map<String, dynamic> json) =>
      _$BuySubcategoryFromJson(json);
}

@freezed
class BuyCategory with _$BuyCategory {
  const factory BuyCategory({
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
  }) = _BuyCategory;

  const BuyCategory._();

  factory BuyCategory.fromJson(Map<String, dynamic> json) =>
      _$BuyCategoryFromJson(json);

  /// Whether this category should be displayed (active and not hidden by feature flag)
  bool get isDisplayable => isActive || isComingSoon;

  /// SVG asset path for this category's icon (used by buy_category_tile)
  String get iconSvgPath => 'assets/icons/buy/$id.svg';
}
