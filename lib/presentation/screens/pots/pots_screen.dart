import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/pot_pool.dart';
import '../../../domain/entities/user_score.dart';
import '../../../domain/enums/pot_type.dart';
import '../../blocs/pot/pot_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class PotsScreen extends StatefulWidget {
  const PotsScreen({super.key});

  @override
  State<PotsScreen> createState() => _PotsScreenState();
}

class _PotsScreenState extends State<PotsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load initial data
    final potBloc = context.read<PotBloc>();
    potBloc.add(const PotEvent.watchDailyPot());
    potBloc.add(const PotEvent.watchWeeklyPot());
    potBloc.add(const PotEvent.checkEligibility());
    potBloc.add(const PotEvent.loadLeaderboard(type: PotType.daily, limit: 10));
    potBloc.add(const PotEvent.loadCurrentUserScore(PotType.daily));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pots'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'History'),
          ],
          labelColor: AppColors.primary,
          indicatorColor: AppColors.primary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard_outlined),
            onPressed: () => _showLeaderboardSheet(context),
            tooltip: 'Leaderboard',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActivePotsTab(context),
          _buildHistoryTab(context),
        ],
      ),
    );
  }

  Widget _buildActivePotsTab(BuildContext context) {
    return BlocBuilder<PotBloc, PotState>(
      builder: (context, state) {
        if (state.isLoadingDaily && state.isLoadingWeekly) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<PotBloc>().add(const PotEvent.loadDailyPot());
            context.read<PotBloc>().add(const PotEvent.loadWeeklyPot());
            context.read<PotBloc>().add(const PotEvent.checkEligibility());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Card
                Container(
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.info),
                      AppSpacing.horizontalMd,
                      Expanded(
                        child: Text(
                          'Earn tokens to join pots. Top earners win a share of the pot!',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.info,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalLg,

                // Daily Pot
                if (state.dailyPot != null)
                  _buildPotCard(
                    context,
                    pot: state.dailyPot!,
                    isEligible: state.isDailyEligible,
                    userScore: state.selectedPotType == PotType.daily
                        ? state.currentUserScore
                        : null,
                  ),
                if (state.dailyPot != null) AppSpacing.verticalMd,

                // Weekly Pot
                if (state.weeklyPot != null)
                  _buildPotCard(
                    context,
                    pot: state.weeklyPot!,
                    isEligible: state.isWeeklyEligible,
                    userScore: state.selectedPotType == PotType.weekly
                        ? state.currentUserScore
                        : null,
                  ),

                // Empty state
                if (state.dailyPot == null && state.weeklyPot == null)
                  _buildEmptyState(context, 'No active pots available'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryTab(BuildContext context) {
    return BlocBuilder<PotBloc, PotState>(
      builder: (context, state) {
        if (state.potHistory.isEmpty && !state.isLoadingHistory) {
          // Load history when tab is viewed
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<PotBloc>().add(
                  const PotEvent.loadPotHistory(type: PotType.daily, limit: 20),
                );
          });
        }

        if (state.isLoadingHistory) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.potHistory.isEmpty) {
          return _buildEmptyState(
            context,
            'No completed pots yet',
            subtitle: 'Your pot history will appear here',
          );
        }

        return ListView.separated(
          padding: AppSpacing.pagePadding,
          itemCount: state.potHistory.length,
          separatorBuilder: (_, __) => AppSpacing.verticalMd,
          itemBuilder: (context, index) {
            final pot = state.potHistory[index];
            return _buildHistoryCard(context, pot);
          },
        );
      },
    );
  }

  Widget _buildPotCard(
    BuildContext context, {
    required PotPool pot,
    required bool isEligible,
    UserScore? userScore,
  }) {
    final hasJoined = userScore != null && userScore.rank > 0;
    final timeRemaining = pot.timeRemaining;
    final isClosingSoon = pot.isClosingSoon;

    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: hasJoined
              ? AppColors.success
              : isClosingSoon
                  ? AppColors.warning
                  : AppColors.border,
          width: hasJoined ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    pot.type == PotType.daily
                        ? Icons.wb_sunny
                        : Icons.calendar_month,
                    color: AppColors.tokenGold,
                    size: 24,
                  ),
                  AppSpacing.horizontalSm,
                  Text(
                    pot.periodLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              _buildStatusChip(context, hasJoined, isEligible, isClosingSoon),
            ],
          ),
          AppSpacing.verticalMd,

          // Prize amount
          Container(
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.tokenGold.withValues(alpha: 0.2),
                  AppColors.tokenGold.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, color: AppColors.tokenGold, size: 32),
                AppSpacing.horizontalMd,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prize Pool',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    Text(
                      'R${(pot.totalTokens * 0.01).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.tokenGold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.verticalMd,

          // Stats row
          Row(
            children: [
              Expanded(
                child: _buildPotStat(
                  context,
                  icon: Icons.people,
                  label: 'Players',
                  value: pot.participantCount.toString(),
                  color: AppColors.accent,
                ),
              ),
              Expanded(
                child: _buildPotStat(
                  context,
                  icon: Icons.timer,
                  label: 'Ends in',
                  value: _formatDuration(timeRemaining),
                  color: isClosingSoon ? AppColors.warning : AppColors.info,
                ),
              ),
              Expanded(
                child: _buildPotStat(
                  context,
                  icon: Icons.token,
                  label: 'Tokens',
                  value: _formatNumber(pot.totalTokens),
                  color: AppColors.tokenGold,
                ),
              ),
            ],
          ),

          // User rank if joined
          if (hasJoined) ...[
            AppSpacing.verticalMd,
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUserStat(
                    context,
                    label: 'Your Rank',
                    value: '#${userScore.rank}',
                    icon: Icons.leaderboard,
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.border,
                  ),
                  _buildUserStat(
                    context,
                    label: 'Earned',
                    value: '${userScore.totalTokensEarned}',
                    icon: Icons.token,
                  ),
                  if (userScore.rankChange != null) ...[
                    Container(
                      height: 40,
                      width: 1,
                      color: AppColors.border,
                    ),
                    _buildRankChange(context, userScore.rankChange!),
                  ],
                ],
              ),
            ),
          ],
          AppSpacing.verticalMd,

          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isEligible || hasJoined
                  ? () => _showLeaderboardSheet(context, potType: pot.type)
                  : null,
              icon: Icon(
                hasJoined ? Icons.leaderboard : Icons.play_arrow,
              ),
              label: Text(
                hasJoined
                    ? 'View Leaderboard'
                    : isEligible
                        ? 'Start Earning'
                        : 'Complete 1 Engagement to Join',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    hasJoined ? AppColors.textSecondary : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(
    BuildContext context,
    bool hasJoined,
    bool isEligible,
    bool isClosingSoon,
  ) {
    Color color;
    String text;

    if (hasJoined) {
      color = AppColors.success;
      text = 'Joined';
    } else if (isClosingSoon) {
      color = AppColors.warning;
      text = 'Closing Soon';
    } else if (isEligible) {
      color = AppColors.primary;
      text = 'Open';
    } else {
      color = AppColors.textSecondary;
      text = 'Locked';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildUserStat(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.success),
            AppSpacing.horizontalXs,
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
            ),
          ],
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildRankChange(BuildContext context, int change) {
    final isUp = change > 0;
    final color = isUp ? AppColors.success : AppColors.error;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isUp ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
              color: color,
            ),
            Text(
              change.abs().toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
        Text(
          'Change',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(BuildContext context, PotPool pot) {
    final winners = pot.winners ?? [];
    final topWinner = winners.isNotEmpty ? winners.first : null;

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pot.periodLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                _formatDate(pot.periodEnd),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
          AppSpacing.verticalSm,
          Row(
            children: [
              Icon(Icons.emoji_events, color: AppColors.tokenGold, size: 20),
              AppSpacing.horizontalSm,
              Text(
                'Prize: R${(pot.totalTokens * 0.01).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              Text(
                '${pot.participantCount} players',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
          if (topWinner != null) ...[
            AppSpacing.verticalSm,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.tokenGold.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Row(
                children: [
                  const Icon(Icons.military_tech, color: AppColors.tokenGold, size: 20),
                  AppSpacing.horizontalSm,
                  Text(
                    'Winner: ${topWinner.displayName}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '+${topWinner.tokensWon} tokens',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPotStat(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        AppSpacing.verticalXs,
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    String title, {
    String? subtitle,
  }) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            AppSpacing.verticalLg,
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (subtitle != null) ...[
              AppSpacing.verticalSm,
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showLeaderboardSheet(BuildContext context, {PotType? potType}) {
    final bloc = context.read<PotBloc>();
    final type = potType ?? bloc.state.selectedPotType;

    bloc.add(PotEvent.selectPotType(type));
    bloc.add(PotEvent.loadLeaderboard(type: type, limit: 50));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: _LeaderboardSheet(initialType: type),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return 'Ending...';
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _LeaderboardSheet extends StatefulWidget {
  final PotType initialType;

  const _LeaderboardSheet({required this.initialType});

  @override
  State<_LeaderboardSheet> createState() => _LeaderboardSheetState();
}

class _LeaderboardSheetState extends State<_LeaderboardSheet> {
  late PotType _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: AppSpacing.pagePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leaderboard',
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
          // Tab selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    context,
                    label: 'Daily',
                    isSelected: _selectedType == PotType.daily,
                    onTap: () {
                      setState(() => _selectedType = PotType.daily);
                      context.read<PotBloc>().add(
                            const PotEvent.loadLeaderboard(
                              type: PotType.daily,
                              limit: 50,
                            ),
                          );
                    },
                  ),
                ),
                AppSpacing.horizontalSm,
                Expanded(
                  child: _buildTabButton(
                    context,
                    label: 'Weekly',
                    isSelected: _selectedType == PotType.weekly,
                    onTap: () {
                      setState(() => _selectedType = PotType.weekly);
                      context.read<PotBloc>().add(
                            const PotEvent.loadLeaderboard(
                              type: PotType.weekly,
                              limit: 50,
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalMd,
          // Leaderboard list
          Expanded(
            child: BlocBuilder<PotBloc, PotState>(
              builder: (context, state) {
                if (state.isLoadingLeaderboard) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.leaderboard.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.leaderboard_outlined,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                        AppSpacing.verticalMd,
                        Text(
                          'No rankings yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        AppSpacing.verticalSm,
                        Text(
                          'Start earning to appear on the leaderboard!',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: AppSpacing.pagePadding,
                  itemCount: state.leaderboard.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final score = state.leaderboard[index];
                    return _buildLeaderboardItem(context, score, index + 1);
                  },
                );
              },
            ),
          ),
          // Current user's position
          BlocBuilder<PotBloc, PotState>(
            builder: (context, state) {
              if (state.currentUserScore == null ||
                  state.currentUserScore!.rank == 0) {
                return const SizedBox.shrink();
              }

              return Container(
                padding: AppSpacing.pagePadding,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(color: AppColors.border),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: _buildLeaderboardItem(
                    context,
                    state.currentUserScore!,
                    state.currentUserScore!.rank,
                    isCurrentUser: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(
    BuildContext context,
    UserScore score,
    int rank, {
    bool isCurrentUser = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 40,
            child: rank <= 3
                ? Icon(
                    Icons.emoji_events,
                    color: rank == 1
                        ? const Color(0xFFFFD700)
                        : rank == 2
                            ? const Color(0xFFC0C0C0)
                            : const Color(0xFFCD7F32),
                  )
                : Text(
                    '#$rank',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
          ),
          AppSpacing.horizontalMd,
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: score.avatarColor != null
                ? Color(int.parse('0xFF${score.avatarColor!.replaceAll('#', '')}'))
                : AppColors.primary.withValues(alpha: 0.2),
            backgroundImage:
                score.avatarUrl != null ? NetworkImage(score.avatarUrl!) : null,
            child: score.avatarUrl == null
                ? Text(
                    score.initials,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  )
                : null,
          ),
          AppSpacing.horizontalMd,
          // Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCurrentUser ? 'You' : score.displayName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (score.username != null)
                  Text(
                    '@${score.username}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
              ],
            ),
          ),
          // Tokens
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.token, size: 16, color: AppColors.tokenGold),
                  AppSpacing.horizontalXs,
                  Text(
                    score.totalTokensEarned.toString(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              if (score.currentStreak > 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_fire_department,
                        size: 14, color: AppColors.warning),
                    AppSpacing.horizontalXs,
                    Text(
                      '${score.currentStreak} day streak',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.warning,
                          ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
