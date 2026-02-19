import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/community_type.dart';
import '../value_objects/token_amount.dart';
import 'group.dart'; // Reuse StokvelSettings as-is

part 'community.freezed.dart';
part 'community.g.dart';

/// Community settings (extends GroupSettings with messaging controls)
@freezed
class CommunitySettings with _$CommunitySettings {
  const factory CommunitySettings({
    @Default(100) int maxMembers,
    @Default(true) bool allowMemberInvites,
    @Default(false) bool onlyAdminsPost,
    @Default(true) bool membersCanShareMedia,
    @Default(false) bool enableFinancials,
    @Default(5000) int requireApprovalAbove,
    @Default(false) bool allowMemberWithdrawals,
    @Default('none') String contributionCycle,
    @Default(0) int contributionAmount,
    @Default(0) int penaltyPercentage,
  }) = _CommunitySettings;

  factory CommunitySettings.fromJson(Map<String, dynamic> json) =>
      _$CommunitySettingsFromJson(json);

  const CommunitySettings._();

  /// Default settings for a community type
  factory CommunitySettings.defaultFor(CommunityType type) {
    switch (type) {
      case CommunityType.stokvel:
        return const CommunitySettings(
          enableFinancials: true,
          allowMemberWithdrawals: false,
          contributionCycle: 'monthly',
          contributionAmount: 1000,
          penaltyPercentage: 5,
          requireApprovalAbove: 5000,
        );
      case CommunityType.regular:
        return const CommunitySettings();
    }
  }
}

/// Community entity
///
/// Represents both regular communities and stokvel communities.
/// Stokvel communities have full financial lifecycle support
/// via the reused [StokvelSettings] from the groups system.
///
/// Collection: communities/{communityId}
@freezed
class Community with _$Community {
  const factory Community({
    required String id,
    required CommunityType type,
    required String name,
    String? description,
    String? avatarUrl,

    // Ownership & membership
    required String ownerId,
    required List<String> memberIds,
    required List<String> adminIds,
    required int memberCount,
    required int totalBalance,
    required String status,

    // Settings
    required CommunitySettings settings,
    StokvelSettings? stokvelSettings,

    // Last message preview (for inbox list)
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    DateTime? lastMessageAt,

    // Per-user state
    required Map<String, int> unreadCounts,
    required Map<String, bool> muted,

    // E2EE: per-user encrypted last message previews
    @Default({}) Map<String, String> lastMessageEncryptedPreviews,

    // Timestamps
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Community;

  const Community._();

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  bool get isStokvel => type == CommunityType.stokvel;
  bool get isActive => status == 'active';
  bool get isSuspended => status == 'suspended';
  bool get isClosed => status == 'closed';
  bool get hasFinancials => settings.enableFinancials;

  bool isMember(String userId) => memberIds.contains(userId);
  bool isAdmin(String userId) => adminIds.contains(userId);
  bool isOwner(String userId) => ownerId == userId;

  int unreadCountFor(String userId) => unreadCounts[userId] ?? 0;
  bool hasUnreadFor(String userId) => unreadCountFor(userId) > 0;
  bool isMutedFor(String userId) => muted[userId] ?? false;

  /// Token balance as TokenAmount
  TokenAmount get tokenBalance => TokenAmount(totalBalance);

  /// Token balance as ZAR (100 tokens = R1)
  double get balanceZar => totalBalance / 100;

  /// Get initials for avatar fallback
  String get displayInitials {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }
}
