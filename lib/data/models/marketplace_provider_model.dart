import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/marketplace_provider.dart';
import '../../domain/enums/provider_status.dart';

part 'marketplace_provider_model.freezed.dart';

@freezed
class MarketplaceProviderModel with _$MarketplaceProviderModel {
  const factory MarketplaceProviderModel({
    required String id,
    required String userId,
    required String displayName,
    String? bio,
    String? photoUrl,
    String? communityId,
    String? servicesDescription,
    required ProviderStatus status,
    @Default(0.0) double trustScore,
    @Default(0) int vouchCount,
    @Default(0) int completedOrders,
    @Default(false) bool isVerified,
    bool? isVerifiedOverride,
    @Default([]) List<String> customerIds,
    required DateTime createdAt,
  }) = _MarketplaceProviderModel;

  const MarketplaceProviderModel._();

  factory MarketplaceProviderModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceProviderModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      bio: json['bio'] as String?,
      photoUrl: json['photoUrl'] as String?,
      communityId: json['communityId'] as String?,
      servicesDescription: json['servicesDescription'] as String?,
      status: _parseProviderStatus(json['status'] as String?),
      trustScore: (json['trustScore'] as num?)?.toDouble() ?? 0.0,
      vouchCount: (json['vouchCount'] as num?)?.toInt() ?? 0,
      completedOrders: (json['completedOrders'] as num?)?.toInt() ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      isVerifiedOverride: json['isVerifiedOverride'] as bool?,
      customerIds: (json['customerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : json['createdAt'] is String
              ? (DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now())
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      if (bio != null) 'bio': bio,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (communityId != null) 'communityId': communityId,
      if (servicesDescription != null)
        'servicesDescription': servicesDescription,
      'status': status.name,
      'trustScore': trustScore,
      'vouchCount': vouchCount,
      'completedOrders': completedOrders,
      'isVerified': isVerified,
      if (isVerifiedOverride != null) 'isVerifiedOverride': isVerifiedOverride,
      'customerIds': customerIds,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  MarketplaceProvider toEntity() {
    return MarketplaceProvider(
      id: id,
      userId: userId,
      displayName: displayName,
      bio: bio,
      photoUrl: photoUrl,
      communityId: communityId,
      servicesDescription: servicesDescription,
      status: status,
      trustScore: trustScore,
      vouchCount: vouchCount,
      completedOrders: completedOrders,
      isVerified: isVerified,
      isVerifiedOverride: isVerifiedOverride,
      customerIds: customerIds,
      createdAt: createdAt,
    );
  }

  factory MarketplaceProviderModel.fromEntity(MarketplaceProvider entity) {
    return MarketplaceProviderModel(
      id: entity.id,
      userId: entity.userId,
      displayName: entity.displayName,
      bio: entity.bio,
      photoUrl: entity.photoUrl,
      communityId: entity.communityId,
      servicesDescription: entity.servicesDescription,
      status: entity.status,
      trustScore: entity.trustScore,
      vouchCount: entity.vouchCount,
      completedOrders: entity.completedOrders,
      isVerified: entity.isVerified,
      isVerifiedOverride: entity.isVerifiedOverride,
      customerIds: entity.customerIds,
      createdAt: entity.createdAt,
    );
  }
}

ProviderStatus _parseProviderStatus(String? value) {
  switch (value) {
    case 'approved':
      return ProviderStatus.approved;
    case 'suspended':
      return ProviderStatus.suspended;
    case 'rejected':
      return ProviderStatus.rejected;
    default:
      return ProviderStatus.pending;
  }
}
