import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/earn_opportunity.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../blocs/earn_inbox/earn_inbox_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/wave_background.dart';

/// Success screen shown after completing an earn engagement
/// Shows confetti animation, token breakdown (90/5/5), and navigation options
class EarnWalletConfirmScreen extends StatefulWidget {
  const EarnWalletConfirmScreen({super.key});

  @override
  State<EarnWalletConfirmScreen> createState() =>
      _EarnWalletConfirmScreenState();
}

class _EarnWalletConfirmScreenState extends State<EarnWalletConfirmScreen>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Confetti controller
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Scale animation for the success icon
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // Fade animation for content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Start scale + fade animations immediately (screen may show loading)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaleController.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _fadeController.forward();
      });

      // If already completed on first frame (fast CF), trigger success effects
      final earnState = context.read<EarnBloc>().state;
      if (earnState.engagementPhase == EngagementPhase.completed) {
        _onSubmissionCompleted(earnState.isPendingReview);
      }
    });
  }

  bool _completionHandled = false;

  void _onSubmissionCompleted(bool isPendingReview) {
    if (_completionHandled) return;
    _completionHandled = true;

    if (!isPendingReview) {
      _confettiController.play();
      context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EarnBloc, EarnState>(
      listener: (context, earnState) {
        // Trigger confetti + wallet refresh when submission completes
        if (earnState.engagementPhase == EngagementPhase.completed) {
          _onSubmissionCompleted(earnState.isPendingReview);
        }

        // Handle submission failure — show error and navigate back
        if (earnState.engagementPhase == EngagementPhase.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  earnState.errorMessage ?? 'Submission failed. Please retry.'),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<EarnBloc>().add(const EarnEvent.resetEngagement());
          context.go('/earn');
        }
      },
      builder: (context, earnState) {
        final isSubmitting =
            earnState.engagementPhase == EngagementPhase.submitting;
        final engagement = earnState.currentEngagement;
        final opportunity = earnState.selectedOpportunity;
        final isPendingReview = earnState.isPendingReview;
        // Use engagement tokensEarned, fall back to opportunity tokenReward
        final tokensEarned = (engagement?.tokensEarned != null &&
                engagement!.tokensEarned! > 0)
            ? engagement.tokensEarned!
            : opportunity?.tokenReward ?? 0;

        // Calculate 90/5/5 breakdown
        final userTokens = (tokensEarned * 0.90).round();
        final dailyPotTokens = (tokensEarned * 0.05).round();
        final weeklyPotTokens = (tokensEarned * 0.05).round();

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              _goToEarn();
            }
          },
          child: Scaffold(
            body: WaveBackground(
              child: Stack(
                children: [
                  // Main content
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg),
                      child: CustomScrollView(
                        slivers: [
                          // Top spacing
                          SliverToBoxAdapter(
                            child: SizedBox(height: AppSpacing.xl),
                          ),
                          // Centered content
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              children: [
                                const Spacer(),

                                // Animated success/loading icon
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: isSubmitting
                                    ? AppColors.primary.withValues(alpha: 0.2)
                                    : isPendingReview
                                        ? AppColors.warning
                                            .withValues(alpha: 0.2)
                                        : AppColors.success
                                            .withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: isSubmitting
                                  ? const Padding(
                                      padding: EdgeInsets.all(28),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                      ),
                                    )
                                  : Icon(
                                      isPendingReview
                                          ? Icons.hourglass_top
                                          : Icons.check_circle,
                                      size: 80,
                                      color: isPendingReview
                                          ? AppColors.warning
                                          : AppColors.success,
                                    ),
                            ),
                          ),
                          SizedBox(height: AppSpacing.lg),

                          // Animated content
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              children: [
                                // Success / submitting message
                                Text(
                                  isSubmitting
                                      ? 'Almost there...'
                                      : isPendingReview
                                          ? 'Submission Received!'
                                          : 'Congratulations!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Text(
                                  isSubmitting
                                      ? 'Processing your tokens'
                                      : isPendingReview
                                          ? 'Your upload is under review'
                                          : 'You earned tokens successfully',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                                SizedBox(height: AppSpacing.xl),

                                if (isPendingReview) ...[
                                  // Pending review info card
                                  Card(
                                    color: AppColors.warning
                                        .withValues(alpha: 0.1),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(AppSpacing.md),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.info_outline,
                                                  color: AppColors.warning),
                                              SizedBox(
                                                  width: AppSpacing.sm),
                                              Expanded(
                                                child: Text(
                                                  'Your submission will be reviewed by an admin. Tokens will be awarded once approved.',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: AppColors
                                                            .textSecondary,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: AppSpacing.md),
                                          Container(
                                            padding:
                                                EdgeInsets.symmetric(
                                              horizontal: AppSpacing.lg,
                                              vertical: AppSpacing.sm,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.warning
                                                  .withValues(alpha: 0.2),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      16),
                                            ),
                                            child: Text(
                                              '+$tokensEarned tokens pending',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color:
                                                        AppColors.warning,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppSpacing.md),
                                ] else ...[
                                  // Token breakdown card
                                  Card(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(AppSpacing.md),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Token Distribution',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      color: AppColors
                                                          .textSecondary,
                                                    ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                  horizontal: 10,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(
                                                    colors: [
                                                      AppColors.gold,
                                                      AppColors.gold
                                                          .withValues(
                                                              alpha: 0.8),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .monetization_on,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    const SizedBox(
                                                        width: 4),
                                                    Text(
                                                      '+$tokensEarned',
                                                      style: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                            color: Colors
                                                                .white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: AppSpacing.md),
                                          _buildBreakdownRow(
                                            context,
                                            icon: Icons
                                                .account_balance_wallet,
                                            iconColor: AppColors.primary,
                                            label: 'Your Wallet',
                                            tokens: userTokens,
                                            percentage: '90%',
                                          ),
                                          Divider(
                                              height: AppSpacing.md),
                                          _buildBreakdownRow(
                                            context,
                                            icon: Icons.today,
                                            iconColor:
                                                AppColors.secondary,
                                            label: 'Daily Pot',
                                            tokens: dailyPotTokens,
                                            percentage: '5%',
                                          ),
                                          Divider(
                                              height: AppSpacing.md),
                                          _buildBreakdownRow(
                                            context,
                                            icon: Icons.emoji_events,
                                            iconColor: AppColors.gold,
                                            label: 'Weekly Pot',
                                            tokens: weeklyPotTokens,
                                            percentage: '5%',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppSpacing.md),
                                ],

                                // Opportunity info
                                if (opportunity != null)
                                  Card(
                                    color: AppColors.surface,
                                    child: Padding(
                                      padding: EdgeInsets.all(AppSpacing.md),
                                      child: Row(
                                        children: [
                                          _buildClientAvatar(opportunity),
                                          SizedBox(width: AppSpacing.sm),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  opportunity.clientName ??
                                                      'Brand',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                Text(
                                                  opportunity.title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: AppColors
                                                            .textSecondary,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: AppColors.success,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                // Streak info if applicable
                                if (engagement?.streakDayAtCompletion != null &&
                                    engagement!.streakDayAtCompletion! > 1)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: AppSpacing.md),
                                    child: Card(
                                      color: AppColors.primaryLight
                                          .withValues(alpha: 0.3),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(AppSpacing.md),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              color: AppColors.error,
                                            ),
                                            SizedBox(width: AppSpacing.sm),
                                            Text(
                                              '${engagement.streakDayAtCompletion} Day Streak!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            if (engagement.multiplierApplied !=
                                                    null &&
                                                engagement.multiplierApplied! >
                                                    1.0) ...[
                                              SizedBox(width: AppSpacing.sm),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: AppSpacing.sm,
                                                  vertical: AppSpacing.xs,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.gold,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  '${engagement.multiplierApplied}x',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                // Reward pending card
                                if (earnState.rewardPending)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: AppSpacing.md),
                                    child: Card(
                                      color: AppColors.accent
                                          .withValues(alpha: 0.15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(AppSpacing.md),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.card_giftcard,
                                              color: AppColors.accent,
                                              size: 28,
                                            ),
                                            SizedBox(width: AppSpacing.sm),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'A reward is on its way!',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    earnState.rewardCampaignName ??
                                                        'Check your rewards shortly',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color: AppColors
                                                              .textSecondary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // Action buttons
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppButton(
                                  text: isSubmitting
                                      ? 'Processing...'
                                      : 'Continue Earning',
                                  onPressed:
                                      isSubmitting ? null : _goToEarn,
                                  icon: Icons.arrow_forward,
                                ),
                                SizedBox(height: AppSpacing.sm),
                                AppButton(
                                  text: 'Go to Wallet',
                                  onPressed:
                                      isSubmitting ? null : _goToWallet,
                                  variant: AppButtonVariant.outline,
                                  icon: Icons.account_balance_wallet,
                                ),
                              ],
                            ),
                          ),
                                SizedBox(height: AppSpacing.xl),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Confetti overlay
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirection: math.pi / 2, // downward
                      maxBlastForce: 5,
                      minBlastForce: 2,
                      emissionFrequency: 0.05,
                      numberOfParticles: 20,
                      gravity: 0.3,
                      shouldLoop: false,
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                        AppColors.gold,
                        AppColors.success,
                        Colors.purple,
                        Colors.pink,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBreakdownRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required int tokens,
    required String percentage,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Text(
          percentage,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          '+$tokens',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
        ),
      ],
    );
  }

  Widget _buildClientAvatar(EarnOpportunity opportunity) {
    final color = AppColors.parseHex(opportunity.clientAvatarColor);

    final initials =
        opportunity.clientName != null && opportunity.clientName!.isNotEmpty
            ? opportunity.clientName!.split(' ').map((w) => w[0]).take(2).join()
            : '??';

    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  void _goToEarn() {
    context.read<EarnBloc>().add(const EarnEvent.resetEngagement());
    // Refresh inbox so completed opportunity shows updated state
    context.read<EarnInboxBloc>().add(const EarnInboxEvent.loadInbox());
    context.go('/earn');
  }

  void _goToWallet() {
    context.read<EarnBloc>().add(const EarnEvent.resetEngagement());
    // Refresh inbox so completed opportunity shows updated state
    context.read<EarnInboxBloc>().add(const EarnInboxEvent.loadInbox());
    context.go('/wallet');
  }
}
