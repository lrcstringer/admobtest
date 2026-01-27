import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/referral.dart';
import '../../blocs/referral/referral_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ReferralBloc>();
    bloc.add(const ReferralEvent.loadStats());
    bloc.add(const ReferralEvent.watchReferrals());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite & Earn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard_outlined),
            onPressed: () => _showLeaderboardSheet(context),
            tooltip: 'Leaderboard',
          ),
        ],
      ),
      body: BlocConsumer<ReferralBloc, ReferralState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<ReferralBloc>().add(const ReferralEvent.clearError());
          }
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            context.read<ReferralBloc>().add(const ReferralEvent.clearSuccess());
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.stats == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ReferralBloc>().add(const ReferralEvent.loadStats());
              context.read<ReferralBloc>().add(const ReferralEvent.loadReferrals());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats card
                  if (state.stats != null) _buildStatsCard(context, state.stats!),
                  AppSpacing.verticalLg,

                  // Share card
                  if (state.stats != null) _buildShareCard(context, state.stats!),
                  AppSpacing.verticalLg,

                  // How it works
                  _buildHowItWorksCard(context),
                  AppSpacing.verticalLg,

                  // Referral list header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Referrals',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (state.referrals.isNotEmpty)
                        Text(
                          '${state.referrals.length} total',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                    ],
                  ),
                  AppSpacing.verticalMd,

                  // Referral list
                  if (state.referrals.isEmpty)
                    _buildEmptyReferrals(context)
                  else
                    ...state.referrals.map(
                      (referral) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildReferralItem(context, referral),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showApplyCodeSheet(context),
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Enter Code'),
        backgroundColor: AppColors.accent,
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, ReferralStats stats) {
    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                value: stats.totalReferrals.toString(),
                label: 'Total',
                icon: Icons.people,
              ),
              _buildStatItem(
                context,
                value: stats.completedReferrals.toString(),
                label: 'Completed',
                icon: Icons.check_circle,
              ),
              _buildStatItem(
                context,
                value: stats.totalEarned.toString(),
                label: 'Earned',
                icon: Icons.token,
              ),
            ],
          ),
          AppSpacing.verticalMd,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.emoji_events, color: Colors.white, size: 20),
                AppSpacing.horizontalSm,
                Text(
                  'R${(stats.totalEarned * 0.01).toStringAsFixed(2)} earned from referrals',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 24),
        AppSpacing.verticalXs,
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildShareCard(BuildContext context, ReferralStats stats) {
    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Referral Code',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          AppSpacing.verticalSm,
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: AppSpacing.borderRadiusMd,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    stats.referralCode,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                  ),
                ),
              ),
              AppSpacing.horizontalMd,
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: stats.referralCode));
                  context.read<ReferralBloc>().add(const ReferralEvent.copyCode());
                },
                icon: const Icon(Icons.copy),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  foregroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<ReferralBloc>().add(
                      const ReferralEvent.shareReferral(platform: 'share'),
                    );
              },
              icon: const Icon(Icons.share),
              label: const Text('Share with Friends'),
            ),
          ),
          AppSpacing.verticalSm,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: stats.referralLink));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied!')),
                    );
                  },
                  icon: const Icon(Icons.link, size: 18),
                  label: const Text('Copy Link'),
                ),
              ),
              AppSpacing.horizontalMd,
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showQRCodeSheet(context, stats.referralCode),
                  icon: const Icon(Icons.qr_code, size: 18),
                  label: const Text('QR Code'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksCard(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.info),
              AppSpacing.horizontalSm,
              Text(
                'How it Works',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.info,
                    ),
              ),
            ],
          ),
          AppSpacing.verticalMd,
          _buildStep(context, '1', 'Share your code with friends'),
          _buildStep(context, '2', 'They sign up using your code'),
          _buildStep(context, '3', 'They complete their first engagement'),
          _buildStep(
            context,
            '4',
            'You get 100 tokens, they get 50 tokens!',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    BuildContext context,
    String number,
    String text, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.info,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyReferrals(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(
            Icons.people_outline,
            size: 48,
            color: AppColors.textHint,
          ),
          AppSpacing.verticalMd,
          Text(
            'No referrals yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSpacing.verticalSm,
          Text(
            'Share your code with friends to start earning!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReferralItem(BuildContext context, Referral referral) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: _getStatusColor(referral.status).withValues(alpha: 0.2),
            backgroundImage: referral.refereeAvatarUrl != null
                ? NetworkImage(referral.refereeAvatarUrl!)
                : null,
            child: referral.refereeAvatarUrl == null
                ? Text(
                    referral.refereeInitials,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(referral.status),
                        ),
                  )
                : null,
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  referral.refereeDisplayName ?? 'User',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (referral.refereeUsername != null)
                  Text(
                    '@${referral.refereeUsername}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildStatusChip(context, referral.status),
              if (referral.isComplete && referral.referrerReward != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '+${referral.referrerReward} tokens',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, ReferralStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: Text(
        _getStatusText(status),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Color _getStatusColor(ReferralStatus status) {
    switch (status) {
      case ReferralStatus.pending:
        return AppColors.warning;
      case ReferralStatus.registered:
        return AppColors.info;
      case ReferralStatus.qualified:
        return AppColors.accent;
      case ReferralStatus.rewarded:
        return AppColors.success;
      case ReferralStatus.expired:
        return AppColors.textSecondary;
    }
  }

  String _getStatusText(ReferralStatus status) {
    switch (status) {
      case ReferralStatus.pending:
        return 'Pending';
      case ReferralStatus.registered:
        return 'Registered';
      case ReferralStatus.qualified:
        return 'Qualified';
      case ReferralStatus.rewarded:
        return 'Completed';
      case ReferralStatus.expired:
        return 'Expired';
    }
  }

  void _showApplyCodeSheet(BuildContext context) {
    final controller = TextEditingController();
    final bloc = context.read<ReferralBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: Container(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              AppSpacing.verticalMd,
              Text(
                'Enter Referral Code',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Enter a friend\'s referral code to get bonus tokens!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              AppSpacing.verticalLg,
              TextField(
                controller: controller,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Referral Code',
                  hintText: 'ABC123',
                  prefixIcon: const Icon(Icons.card_giftcard),
                  suffixIcon: BlocBuilder<ReferralBloc, ReferralState>(
                    builder: (context, state) {
                      if (state.isValidating) {
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      if (state.isCodeValid == true) {
                        return const Icon(Icons.check_circle, color: AppColors.success);
                      }
                      if (state.isCodeValid == false) {
                        return const Icon(Icons.error, color: AppColors.error);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                onChanged: (value) {
                  if (value.length >= 6) {
                    bloc.add(ReferralEvent.validateCode(value));
                  }
                },
              ),
              AppSpacing.verticalLg,
              BlocBuilder<ReferralBloc, ReferralState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isApplying ||
                              controller.text.length < 6 ||
                              state.isCodeValid == false
                          ? null
                          : () {
                              bloc.add(ReferralEvent.applyCode(controller.text));
                              Navigator.pop(context);
                            },
                      child: state.isApplying
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Apply Code'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQRCodeSheet(BuildContext context, String code) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            AppSpacing.verticalMd,
            Text(
              'Your QR Code',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSpacing.verticalLg,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Icon(
                Icons.qr_code_2,
                size: 200,
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.verticalMd,
            Text(
              code,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Let your friend scan this code',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }

  void _showLeaderboardSheet(BuildContext context) {
    final bloc = context.read<ReferralBloc>();
    bloc.add(const ReferralEvent.loadLeaderboard(limit: 20));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
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
              Padding(
                padding: AppSpacing.pagePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Referral Leaderboard',
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
              Expanded(
                child: BlocBuilder<ReferralBloc, ReferralState>(
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
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: AppSpacing.pagePadding,
                      itemCount: state.leaderboard.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final stats = state.leaderboard[index];
                        return _buildLeaderboardItem(context, stats, index + 1);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(
    BuildContext context,
    ReferralStats stats,
    int rank,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stats.referralCode,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '${stats.completedReferrals} referrals',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.token, size: 16, color: AppColors.tokenGold),
                  AppSpacing.horizontalXs,
                  Text(
                    stats.totalEarned.toString(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
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
