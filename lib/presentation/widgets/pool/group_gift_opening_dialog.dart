import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/enums/pool_status.dart';
import '../../blocs/token_pool/token_pool_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../gift/gift_card_painters.dart';

/// Full-screen dialog for opening a Group Sasaza gift.
///
/// Phases:
/// 1. Sealed: Envelope with "Tap to Open" shimmer
/// 2. Opening: Fires openGroupGift event
/// 3. Revealed: Amount + contributors, confetti
/// 4. Claim: "Claim" button → fires claimGroupGift
/// 5. Claimed: Checkmark, auto-dismiss
class GroupGiftOpeningDialog extends StatefulWidget {
  final GroupGiftMessageData giftData;

  const GroupGiftOpeningDialog({
    super.key,
    required this.giftData,
  });

  @override
  State<GroupGiftOpeningDialog> createState() => _GroupGiftOpeningDialogState();
}

enum _Phase { sealed, opening, revealed, claiming, claimed }

class _GroupGiftOpeningDialogState extends State<GroupGiftOpeningDialog>
    with SingleTickerProviderStateMixin {
  _Phase _phase = _Phase.sealed;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start watching pool for status updates
    context
        .read<TokenPoolBloc>()
        .add(TokenPoolEvent.watchPool(widget.giftData.poolId));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onTapOpen() {
    if (_phase != _Phase.sealed) return;
    setState(() => _phase = _Phase.opening);

    context
        .read<TokenPoolBloc>()
        .add(TokenPoolEvent.openGroupGift(widget.giftData.poolId));

    // Reveal after brief delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _phase = _Phase.revealed);
    });
  }

  void _onClaim() {
    if (_phase != _Phase.revealed) return;
    setState(() => _phase = _Phase.claiming);

    context
        .read<TokenPoolBloc>()
        .add(TokenPoolEvent.claimGroupGift(widget.giftData.poolId));
  }

  @override
  Widget build(BuildContext context) {
    final colors = GiftStyleColors.forStyle(widget.giftData.style);
    final theme = Theme.of(context);

    return BlocListener<TokenPoolBloc, TokenPoolState>(
      listener: (context, state) {
        final pool = state.activePool;
        if (pool == null) return;

        // Auto-advance to claimed phase when pool status is completed
        if (pool.status == PoolStatus.completed &&
            _phase == _Phase.claiming) {
          setState(() => _phase = _Phase.claimed);
          final navigator = Navigator.of(context);
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) navigator.pop();
          });
        }
      },
      child: Dialog.fullscreen(
        backgroundColor: Colors.black87,
        child: SafeArea(
          child: Stack(
            children: [
              // Background gradient
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.2,
                      colors: [
                        colors.iconColor.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Close button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Main content
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _buildPhase(theme, colors),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhase(ThemeData theme, GiftStyleColors colors) {
    switch (_phase) {
      case _Phase.sealed:
        return _buildSealedPhase(theme, colors);
      case _Phase.opening:
        return _buildOpeningPhase(theme, colors);
      case _Phase.revealed:
        return _buildRevealedPhase(theme, colors);
      case _Phase.claiming:
        return _buildClaimingPhase(theme, colors);
      case _Phase.claimed:
        return _buildClaimedPhase(theme, colors);
    }
  }

  Widget _buildSealedPhase(ThemeData theme, GiftStyleColors colors) {
    return GestureDetector(
      onTap: _onTapOpen,
      child: ScaleTransition(
        scale: _pulseAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 100,
              color: colors.iconColor,
            ),
            AppSpacing.verticalMd,
            Text(
              'Group Sasaza',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.verticalSm,
            Text(
              'From ${widget.giftData.organizerName}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
              ),
            ),
            AppSpacing.verticalLg,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: colors.iconColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                'Tap to Open',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.iconColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpeningPhase(ThemeData theme, GiftStyleColors colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            color: colors.iconColor,
            strokeWidth: 3,
          ),
        ),
        AppSpacing.verticalMd,
        Text(
          'Opening...',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildRevealedPhase(ThemeData theme, GiftStyleColors colors) {
    final data = widget.giftData;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Amount
        Text(
          '${data.amount}',
          style: theme.textTheme.displayLarge?.copyWith(
            color: AppColors.tokenGold,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'tokens',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.tokenGold.withValues(alpha: 0.7),
          ),
        ),
        AppSpacing.verticalMd,

        // From line
        Text(
          _fromLine,
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        AppSpacing.verticalSm,

        // Message
        if (data.message.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              '"${data.message}"',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white54,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          AppSpacing.verticalMd,
        ],

        // Contributors list
        if (data.visibleContributorNames.isNotEmpty)
          _buildContributorsList(theme, data),

        AppSpacing.verticalLg,

        // Claim button
        ElevatedButton(
          onPressed: _onClaim,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.iconColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text('Claim'),
        ),
      ],
    );
  }

  Widget _buildClaimingPhase(ThemeData theme, GiftStyleColors colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            color: colors.iconColor,
            strokeWidth: 3,
          ),
        ),
        AppSpacing.verticalMd,
        Text(
          'Claiming...',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildClaimedPhase(ThemeData theme, GiftStyleColors colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle,
          size: 80,
          color: AppColors.success,
        ),
        AppSpacing.verticalMd,
        Text(
          'Claimed!',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: AppColors.success,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalSm,
        Text(
          '${widget.giftData.amount} tokens added to your balance',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildContributorsList(
      ThemeData theme, GroupGiftMessageData data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...data.visibleContributorNames.map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          if (data.anonymousCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '+ ${data.anonymousCount} anonymous',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white38,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String get _fromLine {
    final data = widget.giftData;
    final names = data.visibleContributorNames;
    final total = data.contributorCount;

    if (total == 1 && names.isNotEmpty) return 'From ${names.first}';
    if (names.isNotEmpty) {
      final othersCount = total - 1;
      return 'From ${names.first} and $othersCount other${othersCount > 1 ? 's' : ''}';
    }
    return 'From ${data.organizerName} and others';
  }
}
