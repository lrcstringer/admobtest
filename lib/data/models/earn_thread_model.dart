import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/earn_thread.dart';

part 'earn_thread_model.freezed.dart';

@freezed
class EarnThreadModel with _$EarnThreadModel {
  const factory EarnThreadModel({
    required String id,
    required String brandId,
    required String brandName,
    String? avatarColor,
    String? avatarImage,
    required bool isPinned,
    required bool isActive,
    required int availableOpportunities,
    required int completedOpportunities,
    required DateTime createdAt,
    DateTime? lastActivityAt,
  }) = _EarnThreadModel;

  const EarnThreadModel._();

  factory EarnThreadModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final lastActivityAt = json['lastActivityAt'];

    return EarnThreadModel(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      avatarColor: json['avatarColor'] as String?,
      avatarImage: json['avatarImage'] as String?,
      isPinned: json['isPinned'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      availableOpportunities: json['availableOpportunities'] as int? ?? 0,
      completedOpportunities: json['completedOpportunities'] as int? ?? 0,
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      lastActivityAt: lastActivityAt == null
          ? null
          : lastActivityAt is Timestamp
              ? lastActivityAt.toDate()
              : DateTime.parse(lastActivityAt as String),
    );
  }

  EarnThread toEntity() {
    return EarnThread(
      id: id,
      brandId: brandId,
      brandName: brandName,
      avatarColor: avatarColor,
      avatarImage: avatarImage,
      isPinned: isPinned,
      isActive: isActive,
      availableOpportunities: availableOpportunities,
      completedOpportunities: completedOpportunities,
      createdAt: createdAt,
      lastActivityAt: lastActivityAt,
    );
  }

  factory EarnThreadModel.fromEntity(EarnThread entity) {
    return EarnThreadModel(
      id: entity.id,
      brandId: entity.brandId,
      brandName: entity.brandName,
      avatarColor: entity.avatarColor,
      avatarImage: entity.avatarImage,
      isPinned: entity.isPinned,
      isActive: entity.isActive,
      availableOpportunities: entity.availableOpportunities,
      completedOpportunities: entity.completedOpportunities,
      createdAt: entity.createdAt,
      lastActivityAt: entity.lastActivityAt,
    );
  }
}
