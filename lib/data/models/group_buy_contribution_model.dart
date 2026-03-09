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
    required DateTime contributedAt,
  }) = _GroupBuyContributionModel;

  const GroupBuyContributionModel._();

  factory GroupBuyContributionModel.fromJson(Map<String, dynamic> json) {
    return GroupBuyContributionModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      journalId: json['journalId'] as String?,
      contributedAt: json['contributedAt'] is Timestamp
          ? (json['contributedAt'] as Timestamp).toDate()
          : json['contributedAt'] is String
              ? DateTime.parse(json['contributedAt'] as String)
              : DateTime.now(),
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
      contributedAt: contributedAt,
    );
  }

  factory GroupBuyContributionModel.fromEntity(GroupBuyContribution entity) {
    return GroupBuyContributionModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      amount: entity.amount,
      journalId: entity.journalId,
      contributedAt: entity.contributedAt,
    );
  }
}
