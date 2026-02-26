import 'package:drift/drift.dart';

import '../../domain/entities/community_member.dart';
import '../../domain/enums/member_role.dart';
import '../../domain/enums/member_status.dart';
import '../datasources/local/app_database.dart';

/// Maps between [CommunityMember] domain entities and [LocalCommunityMembers] DB rows.
class LocalCommunityMemberMapper {
  /// Convert a [CommunityMember] entity to a [LocalCommunityMembersCompanion] for DB upsert.
  static LocalCommunityMembersCompanion toCompanion(CommunityMember member) {
    return LocalCommunityMembersCompanion(
      id: Value(member.id),
      communityId: Value(member.communityId),
      userId: Value(member.userId),
      displayName: Value(member.displayName),
      avatarUrl: Value(member.avatarUrl),
      role: Value(member.role.name),
      status: Value(member.status.name),
      contributionBalance: Value(member.contributionBalance),
      joinedAt: Value(member.joinedAt),
      invitedBy: Value(member.invitedBy),
      invitedAt: Value(member.invitedAt),
      lastReadAt: Value(member.lastReadAt),
      createdAt: Value(DateTime.now()),
    );
  }

  /// Convert a [LocalCommunityMember] DB row to a [CommunityMember] domain entity.
  static CommunityMember toEntity(LocalCommunityMember row) {
    return CommunityMember(
      id: row.id,
      communityId: row.communityId,
      userId: row.userId,
      displayName: row.displayName,
      avatarUrl: row.avatarUrl,
      role: _parseMemberRole(row.role),
      status: _parseMemberStatus(row.status),
      contributionBalance: row.contributionBalance,
      joinedAt: row.joinedAt,
      invitedBy: row.invitedBy,
      invitedAt: row.invitedAt ?? DateTime.now(),
      lastReadAt: row.lastReadAt,
    );
  }

  static MemberRole _parseMemberRole(String value) {
    return MemberRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MemberRole.member,
    );
  }

  static MemberStatus _parseMemberStatus(String value) {
    return MemberStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MemberStatus.active,
    );
  }
}
