import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/group_buy_fulfilment_type.dart';
import '../enums/group_buy_status.dart';
import '../enums/group_buy_type.dart';
import '../enums/sponsor_type.dart';

part 'group_buy.freezed.dart';

@freezed
abstract class GroupBuy with _$GroupBuy {
  const factory GroupBuy({
    required String id,
    required String title,
    required String description,
    String? linkedListingId,

    /// Made optional — admin-curated group buys have no user organizer.
    String? organizerId,
    String? organizerName,

    /// Made optional — admin-curated group buys are not community-bound.
    String? communityId,

    required int targetAmount,
    @Default(0) int currentAmount,
    @Default(1) int minParticipants,
    int? maxParticipants,
    required DateTime deadline,
    required GroupBuyStatus status,
    @Default(0) int participantCount,

    @Default(SponsorType.community) SponsorType sponsorType,
    String? brandId,
    String? brandName,
    String? brandLogoUrl,
    int? discountPercent,

    // ── New fields for admin-curated group buys ──

    /// Whether this group buy was created by admin
    @Default(false) bool createdByAdmin,

    /// digital = shown to all, physical = cluster-matched
    @Default(GroupBuyType.digital) GroupBuyType type,

    /// How the deal is fulfilled after target is met
    @Default(GroupBuyFulfilmentType.digital)
    GroupBuyFulfilmentType fulfilmentType,

    /// Regional clusters this deal targets (physical only)
    @Default([]) List<String> clusters,

    /// Freetext pickup/collection addresses for display (physical only)
    @Default([]) List<String> addresses,

    /// Voucher codes uploaded by admin at completion (digital fulfilment)
    @Default([]) List<String> voucherCodes,

    /// Product image URL
    String? imageUrl,

    /// Original price before group buy discount (for strikethrough display)
    int? originalPrice,

    // ── New fields (Spec §9.16) ──
    DateTime? collectionDeadline,
    String? deliveryStatus,
    String? fulfilmentInstructions,
    @Default(0) int collectedCount,
    String? category,
    int? deliveryFee,
    double? organizerSuccessRate,

    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _GroupBuy;

  const GroupBuy._();

  /// Progress as fraction 0.0 – 1.0
  double get progress =>
      targetAmount > 0 ? (currentAmount / targetAmount).clamp(0.0, 1.0) : 0.0;

  /// Progress as percentage 0 – 100
  int get progressPercent => (progress * 100).round();

  /// Whether a user can still join
  bool get canJoin =>
      status.isJoinable &&
      !isExpired() &&
      (maxParticipants == null || participantCount < maxParticipants!);

  /// Remaining spots (null if unlimited, clamped to 0 minimum)
  int? get spotsLeft => maxParticipants != null
      ? (maxParticipants! - participantCount).clamp(0, maxParticipants!)
      : null;

  /// Whether sponsored by a brand
  bool get isBrandSponsored => sponsorType == SponsorType.brand && brandId != null;

  /// Whether the deadline has passed
  bool isExpired({DateTime? now}) => (now ?? DateTime.now()).isAfter(deadline);

  /// Formatted token target
  String get formattedTarget => '$targetAmount tokens';
}
