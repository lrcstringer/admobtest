import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gooi_cycle.dart';
import '../../domain/enums/gooi_cycle_status.dart';

part 'gooi_cycle_model.freezed.dart';

@freezed
class GooiCycleModel with _$GooiCycleModel {
  const factory GooiCycleModel({
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
  }) = _GooiCycleModel;

  const GooiCycleModel._();

  factory GooiCycleModel.fromJson(Map<String, dynamic> json) {
    return GooiCycleModel(
      id: json['id'] as String? ?? '',
      cycleNumber: (json['cycleNumber'] as num?)?.toInt() ?? 0,
      rotationNumber: (json['rotationNumber'] as num?)?.toInt() ?? 1,
      recipientMemberId: json['recipientMemberId'] as String?,
      recipientUserId: json['recipientUserId'] as String? ?? '',
      dueDate: _parseDateTime(json['dueDate']) ?? DateTime.now(),
      graceCloseDate: _parseDateTime(json['graceCloseDate']) ?? DateTime.now(),
      status: GooiCycleStatusX.fromString(json['status'] as String? ?? 'PENDING'),
      totalExpected: (json['totalExpected'] as num?)?.toInt() ?? 0,
      totalCollected: (json['totalCollected'] as num?)?.toInt() ?? 0,
      reserveCollected: (json['reserveCollected'] as num?)?.toInt() ?? 0,
      payoutAmount: (json['payoutAmount'] as num?)?.toInt() ?? 0,
      shortfallAmount: (json['shortfallAmount'] as num?)?.toInt() ?? 0,
      defaulterMemberIds: (json['defaulterMemberIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      triggeredBy: json['triggeredBy'] as String?,
      triggeredAt: _parseDateTime(json['triggeredAt']),
      completedAt: _parseDateTime(json['completedAt']),
      autoTriggerAt: _parseDateTime(json['autoTriggerAt']),
      graceExtendedBy: (json['graceExtendedBy'] as num?)?.toInt() ?? 0,
      graceExtensionVoteId: json['graceExtensionVoteId'] as String?,
    );
  }

  factory GooiCycleModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GooiCycleModel.fromJson({...data, 'id': doc.id});
  }

  GooiCycle toEntity() {
    return GooiCycle(
      id: id,
      cycleNumber: cycleNumber,
      rotationNumber: rotationNumber,
      recipientMemberId: recipientMemberId,
      recipientUserId: recipientUserId,
      dueDate: dueDate,
      graceCloseDate: graceCloseDate,
      status: status,
      totalExpected: totalExpected,
      totalCollected: totalCollected,
      reserveCollected: reserveCollected,
      payoutAmount: payoutAmount,
      shortfallAmount: shortfallAmount,
      defaulterMemberIds: defaulterMemberIds,
      triggeredBy: triggeredBy,
      triggeredAt: triggeredAt,
      completedAt: completedAt,
      autoTriggerAt: autoTriggerAt,
      graceExtendedBy: graceExtendedBy,
      graceExtensionVoteId: graceExtensionVoteId,
    );
  }
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
