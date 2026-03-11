// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_buy_contribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupBuyContribution _$GroupBuyContributionFromJson(
  Map<String, dynamic> json,
) => _GroupBuyContribution(
  id: json['id'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  amount: (json['amount'] as num).toInt(),
  journalId: json['journalId'] as String?,
  deliveryAddress: json['deliveryAddress'] as String?,
  contributedAt: DateTime.parse(json['contributedAt'] as String),
);

Map<String, dynamic> _$GroupBuyContributionToJson(
  _GroupBuyContribution instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'amount': instance.amount,
  'journalId': instance.journalId,
  'deliveryAddress': instance.deliveryAddress,
  'contributedAt': instance.contributedAt.toIso8601String(),
};
