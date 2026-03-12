// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketplaceProvider _$MarketplaceProviderFromJson(Map<String, dynamic> json) =>
    _MarketplaceProvider(
      id: json['id'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      bio: json['bio'] as String?,
      photoUrl: json['photoUrl'] as String?,
      communityId: json['communityId'] as String?,
      status: $enumDecode(_$ProviderStatusEnumMap, json['status']),
      trustScore: (json['trustScore'] as num?)?.toDouble() ?? 0.0,
      vouchCount: (json['vouchCount'] as num?)?.toInt() ?? 0,
      completedOrders: (json['completedOrders'] as num?)?.toInt() ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      isVerifiedOverride: json['isVerifiedOverride'] as bool?,
      customerIds:
          (json['customerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sellerLevel:
          $enumDecodeNullable(_$SellerLevelEnumMap, json['sellerLevel']) ??
          SellerLevel.newSeller,
      avgResponseTimeHrs: (json['avgResponseTimeHrs'] as num?)?.toDouble(),
      warningCount: (json['warningCount'] as num?)?.toInt() ?? 0,
      reportCount: (json['reportCount'] as num?)?.toInt() ?? 0,
      disputeRate: (json['disputeRate'] as num?)?.toDouble() ?? 0.0,
      cancellationRate: (json['cancellationRate'] as num?)?.toDouble() ?? 0.0,
      suspensionReason: json['suspensionReason'] as String?,
      suspensionTrigger: json['suspensionTrigger'] as String?,
      suspendedAt: json['suspendedAt'] == null
          ? null
          : DateTime.parse(json['suspendedAt'] as String),
      bannedAt: json['bannedAt'] == null
          ? null
          : DateTime.parse(json['bannedAt'] as String),
      profileLocation: json['profileLocation'] == null
          ? null
          : LocationData.fromJson(
              json['profileLocation'] as Map<String, dynamic>,
            ),
      servicesDescription: json['servicesDescription'] as String?,
    );

Map<String, dynamic> _$MarketplaceProviderToJson(
  _MarketplaceProvider instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'displayName': instance.displayName,
  'bio': instance.bio,
  'photoUrl': instance.photoUrl,
  'communityId': instance.communityId,
  'status': _$ProviderStatusEnumMap[instance.status]!,
  'trustScore': instance.trustScore,
  'vouchCount': instance.vouchCount,
  'completedOrders': instance.completedOrders,
  'isVerified': instance.isVerified,
  'isVerifiedOverride': instance.isVerifiedOverride,
  'customerIds': instance.customerIds,
  'createdAt': instance.createdAt.toIso8601String(),
  'categories': instance.categories,
  'subCategories': instance.subCategories,
  'sellerLevel': _$SellerLevelEnumMap[instance.sellerLevel]!,
  'avgResponseTimeHrs': instance.avgResponseTimeHrs,
  'warningCount': instance.warningCount,
  'reportCount': instance.reportCount,
  'disputeRate': instance.disputeRate,
  'cancellationRate': instance.cancellationRate,
  'suspensionReason': instance.suspensionReason,
  'suspensionTrigger': instance.suspensionTrigger,
  'suspendedAt': instance.suspendedAt?.toIso8601String(),
  'bannedAt': instance.bannedAt?.toIso8601String(),
  'profileLocation': instance.profileLocation,
  'servicesDescription': instance.servicesDescription,
};

const _$ProviderStatusEnumMap = {
  ProviderStatus.active: 'active',
  ProviderStatus.suspended: 'suspended',
  ProviderStatus.banned: 'banned',
};

const _$SellerLevelEnumMap = {
  SellerLevel.newSeller: 'newSeller',
  SellerLevel.active: 'active',
  SellerLevel.trusted: 'trusted',
  SellerLevel.star: 'star',
};
