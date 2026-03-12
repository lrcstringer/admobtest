import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gooi_group.dart';
import '../../domain/enums/gooi_cycle_frequency.dart';
import '../../domain/enums/gooi_cycle_status.dart';
import '../../domain/enums/gooi_group_status.dart';
import '../../domain/enums/gooi_roster_method.dart';

part 'gooi_group_model.freezed.dart';

@freezed
class GooiGroupModel with _$GooiGroupModel {
  const factory GooiGroupModel({
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
    GooiCycleSummary? currentCycle,
  }) = _GooiGroupModel;

  const GooiGroupModel._();

  factory GooiGroupModel.fromJson(Map<String, dynamic> json) {
    return GooiGroupModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      contributionAmount: (json['contributionAmount'] as num?)?.toInt() ?? 0,
      cycleFrequency: GooiCycleFrequencyX.fromString(json['cycleFrequency'] as String? ?? 'MONTHLY'),
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      totalCycles: (json['totalCycles'] as num?)?.toInt() ?? 0,
      currentCycleNumber: (json['currentCycleNumber'] as num?)?.toInt() ?? 0,
      status: GooiGroupStatusX.fromString(json['status'] as String? ?? 'FORMING'),
      rosterMethod: GooiRosterMethodX.fromString(json['rosterMethod'] as String? ?? 'AGREED'),
      reserveRate: (json['reserveRate'] as num?)?.toDouble() ?? 0.03,
      gracePeriodHours: (json['gracePeriodHours'] as num?)?.toInt() ?? 48,
      recipientContributes: json['recipientContributes'] as bool? ?? true,
      lateFeePercent: (json['lateFeePercent'] as num?)?.toInt() ?? 5,
      initiatorUserId: json['initiatorUserId'] as String? ?? '',
      conversationId: json['conversationId'] as String?,
      rosterOrder: (json['rosterOrder'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      memberUserIds: (json['memberUserIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      biddingDiscountPool: (json['biddingDiscountPool'] as num?)?.toInt() ?? 0,
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
      activatedAt: _parseDateTime(json['activatedAt']),
      completedAt: _parseDateTime(json['completedAt']),
      currentCycle: json['currentCycle'] != null
          ? _parseCycleSummary(json['currentCycle'] as Map<String, dynamic>)
          : null,
    );
  }

  factory GooiGroupModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GooiGroupModel.fromJson({...data, 'id': doc.id});
  }

  GooiGroup toEntity() {
    return GooiGroup(
      id: id,
      name: name,
      contributionAmount: contributionAmount,
      cycleFrequency: cycleFrequency,
      memberCount: memberCount,
      totalCycles: totalCycles,
      currentCycleNumber: currentCycleNumber,
      status: status,
      rosterMethod: rosterMethod,
      reserveRate: reserveRate,
      gracePeriodHours: gracePeriodHours,
      recipientContributes: recipientContributes,
      lateFeePercent: lateFeePercent,
      initiatorUserId: initiatorUserId,
      conversationId: conversationId,
      rosterOrder: rosterOrder,
      memberUserIds: memberUserIds,
      biddingDiscountPool: biddingDiscountPool,
      createdAt: createdAt,
      activatedAt: activatedAt,
      completedAt: completedAt,
      currentCycle: currentCycle,
    );
  }
}

GooiCycleSummary _parseCycleSummary(Map<String, dynamic> json) {
  return GooiCycleSummary(
    cycleNumber: (json['cycleNumber'] as num?)?.toInt() ?? 0,
    status: GooiCycleStatusX.fromString(json['status'] as String? ?? 'PENDING'),
    recipientUserId: json['recipientUserId'] as String? ?? '',
    dueDate: _parseDateTime(json['dueDate']) ?? DateTime.now(),
    totalCollected: (json['totalCollected'] as num?)?.toInt() ?? 0,
    totalExpected: (json['totalExpected'] as num?)?.toInt() ?? 0,
  );
}

DateTime? _parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  if (value is Map) {
    final seconds = value['_seconds'] as int?;
    if (seconds != null) return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
  return null;
}
