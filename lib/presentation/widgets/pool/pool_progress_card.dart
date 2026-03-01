import 'package:flutter/material.dart';

import '../../../domain/entities/token_pool.dart';
import '../../../domain/enums/pool_mode.dart';
import '../../../domain/enums/pool_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../gift/gift_card_painters.dart';

/// Sticky header card showing pool progress in a collection room.
class PoolProgressCard extends StatelessWidget {
  final TokenPool pool;
  final String currentUserId;
  final VoidCallback? onContribute;
  final VoidCallback? onSend;
  final VoidCallback? onDistribute;
  final VoidCallback? onCancel;

  const PoolProgressCard({
    super.key,
    required this.pool,
    required this.currentUserId,
    this.onContribute,
    this.onSend,
    this.onDistribute,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = GiftStyleColors.forStyle(pool.style);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.iconColor.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.iconColor.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gradient background
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors.gradient
                      .map((c) => c.withValues(alpha: 0.15))
                      .toList(),
                ),
              ),
            ),
          ),

          // Decorative paint
          Positioned.fill(
            child: CustomPaint(
              painter: giftStylePainter(pool.style, opacity: 0.3),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mode badge + title
                _buildHeader(theme, colors),
                AppSpacing.verticalSm,

                // Recipient or "Shared Pool"
                _buildRecipientRow(theme),
                AppSpacing.verticalMd,

                // Amount + contributor count
                _buildAmountRow(theme, colors),

                // Expiry countdown (sasaza only)
                if (pool.isSasaza && pool.expiresAt != null && pool.isCollecting)
                  _buildExpiryRow(theme),

                AppSpacing.verticalMd,

                // Action buttons or status banner
                if (pool.isTerminal)
                  _buildStatusBanner(theme, colors)
                else
                  _buildActionButtons(context, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, GiftStyleColors colors) {
    return Row(
      children: [
        // Mode badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colors.iconColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            pool.mode.displayName,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.iconColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            pool.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientRow(ThemeData theme) {
    final subtitle = pool.isSasaza
        ? 'Gift for ${pool.recipientName ?? 'Unknown'}'
        : 'Shared Pool';
    return Row(
      children: [
        Icon(
          pool.isSasaza ? Icons.card_giftcard : Icons.savings_outlined,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountRow(ThemeData theme, GiftStyleColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.toll, size: 20, color: AppColors.tokenGold),
        const SizedBox(width: 6),
        Text(
          '${pool.totalAmount}',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.tokenGold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'tokens',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Icon(Icons.people_outline, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          '${pool.contributorCount} contributor${pool.contributorCount != 1 ? 's' : ''}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryRow(ThemeData theme) {
    final remaining = pool.expiresAt!.difference(DateTime.now());
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;

    String expiryText;
    Color expiryColor;
    if (days > 3) {
      expiryText = '$days days left';
      expiryColor = AppColors.textSecondary;
    } else if (days > 0) {
      expiryText = '$days day${days > 1 ? 's' : ''} left';
      expiryColor = AppColors.warning;
    } else if (hours > 0) {
      expiryText = '$hours hour${hours > 1 ? 's' : ''} left';
      expiryColor = AppColors.error;
    } else {
      expiryText = 'Expiring soon';
      expiryColor = AppColors.error;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(Icons.timer_outlined, size: 14, color: expiryColor),
          const SizedBox(width: 4),
          Text(
            expiryText,
            style: theme.textTheme.bodySmall?.copyWith(color: expiryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBanner(ThemeData theme, GiftStyleColors colors) {
    String label;
    Color color;
    IconData icon;

    switch (pool.status) {
      case PoolStatus.sent:
        label = 'Gift Sent';
        color = AppColors.secondary;
        icon = Icons.send;
      case PoolStatus.completed:
        label = pool.isSasaza ? 'Claimed' : 'Distributed';
        color = AppColors.success;
        icon = Icons.check_circle;
      case PoolStatus.cancelled:
        label = 'Cancelled — Refunded';
        color = AppColors.error;
        icon = Icons.cancel;
      case PoolStatus.expired:
        label = 'Expired';
        color = AppColors.textHint;
        icon = Icons.timer_off;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, GiftStyleColors colors) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        // Contribute button (everyone, when collecting)
        if (pool.canContribute(currentUserId))
          _ActionButton(
            label: 'Contribute',
            icon: Icons.add_circle_outline,
            color: colors.iconColor,
            onTap: onContribute,
          ),

        // Send button (sasaza, organizer only)
        if (pool.canSend(currentUserId))
          _ActionButton(
            label: 'Send to ${pool.recipientName ?? 'Recipient'}',
            icon: Icons.send,
            color: AppColors.success,
            onTap: onSend,
          ),

        // Distribute button (save, organizer only)
        if (pool.canDistribute(currentUserId))
          _ActionButton(
            label: 'Distribute',
            icon: Icons.account_balance_wallet,
            color: AppColors.success,
            onTap: onDistribute,
          ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.15),
        foregroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
