import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/gift_style.dart';
import '../enums/pool_mode.dart';
import '../enums/pool_status.dart';

part 'token_pool.freezed.dart';
part 'token_pool.g.dart';

/// Per-user aggregated contribution in a token pool
@freezed
class PoolContribution with _$PoolContribution {
  const factory PoolContribution({
    required String userId,
    required String displayName,
    required int totalAmount,
    required int contributionCount,
    required bool anonymous,
    required DateTime lastContributedAt,
  }) = _PoolContribution;

  factory PoolContribution.fromJson(Map<String, dynamic> json) =>
      _$PoolContributionFromJson(json);
}

/// A single payout entry in a distribution
@freezed
class PoolPayout with _$PoolPayout {
  const factory PoolPayout({
    required String userId,
    required String displayName,
    required int amount,
  }) = _PoolPayout;

  factory PoolPayout.fromJson(Map<String, dynamic> json) =>
      _$PoolPayoutFromJson(json);
}

/// Token pool entity — the core data model for Collection Rooms.
///
/// Supports two modes:
/// - **sasaza**: Group gift for an external recipient
/// - **save**: Group savings for participants
///
/// Collection: tokenPools/{poolId}
@freezed
class TokenPool with _$TokenPool {
  const factory TokenPool({
    required String id,
    required PoolMode mode,
    required PoolStatus status,

    // Organizer
    required String organizerId,
    required String organizerName,

    // Recipient (sasaza mode only)
    String? recipientId,
    String? recipientName,

    // Conversation link
    required String conversationId,

    // Pool content
    required String title,
    @Default('') String purpose,
    @Default('') String message,
    required GiftStyle style,

    // Financial summary
    @Default(0) int totalAmount,
    @Default(0) int contributionCount,
    @Default(0) int contributorCount,

    // Per-user contributions
    @Default({}) Map<String, PoolContribution> contributions,

    // Payout records (populated on distribute)
    @Default([]) List<PoolPayout> payouts,

    // Gift delivery references (sasaza mode, after send)
    String? giftMessageId,
    String? giftConversationId,

    // Invitees
    @Default([]) List<String> inviteeIds,

    // Expiry
    DateTime? expiresAt,

    // Timestamps
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? sentAt,
    DateTime? openedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,

    // Ledger reference
    required String groupAccountId,

    // Notification state
    @Default(false) bool reminderSent,
  }) = _TokenPool;

  const TokenPool._();

  factory TokenPool.fromJson(Map<String, dynamic> json) =>
      _$TokenPoolFromJson(json);

  // =========================================================================
  // MODE HELPERS
  // =========================================================================

  bool get isSasaza => mode == PoolMode.sasaza;
  bool get isSave => mode == PoolMode.save;

  // =========================================================================
  // STATUS HELPERS
  // =========================================================================

  bool get isCollecting => status == PoolStatus.collecting;
  bool get isSent => status == PoolStatus.sent;
  bool get isCompleted => status == PoolStatus.completed;
  bool get isCancelled => status == PoolStatus.cancelled;
  bool get isExpired =>
      status == PoolStatus.expired ||
      (expiresAt != null && DateTime.now().isAfter(expiresAt!));

  /// Whether the pool is in a terminal state (no more actions possible)
  bool get isTerminal => status.isTerminal;

  /// Whether the pool is still accepting contributions
  bool get isActive => isCollecting;

  // =========================================================================
  // FINANCIAL HELPERS
  // =========================================================================

  bool get hasContributions => totalAmount > 0;
  double get totalAmountZar => totalAmount / 100;

  /// Whether a specific user has contributed to this pool
  bool hasContributed(String userId) => contributions.containsKey(userId);

  /// Get a specific user's total contribution amount
  int contributionFor(String userId) =>
      contributions[userId]?.totalAmount ?? 0;

  // =========================================================================
  // PARTICIPANT HELPERS
  // =========================================================================

  /// Whether the user is the organizer
  bool isOrganizer(String userId) => organizerId == userId;

  /// Whether the user is the recipient (sasaza mode)
  bool isRecipient(String userId) => recipientId == userId;

  /// Whether the user is an invitee
  bool isInvitee(String userId) => inviteeIds.contains(userId);

  /// Whether the user can contribute (is participant and pool is collecting)
  bool canContribute(String userId) =>
      isCollecting && (isOrganizer(userId) || isInvitee(userId));

  /// Whether the user can send the group gift (organizer + sasaza + collecting + has contributions)
  bool canSend(String userId) =>
      isSasaza && isOrganizer(userId) && isCollecting && hasContributions;

  /// Whether the user can distribute (organizer + save + collecting + has contributions)
  bool canDistribute(String userId) =>
      isSave && isOrganizer(userId) && isCollecting && hasContributions;

  /// Whether the user can cancel (organizer + collecting)
  bool canCancel(String userId) => isOrganizer(userId) && isCollecting;

  /// List of non-anonymous contributor names (for display to recipient)
  List<String> get visibleContributorNames => contributions.values
      .where((c) => !c.anonymous)
      .map((c) => c.displayName)
      .toList();

  /// Number of anonymous contributors
  int get anonymousCount =>
      contributions.values.where((c) => c.anonymous).length;

  /// All participant IDs (organizer + invitees)
  List<String> get allParticipantIds => [organizerId, ...inviteeIds];
}
