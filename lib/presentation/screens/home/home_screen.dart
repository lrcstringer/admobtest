import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/entities/pot_pool.dart';
import '../../../domain/enums/pot_type.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/earn_inbox/earn_inbox_bloc.dart';
import '../../blocs/pot/pot_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';

/// Highlight zones synced to intro video playback timestamps.
enum _HighlightZone { none, potCards, streakDays, inviteFriends, helpIcon }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  // Intro video (first visit to Home only)
  static const _kHomeVideoKey = 'home_video_shown';
  VideoPlayerController? _videoController;
  bool _showVideo = false;
  bool _videoPlaying = false;
  bool _videoFinished = false;
  bool _videoInitialized = false;

  // Highlight overlay tied to video playback
  final _potCardsKey = GlobalKey();
  final _streakKey = GlobalKey();
  final _inviteKey = GlobalKey();
  _HighlightZone _activeZone = _HighlightZone.none;
  OverlayEntry? _highlightOverlay;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(const WalletEvent.loadLedger());
    final potBloc = context.read<PotBloc>();
    potBloc.add(const PotEvent.watchDailyPot());
    potBloc.add(const PotEvent.watchWeeklyPot());
    potBloc.add(const PotEvent.loadCurrentUserScore(PotType.daily));
    potBloc.add(const PotEvent.loadCurrentUserScore(PotType.weekly));
    // Keep overlay in sync with scroll position
    _scrollController.addListener(() => _highlightOverlay?.markNeedsBuild());
    _initVideoIfFirstVisit();
  }

  Future<void> _initVideoIfFirstVisit() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_kHomeVideoKey) == true) return;

    // Mark as shown immediately so interrupted sessions don't replay
    await prefs.setBool(_kHomeVideoKey, true);

    if (!mounted) return;
    setState(() => _showVideo = true);

    final controller = VideoPlayerController.asset(
        'assets/video/AyandaHomeVid_cropped.mp4');
    _videoController = controller;

    await controller.initialize();
    if (!mounted) return;
    setState(() => _videoInitialized = true);

    controller.addListener(_onVideoPlaybackChanged);
  }

  void _onVideoPlaybackChanged() {
    final c = _videoController;
    if (c == null || _videoFinished) return;

    final pos = c.value.position;
    final dur = c.value.duration;

    // Update highlight zone while playing
    if (_videoPlaying) {
      final newZone = _zoneForSeconds(pos.inSeconds);
      if (newZone != _activeZone) {
        _activeZone = newZone;
        _scrollToActiveZone();
      }
    }

    // Detect playback completion
    if (dur.inMilliseconds > 0 &&
        pos.inMilliseconds > 0 &&
        !c.value.isPlaying &&
        (dur - pos).inMilliseconds < 500) {
      _removeHighlightOverlay();
      setState(() => _videoFinished = true);
    }
  }

  /// Smoothly scrolls to bring the currently highlighted widget into view,
  /// then rebuilds the overlay so the glow tracks the new position.
  void _scrollToActiveZone() {
    GlobalKey? targetKey;
    switch (_activeZone) {
      case _HighlightZone.potCards:
        targetKey = _potCardsKey;
      case _HighlightZone.streakDays:
        targetKey = _streakKey;
      case _HighlightZone.inviteFriends:
        targetKey = _inviteKey;
      case _HighlightZone.helpIcon:
      case _HighlightZone.none:
        // Help icon is in the AppBar (fixed, not scrollable) — just rebuild.
        _highlightOverlay?.markNeedsBuild();
        return;
    }

    final ctx = targetKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.5, // centre widget in viewport
      ).then((_) => _highlightOverlay?.markNeedsBuild());
    } else {
      _highlightOverlay?.markNeedsBuild();
    }
  }

  _HighlightZone _zoneForSeconds(int s) {
    // 4-14s: bottom nav (skipped)
    if (s >= 16 && s <= 25) return _HighlightZone.potCards;
    if (s >= 28 && s <= 60) return _HighlightZone.streakDays;
    if (s >= 64 && s <= 80) return _HighlightZone.inviteFriends;
    if (s >= 82 && s <= 92) return _HighlightZone.helpIcon;
    return _HighlightZone.none;
  }

  Rect? _getHighlightRect() {
    switch (_activeZone) {
      case _HighlightZone.none:
        return null;
      case _HighlightZone.potCards:
        return _rectFromKey(_potCardsKey);
      case _HighlightZone.streakDays:
        return _rectFromKey(_streakKey);
      case _HighlightZone.inviteFriends:
        return _rectFromKey(_inviteKey);
      case _HighlightZone.helpIcon:
        // Help icon is the first action button in the AppBar (right side)
        final topPad = MediaQuery.of(context).padding.top;
        final screenW = MediaQuery.of(context).size.width;
        return Rect.fromLTWH(screenW - 144, topPad + 4, 48, 48);
    }
  }

  Rect? _rectFromKey(GlobalKey key) {
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    final pos = box.localToGlobal(Offset.zero);
    return pos & box.size;
  }

  void _showHighlightOverlay() {
    _highlightOverlay = OverlayEntry(
      builder: (_) {
        final rect = _getHighlightRect();
        if (rect == null) return const SizedBox.shrink();

        const pad = 6.0;
        return IgnorePointer(
          child: SizedBox.expand(
            child: Stack(
              children: [
                Positioned(
                  left: rect.left - pad,
                  top: rect.top - pad,
                  width: rect.width + pad * 2,
                  height: rect.height + pad * 2,
                  child: _PulsingGlowBorder(key: ValueKey(_activeZone)),
                ),
              ],
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_highlightOverlay!);
  }

  void _removeHighlightOverlay() {
    _highlightOverlay?.remove();
    _highlightOverlay = null;
    _activeZone = _HighlightZone.none;
  }

  void _disposeVideo() {
    _removeHighlightOverlay();
    _videoController?.removeListener(_onVideoPlaybackChanged);
    _videoController?.dispose();
    _videoController = null;
  }

  @override
  void dispose() {
    _disposeVideo();
    _scrollController.dispose();
    super.dispose();
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const IMaliAppBar(title: 'Home'),
      body: _buildHomeTab(),
    );
  }

  Widget _buildHomeTab() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;

        return BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            return BlocBuilder<PotBloc, PotState>(
              builder: (context, potState) {
                return RefreshIndicator(
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
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: TabBackground(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppColors.themed(context).tabGradient,
                      ),
                      overlayAsset: AppColors.themed(context).waveOverlay,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          MediaQuery.of(context).padding.top + kToolbarHeight + 8,
                          20,
                          24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(context, user, walletState),
                            const SizedBox(height: 12),
                            _buildTokenBalanceCard(context, walletState),
                            const SizedBox(height: 16),
                            _buildDailyProgressCard(context),
                            // Intro video (first visit only)
                            if (_showVideo && _videoController != null)
                              _buildIntroVideo(),
                            const SizedBox(height: 24),
                            _buildPotCardsRow(context, potState),
                            const SizedBox(height: 24),
                            _buildInviteFriendsButton(context),
                            const SizedBox(height: 16),
                            _buildHowItWorksLink(context),
                          ],
                        ),
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
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                user?.displayName ?? 'User',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            _buildStreakBadge(context, streak),
          ],
        ),
      ],
    );
  }

  Widget _buildStreakBadge(BuildContext context, int streak) {
    return Container(
      key: _streakKey,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.goldGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department,
              size: 18, color: AppColors.textOnSecondary),
          const SizedBox(width: 6),
          Text(
            'STREAK: $streak DAYS',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textOnSecondary,
                  fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              AppColors.logoGradient[0].withValues(alpha: 0.06),
              Theme.of(context).colorScheme.surface,
            ),
            Color.alphaBlend(
              AppColors.logoGradient[1].withValues(alpha: 0.03),
              Theme.of(context).colorScheme.surface,
            ),
          ],
        ),
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.themed(context).cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Tokens Balance:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(width: 8),
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      color: AppColors.primary, strokeWidth: 2),
                )
              else
                Text(
                  '$balance',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          AppButton(
            text: 'Earn Now',
            onPressed: () => context.go('/earn'),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyProgressCard(BuildContext context) {
    return BlocBuilder<EarnInboxBloc, EarnInboxState>(
      buildWhen: (prev, curr) =>
          prev.dailyCompletions != curr.dailyCompletions ||
          prev.dailyEarnCap != curr.dailyEarnCap ||
          prev.dailyLimitReached != curr.dailyLimitReached,
      builder: (context, state) {
        final completions = state.dailyCompletions;
        final cap = state.dailyEarnCap;
        final progress = cap > 0 ? (completions / cap).clamp(0.0, 1.0) : 0.0;

        return GestureDetector(
          onTap: () => context.go('/earn'),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.goldGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Progress",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.textOnSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '$completions / $cap',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.textOnSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor:
                      AppColors.textOnSecondary.withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.textOnSecondary),
                ),
                const SizedBox(height: 6),
                Text(
                  state.dailyLimitReached
                      ? 'Daily limit reached! Come back tomorrow'
                      : '${(progress * 100).toStringAsFixed(0)}% of daily earn limit',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color:
                            AppColors.textOnSecondary.withValues(alpha: 0.8),
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIntroVideo() {
    return AnimatedOpacity(
      opacity: _videoFinished ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 500),
      onEnd: () {
        if (_videoFinished) {
          setState(() {
            _showVideo = false;
            _disposeVideo();
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: GestureDetector(
          onTap: () {
            if (!_videoPlaying && _videoInitialized) {
              _videoController!.play();
              setState(() => _videoPlaying = true);
              _showHighlightOverlay();
            }
          },
          // Shrink to mini-player once playing so all highlights stay on-screen
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: _videoPlaying ? 0.55 : 1.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            builder: (context, widthFactor, _) {
              return Center(
                child: FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: ClipRRect(
                  borderRadius: AppSpacing.borderRadiusMd,
                  child: AspectRatio(
                    aspectRatio: _videoInitialized
                        ? _videoController!.value.aspectRatio
                        : 16 / 9,
                    child: _videoInitialized
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox.expand(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width:
                                        _videoController!.value.size.width,
                                    height:
                                        _videoController!.value.size.height,
                                    child: VideoPlayer(_videoController!),
                                  ),
                                ),
                              ),
                              if (!_videoPlaying)
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.black.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          )
                        : Container(color: Colors.black),
                  ),
                ),
              ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPotCardsRow(BuildContext context, PotState potState) {
    return Row(
      key: _potCardsKey,
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
      child: ClipRRect(
        borderRadius: AppSpacing.borderRadiusLg,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.alphaBlend(
                  accentColors[0].withValues(alpha: 0.04),
                  Theme.of(context).colorScheme.surface,
                ),
                Color.alphaBlend(
                  accentColors[1].withValues(alpha: 0.02),
                  Theme.of(context).colorScheme.surface,
                ),
              ],
            ),
            borderRadius: AppSpacing.borderRadiusLg,
            border: Border.all(color: AppColors.themed(context).cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  // Top gradient color bar
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: accentColors),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  // Label + trophy row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: accentColors.first,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                      ),
                      Icon(Icons.emoji_events,
                          color: accentColors.first, size: 18),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4),
                  // Amount
                  Text(
                    amount,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Timer row
                  Row(
                    children: [
                      Icon(Icons.timer_outlined,
                          size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          timeLeft,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userRank != null
                            ? 'Your Rank: #$userRank'
                            : 'Your Rank: #\u2014',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                      ),
                      Icon(Icons.chevron_right,
                          size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ],
                  ),
                      ],
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildInviteFriendsButton(BuildContext context) {
    return GestureDetector(
      key: _inviteKey,
      onTap: () => context.push('/home/profile/referrals'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: AppColors.primaryGradient),
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_add_outlined,
                color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              'Invite Friends & Earn',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
          'How iMaliChat works',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

/// Pulsing gold glow border used as a highlight overlay during intro video.
class _PulsingGlowBorder extends StatefulWidget {
  const _PulsingGlowBorder({super.key});

  @override
  State<_PulsingGlowBorder> createState() => _PulsingGlowBorderState();
}

class _PulsingGlowBorderState extends State<_PulsingGlowBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final t = _pulse.value;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.gold.withValues(alpha: 0.4 + t * 0.4),
              width: 2 + t,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.15 + t * 0.2),
                blurRadius: 12 + t * 8,
                spreadRadius: 1 + t * 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
