import 'package:flutter/material.dart';

import '../../../domain/enums/gift_status.dart';
import '../../../domain/enums/gift_style.dart';
import '../../theme/app_colors.dart';

/// A gift card rendered inside a message bubble.
/// Shows gift style icon, amount, status, and tap-to-open for recipients.
class GiftBubble extends StatelessWidget {
  final String giftId;
  final int amount;
  final String message;
  final GiftStyle style;
  final GiftStatus status;
  final String? recipientId;
  final String? recipientName;
  final bool isMe;
  final String currentUserId;
  final VoidCallback? onOpen;
  final VoidCallback? onClaim;

  const GiftBubble({
    super.key,
    required this.giftId,
    required this.amount,
    required this.message,
    required this.style,
    required this.status,
    this.recipientId,
    this.recipientName,
    required this.isMe,
    required this.currentUserId,
    this.onOpen,
    this.onClaim,
  });

  bool get _isRecipient => recipientId == currentUserId;

  Color get _styleColor => switch (style) {
    GiftStyle.celebration => AppColors.gold,
    GiftStyle.birthday => AppColors.primary,
    GiftStyle.love => AppColors.error,
    GiftStyle.ndlovukazi => AppColors.purple,
    GiftStyle.professional => AppColors.textTertiary,
  };

  IconData get _styleIcon => switch (style) {
    GiftStyle.celebration => Icons.celebration,
    GiftStyle.birthday => Icons.cake,
    GiftStyle.love => Icons.favorite,
    GiftStyle.ndlovukazi => Icons.auto_awesome,
    GiftStyle.professional => Icons.business_center,
  };

  @override
  Widget build(BuildContext context) {
    final color = _styleColor;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon + style name
          Icon(_styleIcon, color: color, size: 40),
          const SizedBox(height: 8),
          Text(
            style.displayName,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),

          // Amount
          Text(
            '$amount tokens',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Personal message
          if (message.isNotEmpty)
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 8),

          // Status / action
          _buildAction(context, color),
        ],
      ),
    );
  }

  Widget _buildAction(BuildContext context, Color color) {
    if (status == GiftStatus.claimed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Claimed',
          style: TextStyle(color: AppColors.success, fontSize: 12),
        ),
      );
    }

    if (status == GiftStatus.expired) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Expired',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      );
    }

    if (_isRecipient && status == GiftStatus.pending) {
      return ElevatedButton(
        onPressed: onOpen,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size(100, 32),
        ),
        child: const Text('Tap to Open'),
      );
    }

    if (_isRecipient && status == GiftStatus.opened) {
      return ElevatedButton(
        onPressed: onClaim,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size(100, 32),
        ),
        child: const Text('Claim Tokens'),
      );
    }

    // Sender view or other
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}
