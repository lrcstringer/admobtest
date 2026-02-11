import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/reward_item.dart';
import '../../domain/enums/reward_enums.dart';

part 'reward_item_model.freezed.dart';

@freezed
class RewardItemModel with _$RewardItemModel {
  const factory RewardItemModel({
    required String id,
    required String campaignId,
    String? campaignName,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String? rewardType,
    required String status,
    // Only populated on detail fetch (decrypted server-side)
    String? codeValue,
    DateTime? allocatedAt,
    DateTime? redeemedAt,
    DateTime? expiresAt,
    String? redemptionLocation,
    @Default({}) Map<String, dynamic> campaignMetadata,
    @Default({}) Map<String, dynamic> itemMetadata,
  }) = _RewardItemModel;

  const RewardItemModel._();

  factory RewardItemModel.fromJson(Map<String, dynamic> json) {
    return RewardItemModel(
      id: json['id'] as String,
      campaignId: json['campaignId'] as String,
      campaignName: json['campaignName'] as String?,
      clientName: json['clientName'] as String?,
      clientAvatarImage: json['clientAvatarImage'] as String?,
      clientAvatarColor: json['clientAvatarColor'] as String?,
      rewardType: json['rewardType'] as String?,
      status: json['status'] as String? ?? 'available',
      codeValue: json['codeValue'] as String?,
      allocatedAt: json['allocatedAt'] != null
          ? _parseDateTime(json['allocatedAt'])
          : null,
      redeemedAt: json['redeemedAt'] != null
          ? _parseDateTime(json['redeemedAt'])
          : null,
      expiresAt: json['expiresAt'] != null
          ? _parseDateTime(json['expiresAt'])
          : null,
      redemptionLocation: json['redemptionLocation'] as String?,
      campaignMetadata:
          (json['campaignMetadata'] as Map<String, dynamic>?) ?? {},
      itemMetadata: (json['itemMetadata'] as Map<String, dynamic>?) ??
          (json['metadata'] as Map<String, dynamic>?) ??
          {},
    );
  }

  RewardItem toEntity() {
    return RewardItem(
      id: id,
      campaignId: campaignId,
      campaignName: campaignName,
      clientName: clientName,
      clientAvatarImage: clientAvatarImage,
      clientAvatarColor: clientAvatarColor,
      rewardType:
          rewardType != null ? RewardTypeX.fromString(rewardType!) : null,
      status: RewardItemStatusX.fromString(status),
      codeValue: codeValue,
      allocatedAt: allocatedAt,
      redeemedAt: redeemedAt,
      expiresAt: expiresAt,
      redemptionLocation: redemptionLocation,
      campaignMetadata: campaignMetadata,
      itemMetadata: itemMetadata,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    if (value is DateTime) return value;
    return DateTime.now();
  }
}
