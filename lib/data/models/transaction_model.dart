import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/enums/transaction_type.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String walletId,
    required String type,
    required int amount,
    required int balanceAfter,
    required DateTime createdAt,
    String? description,
    String? counterpartyId,
    String? counterpartyName,
    String? engagementId,
    String? purchaseId,
    String? referralId,
    bool? isBonus,
    Map<String, dynamic>? metadata,
  }) = _TransactionModel;

  const TransactionModel._();

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Transaction toEntity() => Transaction(
        id: id,
        walletId: walletId,
        type: _parseTransactionType(type),
        amount: amount,
        balanceAfter: balanceAfter,
        createdAt: createdAt,
        description: description,
        counterpartyId: counterpartyId,
        counterpartyName: counterpartyName,
        engagementId: engagementId,
        purchaseId: purchaseId,
        referralId: referralId,
        isBonus: isBonus,
        metadata: metadata,
      );

  factory TransactionModel.fromEntity(Transaction tx) => TransactionModel(
        id: tx.id,
        walletId: tx.walletId,
        type: tx.type.name,
        amount: tx.amount,
        balanceAfter: tx.balanceAfter,
        createdAt: tx.createdAt,
        description: tx.description,
        counterpartyId: tx.counterpartyId,
        counterpartyName: tx.counterpartyName,
        engagementId: tx.engagementId,
        purchaseId: tx.purchaseId,
        referralId: tx.referralId,
        isBonus: tx.isBonus,
        metadata: tx.metadata,
      );

  static TransactionType _parseTransactionType(String type) {
    switch (type) {
      case 'earn':
        return TransactionType.earn;
      case 'potWin':
        return TransactionType.potWin;
      case 'p2pSend':
        return TransactionType.p2pSend;
      case 'p2pReceive':
        return TransactionType.p2pReceive;
      case 'cashout':
        return TransactionType.cashout;
      case 'refund':
        return TransactionType.refund;
      case 'referral':
        return TransactionType.referral;
      case 'purchase':
        return TransactionType.purchase;
      case 'adjustment':
        return TransactionType.adjustment;
      case 'reversal':
        return TransactionType.reversal;
      default:
        return TransactionType.earn;
    }
  }
}
