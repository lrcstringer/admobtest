import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_category.freezed.dart';
part 'buy_category.g.dart';

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
  }) = _BuyCategory;

  const BuyCategory._();

  factory BuyCategory.fromJson(Map<String, dynamic> json) =>
      _$BuyCategoryFromJson(json);

  /// Whether this category should be displayed (active and not hidden by feature flag)
  bool get isDisplayable => isActive || isComingSoon;
}
