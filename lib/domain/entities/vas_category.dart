import 'package:freezed_annotation/freezed_annotation.dart';

part 'vas_category.freezed.dart';

/// A Value Added Service category (Airtime, Data, Electricity, etc.)
/// displayed in the Buy tab "Utilities" section.
///
/// Stored in the `vasCategories` Firestore collection, separate from
/// marketplace `buyCategories`.
@freezed
abstract class VasCategory with _$VasCategory {
  const factory VasCategory({
    required String id,
    required String name,
    required String iconName,
    required int sortOrder,
    required bool isActive,
    required String purchaseCategoryMapping,
  }) = _VasCategory;

  const VasCategory._();

  /// SVG asset path for this category's icon (light variant).
  String get iconSvgPath =>
      'assets/icons/fintech_complete_icon_set/${iconName}_light.svg';
}
