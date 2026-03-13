/// Shared date formatting utility for all messaging screens.
///
/// Eliminates duplicated date-formatting logic across conversation list tiles,
/// community list tiles, date separators, and starred messages.
class ChatDateFormatter {
  ChatDateFormatter._();

  /// Cached "today" to avoid repeated DateTime.now() calls.
  static DateTime? _cachedToday;
  static DateTime? _cachedYesterday;

  static DateTime get _today {
    final now = DateTime.now();
    if (_cachedToday == null || !isSameDay(_cachedToday!, now)) {
      _cachedToday = DateTime(now.year, now.month, now.day);
      _cachedYesterday = _cachedToday!.subtract(const Duration(days: 1));
    }
    return _cachedToday!;
  }

  /// Check if two dates are on the same calendar day.
  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Format for conversation/community list rows.
  /// Returns "HH:MM" for today, "Yesterday", weekday name, or "d/M".
  static String formatListTimestamp(DateTime date) {
    final today = _today;
    if (isSameDay(date, today)) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    if (isSameDay(date, _cachedYesterday!)) return 'Yesterday';
    final diff = today.difference(date);
    if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[date.weekday - 1];
    }
    return '${date.day}/${date.month}';
  }

  /// Format for date separator headers in chat view.
  /// Returns "Today", "Yesterday", full weekday name, or "d/M/yyyy".
  static String formatDateHeader(DateTime date) {
    final today = _today;
    if (isSameDay(date, today)) return 'Today';
    if (isSameDay(date, _cachedYesterday!)) return 'Yesterday';
    final diff = today.difference(date);
    if (diff.inDays < 7) {
      const days = [
        'Monday', 'Tuesday', 'Wednesday', 'Thursday',
        'Friday', 'Saturday', 'Sunday',
      ];
      return days[date.weekday - 1];
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Format for relative time display (starred messages, etc.).
  /// Returns "Just now", "Xm ago", "Xh ago", "Xd ago", or "d/M/yyyy".
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
