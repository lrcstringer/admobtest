import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gooi_contribution.dart';
import '../../domain/enums/gooi_contribution_status.dart';

part 'gooi_contribution_model.freezed.dart';

@freezed
class GooiContributionModel with _$GooiContributionModel {
  const factory GooiContributionModel({
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
  }) = _GooiContributionModel;

  const GooiContributionModel._();

  factory GooiContributionModel.fromJson(Map<String, dynamic> json) {
    return GooiContributionModel(
      id: json['id'] as String? ?? '',
      cycleId: json['cycleId'] as String? ?? '',
      cycleNumber: (json['cycleNumber'] as num?)?.toInt() ?? 0,
      memberId: json['memberId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      amountBase: (json['amountBase'] as num?)?.toInt() ?? 0,
      amountReserve: (json['amountReserve'] as num?)?.toInt() ?? 0,
      amountTotal: (json['amountTotal'] as num?)?.toInt() ?? 0,
      lateFee: (json['lateFee'] as num?)?.toInt(),
      lateFeeWaived: json['lateFeeWaived'] as bool? ?? false,
      status: GooiContributionStatusX.fromString(json['status'] as String? ?? 'PENDING'),
      journalId: json['journalId'] as String?,
      paidAt: _parseDateTime(json['paidAt']),
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
    );
  }

  factory GooiContributionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GooiContributionModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cycleId': cycleId,
      'cycleNumber': cycleNumber,
      'memberId': memberId,
      'userId': userId,
      'amountBase': amountBase,
      'amountReserve': amountReserve,
      'amountTotal': amountTotal,
      if (lateFee != null) 'lateFee': lateFee,
      'lateFeeWaived': lateFeeWaived,
      'status': status.name.toUpperCase(),
      if (journalId != null) 'journalId': journalId,
      if (paidAt != null) 'paidAt': paidAt!.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  GooiContribution toEntity() {
    return GooiContribution(
      id: id,
      cycleId: cycleId,
      cycleNumber: cycleNumber,
      memberId: memberId,
      userId: userId,
      amountBase: amountBase,
      amountReserve: amountReserve,
      amountTotal: amountTotal,
      lateFee: lateFee,
      lateFeeWaived: lateFeeWaived,
      status: status,
      journalId: journalId,
      paidAt: paidAt,
      createdAt: createdAt,
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
