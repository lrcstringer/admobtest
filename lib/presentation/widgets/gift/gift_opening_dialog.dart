import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/enums/gift_status.dart';
import '../../../domain/enums/gift_style.dart';
import '../../blocs/gift/gift_bloc.dart';
import '../../theme/app_colors.dart';
import 'gift_card_painters.dart';

/// Full-screen gift-opening overlay.
///
/// Flow:
/// 1. Sealed envelope with "Tap to Open" shimmer
/// 2. Tap → openGift CF fires → reveal animation (icon scales up, amount fades in, confetti)
/// 3. "Claim Tokens" button appears
/// 4. Claim → claimGift CF fires → success state → auto-dismiss

IconData _giftIcon(GiftStyle style) => switch (style) {
      GiftStyle.celebration => Icons.celebration,
      GiftStyle.birthday => Icons.cake,
      GiftStyle.love => Icons.favorite,
      GiftStyle.ndlovukazi => Icons.auto_awesome,
      GiftStyle.professional => Icons.business_center,
    };

/// Shows the gift-opening dialog for a received gift.
void showGiftOpeningDialog(
  BuildContext context, {
  required GiftMessageData gift,
  required String senderName,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    pageBuilder: (_, __, ___) => _GiftOpeningDialog(
      gift: gift,
      senderName: senderName,
    ),
  );
}

class _GiftOpeningDialog extends StatefulWidget {
  final GiftMessageData gift;
  final String senderName;

  const _GiftOpeningDialog({
    required this.gift,
    required this.senderName,
  });

  @override
  State<_GiftOpeningDialog> createState() => _GiftOpeningDialogState();
}

enum _DialogPhase { sealed, opening, revealed, claiming, claimed, expired }

