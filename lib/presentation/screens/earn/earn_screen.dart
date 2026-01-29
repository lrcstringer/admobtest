import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/earn_thread.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

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
        showHomeButton: false,
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
        },
        builder: (context, state) {
          if (state.status == EarnStatus.loading && state.threads.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<EarnBloc>().add(const EarnEvent.loadThreads());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDailyProgressCard(context, state),
                  AppSpacing.verticalXl,
                  _buildThreadsSection(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDailyProgressCard(BuildContext context, EarnState state) {
    final tokensToday = state.tokensEarnedToday;
    const dailyCap = 100; // Daily cap in tokens
    final progress = (tokensToday / dailyCap).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.goldGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Progress',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textOnSecondary.withValues(alpha: 0.8),
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.textOnSecondary.withValues(alpha: 0.2),
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Text(
                  '${state.completedCount} completed',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textOnSecondary,
                      ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSm,
          Text(
            '$tokensToday / $dailyCap Tokens',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textOnSecondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          AppSpacing.verticalSm,
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.textOnSecondary.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOnSecondary),
          ),
          AppSpacing.verticalXs,
          Text(
            progress >= 1.0
                ? 'Daily cap reached! Come back tomorrow.'
                : '${(progress * 100).toStringAsFixed(0)}% of daily cap',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textOnSecondary.withValues(alpha: 0.8),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreadsSection(BuildContext context, EarnState state) {
    if (state.threads.isEmpty && state.status != EarnStatus.loading) {
      return _buildEmptyState(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Brand Opportunities',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '${state.threads.length} brands',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        AppSpacing.verticalMd,
        ...state.threads.map((thread) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildThreadCard(context, thread),
            )),
      ],
    );
  }

  Widget _buildThreadCard(BuildContext context, EarnThread thread) {
    return InkWell(
      onTap: () => _navigateToThread(context, thread),
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: thread.isPinned ? AppColors.primary : AppColors.border,
            width: thread.isPinned ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _buildBrandAvatar(context, thread),
            AppSpacing.horizontalMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.brandName,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      if (thread.isPinned)
                        const Icon(
                          Icons.push_pin,
                          size: 16,
                          color: AppColors.primary,
                        ),
                    ],
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    '${thread.availableOpportunities} opportunities available',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  if (thread.completedOpportunities > 0) ...[
                    AppSpacing.verticalXs,
                    Text(
                      '${thread.completedOpportunities} completed',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.success,
                          ),
                    ),
                  ],
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
    );
  }

  Widget _buildBrandAvatar(BuildContext context, EarnThread thread) {
    final color = thread.avatarColor != null
        ? Color(int.parse(thread.avatarColor!.replaceFirst('#', '0xFF')))
        : AppColors.primary;

    if (thread.avatarImage != null) {
      return CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(thread.avatarImage!),
      );
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: color.withValues(alpha: 0.2),
      child: Text(
        thread.brandName.isNotEmpty ? thread.brandName[0].toUpperCase() : 'B',
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ThreadOpportunitiesScreen(thread: thread),
      ),
    );
  }

  void _showHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const EngagementHistorySheet(),
    );
  }
}

class ThreadOpportunitiesScreen extends StatelessWidget {
  final EarnThread thread;

  const ThreadOpportunitiesScreen({super.key, required this.thread});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(thread.brandName),
      ),
      body: BlocBuilder<EarnBloc, EarnState>(
        builder: (context, state) {
          if (state.opportunities.isEmpty) {
            return const Center(
              child: Text('No opportunities available'),
            );
          }

          return ListView.builder(
            padding: AppSpacing.pagePadding,
            itemCount: state.opportunities.length,
            itemBuilder: (context, index) {
              final opportunity = state.opportunities[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(
                    opportunity.mediaType.name == 'video'
                        ? Icons.smart_display
                        : Icons.image,
                    color: AppColors.primary,
                  ),
                  title: Text(opportunity.title),
                  subtitle: Text(
                    '${opportunity.tokenReward} tokens - ${opportunity.durationSeconds}s',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      context.read<EarnBloc>().add(
                            EarnEvent.startEngagement(
                              opportunityId: opportunity.id,
                            ),
                          );
                    },
                    child: const Text('Start'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EngagementHistorySheet extends StatelessWidget {
  const EngagementHistorySheet({super.key});

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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textHint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
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
                              'No history yet',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        final engagement = state.history[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: engagement.isComplete
                                ? AppColors.success.withValues(alpha: 0.2)
                                : AppColors.error.withValues(alpha: 0.2),
                            child: Icon(
                              engagement.isComplete
                                  ? Icons.check
                                  : Icons.close,
                              color: engagement.isComplete
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                          ),
                          title: Text('Engagement #${engagement.id.substring(0, 8)}'),
                          subtitle: Text(
                            engagement.isComplete
                                ? '+${engagement.tokensEarned ?? 0} tokens'
                                : engagement.status.name,
                          ),
                          trailing: Text(
                            _formatDate(engagement.createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        );
                      },
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
