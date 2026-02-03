import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/enums/transaction_type.dart';

// Re-export TransactionStatus for convenience
export '../../domain/entities/transaction.dart' show TransactionStatus;

part 'transaction_model.freezed.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String walletId,
    required String type,
    required int amount,
    @Default(0) int balanceAfter,
    required DateTime createdAt,
    @Default('completed') String status,
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

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    // Handle server field name: tokenAmount → amount
    final amount = json['tokenAmount'] as int? ?? json['amount'] as int? ?? 0;

    // Handle Firestore Timestamp for createdAt
    final createdAt = json['createdAt'];
    final parsedCreatedAt = createdAt is Timestamp
        ? createdAt.toDate()
        : createdAt is String
            ? DateTime.parse(createdAt)
            : DateTime.now();

    return TransactionModel(
      id: json['id'] as String,
      walletId: json['walletId'] as String,
      type: json['type'] as String? ?? json['subType'] as String? ?? 'earn',
      amount: amount,
      balanceAfter: json['balanceAfter'] as int? ?? 0,
      createdAt: parsedCreatedAt,
      status: json['status'] as String? ?? 'completed',
      description: json['description'] as String?,
      counterpartyId: json['counterpartyId'] as String?,
      counterpartyName: json['counterpartyName'] as String?,
      engagementId: json['engagementId'] as String?,
      purchaseId: json['purchaseId'] as String?,
      referralId: json['referralId'] as String?,
      isBonus: json['isBonus'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Transaction toEntity() => Transaction(
        id: id,
        walletId: walletId,
        type: _parseTransactionType(type),
        amount: amount,
        balanceAfter: balanceAfter,
        createdAt: createdAt,
        status: _parseTransactionStatus(status),
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
        status: tx.status.name,
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

  static TransactionStatus _parseTransactionStatus(String status) {
    switch (status) {
      case 'pending':
        return TransactionStatus.pending;
      case 'completed':
        return TransactionStatus.completed;
      case 'failed':
        return TransactionStatus.failed;
      case 'cancelled':
        return TransactionStatus.cancelled;
      default:
        return TransactionStatus.completed;
    }
  }
}
