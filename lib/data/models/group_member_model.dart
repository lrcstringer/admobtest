// DEPRECATED: Use CommunityMemberModel instead. Will be removed in a future cleanup PR.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group_member.dart';
import '../../core/utils/firestore_helpers.dart';

part 'group_member_model.freezed.dart';
part 'group_member_model.g.dart';

/// Data model for GroupMember
///
/// Maps between Firestore document and GroupMember entity.
/// Collection: groups/{groupId}/members/{memberId}
@freezed
class GroupMemberModel with _$GroupMemberModel {
  const factory GroupMemberModel({
    required String id,
    required String groupId,
    required String userId,
    required String role,
    required String displayName,
    String? avatarUrl,
    required String status,
    required int contributionBalance,
    @NullableTimestampConverter() DateTime? joinedAt,
    required String invitedBy,
    @TimestampConverter() required DateTime invitedAt,
  }) = _GroupMemberModel;

  const GroupMemberModel._();

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);

  /// Create from Firestore document
  factory GroupMemberModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);
    return GroupMemberModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  GroupMember toEntity() => GroupMember(
        id: id,
        groupId: groupId,
        userId: userId,
        role: GroupRole.values.firstWhere(
          (e) => e.name == role,
          orElse: () => GroupRole.member,
        ),
        displayName: displayName,
        avatarUrl: avatarUrl,
        status: GroupMemberStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () => GroupMemberStatus.invited,
        ),
        contributionBalance: contributionBalance,
        joinedAt: joinedAt,
        invitedBy: invitedBy,
        invitedAt: invitedAt,
      );

  /// Create from domain entity
  factory GroupMemberModel.fromEntity(GroupMember entity) => GroupMemberModel(
        id: entity.id,
        groupId: entity.groupId,
        userId: entity.userId,
        role: entity.role.name,
        displayName: entity.displayName,
        avatarUrl: entity.avatarUrl,
        status: entity.status.name,
        contributionBalance: entity.contributionBalance,
        joinedAt: entity.joinedAt,
        invitedBy: entity.invitedBy,
        invitedAt: entity.invitedAt,
      );
}
