import 'package:flutter/material.dart';

import '../../../domain/enums/gift_status.dart';
import '../../../domain/enums/gift_style.dart';
import '../../theme/app_colors.dart';
import 'gift_card_painters.dart';

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

  @override
  Widget build(BuildContext context) {
    final colors = GiftStyleColors.forStyle(style);
    final iconData = _styleIcon;

    return Container(
      width: 220,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.iconColor.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: colors.iconColor.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Rich multi-color gradient background
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors.gradient
                      .map((c) => c.withValues(alpha: 0.2))
                      .toList(),
                ),
              ),
            ),
          ),

          // Style-specific decorative paint layer
          Positioned.fill(
            child: CustomPaint(
              painter: giftStylePainter(style, opacity: 0.5),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon composition
                _buildIconComposition(colors, iconData),
                const SizedBox(height: 6),
                Text(
                  style.displayName,
                  style: TextStyle(
                    color: colors.iconColor,
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
                _buildAction(context, colors.iconColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconComposition(GiftStyleColors colors, IconData mainIcon) {
    return SizedBox(
      width: 56,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Main icon
          Icon(mainIcon, color: colors.iconColor, size: 40),

          // Accent sparkles for celebration/birthday/love/ndlovukazi
          if (style == GiftStyle.celebration) ...[
            Positioned(
              top: -2,
              right: -4,
              child: Icon(Icons.auto_awesome,
                  color: colors.accent1.withValues(alpha: 0.7), size: 14),
            ),
            Positioned(
              bottom: 2,
              left: -2,
              child: Icon(Icons.star,
                  color: colors.accent2.withValues(alpha: 0.6), size: 12),
            ),
          ],
          if (style == GiftStyle.birthday) ...[
            Positioned(
              top: -4,
              right: -6,
              child: Icon(Icons.celebration,
                  color: colors.accent2.withValues(alpha: 0.6), size: 14),
            ),
            Positioned(
              top: -2,
              left: -4,
              child: Icon(Icons.star,
                  color: colors.accent1.withValues(alpha: 0.5), size: 11),
            ),
          ],
          if (style == GiftStyle.love) ...[
            Positioned(
              top: -2,
              right: -6,
              child: Icon(Icons.favorite,
                  color: colors.accent1.withValues(alpha: 0.5), size: 12),
            ),
            Positioned(
              bottom: 0,
              left: -4,
              child: Icon(Icons.favorite_border,
                  color: colors.accent2.withValues(alpha: 0.4), size: 11),
            ),
          ],
          if (style == GiftStyle.ndlovukazi) ...[
            Positioned(
              top: -4,
              right: -6,
              child: Icon(Icons.star,
                  color: colors.accent2.withValues(alpha: 0.6), size: 13),
            ),
            Positioned(
              bottom: 0,
              left: -3,
              child: Icon(Icons.diamond,
                  color: colors.accent1.withValues(alpha: 0.4), size: 11),
            ),
          ],
        ],
      ),
    );
  }

  IconData get _styleIcon => switch (style) {
        GiftStyle.celebration => Icons.celebration,
        GiftStyle.birthday => Icons.cake,
        GiftStyle.love => Icons.favorite,
        GiftStyle.ndlovukazi => Icons.auto_awesome,
        GiftStyle.professional => Icons.business_center,
      };

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
