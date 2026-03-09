import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Amber banner showing offline status with last-synced timestamp.
class BuyOfflineBanner extends StatelessWidget {
  final DateTime? lastSyncedAt;

  const BuyOfflineBanner({super.key, this.lastSyncedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.warning.withValues(alpha: 0.15),
      child: Row(
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 16,
            color: AppColors.warning,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _buildMessage(),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.warning,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildMessage() {
    if (lastSyncedAt == null) {
      return "You're offline \u00b7 Showing saved data";
    }
    final ago = _timeAgo(lastSyncedAt!);
    return "You're offline \u00b7 Showing saved data \u00b7 Updated $ago";
  }

  String _timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
