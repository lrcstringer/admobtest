// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubAccountModelImpl _$$SubAccountModelImplFromJson(
  Map<String, dynamic> json,
) => _$SubAccountModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  accountTypeId: json['accountTypeId'] as String?,
  name: json['name'] as String,
  balance: (json['balance'] as num).toInt(),
  lifetimeCredits: (json['lifetimeCredits'] as num).toInt(),
  lifetimeDebits: (json['lifetimeDebits'] as num).toInt(),
  isActive: json['isActive'] as bool,
  isDefault: json['isDefault'] as bool,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  allowP2pSend: json['allowP2pSend'] as bool? ?? true,
  allowP2pReceive: json['allowP2pReceive'] as bool? ?? true,
  allowCashout: json['allowCashout'] as bool? ?? true,
  p2pRestrictToSameAccountType:
      json['p2pRestrictToSameAccountType'] as bool? ?? false,
  allowedOfframps:
      (json['allowedOfframps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const ["*"],
  expiryDays: (json['expiryDays'] as num?)?.toInt(),
  lastCreditAt: const NullableTimestampConverter().fromJson(
    json['lastCreditAt'],
  ),
);

Map<String, dynamic> _$$SubAccountModelImplToJson(
  _$SubAccountModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'accountTypeId': instance.accountTypeId,
  'name': instance.name,
  'balance': instance.balance,
  'lifetimeCredits': instance.lifetimeCredits,
  'lifetimeDebits': instance.lifetimeDebits,
  'isActive': instance.isActive,
  'isDefault': instance.isDefault,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'allowP2pSend': instance.allowP2pSend,
  'allowP2pReceive': instance.allowP2pReceive,
  'allowCashout': instance.allowCashout,
  'p2pRestrictToSameAccountType': instance.p2pRestrictToSameAccountType,
  'allowedOfframps': instance.allowedOfframps,
  'expiryDays': instance.expiryDays,
  'lastCreditAt': const NullableTimestampConverter().toJson(
    instance.lastCreditAt,
  ),
};
