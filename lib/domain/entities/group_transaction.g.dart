// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupTransactionImpl _$$GroupTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$GroupTransactionImpl(
  id: json['id'] as String,
  groupId: json['groupId'] as String,
  journalId: json['journalId'] as String?,
  type: $enumDecode(_$GroupTransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  fromMemberId: json['fromMemberId'] as String?,
  toMemberId: json['toMemberId'] as String?,
  description: json['description'] as String,
  status: $enumDecode(_$GroupTransactionStatusEnumMap, json['status']),
  approvedBy: json['approvedBy'] as String?,
  createdBy: json['createdBy'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$$GroupTransactionImplToJson(
  _$GroupTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'groupId': instance.groupId,
  'journalId': instance.journalId,
  'type': _$GroupTransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'fromMemberId': instance.fromMemberId,
  'toMemberId': instance.toMemberId,
  'description': instance.description,
  'status': _$GroupTransactionStatusEnumMap[instance.status]!,
  'approvedBy': instance.approvedBy,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
};

const _$GroupTransactionTypeEnumMap = {
  GroupTransactionType.contribution: 'contribution',
  GroupTransactionType.withdrawal: 'withdrawal',
  GroupTransactionType.transferIn: 'transfer_in',
  GroupTransactionType.transferOut: 'transfer_out',
  GroupTransactionType.penalty: 'penalty',
  GroupTransactionType.payout: 'payout',
};

const _$GroupTransactionStatusEnumMap = {
  GroupTransactionStatus.pending: 'pending',
  GroupTransactionStatus.approved: 'approved',
  GroupTransactionStatus.completed: 'completed',
  GroupTransactionStatus.rejected: 'rejected',
};

_$PendingApprovalImpl _$$PendingApprovalImplFromJson(
  Map<String, dynamic> json,
) => _$PendingApprovalImpl(
  id: json['id'] as String,
  groupId: json['groupId'] as String,
  transactionId: json['transactionId'] as String,
  requiredApprovers: (json['requiredApprovers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  approvers: (json['approvers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  rejectedBy: json['rejectedBy'] as String?,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  transactionType: $enumDecodeNullable(
    _$GroupTransactionTypeEnumMap,
    json['transactionType'],
  ),
  amount: (json['amount'] as num?)?.toInt(),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
);

Map<String, dynamic> _$$PendingApprovalImplToJson(
  _$PendingApprovalImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'groupId': instance.groupId,
  'transactionId': instance.transactionId,
  'requiredApprovers': instance.requiredApprovers,
  'approvers': instance.approvers,
  'rejectedBy': instance.rejectedBy,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'expiresAt': instance.expiresAt.toIso8601String(),
  'transactionType': _$GroupTransactionTypeEnumMap[instance.transactionType],
  'amount': instance.amount,
  'description': instance.description,
  'createdBy': instance.createdBy,
};
