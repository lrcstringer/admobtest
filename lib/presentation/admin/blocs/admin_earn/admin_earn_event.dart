part of 'admin_earn_bloc.dart';

@freezed
class AdminEarnEvent with _$AdminEarnEvent {
  // Statistics
  const factory AdminEarnEvent.loadStatistics() = _LoadStatistics;
  const factory AdminEarnEvent.loadTargetingOptions() = _LoadTargetingOptions;
  const factory AdminEarnEvent.loadClientStats(String clientId) =
      _LoadClientStats;
  const factory AdminEarnEvent.loadThreadAnalytics({
    required String threadId,
    DateTime? startDate,
    DateTime? endDate,
  }) = _LoadThreadAnalytics;

  // Clients
  const factory AdminEarnEvent.loadClients({bool? activeOnly}) = _LoadClients;
  const factory AdminEarnEvent.createClient({
    String? id,
    required String companyName,
    required String displayName,
    String? contactEmail,
    String? contactPhone,
    String? avatarImage,
    String? avatarColor,
    String? industry,
    String? companyRegistration,
    String? vatNumber,
  }) = _CreateClient;
  const factory AdminEarnEvent.updateClient({
    required String clientId,
    String? companyName,
    String? displayName,
    String? contactEmail,
    String? contactPhone,
    String? avatarImage,
    String? avatarColor,
    String? industry,
    String? companyRegistration,
    String? vatNumber,
    bool? isActive,
  }) = _UpdateClient;
  const factory AdminEarnEvent.deleteClient(String clientId) = _DeleteClient;
  const factory AdminEarnEvent.selectClient(String? clientId) = _SelectClient;
  const factory AdminEarnEvent.fundClientSubAccount({
    required String clientId,
    required String subAccountId,
    required int amount,
    String? note,
  }) = _FundClientSubAccount;

  // Threads
  const factory AdminEarnEvent.loadThreadsForClient(String clientId) =
      _LoadThreadsForClient;
  const factory AdminEarnEvent.createThread({
    String? id,
    required String clientId,
    required String title,
    String? description,
    required String tokenSourceSubAccountId,
    String? tokenDestAccountTypeId,
    @Default(false) bool isPinned,
    @Default(false) bool isFeatured,
    @Default(true) bool isActive,
    DateTime? activeFrom,
    DateTime? activeTo,
    Map<String, dynamic>? targeting,
  }) = _CreateThread;
  const factory AdminEarnEvent.selectThread(String? threadId) = _SelectThread;

  // Opportunities
  const factory AdminEarnEvent.loadOpportunitiesForThread(String threadId) =
      _LoadOpportunitiesForThread;
  const factory AdminEarnEvent.createOpportunity({
    String? id,
    required String threadId,
    required String title,
    String? description,
    required String earningType,
    required int tokenReward,
    String? mediaType,
    String? mediaUrl,
    List<Map<String, dynamic>>? questions,
    required int durationSeconds,
    DateTime? expiresAt,
    bool? isActive,
    Map<String, dynamic>? targeting,
  }) = _CreateOpportunity;

  // Clear state
  const factory AdminEarnEvent.clearError() = _ClearError;
  const factory AdminEarnEvent.clearSuccess() = _ClearSuccess;
}
