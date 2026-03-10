import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/group_buy.dart';
import '../../domain/enums/group_buy_status.dart';

part 'group_buy_model.freezed.dart';

@freezed
class GroupBuyModel with _$GroupBuyModel {
  const factory GroupBuyModel({
    required String id,
    required String title,
    required String description,
    String? linkedListingId,
    String? organizerId,
    String? organizerName,
    String? communityId,
    required int targetAmount,
    @Default(0) int currentAmount,
    @Default(1) int minParticipants,
    int? maxParticipants,
    required DateTime deadline,
    required GroupBuyStatus status,
    @Default(0) int participantCount,
    @Default('community') String sponsorType,
    String? brandId,
    String? brandName,
    String? brandLogoUrl,
    int? discountPercent,
    @Default(false) bool createdByAdmin,
    @Default(GroupBuyType.digital) GroupBuyType type,
    @Default(GroupBuyFulfilmentType.digital)
    GroupBuyFulfilmentType fulfilmentType,
    @Default([]) List<String> clusters,
    @Default([]) List<String> addresses,
    @Default([]) List<String> voucherCodes,
    String? imageUrl,
    int? originalPrice,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _GroupBuyModel;

  const GroupBuyModel._();

  factory GroupBuyModel.fromJson(Map<String, dynamic> json) {
    return GroupBuyModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      linkedListingId: json['linkedListingId'] as String?,
      organizerId: json['organizerId'] as String?,
      organizerName: json['organizerName'] as String?,
      communityId: json['communityId'] as String?,
      targetAmount: (json['targetAmount'] as num?)?.toInt() ?? 0,
      currentAmount: (json['currentAmount'] as num?)?.toInt() ?? 0,
      minParticipants: (json['minParticipants'] as num?)?.toInt() ?? 1,
      maxParticipants: (json['maxParticipants'] as num?)?.toInt(),
      deadline: _parseDateTime(json['deadline']) ?? DateTime.now(),
      status: _parseGroupBuyStatus(json['status'] as String?),
      participantCount: (json['participantCount'] as num?)?.toInt() ?? 0,
      sponsorType: json['sponsorType'] as String? ?? 'community',
      brandId: json['brandId'] as String?,
      brandName: json['brandName'] as String?,
      brandLogoUrl: json['brandLogoUrl'] as String?,
      discountPercent: (json['discountPercent'] as num?)?.toInt(),
      createdByAdmin: json['createdByAdmin'] as bool? ?? false,
      type: _parseGroupBuyType(json['type'] as String?),
      fulfilmentType:
          _parseGroupBuyFulfilmentType(json['fulfilmentType'] as String?),
      clusters: (json['clusters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      voucherCodes: (json['voucherCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageUrl: json['imageUrl'] as String?,
      originalPrice: (json['originalPrice'] as num?)?.toInt(),
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  factory GroupBuyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GroupBuyModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'title': title,
      'description': description,
      if (linkedListingId != null) 'linkedListingId': linkedListingId,
      if (organizerId != null) 'organizerId': organizerId,
      if (organizerName != null) 'organizerName': organizerName,
      if (communityId != null) 'communityId': communityId,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'minParticipants': minParticipants,
      if (maxParticipants != null) 'maxParticipants': maxParticipants,
      'deadline': Timestamp.fromDate(deadline),
      'status': status.name,
      'participantCount': participantCount,
      'sponsorType': sponsorType,
      if (brandId != null) 'brandId': brandId,
      if (brandName != null) 'brandName': brandName,
      if (brandLogoUrl != null) 'brandLogoUrl': brandLogoUrl,
      if (discountPercent != null) 'discountPercent': discountPercent,
      'createdByAdmin': createdByAdmin,
      'type': type.name,
      'fulfilmentType': fulfilmentType.name,
      if (clusters.isNotEmpty) 'clusters': clusters,
      if (addresses.isNotEmpty) 'addresses': addresses,
      if (voucherCodes.isNotEmpty) 'voucherCodes': voucherCodes,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (originalPrice != null) 'originalPrice': originalPrice,
      'createdAt': Timestamp.fromDate(createdAt),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  GroupBuy toEntity() {
    return GroupBuy(
      id: id,
      title: title,
      description: description,
      linkedListingId: linkedListingId,
      organizerId: organizerId,
      organizerName: organizerName,
      communityId: communityId,
      targetAmount: targetAmount,
      currentAmount: currentAmount,
      minParticipants: minParticipants,
      maxParticipants: maxParticipants,
      deadline: deadline,
      status: status,
      participantCount: participantCount,
      sponsorType: sponsorType,
      brandId: brandId,
      brandName: brandName,
      brandLogoUrl: brandLogoUrl,
      discountPercent: discountPercent,
      createdByAdmin: createdByAdmin,
      type: type,
      fulfilmentType: fulfilmentType,
      clusters: clusters,
      addresses: addresses,
      voucherCodes: voucherCodes,
      imageUrl: imageUrl,
      originalPrice: originalPrice,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory GroupBuyModel.fromEntity(GroupBuy entity) {
    return GroupBuyModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      linkedListingId: entity.linkedListingId,
      organizerId: entity.organizerId,
      organizerName: entity.organizerName,
      communityId: entity.communityId,
      targetAmount: entity.targetAmount,
      currentAmount: entity.currentAmount,
      minParticipants: entity.minParticipants,
      maxParticipants: entity.maxParticipants,
      deadline: entity.deadline,
      status: entity.status,
      participantCount: entity.participantCount,
      sponsorType: entity.sponsorType,
      brandId: entity.brandId,
      brandName: entity.brandName,
      brandLogoUrl: entity.brandLogoUrl,
      discountPercent: entity.discountPercent,
      createdByAdmin: entity.createdByAdmin,
      type: entity.type,
      fulfilmentType: entity.fulfilmentType,
      clusters: entity.clusters,
      addresses: entity.addresses,
      voucherCodes: entity.voucherCodes,
      imageUrl: entity.imageUrl,
      originalPrice: entity.originalPrice,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

GroupBuyStatus _parseGroupBuyStatus(String? value) {
  switch (value) {
    case 'targetMet':
      return GroupBuyStatus.targetMet;
    case 'expired':
      return GroupBuyStatus.expired;
    case 'completed':
      return GroupBuyStatus.completed;
    case 'cancelled':
      return GroupBuyStatus.cancelled;
    default:
      return GroupBuyStatus.open;
  }
}

GroupBuyType _parseGroupBuyType(String? value) {
  if (value == null) return GroupBuyType.digital;
  return GroupBuyType.values.firstWhere(
    (e) => e.name == value,
    orElse: () => GroupBuyType.digital,
  );
}

GroupBuyFulfilmentType _parseGroupBuyFulfilmentType(String? value) {
  if (value == null) return GroupBuyFulfilmentType.digital;
  return GroupBuyFulfilmentType.values.firstWhere(
    (e) => e.name == value,
    orElse: () => GroupBuyFulfilmentType.digital,
  );
}

DateTime? _parseDateTime(dynamic raw) {
  if (raw == null) return null;
  if (raw is Timestamp) return raw.toDate();
  if (raw is String) return DateTime.parse(raw);
  if (raw is DateTime) return raw;
  return null;
}
