part of 'group_bloc.dart';

@freezed
abstract class GroupState with _$GroupState {
  const factory GroupState({
    // Status
    @Default(GroupLoadingStatus.initial) GroupLoadingStatus status,
    @Default(GroupOperationStatus.idle) GroupOperationStatus operationStatus,

    // Groups list
    @Default([]) List<Group> groups,
    @Default([]) List<GroupMember> pendingInvitations,

    // Selected group details
    Group? selectedGroup,
    @Default([]) List<GroupMember> selectedGroupMembers,
    @Default([]) List<GroupTransaction> selectedGroupTransactions,
    @Default([]) List<PendingApproval> selectedGroupApprovals,

    // Loading states
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMoreTransactions,

    // Stokvel analytics
    StokvelAnalytics? stokvelAnalytics,
    @Default(false) bool isLoadingAnalytics,

    // Error handling
    String? errorMessage,
    String? successMessage,
  }) = _GroupState;

  const GroupState._();

  /// Check if user is owner of selected group
  bool get isOwner =>
      selectedGroup != null &&
      selectedGroupMembers.any((m) => m.role == GroupRole.owner);

  /// Get current user's membership in selected group
  GroupMember? getMemberByUserId(String userId) =>
      selectedGroupMembers.where((m) => m.userId == userId).firstOrNull;

  /// Get total balance of selected group
  int get selectedGroupBalance => selectedGroup?.totalBalance ?? 0;

  /// Get balance in ZAR (100 tokens = R1)
  double get selectedGroupBalanceZar =>
      AppConstants.tokensToZar(selectedGroupBalance);

  /// Check if selected group has pending approvals
  bool get hasPendingApprovals => selectedGroupApprovals.isNotEmpty;

  /// Get groups by type
  List<Group> getGroupsByType(GroupType type) =>
      groups.where((g) => g.type == type).toList();

  /// Get active groups only
  List<Group> get activeGroups =>
      groups.where((g) => g.status == GroupStatus.active).toList();
}

/// Overall loading status for group list (renamed to avoid conflict with entity GroupStatus)
enum GroupLoadingStatus {
  initial,
  loading,
  loaded,
  error,
}

/// Status for individual operations (create, contribute, etc.)
enum GroupOperationStatus {
  idle,
  processing,
  success,
  failure,
}
