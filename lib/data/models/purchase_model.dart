import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/purchase.dart';
import 'purchase_category_helpers.dart';

part 'purchase_model.freezed.dart';

@freezed
class PurchaseModel with _$PurchaseModel {
  const factory PurchaseModel({
    required String id,
    required String subAccountId,
    required String userId,
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

  // Manual parsing handles Firestore Timestamps and null safety
  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final processedAt = json['processedAt'];
    final completedAt = json['completedAt'];

    return PurchaseModel(
      id: json['id'] as String? ?? '',
      subAccountId: json['subAccountId'] as String? ?? json['walletId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      providerId: json['providerId'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      category: json['category'] as String? ?? 'other',
      tokenAmount: (json['tokenAmount'] as num?)?.toInt() ?? 0,
      zarAmount: (json['zarAmount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending',
      productCode: json['productCode'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      recipientNumber: json['recipientNumber'] as String?,
      voucherCode: json['voucherCode'] as String?,
      voucherPin: json['voucherPin'] as String?,
      reference: json['reference'] as String?,
      failureReason: json['failureReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      // sanitizeFirestoreData converts Timestamps to ISO strings before
      // this parser runs, but raw Firestore data may still contain
      // Timestamp objects — handle both formats for safety.
      createdAt: createdAt == null
          ? DateTime.fromMillisecondsSinceEpoch(0)
          : createdAt is Timestamp
              ? createdAt.toDate()
              : createdAt is String
                  ? DateTime.tryParse(createdAt) ?? DateTime.fromMillisecondsSinceEpoch(0)
                  : DateTime.fromMillisecondsSinceEpoch(0),
      processedAt: processedAt == null
          ? null
          : processedAt is Timestamp
              ? processedAt.toDate()
              : processedAt is String
                  ? DateTime.tryParse(processedAt)
                  : null,
      completedAt: completedAt == null
          ? null
          : completedAt is Timestamp
              ? completedAt.toDate()
              : completedAt is String
                  ? DateTime.tryParse(completedAt)
                  : null,
    );
  }

  // ID is the document key, not stored in document body
  Map<String, dynamic> toFirestoreJson() {
    return {
      'subAccountId': subAccountId,
      'userId': userId,
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
      subAccountId: subAccountId,
      userId: userId,
      providerId: providerId,
      providerName: providerName,
      category: parsePurchaseCategory(category),
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
      subAccountId: entity.subAccountId,
      userId: entity.userId,
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
        developer.log(
          'Unknown PurchaseStatus "$status", defaulting to pending',
          name: 'PurchaseModel',
        );
        return PurchaseStatus.pending;
    }
  }
}
