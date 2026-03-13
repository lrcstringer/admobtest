import 'package:freezed_annotation/freezed_annotation.dart';

part 'featured_item.freezed.dart';

/// A featured/promoted item in the Buy tab carousel.
@freezed
class FeaturedItem with _$FeaturedItem {
  const factory FeaturedItem({
    required String id,
    required String title,
    String? subtitle,
    String? imageUrl,
    /// Optional short looping video URL. When set, replaces the image on the card.
    /// imageUrl still serves as poster/thumbnail while video loads.
    String? videoUrl,
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
    /// Display name for the brand (e.g. "VODACOM")
    String? brandName,
    /// CTA button label (e.g. "Claim with Sasaza")
    String? ctaText,

    /// Custom bg color hex. Solid: '#FF6429'. Gradient: '#FFB82C,#FF6429'.
    /// Only used when bgGradientType == 'custom'.
    String? bgColorHex,

    /// Custom color intensity (0.0–1.0). Only when bgGradientType == 'custom'.
    @Default(0.4) double colorIntensity,

    /// Image overlay opacity (0.0–1.0). Only when bgGradientType == 'custom'.
    @Default(1.0) double imageOpacity,

    /// Image layout: 'full' (entire card) or 'right' (right half only).
    @Default('right') String imageLayout,

    @Default(false) bool isDeleted,
  }) = _FeaturedItem;

  const FeaturedItem._();

  bool get isScheduled => scheduledStart != null || scheduledEnd != null;

  bool get isCurrentlyActive {
    if (!isActive || isDeleted) return false;
    final now = DateTime.now().toUtc();
    if (scheduledStart != null && now.isBefore(scheduledStart!)) return false;
    if (scheduledEnd != null && now.isAfter(scheduledEnd!)) return false;
    return true;
  }
}
