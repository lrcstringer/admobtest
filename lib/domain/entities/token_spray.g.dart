// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_spray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SprayContributionImpl _$$SprayContributionImplFromJson(
  Map<String, dynamic> json,
) => _$SprayContributionImpl(
  amount: (json['amount'] as num).toInt(),
  contributedAt: DateTime.parse(json['contributedAt'] as String),
  displayName: json['displayName'] as String,
  message: json['message'] as String?,
);

Map<String, dynamic> _$$SprayContributionImplToJson(
  _$SprayContributionImpl instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'contributedAt': instance.contributedAt.toIso8601String(),
  'displayName': instance.displayName,
  'message': instance.message,
};

_$SprayTopContributorImpl _$$SprayTopContributorImplFromJson(
  Map<String, dynamic> json,
) => _$SprayTopContributorImpl(
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  amount: (json['amount'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
);

Map<String, dynamic> _$$SprayTopContributorImplToJson(
  _$SprayTopContributorImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'displayName': instance.displayName,
  'amount': instance.amount,
  'rank': instance.rank,
};

_$TokenSprayImpl _$$TokenSprayImplFromJson(Map<String, dynamic> json) =>
    _$TokenSprayImpl(
      id: json['id'] as String,
      communityId: json['communityId'] as String,
      communityName: json['communityName'] as String,
      messageId: json['messageId'] as String,
      creatorId: json['creatorId'] as String,
      creatorName: json['creatorName'] as String,
      recipientId: json['recipientId'] as String,
      recipientName: json['recipientName'] as String,
      occasion: $enumDecode(_$SprayOccasionEnumMap, json['occasion']),
      occasionText: json['occasionText'] as String,
      message: json['message'] as String,
      targetAmount: (json['targetAmount'] as num?)?.toInt(),
      currentTotal: (json['currentTotal'] as num).toInt(),
      contributions: (json['contributions'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, SprayContribution.fromJson(e as Map<String, dynamic>)),
      ),
      contributorCount: (json['contributorCount'] as num).toInt(),
      topContributors:
          (json['topContributors'] as List<dynamic>?)
              ?.map(
                (e) => SprayTopContributor.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      status: $enumDecode(_$SprayStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
      claimedAt: json['claimedAt'] == null
          ? null
          : DateTime.parse(json['claimedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$TokenSprayImplToJson(_$TokenSprayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'communityId': instance.communityId,
      'communityName': instance.communityName,
      'messageId': instance.messageId,
      'creatorId': instance.creatorId,
      'creatorName': instance.creatorName,
      'recipientId': instance.recipientId,
      'recipientName': instance.recipientName,
      'occasion': _$SprayOccasionEnumMap[instance.occasion]!,
      'occasionText': instance.occasionText,
      'message': instance.message,
      'targetAmount': instance.targetAmount,
      'currentTotal': instance.currentTotal,
      'contributions': instance.contributions,
      'contributorCount': instance.contributorCount,
      'topContributors': instance.topContributors,
      'status': _$SprayStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
      'claimedAt': instance.claimedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

const _$SprayOccasionEnumMap = {
  SprayOccasion.newJob: 'newJob',
  SprayOccasion.birthday: 'birthday',
  SprayOccasion.graduation: 'graduation',
  SprayOccasion.newBaby: 'newBaby',
  SprayOccasion.wedding: 'wedding',
  SprayOccasion.achievement: 'achievement',
  SprayOccasion.custom: 'custom',
};

const _$SprayStatusEnumMap = {
  SprayStatus.active: 'active',
  SprayStatus.closed: 'closed',
  SprayStatus.claimed: 'claimed',
  SprayStatus.expired: 'expired',
};
