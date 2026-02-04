// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubAccountImpl _$$SubAccountImplFromJson(Map<String, dynamic> json) =>
    _$SubAccountImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      accountTypeId: json['accountTypeId'] as String?,
      name: json['name'] as String,
      balance: (json['balance'] as num).toInt(),
      lifetimeCredits: (json['lifetimeCredits'] as num).toInt(),
      lifetimeDebits: (json['lifetimeDebits'] as num).toInt(),
      isActive: json['isActive'] as bool,
      isDefault: json['isDefault'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SubAccountImplToJson(_$SubAccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'accountTypeId': instance.accountTypeId,
      'name': instance.name,
      'balance': instance.balance,
      'lifetimeCredits': instance.lifetimeCredits,
      'lifetimeDebits': instance.lifetimeDebits,
      'isActive': instance.isActive,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
