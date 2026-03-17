import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/security/secure_clipboard.dart';
import '../../../domain/entities/group_buy.dart';
import '../../../domain/entities/group_buy_contribution.dart';
import '../../../domain/enums/group_buy_status.dart';
import '../../../domain/enums/group_buy_type.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../../core/constants/app_constants.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/buy/countdown_timer_widget.dart';
import '../../widgets/buy/group_buy_progress_bar.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/token_display.dart';

/// Detail screen for a single group buy (Hlangana deal).
///
/// Shows animated progress bar, live countdown, participant list,
/// linked listing info, join CTA, and share button.
class GroupBuyDetailScreen extends StatefulWidget {
  final String groupBuyId;

  const GroupBuyDetailScreen({
    super.key,
    required this.groupBuyId,
  });

  @override
  State<GroupBuyDetailScreen> createState() => _GroupBuyDetailScreenState();
}

class _GroupBuyDetailScreenState extends State<GroupBuyDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GroupBuyBloc>()
        .add(GroupBuyEvent.loadGroupBuy(widget.groupBuyId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBuyBloc, GroupBuyState>(
      listenWhen: (prev, curr) =>
          prev.successMessage != curr.successMessage ||
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        if (state.successMessage != null) {
          final shouldPop = state.shouldPopOnSuccess;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.buySuccess,
            ),
          );
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
          if (shouldPop) {
            context.pop();
          } else {
            // Reload to get updated data
            context
                .read<GroupBuyBloc>()
                .add(GroupBuyEvent.loadGroupBuy(widget.groupBuyId));
          }
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.buyError,
            ),
          );
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
        }
      },
      builder: (context, state) {
        final groupBuy = state.selectedGroupBuy;

        return Scaffold(
          backgroundColor: AppColors.buyBackground,
          appBar: AppBar(
            title: Text(groupBuy?.title ?? 'Group Buy'),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.buyTextPrimary,
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: groupBuy != null ? () => _onShare(groupBuy) : null,
              ),
            ],
          ),
          body: _buildBody(state, groupBuy),
          bottomNavigationBar: groupBuy != null
              ? _buildBottomBar(context, state, groupBuy)
              : null,
        );
      },
    );
  }

  Widget _buildBody(GroupBuyState state, GroupBuy? groupBuy) {
    if (state.isLoadingDetail && groupBuy == null) {
      return _buildShimmer();
    }

    if (groupBuy == null) {
      return Center(
        child: Text(
          state.errorMessage ?? 'Group buy not found',
          style: const TextStyle(color: AppColors.buyTextSecondary),
        ),
      );
    }

    final isBrand = groupBuy.isBrandSponsored;
    final accentColor = isBrand ? AppColors.gold : AppColors.buyGroupBuyAccent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image (admin-curated deals)
          if (groupBuy.imageUrl != null && groupBuy.imageUrl!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: Image.network(
                groupBuy.imageUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Status badge row with category
          Row(
            children: [
              _buildStatusBadge(groupBuy, accentColor),
              if (groupBuy.category != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.buyGroupBuyAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    groupBuy.category!,
                    style: const TextStyle(
                      color: AppColors.buyGroupBuyAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              if (groupBuy.deliveryFee != null && groupBuy.deliveryFee! > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.buyWarning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '+${groupBuy.deliveryFee} delivery',
                    style: const TextStyle(
                      color: AppColors.buyWarning,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Delivery status chip
          if (groupBuy.deliveryStatus != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.buyGroupBuyAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_shipping_outlined,
                      size: 14, color: AppColors.buyGroupBuyAccent),
                  const SizedBox(width: 4),
                  Text(
                    'Delivery: ${groupBuy.deliveryStatus!.replaceAll('_', ' ')}',
                    style: const TextStyle(
                      color: AppColors.buyGroupBuyAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),

          // Title
          Text(
            groupBuy.title,
            style: const TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          // Organizer with success rate
          Row(
            children: [
              Text(
                'Organized by ${groupBuy.organizerName ?? 'iMali Team'}',
                style: const TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 13,
                ),
              ),
              if (groupBuy.organizerSuccessRate != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.buySuccess.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${(groupBuy.organizerSuccessRate! * 100).round()}% success',
                    style: const TextStyle(
                      color: AppColors.buySuccess,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Progress section
          _buildProgressSection(groupBuy),
          const SizedBox(height: AppSpacing.lg),

          // Countdown
          if (groupBuy.status.isActive) ...[
            _buildCountdownSection(groupBuy),
            const SizedBox(height: AppSpacing.sm),
            // Deadline extension for organizer
            if (groupBuy.status == GroupBuyStatus.open &&
                groupBuy.organizerId == _currentUserId)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => _showExtendDeadlineDialog(groupBuy),
                  icon: const Icon(Icons.schedule_send, size: 16),
                  label: const Text('Extend deadline'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.buyGroupBuyAccent,
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Description
          if (groupBuy.description.isNotEmpty) ...[
            const Text(
              'About this deal',
              style: TextStyle(
                color: AppColors.buyTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              groupBuy.description,
              style: const TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Linked listing
          if (groupBuy.linkedListingId != null) ...[
            _buildLinkedListing(groupBuy),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Brand info
          if (isBrand) ...[
            _buildBrandInfo(groupBuy),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Collection deadline countdown
          if (groupBuy.collectionDeadline != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.buyCardBorder),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time_outlined,
                      color: AppColors.buyWarning),
                  const SizedBox(width: AppSpacing.sm),
                  const Text(
                    'Collect by',
                    style: TextStyle(
                      color: AppColors.buyTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  CountdownTimerWidget(
                    deadline: groupBuy.collectionDeadline!,
                    fontSize: 18,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Fulfilment instructions
          if (groupBuy.fulfilmentInstructions != null &&
              groupBuy.fulfilmentInstructions!.isNotEmpty) ...[
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(bottom: AppSpacing.md),
              title: const Text(
                'Fulfilment Instructions',
                style: TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              children: [
                Text(
                  groupBuy.fulfilmentInstructions!,
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Participants / contributions
          _buildContributions(state.contributions),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(GroupBuy groupBuy, Color accentColor) {
    final isTerminal = groupBuy.status.isTerminal;
    final isExpired = groupBuy.status == GroupBuyStatus.expired ||
        groupBuy.status == GroupBuyStatus.cancelled;
    final label = groupBuy.status.displayName;

    final Color badgeBg;
    final Color badgeFg;
    if (isExpired) {
      badgeBg = AppColors.buyError.withValues(alpha: 0.15);
      badgeFg = AppColors.buyError;
    } else if (isTerminal) {
      badgeBg = AppColors.buyCardBorder;
      badgeFg = AppColors.buyTextTertiary;
    } else {
      badgeBg = accentColor.withValues(alpha: 0.15);
      badgeFg = accentColor;
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: badgeBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isExpired) ...[
                Icon(Icons.warning_amber_rounded, size: 14, color: badgeFg),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: badgeFg,
                ),
              ),
            ],
          ),
        ),
        if (isExpired) ...[
          const SizedBox(width: 8),
          Text(
            'This deal has ended',
            style: TextStyle(
              color: AppColors.buyError.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProgressSection(GroupBuy groupBuy) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder),
      ),
      child: Column(
        children: [
          // Token target display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Target',
                style: TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 13,
                ),
              ),
              TokenDisplay(
                amount: groupBuy.targetAmount,
                showZar: true,
                style: TokenDisplayStyle.medium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Progress bar
          GroupBuyProgressBar(
            progress: groupBuy.progress,
            currentAmount: groupBuy.currentAmount,
            targetAmount: groupBuy.targetAmount,
            height: 10,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Participant count
          Row(
            children: [
              Icon(Icons.people_outline, size: 16, color: AppColors.buyTextSecondary),
              const SizedBox(width: 6),
              Text(
                groupBuy.maxParticipants != null
                    ? '${groupBuy.participantCount} of ${groupBuy.maxParticipants} participants'
                    : '${groupBuy.participantCount} participants',
                style: const TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              if (groupBuy.spotsLeft != null && groupBuy.spotsLeft! <= 10)
                Text(
                  '${groupBuy.spotsLeft} spots left!',
                  style: const TextStyle(
                    color: AppColors.buyError,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownSection(GroupBuy groupBuy) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: AppColors.buyTextSecondary),
          const SizedBox(width: AppSpacing.sm),
          const Text(
            'Ends in',
            style: TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          CountdownTimerWidget(
            deadline: groupBuy.deadline,
            fontSize: 20,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedListing(GroupBuy groupBuy) {
    return GestureDetector(
      onTap: () => context.push(
        '/buy/marketplace/listing/${groupBuy.linkedListingId}',
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.buyCardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.storefront_outlined,
                color: AppColors.buyTextTertiary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Expanded(
              child: Text(
                'View linked listing',
                style: TextStyle(
                  color: AppColors.buyGroupBuyAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.buyTextSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandInfo(GroupBuy groupBuy) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withValues(alpha: 0.08),
            AppColors.gold.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified, color: AppColors.gold, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sponsored by ${groupBuy.brandName ?? 'Brand Partner'}',
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (groupBuy.discountPercent != null)
                  Text(
                    '${groupBuy.discountPercent}% off bulk pricing',
                    style: const TextStyle(
                      color: AppColors.buyTextSecondary,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributions(List<GroupBuyContribution> contributions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contributions (${contributions.length})',
          style: const TextStyle(
            color: AppColors.buyTextPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        if (contributions.isEmpty)
          const Text(
            'No contributions yet. Be the first to join!',
            style: TextStyle(color: AppColors.buyTextSecondary, fontSize: 13),
          )
        else
          ...contributions.map(_buildContributionTile),
      ],
    );
  }

  Widget _buildContributionTile(GroupBuyContribution contribution) {
    final isCurrentUser = contribution.userId == _currentUserId;
    final dateStr =
        '${contribution.contributedAt.day}/${contribution.contributedAt.month}/${contribution.contributedAt.year}';
    final walletLabel =
        contribution.walletId == 'primary' ? 'Main Wallet' : contribution.walletId;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? AppColors.buyGroupBuyAccent.withValues(alpha: 0.05)
              : AppColors.buyCard,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: isCurrentUser
              ? Border.all(color: AppColors.buyGroupBuyAccent.withValues(alpha: 0.2))
              : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.buyGroupBuyAccent.withValues(alpha: 0.15),
              child: Text(
                contribution.userName.isNotEmpty
                    ? contribution.userName[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: AppColors.buyGroupBuyAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        contribution.userName,
                        style: const TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 13,
                        ),
                      ),
                      if (isCurrentUser) ...[
                        const SizedBox(width: 4),
                        const Text(
                          '(You)',
                          style: TextStyle(
                            color: AppColors.buyGroupBuyAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isCurrentUser
                        ? '$dateStr \u00b7 $walletLabel'
                        : dateStr,
                    style: const TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            TokenDisplay(
              amount: contribution.amount,
              style: TokenDisplayStyle.small,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    GroupBuyState state,
    GroupBuy groupBuy,
  ) {
    final uid = _currentUserId;
    final isOrganizer = uid != null && groupBuy.organizerId == uid;
    final hasContributed = uid != null &&
        state.contributions.any((c) => c.userId == uid);
    final isOpen = groupBuy.status == GroupBuyStatus.open;
    final isTargetMet = groupBuy.status == GroupBuyStatus.targetMet;
    final isCompleted = groupBuy.status == GroupBuyStatus.completed;

    final buttons = <Widget>[];

    // Leave button (if user has contributed and deal is still open)
    if (hasContributed && isOpen) {
      buttons.add(
        Expanded(
          child: AppButton(
            text: 'Leave',
            isLoading: state.isLeaving,
            loadingText: 'Leaving...',
            onPressed: () => _showLeaveDialog(groupBuy),
            variant: AppButtonVariant.outline,
          ),
        ),
      );
    }

    // Join button (hidden if user already contributed)
    if (groupBuy.canJoin && !hasContributed) {
      buttons.add(
        Expanded(
          child: AppButton(
            text: 'Join · ${groupBuy.formattedTarget}',
            isLoading: state.isJoining,
            loadingText: 'Joining...',
            onPressed: () => _showJoinDialog(groupBuy),
            variant: groupBuy.isBrandSponsored
                ? AppButtonVariant.secondary
                : AppButtonVariant.primary,
          ),
        ),
      );
    }

    // Cancel button (organizer only, while open)
    if (isOpen && isOrganizer) {
      buttons.add(
        Expanded(
          child: AppButton(
            text: 'Cancel',
            isLoading: state.isCancelling,
            loadingText: 'Cancelling...',
            onPressed: () => _showCancelDialog(groupBuy),
            variant: AppButtonVariant.danger,
          ),
        ),
      );
    }

    // Complete button (organizer only, when target met)
    if (isTargetMet && isOrganizer) {
      buttons.add(
        Expanded(
          child: AppButton(
            text: 'Complete & Release Funds',
            isLoading: state.isCompleting,
            loadingText: 'Completing...',
            onPressed: () => _showCompleteDialog(groupBuy),
            variant: AppButtonVariant.primary,
          ),
        ),
      );
    }

    // Confirm Collection button (completed, user has contributed)
    if (isCompleted && hasContributed) {
      final userContribution = state.contributions.firstWhere(
        (c) => c.userId == uid,
      );
      if (!userContribution.hasCollected) {
        buttons.add(
          Expanded(
            child: AppButton(
              text: 'Confirm Collection',
              isLoading: state.isConfirmingCollection,
              loadingText: 'Confirming...',
              onPressed: () {
                context.read<GroupBuyBloc>().add(
                      GroupBuyEvent.confirmCollection(
                        groupBuyId: groupBuy.id,
                        contributionId: userContribution.id,
                      ),
                    );
              },
              variant: AppButtonVariant.secondary,
            ),
          ),
        );
      }
    }

    // Delivery Status Update (organizer only, when completed)
    if (isCompleted && isOrganizer) {
      buttons.add(
        Expanded(
          child: _buildDeliveryStatusDropdown(groupBuy),
        ),
      );
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    // Add spacing between buttons
    final spacedChildren = <Widget>[];
    for (var i = 0; i < buttons.length; i++) {
      spacedChildren.add(buttons[i]);
      if (i < buttons.length - 1) {
        spacedChildren.add(const SizedBox(width: AppSpacing.sm));
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.buyCard,
        border: Border(
          top: BorderSide(color: AppColors.buyCardBorder, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Row(children: spacedChildren),
      ),
    );
  }

  Widget _buildDeliveryStatusDropdown(GroupBuy groupBuy) {
    const deliveryStatuses = {
      'preparing': 'Preparing',
      'shipped': 'Shipped',
      'in_transit': 'In Transit',
      'delivered': 'Delivered',
    };
    return DropdownButtonFormField<String>(
      initialValue: groupBuy.deliveryStatus ?? 'preparing',
      dropdownColor: AppColors.buyCard,
      style: const TextStyle(color: AppColors.buyTextPrimary, fontSize: 13),
      decoration: InputDecoration(
        labelText: 'Delivery Status',
        labelStyle: const TextStyle(color: AppColors.buyTextSecondary, fontSize: 12),
        filled: true,
        fillColor: AppColors.buyCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.buyCardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.buyCardBorder),
        ),
      ),
      items: deliveryStatuses.entries
          .map((e) => DropdownMenuItem(
                value: e.key,
                child: Text(
                  e.value,
                  style: const TextStyle(fontSize: 13),
                ),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null && value != groupBuy.deliveryStatus) {
          context.read<GroupBuyBloc>().add(
                GroupBuyEvent.updateDeliveryStatus(
                  groupBuyId: groupBuy.id,
                  deliveryStatus: value,
                ),
              );
        }
      },
    );
  }

  void _showCompleteDialog(GroupBuy groupBuy) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.buyCard,
        title: const Text(
          'Complete this deal?',
          style: TextStyle(color: AppColors.buyTextPrimary),
        ),
        content: const Text(
          'This will release the escrowed funds. '
          'Make sure all participants are satisfied before proceeding.',
          style: TextStyle(color: AppColors.buyTextSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<GroupBuyBloc>().add(
                    GroupBuyEvent.completeGroupBuy(
                      groupBuyId: groupBuy.id,
                    ),
                  );
            },
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(GroupBuy groupBuy) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.buyCard,
        title: const Text(
          'Cancel this deal?',
          style: TextStyle(color: AppColors.buyTextPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'All contributions will be refunded. This cannot be undone.',
              style: TextStyle(color: AppColors.buyTextSecondary, fontSize: 13),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: reasonController,
              style: const TextStyle(color: AppColors.buyTextPrimary),
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Reason (optional)',
                hintStyle: const TextStyle(color: AppColors.buyTextTertiary),
                filled: true,
                fillColor: AppColors.buyCard,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  borderSide: const BorderSide(color: AppColors.buyCardBorder),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Back'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              final reason = reasonController.text.trim();
              context.read<GroupBuyBloc>().add(
                    GroupBuyEvent.cancelGroupBuy(
                      groupBuyId: groupBuy.id,
                      reason: reason.isNotEmpty ? reason : null,
                    ),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.buyError),
            child: const Text('Cancel Deal'),
          ),
        ],
      ),
    );
  }

  String? get _currentUserId => context.read<AuthBloc>().state.user?.id;

  void _showLeaveDialog(GroupBuy groupBuy) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.buyCard,
        title: const Text(
          'Leave this deal?',
          style: TextStyle(color: AppColors.buyTextPrimary),
        ),
        content: const Text(
          'Your contribution will be refunded to your wallet. '
          'You can rejoin later if spots are still available.',
          style: TextStyle(color: AppColors.buyTextSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<GroupBuyBloc>().add(
                    GroupBuyEvent.leaveGroupBuy(
                      groupBuyId: groupBuy.id,
                    ),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.buyError),
            child: const Text('Leave & Refund'),
          ),
        ],
      ),
    );
  }

  void _showJoinDialog(GroupBuy groupBuy) {
    // Refresh wallet to get latest balance before showing dialog
    context.read<WalletBloc>().add(const WalletEvent.refreshLedger());

    final amountController = TextEditingController();
    final walletState = context.read<WalletBloc>().state;
    final spendableSubAccounts = walletState.subAccounts
        .where((sa) => sa.isActive && !sa.isRestricted)
        .toList();
    var selectedWalletId = 'primary';
    String? selectedAddress;
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.buyCard,
          title: const Text(
            'Join this deal',
            style: TextStyle(color: AppColors.buyTextPrimary),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How many tokens would you like to contribute?',
                  style: const TextStyle(color: AppColors.buyTextSecondary, fontSize: 13),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.buyTextPrimary),
                  decoration: InputDecoration(
                    hintText: 'Amount in tokens',
                    hintStyle: const TextStyle(color: AppColors.buyTextTertiary),
                    filled: true,
                    fillColor: AppColors.buyCard,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      borderSide: const BorderSide(color: AppColors.buyCardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      borderSide: const BorderSide(color: AppColors.buyCardBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      borderSide: const BorderSide(color: AppColors.buyGroupBuyAccent),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: selectedWalletId,
                  dropdownColor: AppColors.buyCard,
                  style: const TextStyle(color: AppColors.buyTextPrimary),
                  decoration: InputDecoration(
                    labelText: 'Pay from',
                    labelStyle: const TextStyle(color: AppColors.buyTextSecondary),
                    filled: true,
                    fillColor: AppColors.buyCard,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      borderSide: const BorderSide(color: AppColors.buyCardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      borderSide: const BorderSide(color: AppColors.buyCardBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      borderSide: const BorderSide(color: AppColors.buyGroupBuyAccent),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'primary',
                      child: Text(
                        'Main Wallet (${walletState.mainWalletAvailable} tokens)',
                        style: const TextStyle(color: AppColors.buyTextPrimary),
                      ),
                    ),
                    ...spendableSubAccounts.map(
                      (sa) => DropdownMenuItem(
                        value: sa.id,
                        child: Text(
                          '${sa.name} (${sa.balance} tokens)',
                          style: const TextStyle(color: AppColors.buyTextPrimary),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => selectedWalletId = value);
                    }
                  },
                ),

                // Delivery address for physical group buys
                if (groupBuy.type == GroupBuyType.physical) ...[
                  const SizedBox(height: AppSpacing.md),
                  if (groupBuy.addresses.isNotEmpty)
                    DropdownButtonFormField<String>(
                      dropdownColor: AppColors.buyCard,
                      style: const TextStyle(color: AppColors.buyTextPrimary),
                      decoration: InputDecoration(
                        labelText: 'Delivery/Collection Point',
                        labelStyle: const TextStyle(color: AppColors.buyTextSecondary),
                        filled: true,
                        fillColor: AppColors.buyCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          borderSide: const BorderSide(color: AppColors.buyCardBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          borderSide: const BorderSide(color: AppColors.buyCardBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          borderSide: const BorderSide(color: AppColors.buyGroupBuyAccent),
                        ),
                      ),
                      items: groupBuy.addresses
                          .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() => selectedAddress = value);
                      },
                      validator: (v) =>
                          v == null ? 'Please select a delivery point' : null,
                    )
                  else
                    TextField(
                      controller: addressController,
                      style: const TextStyle(color: AppColors.buyTextPrimary),
                      decoration: InputDecoration(
                        labelText: 'Delivery Address',
                        labelStyle: const TextStyle(color: AppColors.buyTextSecondary),
                        filled: true,
                        fillColor: AppColors.buyCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          borderSide: const BorderSide(color: AppColors.buyCardBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          borderSide: const BorderSide(color: AppColors.buyCardBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          borderSide: const BorderSide(color: AppColors.buyGroupBuyAccent),
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final amount = int.tryParse(amountController.text);
                if (amount == null || amount <= 0) return;

                // G-15: Check against remaining target
                final remainingAmount =
                    groupBuy.targetAmount - groupBuy.currentAmount;
                if (amount > remainingAmount) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Amount exceeds remaining target of $remainingAmount tokens',
                      ),
                      backgroundColor: AppColors.buyError,
                    ),
                  );
                  return;
                }

                // G-16: Warn if amount exceeds wallet balance
                final walletBalance = selectedWalletId == 'primary'
                    ? walletState.mainWalletAvailable
                    : spendableSubAccounts
                        .where((sa) => sa.id == selectedWalletId)
                        .fold(0, (_, sa) => sa.balance);
                if (amount > walletBalance) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Warning: amount exceeds your wallet balance of $walletBalance tokens',
                      ),
                      backgroundColor: AppColors.buyWarning,
                    ),
                  );
                  // Don't return — let the backend reject if truly insufficient
                }

                // Validate address for physical group buys
                if (groupBuy.type == GroupBuyType.physical) {
                  final address = selectedAddress ?? addressController.text.trim();
                  if (address.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please provide a delivery address'),
                        backgroundColor: AppColors.buyError,
                      ),
                    );
                    return;
                  }
                  if (address.length < 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Address must be at least 10 characters long',
                        ),
                        backgroundColor: AppColors.buyError,
                      ),
                    );
                    return;
                  }
                  selectedAddress = address;
                }

                Navigator.of(ctx).pop();
                context.read<GroupBuyBloc>().add(
                      GroupBuyEvent.joinGroupBuy(
                        groupBuyId: groupBuy.id,
                        amount: amount,
                        walletId: selectedWalletId,
                        deliveryAddress: selectedAddress,
                      ),
                    );
              },
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }

  void _showExtendDeadlineDialog(GroupBuy groupBuy) {
    final currentDeadline = groupBuy.deadline;
    var newDeadline = currentDeadline.add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.buyCard,
          title: const Text(
            'Extend Deadline',
            style: TextStyle(color: AppColors.buyTextPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current deadline: ${currentDeadline.day}/${currentDeadline.month}/${currentDeadline.year}',
                style: const TextStyle(
                    color: AppColors.buyTextSecondary, fontSize: 13),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'New deadline: ${newDeadline.day}/${newDeadline.month}/${newDeadline.year}',
                style: const TextStyle(
                    color: AppColors.buyTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      final candidate =
                          newDeadline.add(const Duration(days: -7));
                      if (candidate.isAfter(currentDeadline)) {
                        setDialogState(() => newDeadline = candidate);
                      }
                    },
                    child: const Text('-7 days'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => setDialogState(
                        () => newDeadline = newDeadline.add(const Duration(days: 7))),
                    child: const Text('+7 days'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                context.read<GroupBuyBloc>().add(
                      GroupBuyEvent.extendDeadline(
                        groupBuyId: groupBuy.id,
                        newDeadline: newDeadline,
                      ),
                    );
              },
              child: const Text('Extend'),
            ),
          ],
        ),
      ),
    );
  }

  void _onShare(GroupBuy groupBuy) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.buyCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.buyCardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.buyGroupBuyAccent,
              ),
              title: const Text(
                'Share to Chat',
                style: TextStyle(color: AppColors.buyTextPrimary),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                context.push(
                  '/share/group-buy/${groupBuy.id}',
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.copy,
                color: AppColors.buyTextSecondary,
              ),
              title: const Text(
                'Copy Link',
                style: TextStyle(color: AppColors.buyTextPrimary),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                SecureClipboard.copy(
                  '${AppConstants.deepLinkDomain}/buy/group-buys/${groupBuy.id}',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link copied!'),
                    backgroundColor: AppColors.buySuccess,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.share_outlined,
                color: AppColors.buyTextSecondary,
              ),
              title: const Text(
                'Share via...',
                style: TextStyle(color: AppColors.buyTextPrimary),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                final deepLink =
                    '${AppConstants.deepLinkDomain}/buy/group-buys/${groupBuy.id}';
                SharePlus.instance.share(
                  ShareParams(
                    text: 'Check out this Hlangana deal: ${groupBuy.title}\n$deepLink',
                    subject: 'Hlangana Deal: ${groupBuy.title}',
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.buyShimmerBase,
      highlightColor: AppColors.buyShimmerHigh,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 24,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              height: 28,
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
