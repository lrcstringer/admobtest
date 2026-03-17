import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/community_transaction.dart';
import '../../core/utils/firestore_helpers.dart';

part 'community_transaction_model.freezed.dart';
part 'community_transaction_model.g.dart';

/// Data model for CommunityTransaction
///
/// Maps between Firestore document and CommunityTransaction entity.
/// Subcollection: communities/{communityId}/transactions/{transactionId}
@freezed
abstract class CommunityTransactionModel with _$CommunityTransactionModel {
  const factory CommunityTransactionModel({
    required String id,
    required String communityId,
    String? journalId,
    required String type,
    required int amount,
    required String memberId,
    required String memberName,
    String? description,
    required String status,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? completedAt,
  }) = _CommunityTransactionModel;

  const CommunityTransactionModel._();

  factory CommunityTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityTransactionModelFromJson(json);

  /// Create from Firestore document
  factory CommunityTransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);
    return CommunityTransactionModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  CommunityTransaction toEntity() => CommunityTransaction(
        id: id,
        communityId: communityId,
        journalId: journalId,
        type: _parseTransactionType(type),
        amount: amount,
        memberId: memberId,
        memberName: memberName,
        description: description,
        status: _parseTransactionStatus(status),
        approvedBy: approvedBy,
        rejectedBy: rejectedBy,
        rejectionReason: rejectionReason,
        createdAt: createdAt,
        completedAt: completedAt,
      );

  /// Create from domain entity
  factory CommunityTransactionModel.fromEntity(
          CommunityTransaction entity) =>
      CommunityTransactionModel(
        id: entity.id,
        communityId: entity.communityId,
        journalId: entity.journalId,
        type: _transactionTypeToString(entity.type),
        amount: entity.amount,
        memberId: entity.memberId,
        memberName: entity.memberName,
        description: entity.description,
        status: entity.status.name,
        approvedBy: entity.approvedBy,
        rejectedBy: entity.rejectedBy,
        rejectionReason: entity.rejectionReason,
        createdAt: entity.createdAt,
        completedAt: entity.completedAt,
      );
}

CommunityTransactionType _parseTransactionType(String value) {
  switch (value) {
    case 'contribution':
      return CommunityTransactionType.contribution;
    case 'withdrawal':
      return CommunityTransactionType.withdrawal;
    case 'transfer_in':
      return CommunityTransactionType.transferIn;
    case 'transfer_out':
      return CommunityTransactionType.transferOut;
    case 'penalty':
      return CommunityTransactionType.penalty;
    case 'payout':
      return CommunityTransactionType.payout;
    default:
      return CommunityTransactionType.contribution;
  }
}

CommunityTransactionStatus _parseTransactionStatus(String value) {
  return CommunityTransactionStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => CommunityTransactionStatus.pending,
  );
}

ApprovalStatus _parseApprovalStatus(String value) {
  return ApprovalStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => ApprovalStatus.pending,
  );
}

String _transactionTypeToString(CommunityTransactionType type) {
  switch (type) {
    case CommunityTransactionType.contribution:
      return 'contribution';
    case CommunityTransactionType.withdrawal:
      return 'withdrawal';
    case CommunityTransactionType.transferIn:
      return 'transfer_in';
    case CommunityTransactionType.transferOut:
      return 'transfer_out';
    case CommunityTransactionType.penalty:
      return 'penalty';
    case CommunityTransactionType.payout:
      return 'payout';
  }
}

/// Data model for CommunityApproval
///
/// Maps between Firestore document and CommunityApproval entity.
/// Subcollection: communities/{communityId}/pendingApprovals/{approvalId}
@freezed
abstract class CommunityApprovalModel with _$CommunityApprovalModel {
  const factory CommunityApprovalModel({
    required String id,
    required String communityId,
    required String transactionId,
    required String requestedBy,
    required String requestedByName,
    required int amount,
    required String type,
    String? description,
    required List<String> approvers,
    required int requiredApprovals,
    required String status,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime expiresAt,
  }) = _CommunityApprovalModel;

  const CommunityApprovalModel._();

  factory CommunityApprovalModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityApprovalModelFromJson(json);

  /// Create from Firestore document
  factory CommunityApprovalModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);
    return CommunityApprovalModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  CommunityApproval toEntity() => CommunityApproval(
        id: id,
        communityId: communityId,
        transactionId: transactionId,
        requestedBy: requestedBy,
        requestedByName: requestedByName,
        amount: amount,
        type: _parseTransactionType(type),
        description: description,
        approvers: approvers,
        requiredApprovals: requiredApprovals,
        status: _parseApprovalStatus(status),
        createdAt: createdAt,
        expiresAt: expiresAt,
      );

  /// Create from domain entity
  factory CommunityApprovalModel.fromEntity(CommunityApproval entity) =>
      CommunityApprovalModel(
        id: entity.id,
        communityId: entity.communityId,
        transactionId: entity.transactionId,
        requestedBy: entity.requestedBy,
        requestedByName: entity.requestedByName,
        amount: entity.amount,
        type: _transactionTypeToString(entity.type),
        description: entity.description,
        approvers: entity.approvers,
        requiredApprovals: entity.requiredApprovals,
        status: entity.status.name,
        createdAt: entity.createdAt,
        expiresAt: entity.expiresAt,
      );
}
