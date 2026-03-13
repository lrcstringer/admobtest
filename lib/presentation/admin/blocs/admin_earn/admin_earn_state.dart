part of 'admin_earn_bloc.dart';

enum AdminEarnStatus { initial, loading, loaded, error }

@freezed
abstract class AdminEarnState with _$AdminEarnState {
  const factory AdminEarnState({
    // Status
    @Default(AdminEarnStatus.initial) AdminEarnStatus status,
    String? errorMessage,
    String? successMessage,

    // Statistics
    Map<String, dynamic>? statistics,
    Map<String, dynamic>? targetingOptions,
    Map<String, dynamic>? clientStats,
    Map<String, dynamic>? threadAnalytics,

    // Clients
    @Default([]) List<Map<String, dynamic>> clients,
    String? selectedClientId,

    // Threads
    @Default([]) List<Map<String, dynamic>> threads,
    String? selectedThreadId,

    // Opportunities
    @Default([]) List<Map<String, dynamic>> opportunities,

    // Loading states
    @Default(false) bool isLoadingStatistics,
    @Default(false) bool isLoadingClients,
    @Default(false) bool isLoadingThreads,
    @Default(false) bool isLoadingOpportunities,
    @Default(false) bool isLoadingClientStats,
    @Default(false) bool isLoadingThreadAnalytics,
    @Default(false) bool isSaving,
  }) = _AdminEarnState;

  const AdminEarnState._();

  Map<String, dynamic>? get selectedClient {
    if (selectedClientId == null) return null;
    try {
      return clients.firstWhere((c) => c['id'] == selectedClientId);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic>? get selectedThread {
    if (selectedThreadId == null) return null;
    try {
      return threads.firstWhere((t) => t['id'] == selectedThreadId);
    } catch (_) {
      return null;
    }
  }

  int get activeClientsCount =>
      clients.where((c) => c['isActive'] == true).length;

  int get activeThreadsCount =>
      threads.where((t) => t['isActive'] == true).length;

  int get activeOpportunitiesCount =>
      opportunities.where((o) => o['isActive'] == true).length;
}
