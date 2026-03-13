import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/gooi_cycle_status.dart';

part 'gooi_cycle.freezed.dart';
part 'gooi_cycle.g.dart';

@freezed
abstract class GooiCycle with _$GooiCycle {
  const factory GooiCycle({
    required String id,
    required int cycleNumber,
    @Default(1) int rotationNumber,
    String? recipientMemberId,
    required String recipientUserId,
    required DateTime dueDate,
    required DateTime graceCloseDate,
    required GooiCycleStatus status,
    @Default(0) int totalExpected,
    @Default(0) int totalCollected,
    @Default(0) int reserveCollected,
    @Default(0) int payoutAmount,
    @Default(0) int shortfallAmount,
    @Default([]) List<String> defaulterMemberIds,
    String? triggeredBy,
    DateTime? triggeredAt,
    DateTime? completedAt,
    DateTime? autoTriggerAt,
    @Default(0) int graceExtendedBy,
    String? graceExtensionVoteId,
  }) = _GooiCycle;

  const GooiCycle._();

  factory GooiCycle.fromJson(Map<String, dynamic> json) =>
      _$GooiCycleFromJson(json);

  double get collectionProgress =>
      totalExpected > 0 ? totalCollected / totalExpected : 0.0;

  bool get hasShortfall => shortfallAmount > 0;
  bool get isAwaitingTrigger => status == GooiCycleStatus.awaitingTrigger;
}
