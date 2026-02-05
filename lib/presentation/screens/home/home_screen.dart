import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/pot_pool.dart';
import '../../../domain/enums/pot_type.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/pot/pot_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(const WalletEvent.loadLedger());
    final potBloc = context.read<PotBloc>();
    potBloc.add(const PotEvent.watchDailyPot());
    potBloc.add(const PotEvent.watchWeeklyPot());
    potBloc.add(const PotEvent.loadCurrentUserScore(PotType.daily));
    potBloc.add(const PotEvent.loadCurrentUserScore(PotType.weekly));
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }

  String _formatPotTime(Duration duration, bool isDaily) {
    if (duration <= Duration.zero) return 'Ended';
    if (isDaily) {
      if (duration.inHours > 0) return 'about ${duration.inHours} hours';
      return '${duration.inMinutes} min';
    } else {
      if (duration.inDays > 0) return '${duration.inDays} day${duration.inDays == 1 ? '' : 's'}';
      return 'about ${duration.inHours} hours';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;

        return BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            return BlocBuilder<PotBloc, PotState>(
              builder: (context, potState) {
                return Scaffold(
                  appBar: const IMaliAppBar(title: 'Home'),
                  body: RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<WalletBloc>()
                              .add(const WalletEvent.refreshLedger());
                          final potBloc = context.read<PotBloc>();
                          potBloc.add(const PotEvent.loadDailyPot());
                          potBloc.add(const PotEvent.loadWeeklyPot());
                          potBloc.add(const PotEvent.loadCurrentUserScore(
                              PotType.daily));
                          potBloc.add(const PotEvent.loadCurrentUserScore(
                              PotType.weekly));
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(context, user, walletState),
                              const SizedBox(height: 24),
                              _buildTokenBalanceCard(context, walletState),
                              const SizedBox(height: 24),
                              _buildPotCardsRow(context, potState),
                              const SizedBox(height: 24),
                              _buildInviteFriendsButton(context),
                              const SizedBox(height: 16),
                              _buildHowItWorksLink(context),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(
      BuildContext context, dynamic user, WalletState walletState) {
    // Use engagement stats as the authoritative source for streak
    final streak = walletState.currentStreak;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getGreeting(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          user?.displayName ?? 'User',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        _buildStreakBadge(context, streak),
      ],
    );
  }

  Widget _buildStreakBadge(BuildContext context, int streak) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'STREAK: $streak DAYS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenBalanceCard(
      BuildContext context, WalletState walletState) {
    final isLoading = walletState.status == WalletStatus.loading;
    final balance = walletState.balance;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
                'Total Token Balance',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              Icon(Icons.account_balance_wallet_outlined,
                  color: AppColors.primary, size: 24),
            ],
          ),
          const SizedBox(height: 12),
          if (isLoading)
            const SizedBox(
              height: 40,
              child: Center(
                child: CircularProgressIndicator(
                    color: AppColors.primary, strokeWidth: 2),
              ),
            )
          else
            Text(
              '$balance',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: AppColors.primaryGradient),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () => context.go('/earn'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Earn Now',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPotCardsRow(BuildContext context, PotState potState) {
    return Row(
      children: [
        Expanded(
          child: _buildPotCard(
            context,
            pot: potState.dailyPot,
            label: 'DAILY',
            title: "TODAY'S POT",
            accentColors: AppColors.goldGradient,
            userRank: potState.dailyUserScore?.rank,
            isDaily: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPotCard(
            context,
            pot: potState.weeklyPot,
            label: 'WEEKLY',
            title: "THIS WEEK'S POT",
            accentColors: AppColors.primaryGradient,
            userRank: potState.weeklyUserScore?.rank,
            isDaily: false,
          ),
        ),
      ],
    );
  }

  Widget _buildPotCard(
    BuildContext context, {
    PotPool? pot,
    required String label,
    required String title,
    required List<Color> accentColors,
    int? userRank,
    required bool isDaily,
  }) {
    final amount = pot != null
        ? 'R ${(pot.totalTokens * 0.01).toStringAsFixed(2)}'
        : 'R 0.00';
    final timeLeft = pot != null
        ? _formatPotTime(pot.timeRemaining, isDaily)
        : '--';

    return GestureDetector(
      onTap: () => context.push('/pots'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top accent line
            Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: accentColors),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            // Label + trophy row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: accentColors.first,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                ),
                Icon(Icons.emoji_events, color: accentColors.first, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 4),
            // Amount
            Text(
              amount,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            // Timer row
            Row(
              children: [
                Icon(Icons.timer_outlined,
                    size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    timeLeft,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            // Rank (daily only)
            if (isDaily) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userRank != null
                        ? 'Your Rank: #$userRank'
                        : 'Your Rank: #\u2014',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  Icon(Icons.chevron_right,
                      size: 18, color: AppColors.textSecondary),
                ],
              ),
            ] else ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.chevron_right,
                    size: 18, color: AppColors.textSecondary),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInviteFriendsButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/profile/referrals'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add_outlined,
                color: AppColors.textPrimary, size: 20),
            const SizedBox(width: 10),
            Text(
              'Invite friends & Earn',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksLink(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => context.go('/home/how-to-earn'),
        child: Text(
          'How it works',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
