import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/earn/earn_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet widget for displaying engagement history
/// Supports pagination via loadMoreHistory event
class EngagementHistorySheet extends StatelessWidget {
  const EngagementHistorySheet({super.key});

  /// Show the history sheet as a modal bottom sheet
  static void show(BuildContext context) {
    // Load initial history
    context.read<EarnBloc>().add(const EarnEvent.loadHistory());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EngagementHistorySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textHint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Earning History',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Content
              Expanded(
                child: BlocBuilder<EarnBloc, EarnState>(
                  builder: (context, state) {
                    if (state.isLoadingHistory && state.history.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.history.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 64,
                              color: AppColors.textHint,
                            ),
                            AppSpacing.verticalMd,
                            Text(
                              'No earning history yet',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              'Complete opportunities to see your history',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textHint),
                            ),
                          ],
                        ),
                      );
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        // Load more when near bottom
                        if (notification is ScrollEndNotification &&
                            notification.metrics.extentAfter < 100 &&
                            state.hasMoreHistory &&
                            !state.isLoadingHistory) {
                          context
                              .read<EarnBloc>()
                              .add(const EarnEvent.loadMoreHistory());
                        }
                        return false;
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount:
                            state.history.length + (state.hasMoreHistory ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Loading indicator at bottom
                          if (index >= state.history.length) {
                            return Padding(
                              padding: EdgeInsets.all(AppSpacing.md),
                              child: Center(
                                child: state.isLoadingHistory
                                    ? const CircularProgressIndicator()
                                    : const SizedBox.shrink(),
                              ),
                            );
                          }

                          final engagement = state.history[index];
                          final totalTokens = engagement.tokensEarned ?? 0;

                          return Card(
                            margin: EdgeInsets.only(bottom: AppSpacing.sm),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: engagement.isComplete
                                    ? AppColors.success.withValues(alpha: 0.2)
                                    : engagement.isFailed
                                        ? AppColors.error.withValues(alpha: 0.2)
                                        : AppColors.warning.withValues(alpha: 0.2),
                                child: Icon(
                                  engagement.isComplete
                                      ? Icons.check
                                      : engagement.isFailed
                                          ? Icons.close
                                          : Icons.hourglass_top,
                                  color: engagement.isComplete
                                      ? AppColors.success
                                      : engagement.isFailed
                                          ? AppColors.error
                                          : AppColors.warning,
                                ),
                              ),
                              title: Text(
                                'Engagement #${engagement.id.substring(0, 8)}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              subtitle: engagement.isComplete
                                  ? _buildEarningsBreakdown(context, totalTokens)
                                  : Text(
                                      engagement.isFailed
                                          ? engagement.failureReason ?? 'Failed'
                                          : engagement.status.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: engagement.isFailed
                                                ? AppColors.error
                                                : AppColors.textSecondary,
                                          ),
                                    ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (engagement.isComplete)
                                    Text(
                                      '+$totalTokens',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: AppColors.gold,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  Text(
                                    _formatDate(engagement.createdAt),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEarningsBreakdown(BuildContext context, int totalTokens) {
    // Calculate 90/5/5 split
    final walletAmount = (totalTokens * 0.90).round();
    final dailyPot = (totalTokens * 0.05).round();
    final weeklyPot = totalTokens - walletAmount - dailyPot;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              size: 12,
              color: AppColors.primary,
            ),
            SizedBox(width: 4),
            Text(
              '+$walletAmount to wallet',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Text(
          '+$dailyPot daily pot, +$weeklyPot weekly pot',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        return '${diff.inMinutes}m ago';
      }
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
