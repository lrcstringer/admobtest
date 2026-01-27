import 'package:intl/intl.dart';

/// Utility class for date/time operations
class AppDateUtils {
  AppDateUtils._();

  /// South African Standard Time offset (UTC+2)
  static const Duration sastOffset = Duration(hours: 2);

  /// Get current time in SAST
  static DateTime nowSast() {
    return DateTime.now().toUtc().add(sastOffset);
  }

  /// Convert UTC to SAST
  static DateTime toSast(DateTime utc) {
    return utc.toUtc().add(sastOffset);
  }

  /// Convert SAST to UTC
  static DateTime toUtc(DateTime sast) {
    return sast.subtract(sastOffset);
  }

  /// Format date as "Today", "Yesterday", or "Jan 15"
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    final difference = today.difference(dateOnly).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return DateFormat('EEEE').format(date); // Day name
    } else {
      return DateFormat('MMM d').format(date); // Jan 15
    }
  }

  /// Format time as "10:30 AM"
  static String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// Format date and time as "Jan 15, 10:30 AM"
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM d, h:mm a').format(date);
  }

  /// Format countdown duration as "04h 32m" or "3d 12h"
  static String formatCountdown(Duration duration) {
    if (duration.isNegative) {
      return 'Ended';
    }

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    if (days > 0) {
      return '${days}d ${hours}h';
    } else if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m';
    } else {
      final seconds = duration.inSeconds % 60;
      return '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
    }
  }

  /// Get greeting based on time of day
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  /// Get start of today (midnight)
  static DateTime startOfToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Get start of current week (Monday)
  static DateTime startOfWeek() {
    final now = DateTime.now();
    final daysFromMonday = now.weekday - 1;
    return DateTime(now.year, now.month, now.day - daysFromMonday);
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime date) {
    final start = startOfWeek();
    final end = start.add(const Duration(days: 7));
    return date.isAfter(start) && date.isBefore(end);
  }
}
