import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_review.freezed.dart';
part 'brand_review.g.dart';

@freezed
class BrandReview with _$BrandReview {
  const factory BrandReview({
    required String id,
    required String brandId,
    required String userId,
    required String userName,

    /// Purchase that qualifies this review (uniqueness key)
    required String orderId,

    /// 1-5 stars
    required int qualityRating,
    required int valueRating,
    required int serviceRating,

    /// Computed average of the three dimensions
    required double overallRating,

    String? comment,

    /// Auto-filter flagged this (hidden from carousel)
    @Default(false) bool isFiltered,

    /// Admin manually removed
    @Default(false) bool isRemovedByAdmin,

    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _BrandReview;

  const BrandReview._();

  factory BrandReview.fromJson(Map<String, dynamic> json) =>
      _$BrandReviewFromJson(json);

  /// Whether this review should be shown publicly
  bool get isVisible => !isFiltered && !isRemovedByAdmin;
}
