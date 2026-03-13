import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/group_buy_request_status.dart';

part 'group_buy_request.freezed.dart';

/// A user-submitted suggestion for a group buy deal.
@freezed
abstract class GroupBuyRequest with _$GroupBuyRequest {
  const factory GroupBuyRequest({
    required String id,
    required String userId,
    required String userName,

    /// Freetext description of the desired deal
    required String description,

    /// Brand or store name
    required String brandOrStore,

    /// Estimated price in tokens (optional)
    int? estimatedPrice,

    /// Link to the product/deal online
    String? sourceUrl,

    /// Optional image URL for the product
    String? imageUrl,

    /// Whether the suggester wants to be first to join
    @Default(true) bool wantsToJoin,

    required GroupBuyRequestStatus status,

    /// Admin notes (reason for approval/decline)
    String? adminNotes,

    /// If approved, the ID of the created group buy
    String? convertedGroupBuyId,

    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _GroupBuyRequest;

  const GroupBuyRequest._();


  bool get isPending => status == GroupBuyRequestStatus.pending;
}
