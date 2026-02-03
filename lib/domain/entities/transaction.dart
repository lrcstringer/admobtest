import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/transaction_type.dart';
import '../value_objects/token_amount.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

/// Transaction status enum
enum TransactionStatus {
  pending,
  completed,
  failed,
  cancelled,
}

/// Transaction entity representing wallet movements
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String walletId,
    required TransactionType type,
    required int amount,
    @Default(0) int balanceAfter,
    required DateTime createdAt,
    @Default(TransactionStatus.completed) TransactionStatus status,
    String? description,
    String? counterpartyId,
    String? counterpartyName,
    String? engagementId,
    String? purchaseId,
    String? referralId,
    bool? isBonus,
    Map<String, dynamic>? metadata,
  }) = _Transaction;

  const Transaction._();

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  /// Get amount as TokenAmount
  TokenAmount get tokenAmount => TokenAmount(amount);

  /// Check if this is a credit (money in)
  bool get isCredit => type.isCredit;

  /// Check if this is a debit (money out)
  bool get isDebit => type.isDebit;

  /// Get signed amount (positive for credit, negative for debit)
  int get signedAmount => isCredit ? amount : -amount;

  /// Get formatted amount with sign
  String get formattedAmount {
    final sign = isCredit ? '+' : '-';
    return '$sign${tokenAmount.formatted}';
  }
}
