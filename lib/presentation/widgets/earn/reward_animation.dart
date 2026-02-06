import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Animated reward celebration widget
/// Shows confetti, animated success icon, and token count
class RewardAnimation extends StatefulWidget {
  final int tokensEarned;
  final VoidCallback? onComplete;
  final Duration duration;
  final bool showConfetti;

  const RewardAnimation({
    super.key,
    required this.tokensEarned,
    this.onComplete,
    this.duration = const Duration(seconds: 3),
    this.showConfetti = true,
  });

  @override
  State<RewardAnimation> createState() => _RewardAnimationState();
}

class _RewardAnimationState extends State<RewardAnimation>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _tokenCountController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _tokenCountAnimation;

  @override
  void initState() {
    super.initState();

    // Confetti
    _confettiController = ConfettiController(duration: widget.duration);

    // Scale animation for icon
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

    // Token count animation
    _tokenCountController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _tokenCountAnimation = IntTween(
      begin: 0,
      end: widget.tokensEarned,
    ).animate(CurvedAnimation(
      parent: _tokenCountController,
      curve: Curves.easeOut,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() {
    if (widget.showConfetti) {
      _confettiController.play();
    }
    _scaleController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _fadeController.forward();
        _tokenCountController.forward();
      }
    });

    // Call onComplete after duration
    if (widget.onComplete != null) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          widget.onComplete?.call();
        }
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    _tokenCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Content
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated success icon
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 64,
                  color: AppColors.success,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // Animated token count
            FadeTransition(
              opacity: _fadeAnimation,
              child: AnimatedBuilder(
                animation: _tokenCountAnimation,
                builder: (context, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gold,
                          AppColors.gold.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Text(
                          '+${_tokenCountAnimation.value}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(width: AppSpacing.xs),
                        Text(
                          'tokens',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // Confetti overlay
        if (widget.showConfetti)
          Positioned(
            top: 0,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: math.pi / 2, // downward
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 15,
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
    );
  }
}

/// Simple reward badge for inline display
class RewardBadge extends StatelessWidget {
  final int tokens;
  final bool compact;

  const RewardBadge({
    super.key,
    required this.tokens,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.gold.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.monetization_on,
              size: 14,
              color: AppColors.gold,
            ),
            SizedBox(width: 4),
            Text(
              '+$tokens',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold,
            AppColors.gold.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.monetization_on,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: AppSpacing.xs),
          Text(
            '+$tokens tokens',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
