import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gooi_payout.dart';
import '../../domain/enums/gooi_payout_status.dart';

part 'gooi_payout_model.freezed.dart';

@freezed
class GooiPayoutModel with _$GooiPayoutModel {
  const factory GooiPayoutModel({
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
  }) = _GooiPayoutModel;

  const GooiPayoutModel._();

  factory GooiPayoutModel.fromJson(Map<String, dynamic> json) {
    return GooiPayoutModel(
      id: json['id'] as String? ?? '',
      cycleId: json['cycleId'] as String? ?? '',
      cycleNumber: (json['cycleNumber'] as num?)?.toInt() ?? 0,
      recipientMemberId: json['recipientMemberId'] as String?,
      recipientUserId: json['recipientUserId'] as String? ?? '',
      amountFromContributions: (json['amountFromContributions'] as num?)?.toInt() ?? 0,
      amountFromReserve: (json['amountFromReserve'] as num?)?.toInt() ?? 0,
      totalPayoutAmount: (json['totalPayoutAmount'] as num?)?.toInt() ?? 0,
      shortfallAmount: (json['shortfallAmount'] as num?)?.toInt() ?? 0,
      status: GooiPayoutStatusX.fromString(json['status'] as String? ?? 'PENDING'),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      journalId: json['journalId'] as String?,
      triggeredBy: json['triggeredBy'] as String?,
      triggeredAt: _parseDateTime(json['triggeredAt']),
      completedAt: _parseDateTime(json['completedAt']),
      defaulterMemberIds: (json['defaulterMemberIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  factory GooiPayoutModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GooiPayoutModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cycleId': cycleId,
      'cycleNumber': cycleNumber,
      if (recipientMemberId != null) 'recipientMemberId': recipientMemberId,
      'recipientUserId': recipientUserId,
      'amountFromContributions': amountFromContributions,
      'amountFromReserve': amountFromReserve,
      'totalPayoutAmount': totalPayoutAmount,
      'shortfallAmount': shortfallAmount,
      'status': status.name.toUpperCase(),
      'retryCount': retryCount,
      if (journalId != null) 'journalId': journalId,
      if (triggeredBy != null) 'triggeredBy': triggeredBy,
      if (triggeredAt != null) 'triggeredAt': triggeredAt!.toIso8601String(),
      if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
      'defaulterMemberIds': defaulterMemberIds,
    };
  }

  GooiPayout toEntity() {
    return GooiPayout(
      id: id,
      cycleId: cycleId,
      cycleNumber: cycleNumber,
      recipientMemberId: recipientMemberId,
      recipientUserId: recipientUserId,
      amountFromContributions: amountFromContributions,
      amountFromReserve: amountFromReserve,
      totalPayoutAmount: totalPayoutAmount,
      shortfallAmount: shortfallAmount,
      status: status,
      retryCount: retryCount,
      journalId: journalId,
      triggeredBy: triggeredBy,
      triggeredAt: triggeredAt,
      completedAt: completedAt,
      defaulterMemberIds: defaulterMemberIds,
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
