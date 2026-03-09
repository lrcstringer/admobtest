import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_regular.freezed.dart';
part 'buy_regular.g.dart';

/// A user's frequently-purchased VAS product shortcut.
@freezed
class BuyRegular with _$BuyRegular {
  const factory BuyRegular({
    required String id,
    required String providerId,
    required String productId,
    required String providerName,
    required String productName,
    required String recipientNumber,
    String? recipientLabel,
    @Default(false) bool isPinned,
    @Default(0) int usageCount,
    required DateTime lastUsedAt,
    /// Emoji from the category for display in the dock chip
    String? categoryEmoji,
    /// Purchase category mapping for routing
    String? purchaseCategoryMapping,
  }) = _BuyRegular;

  const BuyRegular._();

  factory BuyRegular.fromJson(Map<String, dynamic> json) =>
      _$BuyRegularFromJson(json);

  /// Short display label for the dock chip (e.g., "MTN R50")
  String get chipLabel => recipientLabel ?? productName;
}
