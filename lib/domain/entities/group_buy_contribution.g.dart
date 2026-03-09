// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_buy_contribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupBuyContributionImpl _$$GroupBuyContributionImplFromJson(
  Map<String, dynamic> json,
) => _$GroupBuyContributionImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  amount: (json['amount'] as num).toInt(),
  journalId: json['journalId'] as String?,
  contributedAt: DateTime.parse(json['contributedAt'] as String),
);

Map<String, dynamic> _$$GroupBuyContributionImplToJson(
  _$GroupBuyContributionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'amount': instance.amount,
  'journalId': instance.journalId,
  'contributedAt': instance.contributedAt.toIso8601String(),
};
