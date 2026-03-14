import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../../core/services/buy_analytics_service.dart';
import '../../../domain/entities/featured_item.dart';
import '../../theme/app_colors.dart';
import '../common/brand_card.dart';

/// Presentation-layer helper that delegates to [FeaturedItem.isCurrentlyActiveAt]
/// with an explicit [now] captured once per build / event cycle.
bool _isActiveAt(FeaturedItem item, DateTime now) =>
    item.isCurrentlyActiveAt(now);

/// Auto-advancing featured carousel for Buy tab Layer 1.
/// 5-second auto-advance, pauses on touch, lifecycle-aware.
class FeaturedCarousel extends StatefulWidget {
  final List<FeaturedItem> items;
  final ValueChanged<FeaturedItem> onItemTap;

  const FeaturedCarousel({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel>
    with WidgetsBindingObserver {
  late PageController _pageController;
  Timer? _autoAdvanceTimer;
  int _currentPage = 0;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
    _startAutoAdvance();
  }

  @override
  void didUpdateWidget(covariant FeaturedCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    final now = DateTime.now();
    final oldActive =
        oldWidget.items.where((i) => _isActiveAt(i, now)).toList();
    final newActive =
        widget.items.where((i) => _isActiveAt(i, now)).toList();
    if (oldActive.length != newActive.length) {
      _autoAdvanceTimer?.cancel();
      _autoAdvanceTimer = null;
      _currentPage = 0;
      final oldController = _pageController;
      _pageController = PageController();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        oldController.dispose();
      });
      _startAutoAdvance();
    }
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startAutoAdvance();
    } else {
      _autoAdvanceTimer?.cancel();
      _autoAdvanceTimer = null;
    }
  }

  void _startAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    final now = DateTime.now();
    final activeItems =
        widget.items.where((item) => _isActiveAt(item, now)).toList();
    if (activeItems.length <= 1) return;

    _autoAdvanceTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _isUserInteracting) return;
      final tickNow = DateTime.now();
      final items =
          widget.items.where((item) => _isActiveAt(item, tickNow)).toList();
      if (items.isEmpty) return;
      if (!_pageController.hasClients) return;
      final nextPage = (_currentPage + 1) % items.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  BrandGradient _gradientForType(String bgGradientType) {
    switch (bgGradientType) {
      case 'goldOrange':
        return BrandGradient.goldOrange;
      case 'cyanBlue':
        return BrandGradient.cyanBlue;
      case 'pinkPurple':
        return BrandGradient.pinkPurple;
      case 'logo':
        return BrandGradient.logo;
      case 'custom':
        return BrandGradient.goldOrange;
      default:
        return BrandGradient.goldOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final activeItems =
        widget.items.where((item) => _isActiveAt(item, now)).toList();
    if (activeItems.isEmpty) {
      if (widget.items.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.buyCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, color: AppColors.buyTextTertiary, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'Featured content coming soon',
                    style: TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 180,
            child: GestureDetector(
              onPanDown: (_) {
                _isUserInteracting = true;
                _autoAdvanceTimer?.cancel();
                _autoAdvanceTimer = null;
              },
              onPanCancel: () {
                _isUserInteracting = false;
                _startAutoAdvance();
              },
              onPanEnd: (_) {
                _isUserInteracting = false;
                _startAutoAdvance();
              },
              child: PageView.builder(
                controller: _pageController,
                itemCount: activeItems.length,
                onPageChanged: (index) {
                  if (index < activeItems.length) {
                    setState(() => _currentPage = index);
                  }
                },
                itemBuilder: (context, index) {
                  return _buildCard(activeItems[index]);
                },
              ),
            ),
          ),
          if (activeItems.length > 1) ...[
            const SizedBox(height: 10),
            _buildDotIndicators(activeItems.length),
          ],
        ],
      ),
    );
  }

  Widget _buildCard(FeaturedItem item) {
    final List<Color> bgColors;
    final double intensity;
    final double imgOpacity;
    final isFullImage = item.imageLayout == 'full';

    if (item.bgGradientType == 'custom' && item.bgColorHex != null) {
      final hex = item.bgColorHex!;
      if (hex.contains(',')) {
        final parts = hex.split(',');
        bgColors = parts.map((h) => AppColors.parseHex(h.trim())).toList();
      } else {
        final c = AppColors.parseHex(hex);
        bgColors = [c, c];
      }
      intensity = item.colorIntensity;
      imgOpacity = item.imageOpacity;
    } else {
      bgColors = BrandCard.colorsFor(_gradientForType(item.bgGradientType));
      intensity = 0.4;
      imgOpacity = 0.3;
    }

    final darkBg = [
      Color.alphaBlend(
        bgColors[0].withValues(alpha: intensity),
        const Color(0xFF0D0D0D),
      ),
      Color.alphaBlend(
        bgColors[bgColors.length > 1 ? 1 : 0]
            .withValues(alpha: intensity * 0.75),
        const Color(0xFF0D0D0D),
      ),
    ];

    final circleColor = bgColors[0].withValues(alpha: 0.15);
    final hasLink =
        item.deepLinkRoute != null && item.deepLinkRoute!.isNotEmpty;
    final ctaLabel =
        hasLink ? (item.ctaText ?? _defaultCtaForType(item.type)) : '';

    return GestureDetector(
      onTap: () {
        GetIt.I<BuyAnalyticsService>().trackFeaturedItemTapped(
          itemId: item.id,
          itemType: item.type,
        );
        widget.onItemTap(item);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: darkBg,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              if (item.bgGradientType != 'custom') ...[
                Positioned(
                  right: -20,
                  top: -20,
                  child: _circle(120, circleColor),
                ),
                Positioned(
                  right: 50,
                  bottom: -30,
                  child: _circle(80, circleColor),
                ),
                Positioned(
                  right: 100,
                  top: 40,
                  child: _circle(50, circleColor.withValues(alpha: 0.08)),
                ),
              ],

              if (item.videoUrl != null && item.videoUrl!.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  left: isFullImage ? 0 : null,
                  width: isFullImage ? null : 160,
                  child: _FeaturedVideoPlayer(
                    videoUrl: item.videoUrl!,
                    posterUrl: item.imageUrl,
                    isFullImage: isFullImage,
                    isCustom: item.bgGradientType == 'custom',
                    opacity: imgOpacity,
                  ),
                )
              else if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  left: isFullImage ? 0 : null,
                  width: isFullImage ? null : 160,
                  child: item.bgGradientType == 'custom'
                      ? Opacity(
                          opacity: imgOpacity,
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl!,
                            fit: BoxFit.contain,
                            alignment: isFullImage
                                ? Alignment.center
                                : Alignment.centerRight,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) =>
                                const SizedBox.shrink(),
                            errorWidget: (context, url, error) =>
                                const SizedBox.shrink(),
                          ),
                        )
                      : ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            begin: isFullImage
                                ? Alignment.bottomCenter
                                : Alignment.centerRight,
                            end: isFullImage
                                ? Alignment.topCenter
                                : Alignment.centerLeft,
                            colors: [
                              Colors.white
                                  .withValues(alpha: imgOpacity),
                              Colors.transparent,
                            ],
                          ).createShader(bounds),
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const SizedBox.shrink(),
                            errorWidget: (context, url, error) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBadge(item.type),
                    const SizedBox(height: 8),

                    if (item.brandName != null &&
                        item.brandName!.isNotEmpty) ...[
                      Text(
                        item.brandName!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: bgColors[0],
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],

                    Expanded(
                      child: item.showTitle
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    if (item.subtitle != null &&
                        item.subtitle!.isNotEmpty) ...[
                      Text(
                        item.subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    if (ctaLabel.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB82C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ctaLabel,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.chevron_right,
                                size: 16, color: Color(0xFF1A1A1A)),
                          ],
                        ),
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

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _buildBadge(String type) {
    if (type == 'none') return const SizedBox.shrink();
    final (label, bg, fg) = _badgeConfigForType(type);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }

  (String, Color, Color) _badgeConfigForType(String type) {
    switch (type) {
      case 'promotion':
        return (
          '\u{1F525} LIMITED OFFER',
          const Color(0xFFFF6429),
          Colors.white
        );
      case 'trending':
        return (
          '\u{1F4C8} TRENDING',
          const Color(0xFF08C2F4),
          Colors.white
        );
      case 'collectible':
        return (
          '\u{1F48E} COLLECTIBLE',
          const Color(0xFFA011FF),
          Colors.white
        );
      default:
        return (
          '\u{2B50} CAMPAIGN',
          const Color(0xFFFFB82C),
          const Color(0xFF1A1A1A)
        );
    }
  }

  String _defaultCtaForType(String type) {
    switch (type) {
      case 'promotion':
        return 'Claim now';
      case 'trending':
        return 'Check it out';
      case 'collectible':
        return 'View collection';
      default:
        return 'Learn more';
    }
  }

  Widget _buildDotIndicators(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.buyMarketplaceAccent : AppColors.buyTextTertiary,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

/// Inline looping video player for featured carousel cards.
/// Muted, auto-plays, shows poster image while loading.
class _FeaturedVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? posterUrl;
  final bool isFullImage;
  final bool isCustom;
  final double opacity;

  const _FeaturedVideoPlayer({
    required this.videoUrl,
    this.posterUrl,
    required this.isFullImage,
    required this.isCustom,
    required this.opacity,
  });

  @override
  State<_FeaturedVideoPlayer> createState() => _FeaturedVideoPlayerState();
}

class _FeaturedVideoPlayerState extends State<_FeaturedVideoPlayer> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _disposed = false;
  bool _timedOut = false;

  @override
  void initState() {
    super.initState();
    _initializeController(widget.videoUrl);
  }

  @override
  void didUpdateWidget(covariant _FeaturedVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller?.dispose();
      _controller = null;
      _initialized = false;
      _timedOut = false;
      _initializeController(widget.videoUrl);
    }
  }

  void _initializeController(String url) {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller = controller;
    controller.initialize().timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        if (_disposed || !mounted) return;
        if (_controller != controller) return;
        controller.dispose();
        _controller = null;
        setState(() => _timedOut = true);
      },
    ).then((_) {
      if (_disposed || !mounted) return;
      if (_controller != controller) return;
      controller.setLooping(true);
      controller.setVolume(0);
      controller.play();
      setState(() => _initialized = true);
    }).catchError((_) {
      if (_disposed || !mounted) return;
      if (_controller != controller) return;
      controller.dispose();
      _controller = null;
      setState(() => _timedOut = true);
    });
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final Widget content;
    if (_initialized && controller != null && controller.value.isInitialized) {
      content = FittedBox(
        fit: widget.isCustom ? BoxFit.contain : BoxFit.cover,
        alignment: widget.isFullImage
            ? Alignment.center
            : Alignment.centerRight,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      );
    } else if (_timedOut || controller == null) {
      content = _buildPoster();
    } else {
      content = Shimmer.fromColors(
        baseColor: AppColors.buyShimmerBase,
        highlightColor: AppColors.buyShimmerHigh,
        child: Container(
          color: AppColors.buyCard,
        ),
      );
    }

    if (widget.isCustom) {
      return Opacity(opacity: widget.opacity, child: content);
    }

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: widget.isFullImage
            ? Alignment.bottomCenter
            : Alignment.centerRight,
        end: widget.isFullImage
            ? Alignment.topCenter
            : Alignment.centerLeft,
        colors: [
          Colors.white.withValues(alpha: widget.opacity),
          Colors.transparent,
        ],
      ).createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: content,
    );
  }

  Widget _buildPoster() {
    if (widget.posterUrl == null || widget.posterUrl!.isEmpty) {
      return const SizedBox.shrink();
    }
    return CachedNetworkImage(
      imageUrl: widget.posterUrl!,
      fit: widget.isCustom ? BoxFit.contain : BoxFit.cover,
      alignment:
          widget.isFullImage ? Alignment.center : Alignment.centerRight,
      width: double.infinity,
      height: double.infinity,
      placeholder: (context, url) => const SizedBox.shrink(),
      errorWidget: (context, url, error) => const SizedBox.shrink(),
    );
  }
}
