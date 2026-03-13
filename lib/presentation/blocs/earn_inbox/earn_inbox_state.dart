part of 'earn_inbox_bloc.dart';

enum EarnInboxStatus { initial, loading, loaded, error }

@freezed
abstract class EarnInboxState with _$EarnInboxState {
  const factory EarnInboxState({
    @Default(EarnInboxStatus.initial) EarnInboxStatus status,
    @Default([]) List<InboxClient> clients,
    String? expandedClientId,
    @Default([]) List<EarnNotification> notifications,
    @Default(0) int unreadNotificationCount,
    @Default(false) bool isLoadingNotifications,
    @Default(0) int dailyCompletions,
    @Default(30) int dailyEarnCap,
    @Default(false) bool dailyLimitReached,
    String? errorMessage,
  }) = _EarnInboxState;

  const EarnInboxState._();

  bool get hasClients => clients.isNotEmpty;

  bool get hasNotifications => notifications.isNotEmpty;

  bool get hasUnreadNotifications => unreadNotificationCount > 0;

  int get totalAvailableOpportunities => clients.fold(
        0,
        (sum, client) =>
            sum +
            client.threads.fold(
              0,
              (tSum, thread) => tSum + thread.availableOpportunities,
            ),
      );
}
