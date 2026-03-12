import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/marketplace_provider.dart';
import '../../domain/entities/location_data.dart';
import '../../domain/enums/provider_status.dart';
import '../../domain/enums/seller_level.dart';

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
    // ── New fields (Spec §8.25) ──
    @Default([]) List<String> categories,
    List<String>? subCategories,
    @Default(SellerLevel.newSeller) SellerLevel sellerLevel,
    double? avgResponseTimeHrs,
    @Default(0) int warningCount,
    @Default(0) int reportCount,
    @Default(0.0) double disputeRate,
    @Default(0.0) double cancellationRate,
    String? suspensionReason,
    String? suspensionTrigger,
    DateTime? suspendedAt,
    DateTime? bannedAt,
    LocationData? profileLocation,
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
      // New fields (Spec §8.25)
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      subCategories: (json['subCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      sellerLevel: _parseSellerLevel(json['sellerLevel'] as String?),
      avgResponseTimeHrs:
          (json['avgResponseTimeHrs'] as num?)?.toDouble(),
      warningCount: (json['warningCount'] as num?)?.toInt() ?? 0,
      reportCount: (json['reportCount'] as num?)?.toInt() ?? 0,
      disputeRate: (json['disputeRate'] as num?)?.toDouble() ?? 0.0,
      cancellationRate:
          (json['cancellationRate'] as num?)?.toDouble() ?? 0.0,
      suspensionReason: json['suspensionReason'] as String?,
      suspensionTrigger: json['suspensionTrigger'] as String?,
      suspendedAt: json['suspendedAt'] is Timestamp
          ? (json['suspendedAt'] as Timestamp).toDate()
          : null,
      bannedAt: json['bannedAt'] is Timestamp
          ? (json['bannedAt'] as Timestamp).toDate()
          : null,
      profileLocation: json['profileLocation'] is Map<String, dynamic>
          ? LocationData.fromJson(
              json['profileLocation'] as Map<String, dynamic>)
          : null,
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
      // New fields (Spec §8.25)
      if (categories.isNotEmpty) 'categories': categories,
      if (subCategories != null) 'subCategories': subCategories,
      'sellerLevel': sellerLevel.name,
      if (avgResponseTimeHrs != null)
        'avgResponseTimeHrs': avgResponseTimeHrs,
      'warningCount': warningCount,
      'reportCount': reportCount,
      'disputeRate': disputeRate,
      'cancellationRate': cancellationRate,
      if (suspensionReason != null) 'suspensionReason': suspensionReason,
      if (suspensionTrigger != null) 'suspensionTrigger': suspensionTrigger,
      if (suspendedAt != null)
        'suspendedAt': Timestamp.fromDate(suspendedAt!),
      if (bannedAt != null) 'bannedAt': Timestamp.fromDate(bannedAt!),
      if (profileLocation != null)
        'profileLocation': profileLocation!.toJson(),
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
      categories: categories,
      subCategories: subCategories,
      sellerLevel: sellerLevel,
      avgResponseTimeHrs: avgResponseTimeHrs,
      warningCount: warningCount,
      reportCount: reportCount,
      disputeRate: disputeRate,
      cancellationRate: cancellationRate,
      suspensionReason: suspensionReason,
      suspensionTrigger: suspensionTrigger,
      suspendedAt: suspendedAt,
      bannedAt: bannedAt,
      profileLocation: profileLocation,
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
      categories: entity.categories,
      subCategories: entity.subCategories,
      sellerLevel: entity.sellerLevel,
      avgResponseTimeHrs: entity.avgResponseTimeHrs,
      warningCount: entity.warningCount,
      reportCount: entity.reportCount,
      disputeRate: entity.disputeRate,
      cancellationRate: entity.cancellationRate,
      suspensionReason: entity.suspensionReason,
      suspensionTrigger: entity.suspensionTrigger,
      suspendedAt: entity.suspendedAt,
      bannedAt: entity.bannedAt,
      profileLocation: entity.profileLocation,
    );
  }
}

ProviderStatus _parseProviderStatus(String? value) {
  return ProviderStatusX.fromString(value ?? 'active');
}

SellerLevel _parseSellerLevel(String? value) {
  if (value == null) return SellerLevel.newSeller;
  return SellerLevel.values.firstWhere(
    (e) => e.name == value,
    orElse: () => SellerLevel.newSeller,
  );
}
