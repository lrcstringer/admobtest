import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/gooi_cycle_frequency.dart';
import '../enums/gooi_cycle_status.dart';
import '../enums/gooi_group_status.dart';
import '../enums/gooi_roster_method.dart';

part 'gooi_group.freezed.dart';
part 'gooi_group.g.dart';

@freezed
class GooiGroup with _$GooiGroup {
  const factory GooiGroup({
    required String id,
    required String name,
    required int contributionAmount,
    required GooiCycleFrequency cycleFrequency,
    required int memberCount,
    required int totalCycles,
    @Default(0) int currentCycleNumber,
    required GooiGroupStatus status,
    required GooiRosterMethod rosterMethod,
    @Default(0.03) double reserveRate,
    @Default(48) int gracePeriodHours,
    @Default(true) bool recipientContributes,
    @Default(5) int lateFeePercent,
    required String initiatorUserId,
    String? conversationId,
    @Default([]) List<String> rosterOrder,
    @Default([]) List<String> memberUserIds,
    @Default(0) int biddingDiscountPool,
    required DateTime createdAt,
    DateTime? activatedAt,
    DateTime? completedAt,
    /// Current cycle summary (populated from query)
    GooiCycleSummary? currentCycle,
  }) = _GooiGroup;

  const GooiGroup._();

  factory GooiGroup.fromJson(Map<String, dynamic> json) =>
      _$GooiGroupFromJson(json);

  /// Contribution amount displayed in ZAR.
  double get contributionZar => contributionAmount / 100;

  /// Total round duration description (e.g. "6 months").
  String get roundDurationLabel {
    final days = totalCycles * cycleFrequency.approximateDays;
    if (days >= 365) return '${(days / 365).round()} year(s)';
    if (days >= 30) return '${(days / 30).round()} month(s)';
    return '$days days';
  }
}

@freezed
class GooiCycleSummary with _$GooiCycleSummary {
  const factory GooiCycleSummary({
    required int cycleNumber,
    required GooiCycleStatus status,
    required String recipientUserId,
    required DateTime dueDate,
    @Default(0) int totalCollected,
    @Default(0) int totalExpected,
  }) = _GooiCycleSummary;

  factory GooiCycleSummary.fromJson(Map<String, dynamic> json) =>
      _$GooiCycleSummaryFromJson(json);
}
