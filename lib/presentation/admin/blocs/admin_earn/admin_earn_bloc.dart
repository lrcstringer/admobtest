import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/datasources/remote/admin_earn_remote_datasource.dart';

part 'admin_earn_bloc.freezed.dart';
part 'admin_earn_event.dart';
part 'admin_earn_state.dart';

@injectable
class AdminEarnBloc extends Bloc<AdminEarnEvent, AdminEarnState> {
  final AdminEarnRemoteDataSource _dataSource;

  AdminEarnBloc(this._dataSource) : super(const AdminEarnState()) {
    // Statistics
    on<_LoadStatistics>(_onLoadStatistics);
    on<_LoadTargetingOptions>(_onLoadTargetingOptions);
    on<_LoadClientStats>(_onLoadClientStats);
    on<_LoadThreadAnalytics>(_onLoadThreadAnalytics);

    // Clients
    on<_LoadClients>(_onLoadClients);
    on<_CreateClient>(_onCreateClient);
    on<_UpdateClient>(_onUpdateClient);
    on<_DeleteClient>(_onDeleteClient);
    on<_SelectClient>(_onSelectClient);
    on<_FundClientSubAccount>(_onFundClientSubAccount);

    // Threads
    on<_LoadThreadsForClient>(_onLoadThreadsForClient);
    on<_CreateThread>(_onCreateThread);
    on<_SelectThread>(_onSelectThread);

    // Opportunities
    on<_LoadOpportunitiesForThread>(_onLoadOpportunitiesForThread);
    on<_CreateOpportunity>(_onCreateOpportunity);

    // Clear state
    on<_ClearError>(_onClearError);
    on<_ClearSuccess>(_onClearSuccess);
  }

  // ============================================================================
  // STATISTICS HANDLERS
  // ============================================================================

