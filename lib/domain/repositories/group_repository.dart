// DEPRECATED: Use CommunityRepository instead. Will be removed in a future cleanup PR.
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/group.dart';
import '../entities/stokvel_analytics.dart';
import '../entities/group_member.dart';
import '../entities/group_transaction.dart';

/// Parameters for creating a new group
class CreateGroupParams {
  final GroupType type;
  final String name;
  final String description;
  final String? avatarUrl;
  final GroupSettings? settings;
  final StokvelSettings? stokvelSettings;

  const CreateGroupParams({
    required this.type,
    required this.name,
    required this.description,
    this.avatarUrl,
    this.settings,
    this.stokvelSettings,
  });

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'name': name,
        'description': description,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
        if (settings != null) 'settings': settings!.toJson(),
        if (stokvelSettings != null)
          'stokvelSettings': stokvelSettings!.toJson(),
      };
}

/// Parameters for updating a group
class UpdateGroupParams {
  final String? name;
  final String? description;
  final String? avatarUrl;
  final GroupSettings? settings;
  final StokvelSettings? stokvelSettings;

  const UpdateGroupParams({
    this.name,
    this.description,
    this.avatarUrl,
    this.settings,
    this.stokvelSettings,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
        if (settings != null) 'settings': settings!.toJson(),
        if (stokvelSettings != null)
          'stokvelSettings': stokvelSettings!.toJson(),
      };
}

/// Group repository interface
///
/// Defines the contract for group account operations including:
/// - Group CRUD operations
/// - Membership management
/// - Financial transactions (contributions, withdrawals, payouts)
/// - Approval workflows
abstract class GroupRepository {
  // =========================================================================
  // GROUP CRUD
  // =========================================================================

  /// Create a new group
  Future<Either<Failure, Group>> createGroup(CreateGroupParams params);

  /// Get a group by ID
  Future<Either<Failure, Group>> getGroup(String groupId);

  /// Get all groups the current user belongs to
  Future<Either<Failure, List<Group>>> getUserGroups();

  /// Watch all groups the current user belongs to (real-time updates)
  Stream<Either<Failure, List<Group>>> watchUserGroups();

  /// Update group settings
  Future<Either<Failure, void>> updateGroup(
    String groupId,
    UpdateGroupParams params,
  );

  /// Delete (close) a group - only owner can do this
  Future<Either<Failure, void>> deleteGroup(String groupId);

  // =========================================================================
  // MEMBERSHIP
  // =========================================================================

  /// Invite a user to join a group
  Future<Either<Failure, void>> inviteMember(
    String groupId,
    String userId,
    GroupRole role,
  );

  /// Accept an invitation to join a group
  Future<Either<Failure, void>> acceptInvitation(String groupId);

  /// Decline an invitation to join a group
  Future<Either<Failure, void>> declineInvitation(String groupId);

  /// Remove a member from a group
  Future<Either<Failure, void>> removeMember(
    String groupId,
    String memberId,
  );

  /// Update a member's role
  Future<Either<Failure, void>> updateMemberRole(
    String groupId,
    String memberId,
    GroupRole role,
  );

  /// Leave a group (self-removal)
  Future<Either<Failure, void>> leaveGroup(String groupId);

  /// Get members of a group
  Future<Either<Failure, List<GroupMember>>> getGroupMembers(String groupId);

  /// Watch members of a group (real-time updates)
  Stream<Either<Failure, List<GroupMember>>> watchGroupMembers(String groupId);

  /// Get pending invitations for current user
  Future<Either<Failure, List<GroupMember>>> getPendingInvitations();

  // =========================================================================
  // TRANSACTIONS
  // =========================================================================

  /// Contribute tokens to a group
  Future<Either<Failure, GroupTransaction>> contributeToGroup(
    String groupId,
    int amount, {
    String? description,
  });

  /// Request withdrawal from a group
  /// Returns the transaction (may be pending approval)
  Future<Either<Failure, GroupTransaction>> withdrawFromGroup(
    String groupId,
    int amount, {
    String? description,
  });

  /// Approve a pending transaction
  Future<Either<Failure, void>> approveTransaction(
    String groupId,
    String transactionId,
  );

  /// Reject a pending transaction
  Future<Either<Failure, void>> rejectTransaction(
    String groupId,
    String transactionId, {
    String? reason,
  });

  /// Get transactions for a group
  Future<Either<Failure, List<GroupTransaction>>> getGroupTransactions(
    String groupId, {
    int? limit,
  });

  /// Watch transactions for a group (real-time updates)
  Stream<Either<Failure, List<GroupTransaction>>> watchGroupTransactions(
    String groupId, {
    int? limit,
  });

  /// Get pending approvals for a group
  Future<Either<Failure, List<PendingApproval>>> getPendingApprovals(
    String groupId,
  );

  /// Watch pending approvals for a group (real-time updates)
  Stream<Either<Failure, List<PendingApproval>>> watchPendingApprovals(
    String groupId,
  );

  // =========================================================================
  // BALANCE & STATS
  // =========================================================================

  /// Get current balance of a group
  Future<Either<Failure, int>> getGroupBalance(String groupId);

  /// Get group details with members (combined call for efficiency)
  Future<Either<Failure, GroupDetails>> getGroupDetails(String groupId);

  // =========================================================================
  // STOKVEL-SPECIFIC
  // =========================================================================

  /// Manually trigger a stokvel payout (admin only)
  Future<Either<Failure, StokvelPayoutResult>> triggerStokvelPayout(
    String groupId, {
    String? recipientId,
  });

  /// Get stokvel analytics (contribution history, member stats)
  Future<Either<Failure, StokvelAnalytics>> getStokvelAnalytics(
    String groupId, {
    int months = 6,
  });
}

/// Combined group details with members
class GroupDetails {
  final Group group;
  final List<GroupMember> members;

  const GroupDetails({
    required this.group,
    required this.members,
  });
}
