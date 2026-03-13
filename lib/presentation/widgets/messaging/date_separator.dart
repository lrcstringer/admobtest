import 'package:flutter/material.dart';

import '../../../core/utils/chat_date_formatter.dart';
import '../../theme/app_colors.dart';

/// Date header between message groups in a chat view.
class DateSeparator extends StatelessWidget {
  final DateTime date;

  const DateSeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.chatSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            ChatDateFormatter.formatDateHeader(date),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ),
    );
  }

  /// Check if two dates are on the same calendar day.
  /// Delegates to [ChatDateFormatter.isSameDay].
  static bool isSameDay(DateTime a, DateTime b) =>
      ChatDateFormatter.isSameDay(a, b);
}
