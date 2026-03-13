import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/gooi_contribution_status.dart';

part 'gooi_contribution.freezed.dart';
part 'gooi_contribution.g.dart';

@freezed
abstract class GooiContribution with _$GooiContribution {
  const factory GooiContribution({
    required String id,
    required String cycleId,
    required int cycleNumber,
    required String memberId,
    required String userId,
    @Default(0) int amountBase,
    @Default(0) int amountReserve,
    @Default(0) int amountTotal,
    int? lateFee,
    @Default(false) bool lateFeeWaived,
    required GooiContributionStatus status,
    String? journalId,
    DateTime? paidAt,
    required DateTime createdAt,
  }) = _GooiContribution;

  const GooiContribution._();

  factory GooiContribution.fromJson(Map<String, dynamic> json) =>
      _$GooiContributionFromJson(json);

  bool get isPaid => status == GooiContributionStatus.paid;
  bool get isOutstanding => status.isOutstanding;
  bool get hasLateFee => lateFee != null && lateFee! > 0;
  bool get isLateFeeWaived => lateFeeWaived;

  /// Total ZAR display amount.
  double get totalZar => amountTotal / 100;
}
