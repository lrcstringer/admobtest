import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/earn_notification.dart';
import '../../../domain/entities/inbox_client.dart';
import '../../../domain/repositories/earn_repository.dart';

part 'earn_inbox_bloc.freezed.dart';
part 'earn_inbox_event.dart';
part 'earn_inbox_state.dart';

@injectable
class EarnInboxBloc extends Bloc<EarnInboxEvent, EarnInboxState> {
  final EarnRepository _earnRepository;

  EarnInboxBloc(this._earnRepository) : super(const EarnInboxState()) {
    on<_LoadInbox>(_onLoadInbox);
    on<_RefreshInbox>(_onRefreshInbox);
    on<_ToggleClient>(_onToggleClient);
    on<_LoadNotifications>(_onLoadNotifications);
    on<_MarkNotificationRead>(_onMarkNotificationRead);
    on<_MarkAllNotificationsRead>(_onMarkAllNotificationsRead);
    on<_ClearError>(_onClearError);
  }

  Future<void> _onLoadInbox(
    _LoadInbox event,
    Emitter<EarnInboxState> emit,
  ) async {
    emit(state.copyWith(status: EarnInboxStatus.loading, errorMessage: null));

    final result = await _earnRepository.getEligibleInbox();

    result.fold(
      (failure) => emit(state.copyWith(
        status: EarnInboxStatus.error,
        errorMessage: failure.maybeMap(
          serverError: (e) => e.message,
          orElse: () => 'Failed to load inbox',
        ),
      )),
      (inbox) => emit(state.copyWith(
        status: EarnInboxStatus.loaded,
        clients: inbox.clients,
        dailyCompletions: inbox.dailyCompletions,
        dailyEarnCap: inbox.dailyEarnCap,
        dailyLimitReached: inbox.dailyLimitReached,
      )),
    );

    // Also load notifications
    add(const EarnInboxEvent.loadNotifications());
  }

  Future<void> _onRefreshInbox(
    _RefreshInbox event,
    Emitter<EarnInboxState> emit,
  ) async {
    final result = await _earnRepository.getEligibleInbox();

    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: failure.maybeMap(
          serverError: (e) => e.message,
          orElse: () => 'Failed to refresh inbox',
        ),
      )),
      (inbox) => emit(state.copyWith(
        status: EarnInboxStatus.loaded,
        clients: inbox.clients,
        dailyCompletions: inbox.dailyCompletions,
        dailyEarnCap: inbox.dailyEarnCap,
        dailyLimitReached: inbox.dailyLimitReached,
        errorMessage: null,
      )),
    );

    add(const EarnInboxEvent.loadNotifications());
  }

  void _onToggleClient(
    _ToggleClient event,
    Emitter<EarnInboxState> emit,
  ) {
    final newExpanded =
        state.expandedClientId == event.clientId ? null : event.clientId;
    emit(state.copyWith(expandedClientId: newExpanded));
  }

  Future<void> _onLoadNotifications(
    _LoadNotifications event,
    Emitter<EarnInboxState> emit,
  ) async {
    emit(state.copyWith(isLoadingNotifications: true));

    final result = await _earnRepository.getEarnNotifications();

    result.fold(
      (failure) => emit(state.copyWith(isLoadingNotifications: false)),
      (notifications) {
        final unreadCount = notifications.where((n) => n.isUnread).length;
        emit(state.copyWith(
          notifications: notifications,
          unreadNotificationCount: unreadCount,
          isLoadingNotifications: false,
        ));
      },
    );
  }

  Future<void> _onMarkNotificationRead(
    _MarkNotificationRead event,
    Emitter<EarnInboxState> emit,
  ) async {
    // Optimistic update
    final updated = state.notifications.map((n) {
      if (n.id == event.notificationId) {
        return n.copyWith(read: true);
      }
      return n;
    }).toList();

    final newUnread = updated.where((n) => n.isUnread).length;
    emit(state.copyWith(
      notifications: updated,
      unreadNotificationCount: newUnread,
    ));

    await _earnRepository.markNotificationRead(event.notificationId);
  }

  Future<void> _onMarkAllNotificationsRead(
    _MarkAllNotificationsRead event,
    Emitter<EarnInboxState> emit,
  ) async {
    final updated =
        state.notifications.map((n) => n.copyWith(read: true)).toList();

    emit(state.copyWith(
      notifications: updated,
      unreadNotificationCount: 0,
    ));

    await _earnRepository.markAllNotificationsRead();
  }

  void _onClearError(
    _ClearError event,
    Emitter<EarnInboxState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }
}
