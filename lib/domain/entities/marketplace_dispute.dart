import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/dispute_reason.dart';
import '../enums/dispute_resolution.dart';

part 'marketplace_dispute.freezed.dart';
part 'marketplace_dispute.g.dart';

/// Dispute details embedded within a [BuyOrder].
/// Tracks buyer concern, seller response, and admin resolution.
@freezed
class MarketplaceDispute with _$MarketplaceDispute {
  const factory MarketplaceDispute({
    required DisputeReason reason,
    required String details,
    @Default([]) List<String> photos,
    String? sellerResponse,
    @Default([]) List<String> sellerPhotos,
    String? proposedResolution,
    DisputeResolution? resolution,
    int? resolutionAmount,
    String? resolutionNote,
    DateTime? openedAt,
    DateTime? sellerRespondedAt,
    DateTime? resolvedAt,
  }) = _MarketplaceDispute;

  const MarketplaceDispute._();

  factory MarketplaceDispute.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceDisputeFromJson(json);

  bool get isResolved => resolution != null;
  bool get hasSellerResponse => sellerResponse != null;
  bool get isAwaitingSellerResponse =>
      !isResolved && !hasSellerResponse;
}
