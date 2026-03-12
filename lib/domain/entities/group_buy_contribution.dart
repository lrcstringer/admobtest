import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_buy_contribution.freezed.dart';

@freezed
class GroupBuyContribution with _$GroupBuyContribution {
  const factory GroupBuyContribution({
    required String id,
    required String userId,
    required String userName,
    required int amount,
    String? journalId,

    /// Delivery address for physical fulfilment group buys
    String? deliveryAddress,
    required DateTime contributedAt,
    // ── New fields (Spec §9.16) ──
    String? voucherCode,
    @Default(false) bool hasCollected,
    DateTime? collectedAt,
    @Default('primary') String walletId,
  }) = _GroupBuyContribution;

}
