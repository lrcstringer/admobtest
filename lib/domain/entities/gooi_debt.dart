import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/gooi_debt_status.dart';

part 'gooi_debt.freezed.dart';
part 'gooi_debt.g.dart';

@freezed
class GooiDebt with _$GooiDebt {
  const factory GooiDebt({
    required String id,
    required String userId,
    required String groupId,
    required int amount,
    required String reason,
    required GooiDebtStatus status,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _GooiDebt;

  const GooiDebt._();

  factory GooiDebt.fromJson(Map<String, dynamic> json) =>
      _$GooiDebtFromJson(json);

  double get amountZar => amount / 100;
  bool get isOutstanding => status == GooiDebtStatus.outstanding;
}
