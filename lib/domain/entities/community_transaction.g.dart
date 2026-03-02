// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityTransactionImpl _$$CommunityTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityTransactionImpl(
  id: json['id'] as String,
  communityId: json['communityId'] as String,
  journalId: json['journalId'] as String?,
  type: $enumDecode(_$CommunityTransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  memberId: json['memberId'] as String,
  memberName: json['memberName'] as String,
  description: json['description'] as String?,
  status: $enumDecode(_$CommunityTransactionStatusEnumMap, json['status']),
  approvedBy: json['approvedBy'] as String?,
  rejectedBy: json['rejectedBy'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$$CommunityTransactionImplToJson(
  _$CommunityTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'journalId': instance.journalId,
  'type': _$CommunityTransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'memberId': instance.memberId,
  'memberName': instance.memberName,
  'description': instance.description,
  'status': _$CommunityTransactionStatusEnumMap[instance.status]!,
  'approvedBy': instance.approvedBy,
  'rejectedBy': instance.rejectedBy,
  'rejectionReason': instance.rejectionReason,
  'createdAt': instance.createdAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
};

const _$CommunityTransactionTypeEnumMap = {
  CommunityTransactionType.contribution: 'contribution',
  CommunityTransactionType.withdrawal: 'withdrawal',
  CommunityTransactionType.transferIn: 'transfer_in',
  CommunityTransactionType.transferOut: 'transfer_out',
  CommunityTransactionType.penalty: 'penalty',
  CommunityTransactionType.payout: 'payout',
};

const _$CommunityTransactionStatusEnumMap = {
  CommunityTransactionStatus.pending: 'pending',
  CommunityTransactionStatus.approved: 'approved',
  CommunityTransactionStatus.completed: 'completed',
  CommunityTransactionStatus.rejected: 'rejected',
};

_$CommunityApprovalImpl _$$CommunityApprovalImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityApprovalImpl(
  id: json['id'] as String,
  communityId: json['communityId'] as String,
  transactionId: json['transactionId'] as String,
  requestedBy: json['requestedBy'] as String,
  requestedByName: json['requestedByName'] as String,
  amount: (json['amount'] as num).toInt(),
  type: $enumDecode(_$CommunityTransactionTypeEnumMap, json['type']),
  description: json['description'] as String?,
  approvers: (json['approvers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  requiredApprovals: (json['requiredApprovals'] as num).toInt(),
  status: $enumDecode(_$ApprovalStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$$CommunityApprovalImplToJson(
  _$CommunityApprovalImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'transactionId': instance.transactionId,
  'requestedBy': instance.requestedBy,
  'requestedByName': instance.requestedByName,
  'amount': instance.amount,
  'type': _$CommunityTransactionTypeEnumMap[instance.type]!,
  'description': instance.description,
  'approvers': instance.approvers,
  'requiredApprovals': instance.requiredApprovals,
  'status': _$ApprovalStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'expiresAt': instance.expiresAt.toIso8601String(),
};

const _$ApprovalStatusEnumMap = {
  ApprovalStatus.pending: 'pending',
  ApprovalStatus.approved: 'approved',
  ApprovalStatus.rejected: 'rejected',
  ApprovalStatus.expired: 'expired',
};