class _GiftOpeningDialogState extends State<_GiftOpeningDialog>
    with TickerProviderStateMixin {
  _DialogPhase _phase = _DialogPhase.sealed;

  late final AnimationController _sealedPulse;
  late final AnimationController _revealController;
  late final AnimationController _confettiController;
  late final AnimationController _claimedController;

  late final Animation<double> _iconScale;
  late final Animation<double> _contentFade;

  String? _errorMessage;
  StreamSubscription<GiftState>? _blocSubscription;

  @override
  void initState() {
    super.initState();

    // Pre-fetch Play Integrity token so it's cached when user taps "Claim".
    // Without this, claimGift() blocks 3-10s fetching a fresh token.
    getIt<PlayIntegrityService>().warmUp();

    // Pulse animation for the sealed state
    _sealedPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Reveal animation
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _revealController, curve: Curves.elasticOut),
    );
    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _revealController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    // Confetti
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Claimed checkmark
    _claimedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Handle gift states that are already advanced
    switch (widget.gift.status) {
      case GiftStatus.opened:
        _phase = _DialogPhase.revealed;
        _revealController.value = 1.0;
      case GiftStatus.claimed:
        _phase = _DialogPhase.claimed;
        _claimedController.value = 1.0;
      case GiftStatus.expired:
        _phase = _DialogPhase.expired;
        _sealedPulse.stop();
      case GiftStatus.pending:
        // Auto-trigger open — skip the redundant sealed "Tap to Open" phase.
        // The user already tapped "Tap to Open" in the chat bubble to get here.
        WidgetsBinding.instance.addPostFrameCallback((_) => _onTapToOpen());
    }
  }

  @override
  void dispose() {
    _blocSubscription?.cancel();
    _sealedPulse.dispose();
    _revealController.dispose();
    _confettiController.dispose();
    _claimedController.dispose();
    super.dispose();
  }

  void _onTapToOpen() {
    if (_phase != _DialogPhase.sealed) return;
    setState(() {
      _phase = _DialogPhase.opening;
      _errorMessage = null;
    });

    final bloc = context.read<GiftBloc>();
    bloc.add(GiftEvent.openGift(widget.gift.giftId));

    _blocSubscription?.cancel();
    _blocSubscription = bloc.stream.listen((state) {
      if (!mounted) {
        _blocSubscription?.cancel();
        return;
      }
      if (state.errorMessage != null) {
        setState(() {
          _phase = _DialogPhase.sealed;
          _errorMessage = state.errorMessage;
        });
        bloc.add(const GiftEvent.clearError());
        _blocSubscription?.cancel();
        return;
      }
      if (!state.isLoading && state.activeGift != null) {
        setState(() => _phase = _DialogPhase.revealed);
        _sealedPulse.stop();
        _revealController.forward();
        _confettiController.forward();
        _blocSubscription?.cancel();
        return;
      }
    });
  }

  void _onClaimTokens() {
    if (_phase != _DialogPhase.revealed) return;
    setState(() {
      _phase = _DialogPhase.claiming;
      _errorMessage = null;
    });

    final bloc = context.read<GiftBloc>();
    bloc.add(GiftEvent.claimGift(widget.gift.giftId));

    _blocSubscription?.cancel();
    _blocSubscription = bloc.stream.listen((state) {
      if (!mounted) {
        _blocSubscription?.cancel();
        return;
      }
      if (state.errorMessage != null) {
        setState(() {
          _phase = _DialogPhase.revealed;
          _errorMessage = state.errorMessage;
        });
        bloc.add(const GiftEvent.clearError());
        _blocSubscription?.cancel();
        return;
      }
      if (!state.isClaiming && state.activeGift != null) {
        setState(() => _phase = _DialogPhase.claimed);
        _claimedController.forward();
        _blocSubscription?.cancel();
        // Auto-dismiss after showing success (600ms animation + 600ms hold)
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) Navigator.of(context).pop();
        });
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final styleColors = GiftStyleColors.forStyle(widget.gift.style);
    final icon = _giftIcon(widget.gift.style);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Style-specific particle layer (hearts, balloons, or rich confetti)
          if (_phase == _DialogPhase.revealed ||
              _phase == _DialogPhase.claiming ||
              _phase == _DialogPhase.claimed)
            AnimatedBuilder(
              animation: _confettiController,
              builder: (context, _) => CustomPaint(
                size: MediaQuery.of(context).size,
                painter: giftRevealPainter(
                  widget.gift.style,
                  progress: _confettiController.value,
                  color: styleColors.iconColor,
                ),
              ),
            ),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: _buildContent(context, styleColors, icon),
            ),
          ),

          // Close button (top right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: Colors.white70, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, GiftStyleColors styleColors, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sender info
        Text(
          'Sasaza from ${widget.senderName}',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),

        // Gift card with rich gradient + decorative background
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 280,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: styleColors.iconColor.withValues(alpha: 0.5), width: 2),
            boxShadow: [
              BoxShadow(
                color: styleColors.iconColor.withValues(alpha: 0.25),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Multi-color gradient background
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: styleColors.gradient
                          .map((c) => c.withValues(alpha: 0.3))
                          .toList(),
                    ),
                  ),
                ),
              ),

              // Style-specific decorative paint
              Positioned.fill(
                child: CustomPaint(
                  painter: giftStylePainter(widget.gift.style, opacity: 0.6),
                ),
              ),

              // Content on top
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: _phase == _DialogPhase.expired
                    ? _buildExpired(context, styleColors, icon)
                    : _phase == _DialogPhase.sealed ||
                            _phase == _DialogPhase.opening
                        ? _buildSealed(context, styleColors, icon)
                        : _buildRevealed(context, styleColors, icon),
              ),
            ],
          ),
        ),

        // Error message
        if (_errorMessage != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: AppColors.error, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSealed(
      BuildContext context, GiftStyleColors styleColors, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon composition with accents
        SizedBox(
          width: 72,
          height: 64,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Icon(icon, color: styleColors.iconColor, size: 56),
              if (widget.gift.style != GiftStyle.professional) ...[
                Positioned(
                  top: -4,
                  right: -8,
                  child: Icon(
                    Icons.auto_awesome,
                    color: styleColors.accent1.withValues(alpha: 0.6),
                    size: 16,
                  ),
                ),
                Positioned(
                  bottom: 2,
                  left: -6,
                  child: Icon(
                    Icons.star,
                    color: styleColors.accent2.withValues(alpha: 0.5),
                    size: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.gift.style.displayName,
          style: TextStyle(
            color: styleColors.iconColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),

        // Tap to Open button with pulse
        AnimatedBuilder(
          animation: _sealedPulse,
          builder: (context, child) {
            final scale = 1.0 + (_sealedPulse.value * 0.05);
            return Transform.scale(scale: scale, child: child);
          },
          child: _phase == _DialogPhase.opening
              ? const SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    color: Colors.white70,
                    strokeWidth: 3,
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: _onTapToOpen,
                  icon: const Icon(Icons.card_giftcard),
                  label: const Text('Tap to Open'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: styleColors.iconColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildExpired(
      BuildContext context, GiftStyleColors styleColors, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timer_off, color: Colors.white38, size: 56),
        const SizedBox(height: 12),
        const Text(
          'Expired',
          style: TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This Sasaza of ${widget.gift.amount} tokens has expired.\nTokens were refunded to the sender.',
          style: const TextStyle(color: Colors.white30, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRevealed(
      BuildContext context, GiftStyleColors styleColors, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated icon with accent sparkles
        ScaleTransition(
          scale: _iconScale,
          child: SizedBox(
            width: 80,
            height: 72,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Icon(icon, color: styleColors.iconColor, size: 64),
                if (widget.gift.style != GiftStyle.professional) ...[
                  Positioned(
                    top: -6,
                    right: -10,
                    child: Icon(
                      Icons.auto_awesome,
                      color: styleColors.accent1.withValues(alpha: 0.7),
                      size: 18,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: -8,
                    child: Icon(
                      Icons.star,
                      color: styleColors.accent2.withValues(alpha: 0.6),
                      size: 15,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.gift.style.displayName,
          style: TextStyle(
            color: styleColors.iconColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),

        // Amount reveal
        FadeTransition(
          opacity: _contentFade,
          child: Column(
            children: [
              Text(
                '${widget.gift.amount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'tokens',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              if (widget.gift.message.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  '"${widget.gift.message}"',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Claim / Claimed
        if (_phase == _DialogPhase.claimed)
          ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: _claimedController, curve: Curves.elasticOut),
            ),
            child: Column(
              children: [
                const Icon(Icons.check_circle,
                    color: AppColors.success, size: 48),
                const SizedBox(height: 8),
                Text(
                  '${widget.gift.amount} tokens added to your wallet!',
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else if (_phase == _DialogPhase.claiming)
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: AppColors.success,
              strokeWidth: 3,
            ),
          )
        else
          FadeTransition(
            opacity: _contentFade,
            child: ElevatedButton.icon(
              onPressed: _onClaimTokens,
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text('Claim Tokens'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