  Future<void> _onLoadStatistics(
    _LoadStatistics event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isLoadingStatistics: true));
    try {
      final stats = await _dataSource.getEarnStatistics();
      emit(state.copyWith(
        isLoadingStatistics: false,
        statistics: stats,
        status: AdminEarnStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingStatistics: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadTargetingOptions(
    _LoadTargetingOptions event,
    Emitter<AdminEarnState> emit,
  ) async {
    try {
      final options = await _dataSource.getTargetingOptions();
      emit(state.copyWith(targetingOptions: options));
    } catch (e) {
      emit(state.copyWith(
        status: AdminEarnStatus.error,
        errorMessage: 'Failed to load targeting options: $e',
      ));
    }
  }

  Future<void> _onLoadClientStats(
    _LoadClientStats event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isLoadingClientStats: true));
    try {
      final stats = await _dataSource.getClientStats(event.clientId);
      emit(state.copyWith(
        isLoadingClientStats: false,
        clientStats: stats,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingClientStats: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadThreadAnalytics(
    _LoadThreadAnalytics event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isLoadingThreadAnalytics: true));
    try {
      final analytics = await _dataSource.getThreadAnalytics(
        event.threadId,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(state.copyWith(
        isLoadingThreadAnalytics: false,
        threadAnalytics: analytics,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingThreadAnalytics: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ============================================================================
  // CLIENT HANDLERS
  // ============================================================================

  Future<void> _onLoadClients(
    _LoadClients event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isLoadingClients: true));
    try {
      final clients = await _dataSource.listClients(activeOnly: event.activeOnly);
      emit(state.copyWith(
        isLoadingClients: false,
        clients: clients,
        status: AdminEarnStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingClients: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreateClient(
    _CreateClient event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      await _dataSource.createClient(
        id: event.id,
        companyName: event.companyName,
        displayName: event.displayName,
        contactEmail: event.contactEmail,
        contactPhone: event.contactPhone,
        avatarImage: event.avatarImage,
        avatarColor: event.avatarColor,
        industry: event.industry,
        companyRegistration: event.companyRegistration,
        vatNumber: event.vatNumber,
      );
      emit(state.copyWith(
        isSaving: false,
        successMessage: 'Client created successfully',
      ));
      // Reload clients
      add(const AdminEarnEvent.loadClients());
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateClient(
    _UpdateClient event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      await _dataSource.updateClient(
        clientId: event.clientId,
        companyName: event.companyName,
        displayName: event.displayName,
        contactEmail: event.contactEmail,
        contactPhone: event.contactPhone,
        avatarImage: event.avatarImage,
        avatarColor: event.avatarColor,
        industry: event.industry,
        companyRegistration: event.companyRegistration,
        vatNumber: event.vatNumber,
        isActive: event.isActive,
      );
      emit(state.copyWith(
        isSaving: false,
        successMessage: 'Client updated successfully',
      ));
      // Reload clients
      add(const AdminEarnEvent.loadClients());
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteClient(
    _DeleteClient event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      await _dataSource.deleteClient(event.clientId);
      emit(state.copyWith(
        isSaving: false,
        successMessage: 'Client deactivated successfully',
        selectedClientId: null,
      ));
      // Reload clients
      add(const AdminEarnEvent.loadClients());
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSelectClient(
    _SelectClient event,
    Emitter<AdminEarnState> emit,
  ) {
    emit(state.copyWith(
      selectedClientId: event.clientId,
      threads: [],
      selectedThreadId: null,
      opportunities: [],
    ));
    if (event.clientId != null) {
      add(AdminEarnEvent.loadThreadsForClient(event.clientId!));
      add(AdminEarnEvent.loadClientStats(event.clientId!));
    }
  }

  Future<void> _onFundClientSubAccount(
    _FundClientSubAccount event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      await _dataSource.fundClientSubAccount(
        clientId: event.clientId,
        subAccountId: event.subAccountId,
        amount: event.amount,
        note: event.note,
      );
      emit(state.copyWith(
        isSaving: false,
        successMessage:
            'Successfully funded ${event.amount} tokens to sub-account',
      ));
      // Reload client stats
      add(AdminEarnEvent.loadClientStats(event.clientId));
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ============================================================================
  // THREAD HANDLERS
  // ============================================================================

  Future<void> _onLoadThreadsForClient(
    _LoadThreadsForClient event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isLoadingThreads: true));
    try {
      final threads = await _dataSource.listThreadsForClient(event.clientId);
      emit(state.copyWith(
        isLoadingThreads: false,
        threads: threads,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingThreads: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreateThread(
    _CreateThread event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      await _dataSource.createOrUpdateThread(
        id: event.id,
        clientId: event.clientId,
        title: event.title,
        description: event.description,
        tokenSourceSubAccountId: event.tokenSourceSubAccountId,
        tokenDestAccountTypeId: event.tokenDestAccountTypeId,
        isPinned: event.isPinned,
        isFeatured: event.isFeatured,
        isActive: event.isActive,
        activeFrom: event.activeFrom,
        activeTo: event.activeTo,
        targeting: event.targeting,
      );
      emit(state.copyWith(
        isSaving: false,
        successMessage: 'Thread saved successfully',
      ));
      // Reload threads
      add(AdminEarnEvent.loadThreadsForClient(event.clientId));
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSelectThread(
    _SelectThread event,
    Emitter<AdminEarnState> emit,
  ) {
    emit(state.copyWith(
      selectedThreadId: event.threadId,
      opportunities: [],
    ));
    if (event.threadId != null) {
      add(AdminEarnEvent.loadOpportunitiesForThread(event.threadId!));
      add(AdminEarnEvent.loadThreadAnalytics(threadId: event.threadId!));
    }
  }

  // ============================================================================
  // OPPORTUNITY HANDLERS
  // ============================================================================

  Future<void> _onLoadOpportunitiesForThread(
    _LoadOpportunitiesForThread event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isLoadingOpportunities: true));
    try {
      final opportunities =
          await _dataSource.listOpportunitiesForThread(event.threadId);
      emit(state.copyWith(
        isLoadingOpportunities: false,
        opportunities: opportunities,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingOpportunities: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreateOpportunity(
    _CreateOpportunity event,
    Emitter<AdminEarnState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      await _dataSource.createOrUpdateOpportunity(
        id: event.id,
        threadId: event.threadId,
        title: event.title,
        description: event.description,
        earningType: event.earningType,
        tokenReward: event.tokenReward,
        mediaType: event.mediaType ?? 'video',
        mediaUrl: event.mediaUrl,
        questions: event.questions ?? [],
        durationSeconds: event.durationSeconds,
        expiresAt: event.expiresAt,
        isActive: event.isActive ?? true,
        targeting: event.targeting,
      );
      emit(state.copyWith(
        isSaving: false,
        successMessage: 'Opportunity saved successfully',
      ));
      // Reload opportunities
      add(AdminEarnEvent.loadOpportunitiesForThread(event.threadId));
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        status: AdminEarnStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ============================================================================
  // CLEAR STATE HANDLERS
  // ============================================================================

  void _onClearError(
    _ClearError event,
    Emitter<AdminEarnState> emit,
  ) {
    emit(state.copyWith(
      status: AdminEarnStatus.loaded,
      errorMessage: null,
    ));
  }

  void _onClearSuccess(
    _ClearSuccess event,
    Emitter<AdminEarnState> emit,
  ) {
    emit(state.copyWith(successMessage: null));
  }
}
