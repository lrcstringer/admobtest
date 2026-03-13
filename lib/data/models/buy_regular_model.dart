import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/buy_regular.dart';

part 'buy_regular_model.freezed.dart';

@freezed
class BuyRegularModel with _$BuyRegularModel {
  const factory BuyRegularModel({
    required String id,
    required String providerId,
    required String productId,
    required String providerName,
    required String productName,
    required String recipientNumber,
    String? recipientLabel,
    @Default(false) bool isPinned,
    @Default(0) int usageCount,
    required DateTime lastUsedAt,
    String? categoryEmoji,
    String? purchaseCategoryMapping,
  }) = _BuyRegularModel;

  const BuyRegularModel._();

  factory BuyRegularModel.fromJson(Map<String, dynamic> json) {
    return BuyRegularModel(
      id: json['id'] as String? ?? '',
      providerId: json['providerId'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      recipientNumber: json['recipientNumber'] as String? ?? '',
      recipientLabel: json['recipientLabel'] as String?,
      isPinned: json['isPinned'] as bool? ?? false,
      usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
      lastUsedAt: json['lastUsedAt'] is Timestamp
          ? (json['lastUsedAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['lastUsedAt']?.toString() ?? '') ??
              DateTime.utc(1970),
      categoryEmoji: json['categoryEmoji'] as String?,
      purchaseCategoryMapping: json['purchaseCategoryMapping'] as String?,
    );
  }

  BuyRegular toEntity() {
    return BuyRegular(
      id: id,
      providerId: providerId,
      productId: productId,
      providerName: providerName,
      productName: productName,
      recipientNumber: recipientNumber,
      recipientLabel: recipientLabel,
      isPinned: isPinned,
      usageCount: usageCount,
      lastUsedAt: lastUsedAt,
      categoryEmoji: categoryEmoji,
      purchaseCategoryMapping: purchaseCategoryMapping,
    );
  }

  factory BuyRegularModel.fromEntity(BuyRegular entity) {
    return BuyRegularModel(
      id: entity.id,
      providerId: entity.providerId,
      productId: entity.productId,
      providerName: entity.providerName,
      productName: entity.productName,
      recipientNumber: entity.recipientNumber,
      recipientLabel: entity.recipientLabel,
      isPinned: entity.isPinned,
      usageCount: entity.usageCount,
      lastUsedAt: entity.lastUsedAt,
      categoryEmoji: entity.categoryEmoji,
      purchaseCategoryMapping: entity.purchaseCategoryMapping,
    );
  }
}
