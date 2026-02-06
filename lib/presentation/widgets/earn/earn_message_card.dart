import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Type of earn message for styling
enum EarnMessageType {
  success,
  warning,
  info,
  milestone,
  incentive,
}

/// Card widget for displaying earn-related messages
/// Supports completion messages, milestones, incentives, etc.
class EarnMessageCard extends StatelessWidget {
  final EarnMessageType type;
  final String title;
  final String message;
  final int? tokens;
  final DateTime? timestamp;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const EarnMessageCard({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    this.tokens,
    this.timestamp,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _backgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _icon,
                  color: _iconColor,
                  size: 24,
                ),
              ),
              SizedBox(width: AppSpacing.sm),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style:
                                Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: _titleColor,
                                    ),
                          ),
                        ),
                        if (onDismiss != null)
                          GestureDetector(
                            onTap: onDismiss,
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    if (tokens != null || timestamp != null) ...[
                      SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          if (tokens != null) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gold.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    size: 14,
                                    color: AppColors.gold,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '+$tokens',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.gold,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                          if (timestamp != null)
                            Text(
                              _formatTimestamp(timestamp!),
                              style:
                                  Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppColors.textHint,
                                      ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (type) {
      case EarnMessageType.success:
        return AppColors.success.withValues(alpha: 0.1);
      case EarnMessageType.warning:
        return AppColors.warning.withValues(alpha: 0.1);
      case EarnMessageType.info:
        return AppColors.primary.withValues(alpha: 0.1);
      case EarnMessageType.milestone:
        return AppColors.gold.withValues(alpha: 0.1);
      case EarnMessageType.incentive:
        return AppColors.secondary.withValues(alpha: 0.1);
    }
  }

  Color get _iconBackgroundColor {
    switch (type) {
      case EarnMessageType.success:
        return AppColors.success.withValues(alpha: 0.2);
      case EarnMessageType.warning:
        return AppColors.warning.withValues(alpha: 0.2);
      case EarnMessageType.info:
        return AppColors.primary.withValues(alpha: 0.2);
      case EarnMessageType.milestone:
        return AppColors.gold.withValues(alpha: 0.2);
      case EarnMessageType.incentive:
        return AppColors.secondary.withValues(alpha: 0.2);
    }
  }

  Color get _iconColor {
    switch (type) {
      case EarnMessageType.success:
        return AppColors.success;
      case EarnMessageType.warning:
        return AppColors.warning;
      case EarnMessageType.info:
        return AppColors.primary;
      case EarnMessageType.milestone:
        return AppColors.gold;
      case EarnMessageType.incentive:
        return AppColors.secondary;
    }
  }

  Color get _titleColor {
    switch (type) {
      case EarnMessageType.success:
        return AppColors.success;
      case EarnMessageType.warning:
        return AppColors.warning;
      case EarnMessageType.info:
        return AppColors.primary;
      case EarnMessageType.milestone:
        return AppColors.gold;
      case EarnMessageType.incentive:
        return AppColors.secondary;
    }
  }

  IconData get _icon {
    switch (type) {
      case EarnMessageType.success:
        return Icons.check_circle;
      case EarnMessageType.warning:
        return Icons.warning_amber;
      case EarnMessageType.info:
        return Icons.info;
      case EarnMessageType.milestone:
        return Icons.emoji_events;
      case EarnMessageType.incentive:
        return Icons.card_giftcard;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}

/// Factory for common message types
class EarnMessages {
  EarnMessages._();

  /// Engagement completed successfully
  static EarnMessageCard completion({
    required int tokens,
    String? clientName,
    DateTime? timestamp,
    VoidCallback? onTap,
  }) {
    return EarnMessageCard(
      type: EarnMessageType.success,
      title: 'Engagement Complete!',
      message: clientName != null
          ? 'You completed an engagement with $clientName'
          : 'You successfully completed an engagement',
      tokens: tokens,
      timestamp: timestamp,
      onTap: onTap,
    );
  }

  /// Daily streak milestone
  static EarnMessageCard streakMilestone({
    required int days,
    required double multiplier,
    VoidCallback? onTap,
  }) {
    return EarnMessageCard(
      type: EarnMessageType.milestone,
      title: '$days Day Streak!',
      message: 'You\'re earning ${multiplier}x tokens with your streak bonus',
      onTap: onTap,
    );
  }

  /// New opportunities available
  static EarnMessageCard newOpportunities({
    required int count,
    VoidCallback? onTap,
  }) {
    return EarnMessageCard(
      type: EarnMessageType.info,
      title: 'New Opportunities',
      message: '$count new earning opportunities are available for you',
      onTap: onTap,
    );
  }

  /// Opportunity expiring soon
  static EarnMessageCard expiringOpportunity({
    required String title,
    required int tokens,
    required int hoursLeft,
    VoidCallback? onTap,
  }) {
    return EarnMessageCard(
      type: EarnMessageType.warning,
      title: 'Expiring Soon',
      message: '"$title" expires in $hoursLeft hours',
      tokens: tokens,
      onTap: onTap,
    );
  }

  /// Bonus/incentive available
  static EarnMessageCard bonus({
    required String title,
    required String message,
    int? tokens,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    return EarnMessageCard(
      type: EarnMessageType.incentive,
      title: title,
      message: message,
      tokens: tokens,
      onTap: onTap,
      onDismiss: onDismiss,
    );
  }
}
