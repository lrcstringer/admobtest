import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/gift.dart';
import '../../../domain/enums/gift_status.dart';
import '../../../domain/enums/gift_style.dart';
import '../../blocs/gift/gift_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Full-screen animated gift reveal screen.
/// Shows style-specific presentation, personal message, amount,
/// and a "Claim Tokens" button for the recipient.
class GiftOpeningScreen extends StatefulWidget {
  final Gift gift;

  const GiftOpeningScreen({super.key, required this.gift});

  @override
  State<GiftOpeningScreen> createState() => _GiftOpeningScreenState();
}

class _GiftOpeningScreenState extends State<GiftOpeningScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isRevealed = false;

  Gift get _gift => widget.gift;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Auto-open if not yet opened
    if (_gift.isPending) {
      context.read<GiftBloc>().add(GiftEvent.openGift(_gift.id));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _reveal() {
    setState(() => _isRevealed = true);
    _controller.forward();
  }

  void _claim() {
    context.read<GiftBloc>().add(GiftEvent.claimGift(_gift.id));
  }

  Color get _styleColor => switch (_gift.style) {
        GiftStyle.ndlovukazi => AppColors.purple,
        GiftStyle.celebration => AppColors.gold,
        GiftStyle.love => AppColors.error,
        GiftStyle.birthday => AppColors.primary,
        GiftStyle.professional => AppColors.textTertiary,
      };

  IconData get _styleIcon => switch (_gift.style) {
        GiftStyle.ndlovukazi => Icons.auto_awesome,
        GiftStyle.celebration => Icons.celebration,
        GiftStyle.love => Icons.favorite,
        GiftStyle.birthday => Icons.cake,
        GiftStyle.professional => Icons.business_center,
      };

  @override
  Widget build(BuildContext context) {
    final color = _styleColor;

    return BlocListener<GiftBloc, GiftState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
          context.read<GiftBloc>().add(const GiftEvent.clearError());
        }
        // Auto-dismiss after claim
        if (state.activeGift != null &&
            state.activeGift!.isClaimed &&
            !state.isClaiming) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${_gift.amount} tokens claimed!',
              ),
              backgroundColor: AppColors.success,
            ),
          );
          if (context.canPop()) context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: AppColors.textPrimary.withValues(alpha: 0.7)),
                  onPressed: () => context.pop(),
                ),
              ),
              const Spacer(),

              // Gift presentation
              if (!_isRevealed) ...[
                // Wrapped gift — tap to reveal
                GestureDetector(
                  onTap: _reveal,
                  child: _WrappedGift(color: color, icon: _styleIcon),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'From ${_gift.senderName}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary.withValues(alpha: 0.7),
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Tap to open',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color,
                      ),
                ),
              ] else ...[
                // Revealed content
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _RevealedGift(
                      gift: _gift,
                      color: color,
                      icon: _styleIcon,
                    ),
                  ),
                ),
              ],

              const Spacer(),

              // Claim button
              if (_isRevealed &&
                  (_gift.status == GiftStatus.opened ||
                      _gift.status == GiftStatus.pending))
                BlocBuilder<GiftBloc, GiftState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: state.isClaiming ? null : _claim,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: AppColors.textOnPrimary,
                          ),
                          icon: state.isClaiming
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.textOnPrimary,
                                  ),
                                )
                              : const Icon(Icons.toll),
                          label: Text(
                            state.isClaiming
                                ? 'Claiming...'
                                : 'Claim ${_gift.amount} Tokens',
                          ),
                        ),
                      ),
                    );
                  },
                ),

              if (_gift.isClaimed)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: AppColors.success),
                        SizedBox(width: 8),
                        Text(
                          'Already claimed',
                          style: TextStyle(color: AppColors.success, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Wrapped gift visual — before reveal
class _WrappedGift extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _WrappedGift({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.3),
            color.withValues(alpha: 0.1),
          ],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard, color: color, size: 64),
          const SizedBox(height: 8),
          Icon(icon, color: color.withValues(alpha: 0.7), size: 24),
        ],
      ),
    );
  }
}

/// Revealed gift content — after tap
class _RevealedGift extends StatelessWidget {
  final Gift gift;
  final Color color;
  final IconData icon;

  const _RevealedGift({
    required this.gift,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Style icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 48),
        ),
        const SizedBox(height: AppSpacing.md),

        // Style name
        Text(
          gift.style.displayName,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Amount
        Text(
          '${gift.amount}',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          'tokens',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary.withValues(alpha: 0.54),
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'R${gift.amountZar.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Personal message
        if (gift.message.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.textPrimary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '"${gift.message}"',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: AppSpacing.md),

        // Sender
        Text(
          'From ${gift.senderName}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary.withValues(alpha: 0.54),
              ),
        ),
      ],
    );
  }
}
