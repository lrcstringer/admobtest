import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/transaction_type.dart';
import '../enums/transaction_status.dart';
import '../value_objects/token_amount.dart';

// Re-export enums for backward compatibility
export '../enums/transaction_type.dart';
export '../enums/transaction_status.dart';

part 'community_transaction.freezed.dart';
part 'community_transaction.g.dart';

/// Community transaction entity
///
/// Represents a financial transaction within a community.
/// Structurally mirrors [GroupTransaction] with communityId.
///
/// Subcollection: communities/{communityId}/transactions/{transactionId}
@freezed
class CommunityTransaction with _$CommunityTransaction {
  const factory CommunityTransaction({
    required String id,
    required String communityId,
    String? journalId,
    required CommunityTransactionType type,
    required int amount,
    required String memberId,
    required String memberName,
    String? description,
    required CommunityTransactionStatus status,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _CommunityTransaction;

  const CommunityTransaction._();

  factory CommunityTransaction.fromJson(Map<String, dynamic> json) =>
      _$CommunityTransactionFromJson(json);

  /// Get amount as TokenAmount
  TokenAmount get tokenAmount => TokenAmount(amount);

  bool get isPending => status == CommunityTransactionStatus.pending;
  bool get isApproved => status == CommunityTransactionStatus.approved;
  bool get isCompleted => status == CommunityTransactionStatus.completed;
  bool get isRejected => status == CommunityTransactionStatus.rejected;

  bool get needsApproval =>
      status == CommunityTransactionStatus.pending ||
      status == CommunityTransactionStatus.approved;

  bool get isInflow =>
      type == CommunityTransactionType.contribution ||
      type == CommunityTransactionType.transferIn ||
      type == CommunityTransactionType.penalty;

  bool get isOutflow =>
      type == CommunityTransactionType.withdrawal ||
      type == CommunityTransactionType.transferOut ||
      type == CommunityTransactionType.payout;

  String get typeDisplayName {
    switch (type) {
      case CommunityTransactionType.contribution:
        return 'Contribution';
      case CommunityTransactionType.withdrawal:
        return 'Withdrawal';
      case CommunityTransactionType.transferIn:
        return 'Transfer In';
      case CommunityTransactionType.transferOut:
        return 'Transfer Out';
      case CommunityTransactionType.penalty:
        return 'Penalty';
      case CommunityTransactionType.payout:
        return 'Payout';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case CommunityTransactionStatus.pending:
        return 'Pending';
      case CommunityTransactionStatus.approved:
        return 'Approved';
      case CommunityTransactionStatus.completed:
        return 'Completed';
      case CommunityTransactionStatus.rejected:
        return 'Rejected';
    }
  }

  String get typeIcon {
    switch (type) {
      case CommunityTransactionType.contribution:
        return 'add_circle';
      case CommunityTransactionType.withdrawal:
        return 'remove_circle';
      case CommunityTransactionType.transferIn:
        return 'arrow_downward';
      case CommunityTransactionType.transferOut:
        return 'arrow_upward';
      case CommunityTransactionType.penalty:
        return 'warning';
      case CommunityTransactionType.payout:
        return 'payments';
    }
  }
}

/// Pending approval entity for community transactions
///
/// Subcollection: communities/{communityId}/pendingApprovals/{approvalId}
@freezed
class CommunityApproval with _$CommunityApproval {
  const factory CommunityApproval({
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
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _CommunityApproval;

  const CommunityApproval._();

  factory CommunityApproval.fromJson(Map<String, dynamic> json) =>
      _$CommunityApprovalFromJson(json);

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
  bool get isExpired =>
      status == 'expired' || DateTime.now().isAfter(expiresAt);

  int get approvalCount => approvers.length;
  bool hasApproved(String userId) => approvers.contains(userId);
}
