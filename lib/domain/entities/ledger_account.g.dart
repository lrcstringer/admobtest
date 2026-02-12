// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerAccountImpl _$$LedgerAccountImplFromJson(Map<String, dynamic> json) =>
    _$LedgerAccountImpl(
      id: json['id'] as String,
      type: $enumDecode(_$LedgerAccountTypeEnumMap, json['type']),
      name: json['name'] as String,
      ownerId: json['ownerId'] as String?,
      balance: (json['balance'] as num).toInt(),
      currency: json['currency'] as String? ?? 'TOKEN',
      status: $enumDecode(_$LedgerAccountStatusEnumMap, json['status']),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$LedgerAccountImplToJson(_$LedgerAccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$LedgerAccountTypeEnumMap[instance.type]!,
      'name': instance.name,
      'ownerId': instance.ownerId,
      'balance': instance.balance,
      'currency': instance.currency,
      'status': _$LedgerAccountStatusEnumMap[instance.status]!,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };

const _$LedgerAccountTypeEnumMap = {
  LedgerAccountType.system: 'system',
  LedgerAccountType.pot: 'pot',
  LedgerAccountType.user: 'user',
  LedgerAccountType.supplier: 'supplier',
  LedgerAccountType.cbook: 'cbook',
  LedgerAccountType.clientSubacc: 'clientSubacc',
  LedgerAccountType.client: 'client',
  LedgerAccountType.group: 'group',
};

const _$LedgerAccountStatusEnumMap = {
  LedgerAccountStatus.active: 'active',
  LedgerAccountStatus.frozen: 'frozen',
  LedgerAccountStatus.closed: 'closed',
};
