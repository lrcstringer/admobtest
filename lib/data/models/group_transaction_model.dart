import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group_transaction.dart';
import '../../core/utils/firestore_helpers.dart';

part 'group_transaction_model.freezed.dart';
part 'group_transaction_model.g.dart';

/// Data model for GroupTransaction
///
/// Maps between Firestore document and GroupTransaction entity.
/// Collection: groups/{groupId}/transactions/{transactionId}
@freezed
class GroupTransactionModel with _$GroupTransactionModel {
  const factory GroupTransactionModel({
    required String id,
    required String groupId,
    String? journalId,
    required String type,
    required int amount,
    String? fromMemberId,
    String? toMemberId,
    required String description,
    required String status,
    String? approvedBy,
    required String createdBy,
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? completedAt,
  }) = _GroupTransactionModel;

  const GroupTransactionModel._();

  factory GroupTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$GroupTransactionModelFromJson(json);

  /// Create from Firestore document
  factory GroupTransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);
    return GroupTransactionModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  GroupTransaction toEntity() => GroupTransaction(
        id: id,
        groupId: groupId,
        journalId: journalId,
        type: _parseTransactionType(type),
        amount: amount,
        fromMemberId: fromMemberId,
        toMemberId: toMemberId,
        description: description,
        status: GroupTransactionStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () => GroupTransactionStatus.pending,
        ),
        approvedBy: approvedBy,
        createdBy: createdBy,
        createdAt: createdAt,
        completedAt: completedAt,
      );

  /// Create from domain entity
  factory GroupTransactionModel.fromEntity(GroupTransaction entity) =>
      GroupTransactionModel(
        id: entity.id,
        groupId: entity.groupId,
        journalId: entity.journalId,
        type: _transactionTypeToString(entity.type),
        amount: entity.amount,
        fromMemberId: entity.fromMemberId,
        toMemberId: entity.toMemberId,
        description: entity.description,
        status: entity.status.name,
        approvedBy: entity.approvedBy,
        createdBy: entity.createdBy,
        createdAt: entity.createdAt,
        completedAt: entity.completedAt,
      );
}

GroupTransactionType _parseTransactionType(String value) {
  switch (value) {
    case 'contribution':
      return GroupTransactionType.contribution;
    case 'withdrawal':
      return GroupTransactionType.withdrawal;
    case 'transfer_in':
      return GroupTransactionType.transferIn;
    case 'transfer_out':
      return GroupTransactionType.transferOut;
    case 'penalty':
      return GroupTransactionType.penalty;
    case 'payout':
      return GroupTransactionType.payout;
    default:
      return GroupTransactionType.contribution;
  }
}

String _transactionTypeToString(GroupTransactionType type) {
  switch (type) {
    case GroupTransactionType.contribution:
      return 'contribution';
    case GroupTransactionType.withdrawal:
      return 'withdrawal';
    case GroupTransactionType.transferIn:
      return 'transfer_in';
    case GroupTransactionType.transferOut:
      return 'transfer_out';
    case GroupTransactionType.penalty:
      return 'penalty';
    case GroupTransactionType.payout:
      return 'payout';
  }
}

/// Data model for PendingApproval
///
/// Maps between Firestore document and PendingApproval entity.
/// Collection: groups/{groupId}/pendingApprovals/{approvalId}
@freezed
class PendingApprovalModel with _$PendingApprovalModel {
  const factory PendingApprovalModel({
    required String id,
    required String groupId,
    required String transactionId,
    required List<String> requiredApprovers,
    required List<String> approvers,
    String? rejectedBy,
    required String status,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime expiresAt,
    // Transaction details (populated when fetching approvals)
    String? transactionType,
    int? amount,
    String? description,
    String? createdBy,
  }) = _PendingApprovalModel;

  const PendingApprovalModel._();

  factory PendingApprovalModel.fromJson(Map<String, dynamic> json) =>
      _$PendingApprovalModelFromJson(json);

  /// Create from Firestore document
  factory PendingApprovalModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);
    return PendingApprovalModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  PendingApproval toEntity() => PendingApproval(
        id: id,
        groupId: groupId,
        transactionId: transactionId,
        requiredApprovers: requiredApprovers,
        approvers: approvers,
        rejectedBy: rejectedBy,
        status: status,
        createdAt: createdAt,
        expiresAt: expiresAt,
        transactionType: transactionType != null
            ? _parseTransactionType(transactionType!)
            : null,
        amount: amount,
        description: description,
        createdBy: createdBy,
      );

  /// Create from domain entity
  factory PendingApprovalModel.fromEntity(PendingApproval entity) =>
      PendingApprovalModel(
        id: entity.id,
        groupId: entity.groupId,
        transactionId: entity.transactionId,
        requiredApprovers: entity.requiredApprovers,
        approvers: entity.approvers,
        rejectedBy: entity.rejectedBy,
        status: entity.status,
        createdAt: entity.createdAt,
        expiresAt: entity.expiresAt,
        transactionType: entity.transactionType != null
            ? _transactionTypeToString(entity.transactionType!)
            : null,
        amount: entity.amount,
        description: entity.description,
        createdBy: entity.createdBy,
      );
}
