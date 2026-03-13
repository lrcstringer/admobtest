import 'package:freezed_annotation/freezed_annotation.dart';

part 'earn_notification.freezed.dart';
part 'earn_notification.g.dart';

/// In-app earn notification displayed at the top of the earn inbox
@freezed
abstract class EarnNotification with _$EarnNotification {
  const factory EarnNotification({
    required String id,
    required String type, // new_client, new_thread, new_opportunity, expiry_warning
    required String title,
    required String body,
    @Default({}) Map<String, dynamic> data,
    required bool read,
    required DateTime createdAt,
  }) = _EarnNotification;

  const EarnNotification._();

  factory EarnNotification.fromJson(Map<String, dynamic> json) =>
      _$EarnNotificationFromJson(json);

  /// Whether this notification is unread
  bool get isUnread => !read;

  /// Time ago display string
  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${createdAt.day}/${createdAt.month}';
  }
}
