import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/group_buy_request.dart';
import '../../domain/enums/group_buy_request_status.dart';

part 'group_buy_request_model.freezed.dart';

@freezed
class GroupBuyRequestModel with _$GroupBuyRequestModel {
  const factory GroupBuyRequestModel({
    required String id,
    required String userId,
    required String userName,
    required String description,
    required String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    @Default(true) bool wantsToJoin,
    required GroupBuyRequestStatus status,
    String? adminNotes,
    String? convertedGroupBuyId,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _GroupBuyRequestModel;

  const GroupBuyRequestModel._();

  factory GroupBuyRequestModel.fromJson(Map<String, dynamic> json) {
    return GroupBuyRequestModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      brandOrStore: json['brandOrStore'] as String? ?? '',
      estimatedPrice: (json['estimatedPrice'] as num?)?.toInt(),
      sourceUrl: json['sourceUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      wantsToJoin: json['wantsToJoin'] as bool? ?? true,
      status: _parseStatus(json['status'] as String?),
      adminNotes: json['adminNotes'] as String?,
      convertedGroupBuyId: json['convertedGroupBuyId'] as String?,
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  factory GroupBuyRequestModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GroupBuyRequestModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'userId': userId,
      'userName': userName,
      'description': description,
      'brandOrStore': brandOrStore,
      if (estimatedPrice != null) 'estimatedPrice': estimatedPrice,
      if (sourceUrl != null) 'sourceUrl': sourceUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'wantsToJoin': wantsToJoin,
      'status': status.name,
      if (adminNotes != null) 'adminNotes': adminNotes,
      if (convertedGroupBuyId != null)
        'convertedGroupBuyId': convertedGroupBuyId,
      'createdAt': Timestamp.fromDate(createdAt),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  factory GroupBuyRequestModel.fromEntity(GroupBuyRequest entity) {
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

  GroupBuyRequest toEntity() {
    return GroupBuyRequest(
      id: id,
      userId: userId,
      userName: userName,
      description: description,
      brandOrStore: brandOrStore,
      estimatedPrice: estimatedPrice,
      sourceUrl: sourceUrl,
      imageUrl: imageUrl,
      wantsToJoin: wantsToJoin,
      status: status,
      adminNotes: adminNotes,
      convertedGroupBuyId: convertedGroupBuyId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

GroupBuyRequestStatus _parseStatus(String? value) {
  switch (value) {
    case 'approved':
      return GroupBuyRequestStatus.approved;
    case 'declined':
    case 'rejected':
      return GroupBuyRequestStatus.declined;
    default:
      return GroupBuyRequestStatus.pending;
  }
}

DateTime? _parseDateTime(dynamic raw) {
  if (raw == null) return null;
  if (raw is Timestamp) return raw.toDate();
  if (raw is String) return DateTime.parse(raw);
  if (raw is DateTime) return raw;
  return null;
}
