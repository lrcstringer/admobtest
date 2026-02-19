import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/token_amount.dart';

part 'group_member.freezed.dart';
part 'group_member.g.dart';

// DEPRECATED: Use CommunityMember entity instead. Will be removed in a future cleanup PR.

/// Group member roles with different permission levels
enum GroupRole {
  @JsonValue('owner')
  owner,
  @JsonValue('admin')
  admin,
  @JsonValue('treasurer')
  treasurer,
  @JsonValue('member')
  member,
  @JsonValue('viewer')
  viewer,
}

/// Group member status
enum GroupMemberStatus {
  @JsonValue('active')
  active,
  @JsonValue('invited')
  invited,
  @JsonValue('blocked')
  blocked,
}

/// Permissions for group roles
class GroupPermissions {
  final bool canManageMembers;
  final bool canApproveFunds;
  final bool canTransferFunds;
  final bool canViewLedger;
  final bool canEditSettings;
  final int maxTransferWithoutApproval;

  const GroupPermissions({
    required this.canManageMembers,
    required this.canApproveFunds,
    required this.canTransferFunds,
    required this.canViewLedger,
    required this.canEditSettings,
    required this.maxTransferWithoutApproval,
  });

  /// Get permissions for a specific role
  static GroupPermissions forRole(GroupRole role) {
    switch (role) {
      case GroupRole.owner:
        return const GroupPermissions(
          canManageMembers: true,
          canApproveFunds: true,
          canTransferFunds: true,
          canViewLedger: true,
          canEditSettings: true,
          maxTransferWithoutApproval: 999999999, // Infinity
        );
      case GroupRole.admin:
        return const GroupPermissions(
          canManageMembers: true,
          canApproveFunds: true,
          canTransferFunds: true,
          canViewLedger: true,
          canEditSettings: false,
          maxTransferWithoutApproval: 10000,
        );
      case GroupRole.treasurer:
        return const GroupPermissions(
          canManageMembers: false,
          canApproveFunds: true,
          canTransferFunds: true,
          canViewLedger: true,
          canEditSettings: false,
          maxTransferWithoutApproval: 5000,
        );
      case GroupRole.member:
        return const GroupPermissions(
          canManageMembers: false,
          canApproveFunds: false,
          canTransferFunds: true,
          canViewLedger: true,
          canEditSettings: false,
          maxTransferWithoutApproval: 1000,
        );
      case GroupRole.viewer:
        return const GroupPermissions(
          canManageMembers: false,
          canApproveFunds: false,
          canTransferFunds: false,
          canViewLedger: true,
          canEditSettings: false,
          maxTransferWithoutApproval: 0,
        );
    }
  }
}

/// Group member entity
///
/// Represents a user's membership in a group with their role and status.
@freezed
class GroupMember with _$GroupMember {
  const factory GroupMember({
    required String id,
    required String groupId,
    required String userId,
    required GroupRole role,
    required String displayName,
    String? avatarUrl,
    required GroupMemberStatus status,
    required int contributionBalance,
    DateTime? joinedAt,
    required String invitedBy,
    required DateTime invitedAt,
  }) = _GroupMember;

  const GroupMember._();

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  /// Get contribution balance as TokenAmount
  TokenAmount get tokenContribution => TokenAmount(contributionBalance);

  /// Get permissions for this member's role
  GroupPermissions get permissions => GroupPermissions.forRole(role);

  /// Check if member is active
  bool get isActive => status == GroupMemberStatus.active;

  /// Check if member is invited (pending acceptance)
  bool get isInvited => status == GroupMemberStatus.invited;

  /// Check if member is blocked
  bool get isBlocked => status == GroupMemberStatus.blocked;

  /// Check if member is the owner
  bool get isOwner => role == GroupRole.owner;

  /// Check if member is an admin (owner or admin role)
  bool get isAdmin => role == GroupRole.owner || role == GroupRole.admin;

  /// Check if member can manage other members
  bool get canManageMembers => permissions.canManageMembers;

  /// Check if member can approve fund transfers
  bool get canApproveFunds => permissions.canApproveFunds;

  /// Check if member can transfer funds
  bool get canTransferFunds => permissions.canTransferFunds;

  /// Check if member can view the ledger
  bool get canViewLedger => permissions.canViewLedger;

  /// Check if member can edit group settings
  bool get canEditSettings => permissions.canEditSettings;

  /// Get display name for role
  String get roleDisplayName {
    switch (role) {
      case GroupRole.owner:
        return 'Owner';
      case GroupRole.admin:
        return 'Admin';
      case GroupRole.treasurer:
        return 'Treasurer';
      case GroupRole.member:
        return 'Member';
      case GroupRole.viewer:
        return 'Viewer';
    }
  }

  /// Get display name for status
  String get statusDisplayName {
    switch (status) {
      case GroupMemberStatus.active:
        return 'Active';
      case GroupMemberStatus.invited:
        return 'Invited';
      case GroupMemberStatus.blocked:
        return 'Blocked';
    }
  }
}
