import 'package:flutter/material.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/enums/pool_status.dart';
import '../../theme/app_colors.dart';
import '../gift/gift_card_painters.dart';

/// Message bubble for a group gift (Group Sasaza) in the recipient's P2P chat.
class GroupGiftBubble extends StatelessWidget {
  final GroupGiftMessageData data;
  final bool isMe;
  final bool isRecipient;
  final VoidCallback? onOpen;
  final VoidCallback? onClaim;

  const GroupGiftBubble({
    super.key,
    required this.data,
    required this.isMe,
    required this.isRecipient,
    this.onOpen,
    this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    final colors = GiftStyleColors.forStyle(data.style);
    final theme = Theme.of(context);

    return Container(
      width: 220,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.iconColor.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.iconColor.withValues(alpha: 0.15),
            blurRadius: 8,
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
                      .map((c) => c.withValues(alpha: 0.2))
                      .toList(),
                ),
              ),
            ),
          ),

          // Decorative paint
          Positioned.fill(
            child: CustomPaint(
              painter: giftStylePainter(data.style, opacity: 0.5),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Text(
                  'Group Sasaza',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.iconColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Icon
                Icon(
                  Icons.card_giftcard,
                  size: 36,
                  color: colors.iconColor,
                ),
                const SizedBox(height: 6),

                // "From X and N others"
                Text(
                  _fromLine,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),

                // Amount
                Text(
                  '${data.amount} tokens',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.tokenGold,
                  ),
                ),
                const SizedBox(height: 4),

                // Message
                if (data.message.isNotEmpty) ...[
                  Text(
                    data.message,
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                ],

                // Action / status
                _buildAction(context, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _fromLine {
    final names = data.visibleContributorNames;
    final anon = data.anonymousCount;
    final total = data.contributorCount;

    if (total == 1 && names.isNotEmpty) {
      return 'From ${names.first}';
    }
    if (names.isNotEmpty) {
      final othersCount = total - 1;
      return 'From ${names.first} and $othersCount other${othersCount > 1 ? 's' : ''}';
    }
    if (anon > 0) {
      return 'From $anon anonymous contributor${anon > 1 ? 's' : ''}';
    }
    return 'From ${data.organizerName}';
  }

  Widget _buildAction(BuildContext context, GiftStyleColors colors) {
    switch (data.status) {
      case PoolStatus.completed:
        return _buildBadge('Claimed', AppColors.success);
      case PoolStatus.expired:
        return _buildBadge('Expired', AppColors.textHint);
      case PoolStatus.sent:
        if (isRecipient && onOpen != null) {
          return _buildButton('Tap to Open', colors.iconColor, onOpen!);
        }
        return _buildBadge('Sent', colors.iconColor);
      default:
        return _buildBadge(data.status.displayName, AppColors.textSecondary);
    }
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.2),
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(text),
      ),
    );
  }
}
