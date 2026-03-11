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
      servicesDescription: json['servicesDescription'] as String?,
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
  'servicesDescription': instance.servicesDescription,
  'status': _$ProviderStatusEnumMap[instance.status]!,
  'trustScore': instance.trustScore,
  'vouchCount': instance.vouchCount,
  'completedOrders': instance.completedOrders,
  'isVerified': instance.isVerified,
  'isVerifiedOverride': instance.isVerifiedOverride,
  'customerIds': instance.customerIds,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$ProviderStatusEnumMap = {
  ProviderStatus.pending: 'pending',
  ProviderStatus.approved: 'approved',
  ProviderStatus.suspended: 'suspended',
  ProviderStatus.rejected: 'rejected',
};
