import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/purchase.dart';

part 'purchase_model.freezed.dart';

@freezed
class PurchaseModel with _$PurchaseModel {
  const factory PurchaseModel({
    required String id,
    required String walletId,
    required String oddienceUserId,
    required String providerId,
    required String providerName,
    required String category,
    required int tokenAmount,
    required double zarAmount,
    required String status,
    required String productCode,
    required String productName,
    String? recipientNumber,
    String? voucherCode,
    String? voucherPin,
    String? reference,
    String? failureReason,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
  }) = _PurchaseModel;

  const PurchaseModel._();

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final processedAt = json['processedAt'];
    final completedAt = json['completedAt'];

    return PurchaseModel(
      id: json['id'] as String,
      walletId: json['walletId'] as String,
      oddienceUserId: json['oddienceUserId'] as String,
      providerId: json['providerId'] as String,
      providerName: json['providerName'] as String,
      category: json['category'] as String,
      tokenAmount: json['tokenAmount'] as int,
      zarAmount: (json['zarAmount'] as num).toDouble(),
      status: json['status'] as String? ?? 'pending',
      productCode: json['productCode'] as String,
      productName: json['productName'] as String,
      recipientNumber: json['recipientNumber'] as String?,
      voucherCode: json['voucherCode'] as String?,
      voucherPin: json['voucherPin'] as String?,
      reference: json['reference'] as String?,
      failureReason: json['failureReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
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
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'walletId': walletId,
      'oddienceUserId': oddienceUserId,
      'providerId': providerId,
      'providerName': providerName,
      'category': category,
      'tokenAmount': tokenAmount,
      'zarAmount': zarAmount,
      'status': status,
      'productCode': productCode,
      'productName': productName,
      'recipientNumber': recipientNumber,
      'voucherCode': voucherCode,
      'voucherPin': voucherPin,
      'reference': reference,
      'failureReason': failureReason,
      'metadata': metadata,
      'createdAt': Timestamp.fromDate(createdAt),
      'processedAt': processedAt != null ? Timestamp.fromDate(processedAt!) : null,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
    };
  }

  Purchase toEntity() {
    return Purchase(
      id: id,
      walletId: walletId,
      oddienceUserId: oddienceUserId,
      providerId: providerId,
      providerName: providerName,
      category: _parseCategory(category),
      tokenAmount: tokenAmount,
      zarAmount: zarAmount,
      status: _parseStatus(status),
      productCode: productCode,
      productName: productName,
      recipientNumber: recipientNumber,
      voucherCode: voucherCode,
      voucherPin: voucherPin,
      reference: reference,
      failureReason: failureReason,
      metadata: metadata,
      createdAt: createdAt,
      processedAt: processedAt,
      completedAt: completedAt,
    );
  }

  factory PurchaseModel.fromEntity(Purchase entity) {
    return PurchaseModel(
      id: entity.id,
      walletId: entity.walletId,
      oddienceUserId: entity.oddienceUserId,
      providerId: entity.providerId,
      providerName: entity.providerName,
      category: entity.category.name,
      tokenAmount: entity.tokenAmount,
      zarAmount: entity.zarAmount,
      status: entity.status.name,
      productCode: entity.productCode,
      productName: entity.productName,
      recipientNumber: entity.recipientNumber,
      voucherCode: entity.voucherCode,
      voucherPin: entity.voucherPin,
      reference: entity.reference,
      failureReason: entity.failureReason,
      metadata: entity.metadata,
      createdAt: entity.createdAt,
      processedAt: entity.processedAt,
      completedAt: entity.completedAt,
    );
  }

  static PurchaseCategory _parseCategory(String category) {
    switch (category) {
      case 'airtime':
        return PurchaseCategory.airtime;
      case 'data':
        return PurchaseCategory.data;
      case 'electricity':
        return PurchaseCategory.electricity;
      case 'voucher':
        return PurchaseCategory.voucher;
      default:
        return PurchaseCategory.other;
    }
  }

  static PurchaseStatus _parseStatus(String status) {
    switch (status) {
      case 'pending':
        return PurchaseStatus.pending;
      case 'processing':
        return PurchaseStatus.processing;
      case 'completed':
        return PurchaseStatus.completed;
      case 'failed':
        return PurchaseStatus.failed;
      case 'refunded':
        return PurchaseStatus.refunded;
      default:
        return PurchaseStatus.pending;
    }
  }
}
