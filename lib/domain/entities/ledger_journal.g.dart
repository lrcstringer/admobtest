// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerEntryImpl _$$LedgerEntryImplFromJson(Map<String, dynamic> json) =>
    _$LedgerEntryImpl(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      entryType: $enumDecode(_$LedgerEntryTypeEnumMap, json['entryType']),
      amount: (json['amount'] as num).toInt(),
      balanceAfter: (json['balanceAfter'] as num).toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$LedgerEntryImplToJson(_$LedgerEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'entryType': _$LedgerEntryTypeEnumMap[instance.entryType]!,
      'amount': instance.amount,
      'balanceAfter': instance.balanceAfter,
      'description': instance.description,
    };

const _$LedgerEntryTypeEnumMap = {
  LedgerEntryType.debit: 'debit',
  LedgerEntryType.credit: 'credit',
};

_$LedgerJournalImpl _$$LedgerJournalImplFromJson(Map<String, dynamic> json) =>
    _$LedgerJournalImpl(
      id: json['id'] as String,
      idempotencyKey: json['idempotencyKey'] as String,
      type: $enumDecode(_$LedgerJournalTypeEnumMap, json['type']),
      status: $enumDecode(_$LedgerJournalStatusEnumMap, json['status']),
      description: json['description'] as String,
      entries: (json['entries'] as List<dynamic>)
          .map((e) => LedgerEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDebits: (json['totalDebits'] as num).toInt(),
      totalCredits: (json['totalCredits'] as num).toInt(),
      referenceType: $enumDecodeNullable(
        _$LedgerReferenceTypeEnumMap,
        json['referenceType'],
      ),
      referenceId: json['referenceId'] as String?,
      initiatedBy: json['initiatedBy'] as String,
      approvedBy: json['approvedBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      postedAt: json['postedAt'] == null
          ? null
          : DateTime.parse(json['postedAt'] as String),
      reversedAt: json['reversedAt'] == null
          ? null
          : DateTime.parse(json['reversedAt'] as String),
      reversedBy: json['reversedBy'] as String?,
      reversalJournalId: json['reversalJournalId'] as String?,
      originalJournalId: json['originalJournalId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$LedgerJournalImplToJson(_$LedgerJournalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idempotencyKey': instance.idempotencyKey,
      'type': _$LedgerJournalTypeEnumMap[instance.type]!,
      'status': _$LedgerJournalStatusEnumMap[instance.status]!,
      'description': instance.description,
      'entries': instance.entries,
      'totalDebits': instance.totalDebits,
      'totalCredits': instance.totalCredits,
      'referenceType': _$LedgerReferenceTypeEnumMap[instance.referenceType],
      'referenceId': instance.referenceId,
      'initiatedBy': instance.initiatedBy,
      'approvedBy': instance.approvedBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'postedAt': instance.postedAt?.toIso8601String(),
      'reversedAt': instance.reversedAt?.toIso8601String(),
      'reversedBy': instance.reversedBy,
      'reversalJournalId': instance.reversalJournalId,
      'originalJournalId': instance.originalJournalId,
      'metadata': instance.metadata,
    };

const _$LedgerJournalTypeEnumMap = {
  LedgerJournalType.earn: 'earn',
  LedgerJournalType.potContribution: 'potContribution',
  LedgerJournalType.potWin: 'potWin',
  LedgerJournalType.purchase: 'purchase',
  LedgerJournalType.referralReward: 'referralReward',
  LedgerJournalType.p2pTransfer: 'p2pTransfer',
  LedgerJournalType.cashoutInitiate: 'cashoutInitiate',
  LedgerJournalType.cashoutComplete: 'cashoutComplete',
  LedgerJournalType.cashoutFailed: 'cashoutFailed',
  LedgerJournalType.reversal: 'reversal',
  LedgerJournalType.adjustment: 'adjustment',
  LedgerJournalType.clientFund: 'clientFund',
  LedgerJournalType.clientRefund: 'clientRefund',
  LedgerJournalType.subaccFund: 'subaccFund',
};

const _$LedgerJournalStatusEnumMap = {
  LedgerJournalStatus.pending: 'pending',
  LedgerJournalStatus.posted: 'posted',
  LedgerJournalStatus.failed: 'failed',
  LedgerJournalStatus.reversed: 'reversed',
};

const _$LedgerReferenceTypeEnumMap = {
  LedgerReferenceType.engagement: 'engagement',
  LedgerReferenceType.purchase: 'purchase',
  LedgerReferenceType.referral: 'referral',
  LedgerReferenceType.transfer: 'transfer',
  LedgerReferenceType.cashout: 'cashout',
  LedgerReferenceType.potDraw: 'potDraw',
  LedgerReferenceType.potEntry: 'potEntry',
  LedgerReferenceType.clientFund: 'clientFund',
};
