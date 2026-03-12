import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/gooi_payout_status.dart';

part 'gooi_payout.freezed.dart';
part 'gooi_payout.g.dart';

@freezed
class GooiPayout with _$GooiPayout {
  const factory GooiPayout({
    required String id,
    required String cycleId,
    required int cycleNumber,
    String? recipientMemberId,
    required String recipientUserId,
    @Default(0) int amountFromContributions,
    @Default(0) int amountFromReserve,
    @Default(0) int totalPayoutAmount,
    @Default(0) int shortfallAmount,
    required GooiPayoutStatus status,
    @Default(0) int retryCount,
    String? journalId,
    String? triggeredBy,
    DateTime? triggeredAt,
    DateTime? completedAt,
    @Default([]) List<String> defaulterMemberIds,
  }) = _GooiPayout;

  const GooiPayout._();

  factory GooiPayout.fromJson(Map<String, dynamic> json) =>
      _$GooiPayoutFromJson(json);

  double get payoutZar => totalPayoutAmount / 100;
  bool get hasShortfall => shortfallAmount > 0;
}
