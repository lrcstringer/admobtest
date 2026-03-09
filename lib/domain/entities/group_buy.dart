import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/group_buy_status.dart';

part 'group_buy.freezed.dart';
part 'group_buy.g.dart';

@freezed
class GroupBuy with _$GroupBuy {
  const factory GroupBuy({
    required String id,
    required String title,
    required String description,
    String? linkedListingId,
    required String organizerId,
    required String organizerName,
    required String communityId,
    required int targetAmount,
    @Default(0) int currentAmount,
    @Default(1) int minParticipants,
    int? maxParticipants,
    required DateTime deadline,
    required GroupBuyStatus status,
    @Default(0) int participantCount,

    /// 'community' or 'brand'
    @Default('community') String sponsorType,
    String? brandId,
    String? brandName,
    String? brandLogoUrl,
    int? discountPercent,

    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _GroupBuy;

  const GroupBuy._();

  factory GroupBuy.fromJson(Map<String, dynamic> json) =>
      _$GroupBuyFromJson(json);

  /// Progress as fraction 0.0 – 1.0
  double get progress =>
      targetAmount > 0 ? (currentAmount / targetAmount).clamp(0.0, 1.0) : 0.0;

  /// Progress as percentage 0 – 100
  int get progressPercent => (progress * 100).round();

  /// Whether a user can still join
  bool get canJoin =>
      status.isJoinable &&
      (maxParticipants == null || participantCount < maxParticipants!);

  /// Remaining spots (null if unlimited)
  int? get spotsLeft =>
      maxParticipants != null ? maxParticipants! - participantCount : null;

  /// Whether sponsored by a brand
  bool get isBrandSponsored => sponsorType == 'brand' && brandId != null;

  /// Whether the deadline has passed
  bool get isExpired => DateTime.now().isAfter(deadline);

  /// Formatted token target
  String get formattedTarget => '$targetAmount tokens';
}
