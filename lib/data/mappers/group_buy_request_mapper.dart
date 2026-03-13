import '../../domain/entities/group_buy_request.dart';
import '../models/group_buy_request_model.dart';

/// Mapper for converting between [GroupBuyRequestModel] and [GroupBuyRequest].
class GroupBuyRequestMapper {
  static GroupBuyRequest toEntity(GroupBuyRequestModel model) {
    return GroupBuyRequest(
      id: model.id,
      userId: model.userId,
      userName: model.userName,
      description: model.description,
      brandOrStore: model.brandOrStore,
      estimatedPrice: model.estimatedPrice,
      sourceUrl: model.sourceUrl,
      imageUrl: model.imageUrl,
      wantsToJoin: model.wantsToJoin,
      status: model.status,
      adminNotes: model.adminNotes,
      convertedGroupBuyId: model.convertedGroupBuyId,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static GroupBuyRequestModel fromEntity(GroupBuyRequest entity) {
    return GroupBuyRequestModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      description: entity.description,
      brandOrStore: entity.brandOrStore,
      estimatedPrice: entity.estimatedPrice,
      sourceUrl: entity.sourceUrl,
      imageUrl: entity.imageUrl,
      wantsToJoin: entity.wantsToJoin,
      status: entity.status,
      adminNotes: entity.adminNotes,
      convertedGroupBuyId: entity.convertedGroupBuyId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
