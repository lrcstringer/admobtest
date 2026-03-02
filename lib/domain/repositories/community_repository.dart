import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/community.dart';
import '../entities/community_member.dart';
import '../entities/community_transaction.dart';
import '../entities/message.dart';
import '../entities/group.dart'; // StokvelSettings
import '../entities/stokvel_analytics.dart';
import '../enums/community_type.dart';
import '../enums/member_role.dart';

/// Parameters for creating a new community
class CreateCommunityParams {
  final CommunityType type;
  final String name;
  final String? description;
  final String? avatarUrl;
  final CommunitySettings? settings;
  final StokvelSettings? stokvelSettings;

  const CreateCommunityParams({
    required this.type,
    required this.name,
    this.description,
    this.avatarUrl,
    this.settings,
    this.stokvelSettings,
  });

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'name': name,
        if (description != null) 'description': description,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
        if (settings != null) 'settings': settings!.toJson(),
        if (stokvelSettings != null)
          'stokvelSettings': stokvelSettings!.toJson(),
      };
}

/// Parameters for updating a community
class UpdateCommunityParams {
  final String? name;
  final String? description;
  final String? avatarUrl;
  final CommunitySettings? settings;
  final StokvelSettings? stokvelSettings;

  const UpdateCommunityParams({
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

/// Community repository interface
///
/// Defines the contract for community operations including:
/// - Community CRUD
/// - Membership management
/// - Community messaging
/// - Financial transactions (contributions, withdrawals, payouts)
/// - Approval workflows
/// - Stokvel-specific features
abstract class CommunityRepository {
  // =========================================================================
  // COMMUNITY CRUD
  // =========================================================================

  /// Create a new community
  Future<Either<Failure, Community>> createCommunity(
    CreateCommunityParams params,
  );

  /// Get a community by ID
  Future<Either<Failure, Community>> getCommunity(String communityId);

  /// Get all communities the current user belongs to
  Future<Either<Failure, List<Community>>> getUserCommunities();

  /// Watch all communities the current user belongs to (real-time)
  Stream<Either<Failure, List<Community>>> watchUserCommunities();

  /// Update community settings
  Future<Either<Failure, void>> updateCommunity(
    String communityId,
    UpdateCommunityParams params,
  );

  /// Delete (close) a community - only owner can do this
  Future<Either<Failure, void>> deleteCommunity(String communityId);

  // =========================================================================
  // MEMBERSHIP
  // =========================================================================

  /// Invite a user to join a community
  Future<Either<Failure, void>> inviteMember(
    String communityId,
    String userId,
    MemberRole role,
  );

  /// Accept an invitation to join a community
  Future<Either<Failure, void>> acceptInvitation(String communityId);

  /// Decline an invitation to join a community
  Future<Either<Failure, void>> declineInvitation(String communityId);

  /// Remove a member from a community
  Future<Either<Failure, void>> removeMember(
    String communityId,
    String memberId,
  );

  /// Update a member's role
  Future<Either<Failure, void>> updateMemberRole(
    String communityId,
    String memberId,
    MemberRole role,
  );

  /// Leave a community (self-removal)
  Future<Either<Failure, void>> leaveCommunity(String communityId);

  /// Get members of a community
  Future<Either<Failure, List<CommunityMember>>> getMembers(
    String communityId,
  );

  /// Watch members of a community (real-time)
  Stream<Either<Failure, List<CommunityMember>>> watchMembers(
    String communityId,
  );

  /// Get pending invitations for current user
  Future<Either<Failure, List<CommunityMember>>> getPendingInvitations();

  // =========================================================================
  // MESSAGING
  // =========================================================================

  /// Get messages for a community (paginated)
  Future<Either<Failure, List<Message>>> getMessages({
    required String communityId,
    int? limit,
    DateTime? before,
  });

  /// Watch messages in real-time (latest page)
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String communityId,
    int? limit,
  });

  /// Send a text message to a community
  Future<Either<Failure, Message>> sendTextMessage({
    required String communityId,
    required String text,
    String? replyToMessageId,
  });

  /// Send a media message to a community (image, voice, video, or document).
  ///
  /// The repository handles encrypted upload via [MediaUploadDatasource]
  /// before enqueueing the message for SenderKey encryption.
  Future<Either<Failure, Message>> sendMediaMessage({
    required String communityId,
    required File mediaFile,
    required String mediaType,
    String? caption,
    int? durationSeconds,
    File? thumbnailFile,
  });

  // =========================================================================
  // FINANCIAL
  // =========================================================================

  /// Contribute tokens to a community
  Future<Either<Failure, CommunityTransaction>> contribute(
    String communityId,
    int amount, {
    String? description,
  });

  /// Request withdrawal from a community
  Future<Either<Failure, CommunityTransaction>> withdraw(
    String communityId,
    int amount, {
    String? description,
  });

  /// Approve a pending transaction
  Future<Either<Failure, void>> approveTransaction(
    String communityId,
    String transactionId,
  );

  /// Reject a pending transaction
  Future<Either<Failure, void>> rejectTransaction(
    String communityId,
    String transactionId, {
    String? reason,
  });

  /// Get transactions for a community
  Future<Either<Failure, List<CommunityTransaction>>> getTransactions(
    String communityId, {
    int? limit,
  });

  /// Watch transactions for a community (real-time)
  Stream<Either<Failure, List<CommunityTransaction>>> watchTransactions(
    String communityId,
  );

  /// Get pending approvals for a community
  Future<Either<Failure, List<CommunityApproval>>> getPendingApprovals(
    String communityId,
  );

  /// Watch pending approvals (real-time)
  Stream<Either<Failure, List<CommunityApproval>>> watchPendingApprovals(
    String communityId,
  );

  /// Get current balance of a community
  Future<Either<Failure, int>> getBalance(String communityId);

  // =========================================================================
  // STOKVEL-SPECIFIC
  // =========================================================================

  /// Manually trigger a stokvel payout (admin only)
  Future<Either<Failure, StokvelPayoutResult>> triggerPayout(
    String communityId, {
    String? recipientId,
  });

  /// Get stokvel analytics (contribution history, member stats)
  Future<Either<Failure, StokvelAnalytics>> getAnalytics(
    String communityId, {
    int months = 6,
  });

  // =========================================================================
  // REACTIONS
  // =========================================================================

  /// Add a reaction to a community message
  Future<Either<Failure, void>> addReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  });

  /// Remove a reaction from a community message
  Future<Either<Failure, void>> removeReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  });

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  /// Watch total unread count across all communities (for tab badge)
  Stream<Either<Failure, int>> watchTotalCommunityUnreadCount();
}
