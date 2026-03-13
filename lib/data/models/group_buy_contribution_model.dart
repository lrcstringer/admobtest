import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/group_buy_contribution.dart';

part 'group_buy_contribution_model.freezed.dart';

@freezed
class GroupBuyContributionModel with _$GroupBuyContributionModel {
  const factory GroupBuyContributionModel({
    required String id,
    required String userId,
    required String userName,
    required int amount,
    String? journalId,
    String? deliveryAddress,
    required DateTime contributedAt,
    String? voucherCode,
    @Default(false) bool hasCollected,
    DateTime? collectedAt,
    @Default('primary') String walletId,
  }) = _GroupBuyContributionModel;

  const GroupBuyContributionModel._();

  // Manual parsing handles Firestore Timestamps and null safety
  factory GroupBuyContributionModel.fromJson(Map<String, dynamic> json) {
    return GroupBuyContributionModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      journalId: json['journalId'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      contributedAt: json['contributedAt'] is Timestamp
          ? (json['contributedAt'] as Timestamp).toDate()
          : json['contributedAt'] is String
              ? DateTime.parse(json['contributedAt'] as String)
              : DateTime.fromMillisecondsSinceEpoch(0),
      voucherCode: json['voucherCode'] as String?,
      hasCollected: json['hasCollected'] as bool? ?? false,
      collectedAt: json['collectedAt'] is Timestamp
          ? (json['collectedAt'] as Timestamp).toDate()
          : json['collectedAt'] is String
              ? DateTime.parse(json['collectedAt'] as String)
              : null,
      walletId: json['walletId'] as String? ?? 'primary',
    );
  }

  factory GroupBuyContributionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GroupBuyContributionModel.fromJson({...data, 'id': doc.id});
  }

  GroupBuyContribution toEntity() {
    return GroupBuyContribution(
      id: id,
      userId: userId,
      userName: userName,
      amount: amount,
      journalId: journalId,
      deliveryAddress: deliveryAddress,
      contributedAt: contributedAt,
      voucherCode: voucherCode,
      hasCollected: hasCollected,
      collectedAt: collectedAt,
      walletId: walletId,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'userId': userId,
      'userName': userName,
      'amount': amount,
      if (journalId != null) 'journalId': journalId,
      if (deliveryAddress != null) 'deliveryAddress': deliveryAddress,
      'contributedAt': Timestamp.fromDate(contributedAt),
      if (voucherCode != null) 'voucherCode': voucherCode,
      'hasCollected': hasCollected,
      if (collectedAt != null) 'collectedAt': Timestamp.fromDate(collectedAt!),
      'walletId': walletId,
    };
  }

  factory GroupBuyContributionModel.fromEntity(GroupBuyContribution entity) {
    return GroupBuyContributionModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      amount: entity.amount,
      journalId: entity.journalId,
      deliveryAddress: entity.deliveryAddress,
      contributedAt: entity.contributedAt,
      voucherCode: entity.voucherCode,
      hasCollected: entity.hasCollected,
      collectedAt: entity.collectedAt,
      walletId: entity.walletId,
    );
  }
}
