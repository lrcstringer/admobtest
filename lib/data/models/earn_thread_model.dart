import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/earn_thread.dart';
import '../../domain/entities/targeting_criteria.dart';

part 'earn_thread_model.freezed.dart';

@freezed
class EarnThreadModel with _$EarnThreadModel {
  const factory EarnThreadModel({
    required String id,
    // Client fields
    required String clientId,
    required String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    // Thread display
    required String title,
    String? description,
    // Flags
    required bool isPinned,
    required bool isFeatured,
    required bool isActive,
    // Scheduling
    DateTime? activeFrom,
    DateTime? activeTo,
    // Token configuration
    String? tokenSourceSubAccountId,
    String? tokenDestAccountTypeId,
    // Counts
    required int availableOpportunities,
    required int completedOpportunities,
    @Default(0) int completedUniqueUsers,
    // Timestamps
    required DateTime createdAt,
    DateTime? lastActivityAt,
    // Targeting (stored as JSON map)
    Map<String, dynamic>? targeting,
  }) = _EarnThreadModel;

  const EarnThreadModel._();

  factory EarnThreadModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final lastActivityAt = json['lastActivityAt'];
    final activeFrom = json['activeFrom'];
    final activeTo = json['activeTo'];

    return EarnThreadModel(
      id: json['id'] as String,
      clientId: json['clientId'] as String? ?? json['brandId'] as String? ?? '',
      clientName: json['clientName'] as String? ?? json['brandName'] as String? ?? '',
      clientAvatarImage: json['clientAvatarImage'] as String? ?? json['avatarImage'] as String?,
      clientAvatarColor: json['clientAvatarColor'] as String? ?? json['avatarColor'] as String?,
      title: json['title'] as String? ?? json['clientName'] as String? ?? json['brandName'] as String? ?? '',
      description: json['description'] as String?,
      isPinned: json['isPinned'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      activeFrom: activeFrom == null
          ? null
          : activeFrom is Timestamp
              ? activeFrom.toDate()
              : DateTime.parse(activeFrom as String),
      activeTo: activeTo == null
          ? null
          : activeTo is Timestamp
              ? activeTo.toDate()
              : DateTime.parse(activeTo as String),
      tokenSourceSubAccountId: json['tokenSourceSubAccountId'] as String?,
      tokenDestAccountTypeId: json['tokenDestAccountTypeId'] as String?,
      availableOpportunities: json['availableOpportunities'] as int? ?? 0,
      completedOpportunities: json['completedOpportunities'] as int? ?? 0,
      completedUniqueUsers: json['completedUniqueUsers'] as int? ?? 0,
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : createdAt != null
              ? DateTime.parse(createdAt as String)
              : DateTime.now(),
      lastActivityAt: lastActivityAt == null
          ? null
          : lastActivityAt is Timestamp
              ? lastActivityAt.toDate()
              : DateTime.parse(lastActivityAt as String),
      targeting: json['targeting'] as Map<String, dynamic>?,
    );
  }

  EarnThread toEntity() {
    return EarnThread(
      id: id,
      clientId: clientId,
      clientName: clientName,
      clientAvatarImage: clientAvatarImage,
      clientAvatarColor: clientAvatarColor,
      title: title,
      description: description,
      isPinned: isPinned,
      isFeatured: isFeatured,
      isActive: isActive,
      activeFrom: activeFrom,
      activeTo: activeTo,
      tokenSourceSubAccountId: tokenSourceSubAccountId,
      tokenDestAccountTypeId: tokenDestAccountTypeId,
      availableOpportunities: availableOpportunities,
      completedOpportunities: completedOpportunities,
      completedUniqueUsers: completedUniqueUsers,
      createdAt: createdAt,
      lastActivityAt: lastActivityAt,
      targeting: targeting != null ? TargetingCriteria.fromJson(targeting!) : null,
    );
  }

  factory EarnThreadModel.fromEntity(EarnThread entity) {
    return EarnThreadModel(
      id: entity.id,
      clientId: entity.clientId,
      clientName: entity.clientName,
      clientAvatarImage: entity.clientAvatarImage,
      clientAvatarColor: entity.clientAvatarColor,
      title: entity.title,
      description: entity.description,
      isPinned: entity.isPinned,
      isFeatured: entity.isFeatured,
      isActive: entity.isActive,
      activeFrom: entity.activeFrom,
      activeTo: entity.activeTo,
      tokenSourceSubAccountId: entity.tokenSourceSubAccountId,
      tokenDestAccountTypeId: entity.tokenDestAccountTypeId,
      availableOpportunities: entity.availableOpportunities,
      completedOpportunities: entity.completedOpportunities,
      completedUniqueUsers: entity.completedUniqueUsers,
      createdAt: entity.createdAt,
      lastActivityAt: entity.lastActivityAt,
      targeting: entity.targeting?.toJson(),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'id': id,
      'clientId': clientId,
      'clientName': clientName,
      'clientAvatarImage': clientAvatarImage,
      'clientAvatarColor': clientAvatarColor,
      'title': title,
      'description': description,
      'isPinned': isPinned,
      'isFeatured': isFeatured,
      'isActive': isActive,
      'activeFrom': activeFrom != null ? Timestamp.fromDate(activeFrom!) : null,
      'activeTo': activeTo != null ? Timestamp.fromDate(activeTo!) : null,
      'tokenSourceSubAccountId': tokenSourceSubAccountId,
      'tokenDestAccountTypeId': tokenDestAccountTypeId,
      'availableOpportunities': availableOpportunities,
      'completedOpportunities': completedOpportunities,
      'completedUniqueUsers': completedUniqueUsers,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastActivityAt': lastActivityAt != null ? Timestamp.fromDate(lastActivityAt!) : null,
      'targeting': targeting,
    };
  }
}
