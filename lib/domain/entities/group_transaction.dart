import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/token_amount.dart';

part 'group_transaction.freezed.dart';
part 'group_transaction.g.dart';

// DEPRECATED: Use CommunityTransaction entity instead. Will be removed in a future cleanup PR.

/// Group transaction types
enum GroupTransactionType {
  @JsonValue('contribution')
  contribution,
  @JsonValue('withdrawal')
  withdrawal,
  @JsonValue('transfer_in')
  transferIn,
  @JsonValue('transfer_out')
  transferOut,
  @JsonValue('penalty')
  penalty,
  @JsonValue('payout')
  payout,
}

/// Group transaction status
enum GroupTransactionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('completed')
  completed,
  @JsonValue('rejected')
  rejected,
}

/// Group transaction entity
///
/// Represents a financial transaction within a group (contributions, withdrawals, payouts).
@freezed
abstract class GroupTransaction with _$GroupTransaction {
  const factory GroupTransaction({
    required String id,
    required String groupId,
    String? journalId,
    required GroupTransactionType type,
    required int amount,
    String? fromMemberId,
    String? toMemberId,
    required String description,
    required GroupTransactionStatus status,
    String? approvedBy,
    required String createdBy,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _GroupTransaction;

  const GroupTransaction._();

  factory GroupTransaction.fromJson(Map<String, dynamic> json) =>
      _$GroupTransactionFromJson(json);

  /// Get amount as TokenAmount
  TokenAmount get tokenAmount => TokenAmount(amount);

  /// Check if transaction is pending
  bool get isPending => status == GroupTransactionStatus.pending;

  /// Check if transaction is approved (but not yet completed)
  bool get isApproved => status == GroupTransactionStatus.approved;

  /// Check if transaction is completed
  bool get isCompleted => status == GroupTransactionStatus.completed;

  /// Check if transaction is rejected
  bool get isRejected => status == GroupTransactionStatus.rejected;

  /// Check if transaction needs approval
  bool get needsApproval =>
      status == GroupTransactionStatus.pending ||
      status == GroupTransactionStatus.approved;

  /// Check if transaction is an inflow to the group
  bool get isInflow =>
      type == GroupTransactionType.contribution ||
      type == GroupTransactionType.transferIn ||
      type == GroupTransactionType.penalty;

  /// Check if transaction is an outflow from the group
  bool get isOutflow =>
      type == GroupTransactionType.withdrawal ||
      type == GroupTransactionType.transferOut ||
      type == GroupTransactionType.payout;

  /// Get display name for transaction type
  String get typeDisplayName {
    switch (type) {
      case GroupTransactionType.contribution:
        return 'Contribution';
      case GroupTransactionType.withdrawal:
        return 'Withdrawal';
      case GroupTransactionType.transferIn:
        return 'Transfer In';
      case GroupTransactionType.transferOut:
        return 'Transfer Out';
      case GroupTransactionType.penalty:
        return 'Penalty';
      case GroupTransactionType.payout:
        return 'Payout';
    }
  }

  /// Get display name for status
  String get statusDisplayName {
    switch (status) {
      case GroupTransactionStatus.pending:
        return 'Pending';
      case GroupTransactionStatus.approved:
        return 'Approved';
      case GroupTransactionStatus.completed:
        return 'Completed';
      case GroupTransactionStatus.rejected:
        return 'Rejected';
    }
  }

  /// Get icon name for transaction type
  String get typeIcon {
    switch (type) {
      case GroupTransactionType.contribution:
        return 'add_circle';
      case GroupTransactionType.withdrawal:
        return 'remove_circle';
      case GroupTransactionType.transferIn:
        return 'arrow_downward';
      case GroupTransactionType.transferOut:
        return 'arrow_upward';
      case GroupTransactionType.penalty:
        return 'warning';
      case GroupTransactionType.payout:
        return 'payments';
    }
  }
}

/// Pending approval entity
///
/// Represents a transaction awaiting approval from authorized members.
/// Includes transaction details for display purposes.
@freezed
abstract class PendingApproval with _$PendingApproval {
  const factory PendingApproval({
    required String id,
    required String groupId,
    required String transactionId,
    required List<String> requiredApprovers,
    required List<String> approvers,
    String? rejectedBy,
    required String status,
    required DateTime createdAt,
    required DateTime expiresAt,
    // Transaction details for display
    GroupTransactionType? transactionType,
    int? amount,
    String? description,
    String? createdBy,
  }) = _PendingApproval;

  const PendingApproval._();

  factory PendingApproval.fromJson(Map<String, dynamic> json) =>
      _$PendingApprovalFromJson(json);

  /// Check if approval is pending
  bool get isPending => status == 'pending';

  /// Check if approval has been approved
  bool get isApproved => status == 'approved';

  /// Check if approval has been rejected
  bool get isRejected => status == 'rejected';

  /// Check if approval has expired
  bool get isExpired =>
      status == 'expired' || DateTime.now().isAfter(expiresAt);

  /// Get number of approvals received
  int get approvalCount => approvers.length;

  /// Check if a specific user has approved
  bool hasApproved(String userId) => approvers.contains(userId);

  /// Check if a specific user can approve
  bool canApprove(String userId) =>
      requiredApprovers.contains(userId) && !approvers.contains(userId);
}
