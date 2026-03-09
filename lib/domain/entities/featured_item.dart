import 'package:freezed_annotation/freezed_annotation.dart';

part 'featured_item.freezed.dart';
part 'featured_item.g.dart';

/// A featured/promoted item in the Buy tab carousel.
@freezed
class FeaturedItem with _$FeaturedItem {
  const factory FeaturedItem({
    required String id,
    required String title,
    String? subtitle,
    String? imageUrl,
    /// Type: campaign, collectible, trending, promotion
    @Default('campaign') String type,
    /// GoRouter deep link path (e.g. /buy/category/airtime)
    String? deepLinkRoute,
    String? brandId,
    /// Community IDs this item targets (empty = global)
    @Default([]) List<String> communityIds,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    /// BrandGradient type name (e.g. goldOrange, cyanBlue)
    @Default('goldOrange') String bgGradientType,
  }) = _FeaturedItem;

  const FeaturedItem._();

  factory FeaturedItem.fromJson(Map<String, dynamic> json) =>
      _$FeaturedItemFromJson(json);

  bool get isScheduled => scheduledStart != null || scheduledEnd != null;

  bool get isCurrentlyActive {
    if (!isActive) return false;
    final now = DateTime.now();
    if (scheduledStart != null && now.isBefore(scheduledStart!)) return false;
    if (scheduledEnd != null && now.isAfter(scheduledEnd!)) return false;
    return true;
  }
}
