import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/earn_thread.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';
import '../../widgets/earn/engagement_history_sheet.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  @override
  void initState() {
    super.initState();
    // Load threads when screen opens
    context.read<EarnBloc>().add(const EarnEvent.loadThreads());
    context.read<EarnBloc>().add(const EarnEvent.loadHistory(limit: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(
        title: 'Earn',
        extraActions: [
          IconButton(
            icon: const Icon(Icons.history, color: AppColors.textPrimary),
            onPressed: () => _showHistory(context),
          ),
        ],
      ),
      body: BlocConsumer<EarnBloc, EarnState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<EarnBloc>().add(const EarnEvent.clearError());
          }

          // Refresh wallet ledger when engagement completes to show updated balance
          if (state.engagementPhase == EngagementPhase.completed) {
            context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
          }
        },
        builder: (context, state) {
          if (state.status == EarnStatus.loading && state.threads.isEmpty) {
            return const WaveBackground(
                child: Center(child: CircularProgressIndicator()));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<EarnBloc>().add(const EarnEvent.refresh());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: WaveBackground(
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDailyProgressCard(context, state),
                      AppSpacing.verticalSm,
                      _buildThreadsSection(context, state),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDailyProgressCard(BuildContext context, EarnState state) {
    final completions = state.dailyCompletions;
    final cap = state.dailyEarnCap;
    final progress = (completions / cap).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.goldGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$completions / $cap Opportunities',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textOnSecondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              GestureDetector(
                onTap: () => _showDistributionSheet(context),
                child: Text(
                  'How earnings work',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textOnSecondary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textOnSecondary,
                      ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSm,
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.textOnSecondary.withValues(alpha: 0.3),
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.textOnSecondary),
          ),
          AppSpacing.verticalXs,
          Text(
            state.dailyLimitReached
                ? 'Daily limit reached!'
                : '${(progress * 100).toStringAsFixed(0)}% of daily limit',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textOnSecondary.withValues(alpha: 0.8),
                ),
          ),
        ],
      ),
    );
  }

  void _showDistributionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How Your Earnings Are Distributed',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalLg,
            _buildDistributionRow(context, '90%', 'Your Wallet', AppColors.success),
            AppSpacing.verticalSm,
            _buildDistributionRow(context, '5%', 'Daily Pot', AppColors.primary),
            AppSpacing.verticalSm,
            _buildDistributionRow(context, '5%', 'Weekly Pot', AppColors.secondary),
            AppSpacing.verticalLg,
            Text(
              'Pot contributions give you chances to win bonus tokens in daily and weekly draws!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalMd,
          ],
        ),
      ),
    );
  }

  Widget _buildDistributionRow(
    BuildContext context,
    String percentage,
    String label,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        AppSpacing.horizontalSm,
        Text(
          percentage,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        AppSpacing.horizontalSm,
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildThreadsSection(BuildContext context, EarnState state) {
    if (state.threads.isEmpty && state.status != EarnStatus.loading) {
      return _buildEmptyState(context);
    }

    // Separate featured and regular threads
    final featuredThreads =
        state.threads.where((t) => t.isFeatured).toList();
    final regularThreads =
        state.threads.where((t) => !t.isFeatured).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Daily limit reached banner
        if (state.dailyLimitReached) ...[
          _buildDailyLimitBanner(context),
          AppSpacing.verticalMd,
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Earning Opportunities',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '${state.totalAvailableOpportunities} available',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        AppSpacing.verticalMd,
        // Featured threads first
        if (featuredThreads.isNotEmpty) ...[
          ...featuredThreads.map((thread) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildThreadCard(
                  context,
                  thread,
                  isFeatured: true,
                  isDisabled: state.dailyLimitReached,
                ),
              )),
        ],
        // Then regular threads
        ...regularThreads.map((thread) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildThreadCard(
                context,
                thread,
                isDisabled: state.dailyLimitReached,
              ),
            )),
      ],
    );
  }

  Widget _buildDailyLimitBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.celebration,
            color: AppColors.success,
            size: 24,
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good going!',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                ),
                AppSpacing.verticalXs,
                Text(
                  'You have reached the 30 completions per day limit. This will reset at midnight tonight so that you can keep earning.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreadCard(
    BuildContext context,
    EarnThread thread, {
    bool isFeatured = false,
    bool isDisabled = false,
  }) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: InkWell(
        onTap: isDisabled ? null : () => _navigateToThread(context, thread),
        borderRadius: AppSpacing.borderRadiusMd,
        child: Container(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(
              color: isFeatured
                  ? AppColors.accent
                  : thread.isPinned
                      ? AppColors.primary
                      : AppColors.border,
              width: isFeatured || thread.isPinned ? 2 : 1,
            ),
          ),
        child: Row(
          children: [
            _buildClientAvatar(context, thread),
            AppSpacing.horizontalMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.title,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      if (isFeatured)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.2),
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: Text(
                            'Featured',
                            style:
                                Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      if (thread.isPinned && !isFeatured)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.push_pin,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    thread.clientName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  AppSpacing.verticalXs,
                  Row(
                    children: [
                      Text(
                        '${thread.availableOpportunities} opportunities',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      if (thread.completedOpportunities > 0) ...[
                        Text(
                          ' · ',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textHint,
                                  ),
                        ),
                        Text(
                          '${thread.completedOpportunities} completed',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.success,
                                  ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildClientAvatar(BuildContext context, EarnThread thread) {
    final color = thread.clientAvatarColor != null
        ? Color(
            int.parse(thread.clientAvatarColor!.replaceFirst('#', '0xFF')))
        : AppColors.primary;

    if (thread.clientAvatarImage != null) {
      return CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(thread.clientAvatarImage!),
      );
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: color.withValues(alpha: 0.2),
      child: Text(
        thread.clientName.isNotEmpty ? thread.clientName[0].toUpperCase() : 'C',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monetization_on_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            AppSpacing.verticalLg,
            Text(
              'No opportunities available',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Check back later for new earning opportunities',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToThread(BuildContext context, EarnThread thread) {
    context.read<EarnBloc>().add(EarnEvent.selectThread(thread.id));
    context.push('/earn/thread/${thread.id}');
  }

  void _showHistory(BuildContext context) {
    EngagementHistorySheet.show(context);
  }
}
