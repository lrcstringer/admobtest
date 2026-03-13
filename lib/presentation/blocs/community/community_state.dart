part of 'community_bloc.dart';

/// Loading status for the community list
enum CommunityLoadingStatus { initial, loading, loaded, error }

/// Status for individual community operations
enum CommunityOperationStatus { idle, processing, success, failure }

@freezed
abstract class CommunityState with _$CommunityState {
  const factory CommunityState({
    // Status
    @Default(CommunityLoadingStatus.initial) CommunityLoadingStatus status,
    @Default(CommunityOperationStatus.idle)
    CommunityOperationStatus operationStatus,

    // Communities list
    @Default([]) List<Community> communities,
    @Default([]) List<CommunityMember> pendingInvitations,

    // Selected community details
    Community? selectedCommunity,
    @Default([]) List<CommunityMember> selectedCommunityMembers,
    @Default([]) List<CommunityTransaction> selectedCommunityTransactions,
    @Default([]) List<CommunityApproval> selectedCommunityApprovals,

    // Loading states
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMoreTransactions,

    // Stokvel analytics
    StokvelAnalytics? stokvelAnalytics,
    @Default(false) bool isLoadingAnalytics,

    // Unread
    @Default(0) int totalUnreadCount,

    // Error handling
    String? errorMessage,
    String? successMessage,
  }) = _CommunityState;

  const CommunityState._();

  /// Check if current user is owner of selected community
  bool isOwnerOf(String userId) =>
      selectedCommunity?.isOwner(userId) ?? false;

  /// Get current user's membership in selected community
  CommunityMember? getMemberByUserId(String userId) =>
      selectedCommunityMembers.where((m) => m.userId == userId).firstOrNull;

  /// Get total balance of selected community
  int get selectedCommunityBalance =>
      selectedCommunity?.totalBalance ?? 0;

  /// Get balance in ZAR (100 tokens = R1)
  double get selectedCommunityBalanceZar =>
      selectedCommunityBalance / 100;

  /// Check if selected community has pending approvals
  bool get hasPendingApprovals => selectedCommunityApprovals.isNotEmpty;

  /// Get communities by type
  List<Community> getCommunitiesByType(CommunityType type) =>
      communities.where((c) => c.type == type).toList();

  /// Get active communities only
  List<Community> get activeCommunities =>
      communities.where((c) => c.isActive).toList();
}
