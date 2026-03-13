import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/community_member.dart';
import '../../domain/enums/member_role.dart';
import '../../domain/enums/member_status.dart';
import '../../core/utils/firestore_helpers.dart';

part 'community_member_model.freezed.dart';
part 'community_member_model.g.dart';

/// Data model for CommunityMember
///
/// Maps between Firestore document and CommunityMember entity.
/// Subcollection: communities/{communityId}/members/{userId}
@freezed
abstract class CommunityMemberModel with _$CommunityMemberModel {
  const factory CommunityMemberModel({
    required String id,
    required String communityId,
    required String userId,
    required String displayName,
    String? avatarUrl,
    required String role,
    required String status,
    @Default(0) int contributionBalance,
    @NullableTimestampConverter() DateTime? joinedAt,
    required String invitedBy,
    @TimestampConverter() required DateTime invitedAt,
    @NullableTimestampConverter() DateTime? lastReadAt,
    String? communityName,
  }) = _CommunityMemberModel;

  const CommunityMemberModel._();

  factory CommunityMemberModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityMemberModelFromJson(json);

  /// Create from Firestore document
  factory CommunityMemberModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);
    return CommunityMemberModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  CommunityMember toEntity() => CommunityMember(
        id: id,
        communityId: communityId,
        userId: userId,
        displayName: displayName,
        avatarUrl: avatarUrl,
        role: MemberRole.values.firstWhere(
          (e) => e.name == role,
          orElse: () {
            debugPrint('WARNING: Unknown member role "$role", defaulting to member');
            return MemberRole.member;
          },
        ),
        status: MemberStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () {
            debugPrint('WARNING: Unknown member status "$status", defaulting to invited');
            return MemberStatus.invited;
          },
        ),
        contributionBalance: contributionBalance,
        joinedAt: joinedAt,
        invitedBy: invitedBy,
        invitedAt: invitedAt,
        lastReadAt: lastReadAt,
        communityName: communityName,
      );

  /// Create from domain entity
  factory CommunityMemberModel.fromEntity(CommunityMember entity) =>
      CommunityMemberModel(
        id: entity.id,
        communityId: entity.communityId,
        userId: entity.userId,
        displayName: entity.displayName,
        avatarUrl: entity.avatarUrl,
        role: entity.role.name,
        status: entity.status.name,
        contributionBalance: entity.contributionBalance,
        joinedAt: entity.joinedAt,
        invitedBy: entity.invitedBy,
        invitedAt: entity.invitedAt,
        lastReadAt: entity.lastReadAt,
        communityName: entity.communityName,
      );
}
