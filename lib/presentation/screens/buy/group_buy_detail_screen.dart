import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/group_buy.dart';
import '../../../domain/entities/group_buy_contribution.dart';
import '../../../domain/enums/group_buy_status.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
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
              backgroundColor: AppColors.success,
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
              backgroundColor: AppColors.error,
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
          appBar: AppBar(
            title: Text(groupBuy?.title ?? 'Group Buy'),
            backgroundColor: AppColors.surface,
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
    if (state.isLoading && groupBuy == null) {
      return _buildShimmer();
    }

    if (groupBuy == null) {
      return Center(
        child: Text(
          state.errorMessage ?? 'Group buy not found',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    final isBrand = groupBuy.isBrandSponsored;
    final accentColor = isBrand ? AppColors.gold : AppColors.secondary;

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
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Status badge
          _buildStatusBadge(groupBuy, accentColor),
          const SizedBox(height: AppSpacing.md),

          // Title
          Text(
            groupBuy.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          // Organizer
          Text(
            'Organized by ${groupBuy.organizerName}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Progress section
          _buildProgressSection(groupBuy),
          const SizedBox(height: AppSpacing.lg),

          // Countdown
          if (groupBuy.status.isActive) ...[
            _buildCountdownSection(groupBuy),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Description
          if (groupBuy.description.isNotEmpty) ...[
            const Text(
              'About this deal',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              groupBuy.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
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

          // Participants / contributions
          _buildContributions(state.contributions),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(GroupBuy groupBuy, Color accentColor) {
    final isTerminal = groupBuy.status.isTerminal;
    final label = groupBuy.status.displayName;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isTerminal
            ? AppColors.border
            : accentColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: isTerminal ? AppColors.textTertiary : accentColor,
        ),
      ),
    );
  }

  Widget _buildProgressSection(GroupBuy groupBuy) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
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
                  color: AppColors.textSecondary,
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
              Icon(Icons.people_outline, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                groupBuy.maxParticipants != null
                    ? '${groupBuy.participantCount} of ${groupBuy.maxParticipants} participants'
                    : '${groupBuy.participantCount} participants',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              if (groupBuy.spotsLeft != null && groupBuy.spotsLeft! <= 10)
                Text(
                  '${groupBuy.spotsLeft} spots left!',
                  style: const TextStyle(
                    color: AppColors.error,
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
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          const Text(
            'Ends in',
            style: TextStyle(
              color: AppColors.textSecondary,
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
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.storefront_outlined,
                color: AppColors.textHint,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Expanded(
              child: Text(
                'View linked listing',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
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
                      color: AppColors.textSecondary,
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
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        if (contributions.isEmpty)
          const Text(
            'No contributions yet. Be the first to join!',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          )
        else
          ...contributions.map(_buildContributionTile),
      ],
    );
  }

  Widget _buildContributionTile(GroupBuyContribution contribution) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.secondary.withValues(alpha: 0.15),
              child: Text(
                contribution.userName.isNotEmpty
                    ? contribution.userName[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                contribution.userName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                ),
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
    // Determine if the current user has already contributed
    final uid = _currentUserId;
    final hasContributed = uid != null &&
        state.contributions.any((c) => c.userId == uid);
    final isOpen = groupBuy.status == GroupBuyStatus.open;

    // Nothing to show if not open and user can't join
    if (!groupBuy.canJoin && !hasContributed) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Leave button (if user has contributed and deal is still open)
            if (hasContributed && isOpen) ...[
              Expanded(
                child: AppButton(
                  text: 'Leave',
                  isLoading: state.isLeaving,
                  loadingText: 'Leaving...',
                  onPressed: () => _showLeaveDialog(groupBuy),
                  variant: AppButtonVariant.outline,
                ),
              ),
              if (groupBuy.canJoin) const SizedBox(width: AppSpacing.sm),
            ],
            // Join button
            if (groupBuy.canJoin)
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
          ],
        ),
      ),
    );
  }

  String? get _currentUserId => context.read<AuthBloc>().state.user?.id;

  void _showLeaveDialog(GroupBuy groupBuy) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        title: const Text(
          'Leave this deal?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'Your contribution will be refunded to your wallet. '
          'You can rejoin later if spots are still available.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
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
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Leave & Refund'),
          ),
        ],
      ),
    );
  }

  void _showJoinDialog(GroupBuy groupBuy) {
    final amountController = TextEditingController();
    final walletState = context.read<WalletBloc>().state;
    final spendableSubAccounts = walletState.subAccounts
        .where((sa) => sa.isActive && !sa.isRestricted)
        .toList();
    var selectedWalletId = 'primary';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.surfaceElevated,
          title: const Text(
            'Join this deal',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How many tokens would you like to contribute?',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Amount in tokens',
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                initialValue: selectedWalletId,
                dropdownColor: AppColors.surfaceElevated,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Pay from',
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'primary',
                    child: Text(
                      'Main Wallet (${walletState.mainWalletAvailable} tokens)',
                      style: const TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                  ...spendableSubAccounts.map(
                    (sa) => DropdownMenuItem(
                      value: sa.id,
                      child: Text(
                        '${sa.name} (${sa.balance} tokens)',
                        style: const TextStyle(color: AppColors.textPrimary),
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
            ],
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
                Navigator.of(ctx).pop();
                context.read<GroupBuyBloc>().add(
                      GroupBuyEvent.joinGroupBuy(
                        groupBuyId: groupBuy.id,
                        amount: amount,
                        walletId: selectedWalletId,
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

  void _onShare(GroupBuy groupBuy) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surfaceElevated,
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
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.primary,
              ),
              title: const Text(
                'Share to Chat',
                style: TextStyle(color: AppColors.textPrimary),
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
                color: AppColors.textSecondary,
              ),
              title: const Text(
                'Copy Link',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                Clipboard.setData(
                  ClipboardData(
                    text:
                        'https://imalichat.app/buy/group-buys/${groupBuy.id}',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link copied!'),
                    backgroundColor: AppColors.success,
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
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 24,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              height: 28,
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
