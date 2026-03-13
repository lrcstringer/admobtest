import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/group_buy.dart';
import '../../../domain/enums/group_buy_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'countdown_timer_widget.dart';
import 'group_buy_progress_bar.dart';

/// Card for displaying a group buy (Hlangana deal) in list views.
///
/// Cyan-blue gradient background for community-organized deals,
/// gold gradient for brand-sponsored deals. Shows progress bar,
/// countdown timer, participant count, scarcity label, and join CTA.
class GroupBuyCard extends StatelessWidget {
  final GroupBuy groupBuy;
  final VoidCallback? onTap;
  final VoidCallback? onJoinTap;

  const GroupBuyCard({
    super.key,
    required this.groupBuy,
    this.onTap,
    this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    final isBrand = groupBuy.isBrandSponsored;
    final accentColor = isBrand ? AppColors.gold : AppColors.buyGroupBuyAccent;
    final isTerminal = groupBuy.status.isTerminal;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.alphaBlend(
                accentColor.withValues(alpha: 0.06),
                AppColors.buyCard,
              ),
              Color.alphaBlend(
                accentColor.withValues(alpha: 0.02),
                AppColors.buyCard,
              ),
            ],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isTerminal
                ? AppColors.buyCardBorder
                : accentColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row + brand badge / status
            Row(
              children: [
                if (isBrand && groupBuy.brandLogoUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: groupBuy.brandLogoUrl!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => Icon(
                        Icons.store,
                        size: 24,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    groupBuy.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isTerminal
                          ? AppColors.buyTextTertiary
                          : AppColors.buyTextPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildStatusBadge(accentColor, isTerminal),
              ],
            ),
            const SizedBox(height: 12),

            // Progress bar
            GroupBuyProgressBar(
              progress: groupBuy.progress,
              currentAmount: groupBuy.currentAmount,
              targetAmount: groupBuy.targetAmount,
            ),
            const SizedBox(height: 10),

            // Countdown + Participants row
            Row(
              children: [
                // Countdown
                if (!isTerminal) ...[
                  Icon(Icons.timer_outlined, size: 14, color: AppColors.buyTextSecondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: CountdownTimerWidget(
                      deadline: groupBuy.deadline,
                      fontSize: 13,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Text(
                      groupBuy.status.displayName,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.buyTextTertiary,
                      ),
                    ),
                  ),
                ],

                // Participants
                Icon(Icons.people_outline, size: 14, color: AppColors.buyTextSecondary),
                const SizedBox(width: 4),
                Text(
                  groupBuy.maxParticipants != null
                      ? '${groupBuy.participantCount} of ${groupBuy.maxParticipants}'
                      : '${groupBuy.participantCount} joined',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.buyTextSecondary,
                  ),
                ),
              ],
            ),

            // Scarcity label + Join CTA
            if (!isTerminal) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Scarcity / discount label
                  if (groupBuy.spotsLeft != null && groupBuy.spotsLeft! <= 10)
                    Text(
                      '${groupBuy.spotsLeft} spots left!',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buyError,
                      ),
                    )
                  else if (isBrand && groupBuy.discountPercent != null)
                    Text(
                      '${groupBuy.discountPercent}% off bulk',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                      ),
                    )
                  else
                    const SizedBox.shrink(),

                  // Join button
                  if (groupBuy.canJoin)
                    GestureDetector(
                      onTap: onJoinTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isBrand
                                ? AppColors.tertiaryGradient
                                : [AppColors.buyGroupBuyAccent, Color(0xFF10B981)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Join',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(Color accentColor, bool isTerminal) {
    final label = groupBuy.status == GroupBuyStatus.targetMet
        ? 'Target Met!'
        : isBrandSponsored
            ? 'Brand Deal'
            : 'Hlangana';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isTerminal
            ? AppColors.buyCardBorder
            : accentColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isTerminal ? AppColors.buyTextTertiary : accentColor,
        ),
      ),
    );
  }

  bool get isBrandSponsored => groupBuy.isBrandSponsored;
}
