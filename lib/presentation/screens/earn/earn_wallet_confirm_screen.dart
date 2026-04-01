import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/earn_opportunity.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../blocs/earn_inbox/earn_inbox_bloc.dart';
import '../../blocs/reward/reward_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/tab_background.dart';

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
  late ConfettiController _miniConfettiController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _showRandomSparkle = false;

  @override
  void initState() {
    super.initState();

    // Full confetti controller (first-ever completion)
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Mini confetti controller (streak milestones)
    _miniConfettiController = ConfettiController(
      duration: const Duration(seconds: 1),
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

      // Bug 5: guard against direct navigation with empty state (e.g. deep-link).
      final earnState = context.read<EarnBloc>().state;
      final phase = earnState.engagementPhase;
      if (phase == EngagementPhase.idle) {
        context.go('/earn');
        return;
      }

      // If already in a terminal state on the first frame (fast CF / hot reload),
      // trigger the appropriate handlers immediately.
      if (phase == EngagementPhase.optimistic ||
          phase == EngagementPhase.completed) {
        _onWalletRefresh(earnState.isPendingReview);
      }
      if (phase == EngagementPhase.completed) {
        _onCompletionEffects(earnState);
      }
    });
  }

  // Wallet refresh fires on the first of optimistic or completed — whichever
  // arrives first. This gives the wallet the earliest possible signal to update.
  bool _walletRefreshHandled = false;

  void _onWalletRefresh(bool isPendingReview) {
    if (_walletRefreshHandled || isPendingReview) return;
    _walletRefreshHandled = true;
    context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
  }

  // Visual effects (confetti, streak, reward card) fire on completed only —
  // this is when streakDayAtCompletion and rewardItemId are populated by the CF.
  bool _effectsHandled = false;

  void _onCompletionEffects(EarnState earnState) {
    if (_effectsHandled || earnState.isPendingReview) return;
    _effectsHandled = true;

    // Refresh reward items so wallet shows newly allocated reward
    if (earnState.rewardItemId != null) {
      context.read<RewardBloc>().add(const RewardEvent.refreshItems());
    }

    final engagement = earnState.currentEngagement;
    final walletState = context.read<WalletBloc>().state;
    final isFirstCompletion =
        (walletState.engagementStats?.totalEngagementsCompleted ?? 0) <= 1;
    final streakDay = engagement?.streakDayAtCompletion;
    final isStreakMilestone =
        streakDay == 3 || streakDay == 7 || streakDay == 14;

    if (isFirstCompletion) {
      _confettiController.play();
    } else if (isStreakMilestone) {
      _miniConfettiController.play();
    }

    // ~10% random chance for extra sparkle on the success icon
    if (mounted) {
      setState(() {
        _showRandomSparkle = math.Random().nextInt(10) == 0;
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _miniConfettiController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EarnBloc, EarnState>(
      listener: (context, earnState) {
        // Wallet refresh: fire on the first of optimistic or completed.
        if (earnState.engagementPhase == EngagementPhase.optimistic ||
            earnState.engagementPhase == EngagementPhase.completed) {
          _onWalletRefresh(earnState.isPendingReview);
        }
        // Visual effects (confetti, streak card, reward refresh): fire on completed
        // only, when streakDayAtCompletion and rewardItemId are populated by the CF.
        if (earnState.engagementPhase == EngagementPhase.completed) {
          _onCompletionEffects(earnState);
        }

        // Handle submission failure
        if (earnState.engagementPhase == EngagementPhase.failed) {
          final msg = earnState.errorMessage ?? '';

          // Campaign ended or not yet started after completion — tokens still
          // credited, only the bonus reward item was not allocated.
          if (msg.toLowerCase().contains('has ended') ||
              msg.toLowerCase().contains('has not started')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Your tokens have been credited. The bonus reward for this opportunity is no longer available.'),
                backgroundColor: AppColors.info,
                duration: Duration(seconds: 5),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    msg.isNotEmpty ? msg : 'Submission failed. Please retry.'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          context.read<EarnBloc>().add(const EarnEvent.resetEngagement());
          context.go('/earn');
        }
      },
      builder: (context, earnState) {
        // submitting = upload engagements waiting for CF (outcome unknown).
        // optimistic/completed = show success content immediately.
        final isSubmitting =
            earnState.engagementPhase == EngagementPhase.submitting;
        final engagement = earnState.currentEngagement;
        final opportunity = earnState.selectedOpportunity;
        final isPendingReview = earnState.isPendingReview;
        // After completion use the actual bonus-adjusted gross from the engagement;
        // during submission / pending-review fall back to the opportunity's base reward.
        final isCompleted = engagement?.isComplete == true;
        final grossTokens = isCompleted
            ? (engagement!.totalTokensGenerated ??
                (opportunity?.tokenReward.toDouble() ?? 0.0))
            : (opportunity?.tokenReward.toDouble() ?? 0.0);

        // Calculate exact 90/5/5 breakdown using the actual gross
        final dailyPotTokens = grossTokens * 0.05;
        final weeklyPotTokens = grossTokens * 0.05;
        final userTokens = isCompleted && engagement?.tokensEarned != null
            ? engagement!.tokensEarned!
            : grossTokens * 0.9;
        final grossTokensDisplay = grossTokens == grossTokens.roundToDouble()
            ? grossTokens.toInt().toString()
            : grossTokens.toStringAsFixed(1);

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              _goToEarn();
            }
          },
          child: Scaffold(
            body: TabBackground(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.themed(context).tabGradient,
              ),
              overlayAsset: null,
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
                          _buildSuccessIcon(
                            isSubmitting: isSubmitting,
                            isPendingReview: isPendingReview,
                          ),

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
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                                              '+$grossTokensDisplay tokens pending',
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
                                ] else if (!isSubmitting) ...[
                                  // Token breakdown card (only after CF completes)
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
                                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                                                      '+$grossTokensDisplay',
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
                                              )
                                                  .animate()
                                                  .shimmer(
                                                    delay: 600.ms,
                                                    duration: 800.ms,
                                                    color: Colors.white
                                                        .withValues(
                                                            alpha: 0.4),
                                                  )
                                                  .then(delay: 200.ms)
                                                  .shimmer(
                                                    duration: 600.ms,
                                                    color: Colors.white
                                                        .withValues(
                                                            alpha: 0.2),
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

                                // Opportunity info (hidden during submitting)
                                if (opportunity != null && !isSubmitting)
                                  Card(
                                    color: Theme.of(context).colorScheme.surface,
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
                                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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

                                // Reward allocated card
                                if (earnState.rewardItemId != null)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: AppSpacing.md),
                                    child: Card(
                                      color: AppColors.accent
                                          .withValues(alpha: 0.15),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () => context.push(
                                          '/wallet/rewards/${earnState.rewardItemId}',
                                        ),
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
                                                      'You earned a reward!',
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
                                                          'View your reward',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons.chevron_right,
                                                color: AppColors.accent,
                                              ),
                                            ],
                                          ),
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

                  // Full confetti overlay (first-ever completion)
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirection: math.pi / 2,
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

                  // Mini confetti burst (streak milestones: 3, 7, 14 days)
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: _miniConfettiController,
                      blastDirection: math.pi / 2,
                      maxBlastForce: 3,
                      minBlastForce: 1,
                      emissionFrequency: 0.08,
                      numberOfParticles: 4,
                      gravity: 0.2,
                      shouldLoop: false,
                      colors: [
                        AppColors.gold,
                        AppColors.success,
                        AppColors.primary,
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

  Widget _buildSuccessIcon({
    required bool isSubmitting,
    required bool isPendingReview,
  }) {
    Widget icon = ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSubmitting
              ? AppColors.primary.withValues(alpha: 0.2)
              : isPendingReview
                  ? AppColors.warning.withValues(alpha: 0.2)
                  : AppColors.success.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: isSubmitting
            ? const Padding(
                padding: EdgeInsets.all(28),
                child: CircularProgressIndicator(strokeWidth: 4),
              )
            : Icon(
                isPendingReview ? Icons.hourglass_top : Icons.check_circle,
                size: 80,
                color: isPendingReview ? AppColors.warning : AppColors.success,
              ),
      ),
    );

    // ~10% random sparkle: scale pulse + gold shimmer on the success icon
    if (_showRandomSparkle && !isSubmitting && !isPendingReview) {
      icon = icon
          .animate(onPlay: (c) => c.forward())
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.12, 1.12),
            delay: 500.ms,
            duration: 300.ms,
            curve: Curves.easeOut,
          )
          .then()
          .scale(
            end: const Offset(1, 1),
            duration: 200.ms,
            curve: Curves.easeIn,
          )
          .shimmer(
            delay: 100.ms,
            duration: 600.ms,
            color: AppColors.gold.withValues(alpha: 0.5),
          );
    }

    return Column(
      children: [
        icon,
        SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _buildBreakdownRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required double tokens,
    required String percentage,
  }) {
    // Show decimals only when needed (e.g. 4.5 not 4.50, but 5 not 5.0)
    final tokenStr = tokens == tokens.roundToDouble()
        ? tokens.toInt().toString()
        : tokens.toStringAsFixed(2).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');

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
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          '+$tokenStr',
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
