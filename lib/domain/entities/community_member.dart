import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/member_role.dart';
import '../enums/member_status.dart';
import '../value_objects/token_amount.dart';

part 'community_member.freezed.dart';
part 'community_member.g.dart';

/// Community member entity
///
/// Represents a user's membership in a community with their role and status.
/// Mirrors [GroupMember] structure with community-specific additions.
///
/// Subcollection: communities/{communityId}/members/{userId}
@freezed
class CommunityMember with _$CommunityMember {
  const factory CommunityMember({
    required String id,
    required String communityId,
    required String userId,
    required String displayName,
    String? avatarUrl,
    required MemberRole role,
    required MemberStatus status,
    @Default(0) int contributionBalance,
    DateTime? joinedAt,
    required String invitedBy,
    required DateTime invitedAt,
    DateTime? lastReadAt,
    /// Name of the community this member belongs to (denormalized for invitations).
    String? communityName,
  }) = _CommunityMember;

  const CommunityMember._();

  factory CommunityMember.fromJson(Map<String, dynamic> json) =>
      _$CommunityMemberFromJson(json);

  /// Get contribution balance as TokenAmount
  TokenAmount get tokenContribution => TokenAmount(contributionBalance);

  bool get isActive => status == MemberStatus.active;
  bool get isInvited => status == MemberStatus.invited;
  bool get isBlocked => status == MemberStatus.blocked;
  bool get isOwner => role == MemberRole.owner;
  bool get isAdmin => role.isAdmin;
  bool get canManageMembers => role.canManageMembers;
  bool get canApproveFunds => role.canApproveFunds;
  bool get canTransferFunds => role.canTransferFunds;
  bool get canViewLedger => role.canViewLedger;
  bool get canEditSettings => role.canEditSettings;

  String get roleDisplayName => role.displayName;

  String get statusDisplayName {
    switch (status) {
      case MemberStatus.active:
        return 'Active';
      case MemberStatus.invited:
        return 'Invited';
      case MemberStatus.blocked:
        return 'Blocked';
    }
  }
}
