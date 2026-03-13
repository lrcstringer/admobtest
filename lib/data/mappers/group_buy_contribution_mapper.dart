import '../../domain/entities/group_buy_contribution.dart';
import '../models/group_buy_contribution_model.dart';

/// Mapper for converting between [GroupBuyContributionModel] and [GroupBuyContribution].
class GroupBuyContributionMapper {
  static GroupBuyContribution toEntity(GroupBuyContributionModel model) {
    return GroupBuyContribution(
      id: model.id,
      userId: model.userId,
      userName: model.userName,
      amount: model.amount,
      journalId: model.journalId,
      deliveryAddress: model.deliveryAddress,
      contributedAt: model.contributedAt,
      voucherCode: model.voucherCode,
      hasCollected: model.hasCollected,
      collectedAt: model.collectedAt,
      walletId: model.walletId,
    );
  }

  static GroupBuyContributionModel fromEntity(GroupBuyContribution entity) {
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
