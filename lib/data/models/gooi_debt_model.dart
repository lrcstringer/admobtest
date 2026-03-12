import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gooi_debt.dart';
import '../../domain/enums/gooi_debt_status.dart';

part 'gooi_debt_model.freezed.dart';

@freezed
class GooiDebtModel with _$GooiDebtModel {
  const factory GooiDebtModel({
    required String id,
    required String userId,
    required String groupId,
    required int amount,
    required String reason,
    required GooiDebtStatus status,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _GooiDebtModel;

  const GooiDebtModel._();

  factory GooiDebtModel.fromJson(Map<String, dynamic> json) {
    return GooiDebtModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      groupId: json['groupId'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      reason: json['reason'] as String? ?? '',
      status: _parseDebtStatus(json['status'] as String?),
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
      resolvedAt: _parseDateTime(json['resolvedAt']),
    );
  }

  factory GooiDebtModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GooiDebtModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'groupId': groupId,
      'amount': amount,
      'reason': reason,
      'status': status.name.toUpperCase(),
      'createdAt': createdAt.toIso8601String(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt!.toIso8601String(),
    };
  }

  GooiDebt toEntity() {
    return GooiDebt(
      id: id,
      userId: userId,
      groupId: groupId,
      amount: amount,
      reason: reason,
      status: status,
      createdAt: createdAt,
      resolvedAt: resolvedAt,
    );
  }
}

GooiDebtStatus _parseDebtStatus(String? value) {
  switch (value?.toUpperCase()) {
    case 'RECOVERED':
      return GooiDebtStatus.recovered;
    case 'WRITTEN_OFF':
      return GooiDebtStatus.writtenOff;
    default:
      return GooiDebtStatus.outstanding;
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
