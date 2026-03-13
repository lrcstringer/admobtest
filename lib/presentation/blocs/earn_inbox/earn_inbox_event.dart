part of 'earn_inbox_bloc.dart';

@freezed
abstract class EarnInboxEvent with _$EarnInboxEvent {
  /// Load the full inbox (clients + notifications)
  const factory EarnInboxEvent.loadInbox() = _LoadInbox;

  /// Pull-to-refresh — forces reload bypassing cache
  const factory EarnInboxEvent.refreshInbox() = _RefreshInbox;

  /// Expand/collapse a client accordion
  const factory EarnInboxEvent.toggleClient({required String clientId}) =
      _ToggleClient;

  /// Load notifications separately
  const factory EarnInboxEvent.loadNotifications() = _LoadNotifications;

  /// Mark a single notification as read
  const factory EarnInboxEvent.markNotificationRead({
    required String notificationId,
  }) = _MarkNotificationRead;

  /// Mark all notifications as read
  const factory EarnInboxEvent.markAllNotificationsRead() =
      _MarkAllNotificationsRead;

  /// Clear error state
  const factory EarnInboxEvent.clearError() = _ClearError;
}
