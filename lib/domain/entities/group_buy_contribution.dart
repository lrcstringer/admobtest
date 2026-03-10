import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_buy_contribution.freezed.dart';
part 'group_buy_contribution.g.dart';

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
  }) = _GroupBuyContribution;

  factory GroupBuyContribution.fromJson(Map<String, dynamic> json) =>
      _$GroupBuyContributionFromJson(json);
}
