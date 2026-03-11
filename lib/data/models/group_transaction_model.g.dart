// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupTransactionModel _$GroupTransactionModelFromJson(
  Map<String, dynamic> json,
) => _GroupTransactionModel(
  id: json['id'] as String,
  groupId: json['groupId'] as String,
  journalId: json['journalId'] as String?,
  type: json['type'] as String,
  amount: (json['amount'] as num).toInt(),
  fromMemberId: json['fromMemberId'] as String?,
  toMemberId: json['toMemberId'] as String?,
  description: json['description'] as String,
  status: json['status'] as String,
  approvedBy: json['approvedBy'] as String?,
  createdBy: json['createdBy'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  completedAt: const NullableTimestampConverter().fromJson(json['completedAt']),
);

Map<String, dynamic> _$GroupTransactionModelToJson(
  _GroupTransactionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'groupId': instance.groupId,
  'journalId': instance.journalId,
  'type': instance.type,
  'amount': instance.amount,
  'fromMemberId': instance.fromMemberId,
  'toMemberId': instance.toMemberId,
  'description': instance.description,
  'status': instance.status,
  'approvedBy': instance.approvedBy,
  'createdBy': instance.createdBy,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'completedAt': const NullableTimestampConverter().toJson(
    instance.completedAt,
  ),
};

_PendingApprovalModel _$PendingApprovalModelFromJson(
  Map<String, dynamic> json,
) => _PendingApprovalModel(
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
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
  transactionType: json['transactionType'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String?,
);

Map<String, dynamic> _$PendingApprovalModelToJson(
  _PendingApprovalModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'groupId': instance.groupId,
  'transactionId': instance.transactionId,
  'requiredApprovers': instance.requiredApprovers,
  'approvers': instance.approvers,
  'rejectedBy': instance.rejectedBy,
  'status': instance.status,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
  'transactionType': instance.transactionType,
  'amount': instance.amount,
  'description': instance.description,
  'createdBy': instance.createdBy,
};
