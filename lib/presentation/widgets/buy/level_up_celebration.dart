import 'package:flutter/material.dart';

import '../../../domain/enums/seller_level.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Level-up celebration modal (Spec §8.7).
///
/// Shows: confetti-style animation + badge + congratulations message +
/// "Share achievement" button.
///
/// Usage:
/// ```dart
/// showLevelUpCelebration(context, SellerLevel.active);
/// ```
Future<void> showLevelUpCelebration(
  BuildContext context,
  SellerLevel newLevel,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => _LevelUpDialog(level: newLevel),
  );
}

class _LevelUpDialog extends StatefulWidget {
  final SellerLevel level;

  const _LevelUpDialog({required this.level});

  @override
  State<_LevelUpDialog> createState() => _LevelUpDialogState();
}

class _LevelUpDialogState extends State<_LevelUpDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.buyShadow,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Confetti-style decorative dots
              SizedBox(
                height: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(7, (i) {
                    final colors = [
                      AppColors.buyWarning,
                      AppColors.buyMarketplaceAccent,
                      AppColors.buySuccess,
                      _badgeColor,
                      AppColors.buyMarketplaceAccentDark,
                      AppColors.buyWarning,
                      AppColors.buySuccess,
                    ];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          width: 6 + (i % 3) * 2.0,
                          height: 6 + (i % 3) * 2.0,
                          decoration: BoxDecoration(
                            color: colors[i],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Animated badge
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _badgeColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _badgeIcon,
                    size: 40,
                    color: _badgeColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Level name
              FadeTransition(
                opacity: _fadeAnim,
                child: Text(
                  widget.level.displayName,
                  style: TextStyle(
                    color: _badgeColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Congratulations message
              FadeTransition(
                opacity: _fadeAnim,
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Share button
              FadeTransition(
                opacity: _fadeAnim,
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Share action handled by caller
                    },
                    icon: const Icon(Icons.share_outlined, size: 18),
                    label: const Text(
                      'Share Achievement',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _badgeColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Dismiss
              FadeTransition(
                opacity: _fadeAnim,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData get _badgeIcon {
    switch (widget.level) {
      case SellerLevel.newSeller:
        return Icons.storefront_outlined;
      case SellerLevel.active:
        return Icons.trending_up_rounded;
      case SellerLevel.trusted:
        return Icons.verified_user_rounded;
      case SellerLevel.star:
        return Icons.star_rounded;
    }
  }

  Color get _badgeColor {
    switch (widget.level) {
      case SellerLevel.newSeller:
        return AppColors.buyTextTertiary;
      case SellerLevel.active:
        return AppColors.buyMarketplaceAccent;
      case SellerLevel.trusted:
        return AppColors.buySuccess;
      case SellerLevel.star:
        return AppColors.buyWarning;
    }
  }

  String get _message {
    switch (widget.level) {
      case SellerLevel.newSeller:
        return 'Welcome to the marketplace! Start listing to earn your first badge.';
      case SellerLevel.active:
        return "You've made 3 sales and earned your Active Seller badge. Keep it up!";
      case SellerLevel.trusted:
        return 'Trusted Seller status. Your listings now get priority in search.';
      case SellerLevel.star:
        return "Star Seller status. You'll be featured on the trending strip.";
    }
  }
}
