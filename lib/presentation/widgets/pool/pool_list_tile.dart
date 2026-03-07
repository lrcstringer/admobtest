import 'package:flutter/material.dart';

import '../../../domain/entities/token_pool.dart';
import '../../../domain/enums/pool_mode.dart';
import '../../../domain/enums/pool_status.dart';
import '../../theme/app_colors.dart';

/// List tile for a TokenPool in the Collections tab.
/// Takes a [TokenPool] entity directly for rich display
/// (status, amount, contributor count).
class PoolListTile extends StatelessWidget {
  final TokenPool pool;
  final String currentUserId;
  final VoidCallback? onTap;

  const PoolListTile({
    super.key,
    required this.pool,
    required this.currentUserId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: _buildAvatar(),
      title: _buildTitle(theme),
      subtitle: _buildSubtitle(theme),
      trailing: _buildTrailing(theme),
    );
  }

  Widget _buildAvatar() {
    final isSave = pool.mode == PoolMode.save;
    final gradientColors = isSave
        ? [
            AppColors.success.withValues(alpha: 0.3),
            AppColors.primary.withValues(alpha: 0.3),
          ]
        : [
            AppColors.primary.withValues(alpha: 0.3),
            AppColors.secondary.withValues(alpha: 0.3),
          ];
    final iconColor = isSave ? AppColors.success : AppColors.primary;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        isSave ? Icons.savings_outlined : Icons.card_giftcard,
        color: iconColor,
        size: 24,
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            pool.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            pool.mode.displayName,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(ThemeData theme) {
    final text = pool.isCollecting || pool.isSent
        ? '${pool.totalAmount} tokens \u00B7 '
            '${pool.contributorCount} contributor${pool.contributorCount != 1 ? 's' : ''}'
        : pool.status.displayName;

    return Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(
        color: AppColors.textSecondary,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _statusColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _formatDate(pool.updatedAt),
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.textHint,
          ),
        ),
      ],
    );
  }

  Color get _statusColor => switch (pool.status) {
        PoolStatus.collecting => AppColors.success,
        PoolStatus.sent => AppColors.secondary,
        PoolStatus.completed => AppColors.textHint,
        PoolStatus.cancelled => AppColors.error,
        PoolStatus.expired => AppColors.textHint,
      };

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${date.day}/${date.month}';
  }
}
