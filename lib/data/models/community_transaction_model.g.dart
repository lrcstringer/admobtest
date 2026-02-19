// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityTransactionModelImpl _$$CommunityTransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityTransactionModelImpl(
  id: json['id'] as String,
  communityId: json['communityId'] as String,
  journalId: json['journalId'] as String?,
  type: json['type'] as String,
  amount: (json['amount'] as num).toInt(),
  memberId: json['memberId'] as String,
  memberName: json['memberName'] as String,
  description: json['description'] as String?,
  status: json['status'] as String,
  approvedBy: json['approvedBy'] as String?,
  rejectedBy: json['rejectedBy'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  completedAt: const NullableTimestampConverter().fromJson(json['completedAt']),
);

Map<String, dynamic> _$$CommunityTransactionModelImplToJson(
  _$CommunityTransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'journalId': instance.journalId,
  'type': instance.type,
  'amount': instance.amount,
  'memberId': instance.memberId,
  'memberName': instance.memberName,
  'description': instance.description,
  'status': instance.status,
  'approvedBy': instance.approvedBy,
  'rejectedBy': instance.rejectedBy,
  'rejectionReason': instance.rejectionReason,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'completedAt': const NullableTimestampConverter().toJson(
    instance.completedAt,
  ),
};

_$CommunityApprovalModelImpl _$$CommunityApprovalModelImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityApprovalModelImpl(
  id: json['id'] as String,
  communityId: json['communityId'] as String,
  transactionId: json['transactionId'] as String,
  requestedBy: json['requestedBy'] as String,
  requestedByName: json['requestedByName'] as String,
  amount: (json['amount'] as num).toInt(),
  type: json['type'] as String,
  description: json['description'] as String?,
  approvers: (json['approvers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  requiredApprovals: (json['requiredApprovals'] as num).toInt(),
  status: json['status'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
);

Map<String, dynamic> _$$CommunityApprovalModelImplToJson(
  _$CommunityApprovalModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'transactionId': instance.transactionId,
  'requestedBy': instance.requestedBy,
  'requestedByName': instance.requestedByName,
  'amount': instance.amount,
  'type': instance.type,
  'description': instance.description,
  'approvers': instance.approvers,
  'requiredApprovals': instance.requiredApprovals,
  'status': instance.status,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
};
