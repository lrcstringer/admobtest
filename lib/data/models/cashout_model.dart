import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/cashout.dart';
import '../../domain/enums/cashout_status.dart';

part 'cashout_model.freezed.dart';

@freezed
class CashoutModel with _$CashoutModel {
  const factory CashoutModel({
    required String id,
    required String walletId,
    required String userId,
    required int tokenAmount,
    required double zarAmount,
    required String method,
    required String status,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
    String? reference,
    String? failureReason,
    required DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
    DateTime? failedAt,
  }) = _CashoutModel;

  const CashoutModel._();

  factory CashoutModel.fromJson(Map<String, dynamic> json) {
    // Handle Firestore Timestamps
    final createdAt = json['createdAt'];
    final processedAt = json['processedAt'];
    final completedAt = json['completedAt'];
    final failedAt = json['failedAt'];

    // Handle nested bankDetails from server or flat fields for backward compatibility
    final bankDetails = json['bankDetails'] as Map<String, dynamic>?;
    final method = bankDetails?['method'] as String? ?? json['method'] as String?;
    final destinationDetails = bankDetails?['destinationDetails'] as String? ??
        json['destinationDetails'] as String? ?? '';
    final bankName = bankDetails?['bankName'] as String? ?? json['bankName'] as String?;
    final accountNumber = bankDetails?['accountNumber'] as String? ?? json['accountNumber'] as String?;
    final accountHolderName = bankDetails?['accountHolderName'] as String? ?? json['accountHolderName'] as String?;
    final mobileNumber = bankDetails?['mobileNumber'] as String? ?? json['mobileNumber'] as String?;

    return CashoutModel(
      id: json['id'] as String,
      walletId: json['walletId'] as String,
      userId: json['userId'] as String,
      tokenAmount: json['tokenAmount'] as int,
      zarAmount: (json['zarAmount'] as num).toDouble(),
      method: method ?? 'bankTransfer',
      status: json['status'] as String,
      destinationDetails: destinationDetails,
      bankName: bankName,
      accountNumber: accountNumber,
      accountHolderName: accountHolderName,
      mobileNumber: mobileNumber,
      reference: json['reference'] as String?,
      failureReason: json['failureReason'] as String?,
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      processedAt: processedAt == null
          ? null
          : processedAt is Timestamp
              ? processedAt.toDate()
              : DateTime.parse(processedAt as String),
      completedAt: completedAt == null
          ? null
          : completedAt is Timestamp
              ? completedAt.toDate()
              : DateTime.parse(completedAt as String),
      failedAt: failedAt == null
          ? null
          : failedAt is Timestamp
              ? failedAt.toDate()
              : DateTime.parse(failedAt as String),
    );
  }

  Cashout toEntity() {
    return Cashout(
      id: id,
      walletId: walletId,
      userId: userId,
      tokenAmount: tokenAmount,
      zarAmount: zarAmount,
      method: _parseCashoutMethod(method),
      status: _parseCashoutStatus(status),
      destinationDetails: destinationDetails,
      bankName: bankName,
      accountNumber: accountNumber,
      accountHolderName: accountHolderName,
      mobileNumber: mobileNumber,
      reference: reference,
      failureReason: failureReason,
      createdAt: createdAt,
      processedAt: processedAt,
      completedAt: completedAt,
      failedAt: failedAt,
    );
  }

  factory CashoutModel.fromEntity(Cashout entity) {
    return CashoutModel(
      id: entity.id,
      walletId: entity.walletId,
      userId: entity.userId,
      tokenAmount: entity.tokenAmount,
      zarAmount: entity.zarAmount,
      method: entity.method.name,
      status: entity.status.name,
      destinationDetails: entity.destinationDetails,
      bankName: entity.bankName,
      accountNumber: entity.accountNumber,
      accountHolderName: entity.accountHolderName,
      mobileNumber: entity.mobileNumber,
      reference: entity.reference,
      failureReason: entity.failureReason,
      createdAt: entity.createdAt,
      processedAt: entity.processedAt,
      completedAt: entity.completedAt,
      failedAt: entity.failedAt,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'walletId': walletId,
      'userId': userId,
      'tokenAmount': tokenAmount,
      'zarAmount': zarAmount,
      'method': method,
      'status': status,
      'destinationDetails': destinationDetails,
      if (bankName != null) 'bankName': bankName,
      if (accountNumber != null) 'accountNumber': accountNumber,
      if (accountHolderName != null) 'accountHolderName': accountHolderName,
      if (mobileNumber != null) 'mobileNumber': mobileNumber,
      if (reference != null) 'reference': reference,
      if (failureReason != null) 'failureReason': failureReason,
      'createdAt': Timestamp.fromDate(createdAt),
      if (processedAt != null) 'processedAt': Timestamp.fromDate(processedAt!),
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
      if (failedAt != null) 'failedAt': Timestamp.fromDate(failedAt!),
    };
  }

  static CashoutMethod _parseCashoutMethod(String method) {
    switch (method) {
      case 'bankTransfer':
        return CashoutMethod.bankTransfer;
      case 'ewallet':
        return CashoutMethod.ewallet;
      case 'airtime':
        return CashoutMethod.airtime;
      case 'voucher':
        return CashoutMethod.voucher;
      default:
        return CashoutMethod.bankTransfer;
    }
  }

  static CashoutStatus _parseCashoutStatus(String status) {
    switch (status) {
      case 'pending':
        return CashoutStatus.pending;
      case 'onHold':
        return CashoutStatus.onHold;
      case 'processing':
        return CashoutStatus.processing;
      case 'completed':
        return CashoutStatus.completed;
      case 'failed':
        return CashoutStatus.failed;
      case 'cancelled':
        return CashoutStatus.cancelled;
      default:
        return CashoutStatus.pending;
    }
  }
}
