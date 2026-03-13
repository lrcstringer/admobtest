import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/reward_campaign.dart';
import '../../domain/enums/reward_enums.dart';

part 'reward_campaign_model.freezed.dart';

@freezed
abstract class RewardCampaignModel with _$RewardCampaignModel {
  const factory RewardCampaignModel({
    required String id,
    required String clientId,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    required String name,
    String? description,
    required String rewardType,
    required String status,
    required int totalQuantity,
    required int remainingQuantity,
    @Default(0) int allocatedQuantity,
    @Default(0) int redeemedQuantity,
    @Default(1) int maxPerUser,
    required DateTime startsAt,
    required DateTime endsAt,
    DateTime? itemExpiresAt,
    String? displayImageUrl,
    @Default(0) int displayPriority,
    @Default({}) Map<String, dynamic> metadata,
    @Default([]) List<String> linkedOpportunityIds,
    required DateTime createdAt,
  }) = _RewardCampaignModel;

  const RewardCampaignModel._();

  factory RewardCampaignModel.fromJson(Map<String, dynamic> json) {
    return RewardCampaignModel(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String?,
      clientAvatarImage: json['clientAvatarImage'] as String?,
      clientAvatarColor: json['clientAvatarColor'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      rewardType: json['rewardType'] as String? ?? 'custom',
      status: json['status'] as String? ?? 'draft',
      totalQuantity: json['totalQuantity'] as int? ?? 0,
      remainingQuantity: json['remainingQuantity'] as int? ?? 0,
      allocatedQuantity: json['allocatedQuantity'] as int? ?? 0,
      redeemedQuantity: json['redeemedQuantity'] as int? ?? 0,
      maxPerUser: json['maxPerUser'] as int? ?? 1,
      startsAt: _parseDateTime(json['startsAt']),
      endsAt: _parseDateTime(json['endsAt']),
      itemExpiresAt: json['itemExpiresAt'] != null
          ? _parseDateTime(json['itemExpiresAt'])
          : null,
      displayImageUrl: json['displayImageUrl'] as String?,
      displayPriority: json['displayPriority'] as int? ?? 0,
      metadata: (json['metadata'] as Map<String, dynamic>?) ?? {},
      linkedOpportunityIds: (json['linkedOpportunityIds'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  RewardCampaign toEntity() {
    return RewardCampaign(
      id: id,
      clientId: clientId,
      clientName: clientName,
      clientAvatarImage: clientAvatarImage,
      clientAvatarColor: clientAvatarColor,
      name: name,
      description: description,
      rewardType: RewardTypeX.fromString(rewardType),
      status: CampaignStatusX.fromString(status),
      totalQuantity: totalQuantity,
      remainingQuantity: remainingQuantity,
      allocatedQuantity: allocatedQuantity,
      redeemedQuantity: redeemedQuantity,
      maxPerUser: maxPerUser,
      startsAt: startsAt,
      endsAt: endsAt,
      itemExpiresAt: itemExpiresAt,
      displayImageUrl: displayImageUrl,
      displayPriority: displayPriority,
      metadata: metadata,
      linkedOpportunityIds: linkedOpportunityIds,
      createdAt: createdAt,
    );
  }

  factory RewardCampaignModel.fromEntity(RewardCampaign entity) {
    return RewardCampaignModel(
      id: entity.id,
      clientId: entity.clientId,
      clientName: entity.clientName,
      clientAvatarImage: entity.clientAvatarImage,
      clientAvatarColor: entity.clientAvatarColor,
      name: entity.name,
      description: entity.description,
      rewardType: entity.rewardType.firestoreValue,
      status: entity.status.name,
      totalQuantity: entity.totalQuantity,
      remainingQuantity: entity.remainingQuantity,
      allocatedQuantity: entity.allocatedQuantity,
      redeemedQuantity: entity.redeemedQuantity,
      maxPerUser: entity.maxPerUser,
      startsAt: entity.startsAt,
      endsAt: entity.endsAt,
      itemExpiresAt: entity.itemExpiresAt,
      displayImageUrl: entity.displayImageUrl,
      displayPriority: entity.displayPriority,
      metadata: entity.metadata,
      linkedOpportunityIds: entity.linkedOpportunityIds,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'id': id,
      'clientId': clientId,
      'clientName': clientName,
      'clientAvatarImage': clientAvatarImage,
      'clientAvatarColor': clientAvatarColor,
      'name': name,
      'description': description,
      'rewardType': rewardType,
      'status': status,
      'totalQuantity': totalQuantity,
      'remainingQuantity': remainingQuantity,
      'allocatedQuantity': allocatedQuantity,
      'redeemedQuantity': redeemedQuantity,
      'maxPerUser': maxPerUser,
      'startsAt': Timestamp.fromDate(startsAt),
      'endsAt': Timestamp.fromDate(endsAt),
      if (itemExpiresAt != null)
        'itemExpiresAt': Timestamp.fromDate(itemExpiresAt!),
      'displayImageUrl': displayImageUrl,
      'displayPriority': displayPriority,
      'metadata': metadata,
      'linkedOpportunityIds': linkedOpportunityIds,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    if (value is DateTime) return value;
    return DateTime.now();
  }
}
