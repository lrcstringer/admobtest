import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/featured_item.dart';
import '../../theme/app_colors.dart';
import '../common/brand_card.dart';

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
    if (oldWidget.items.length != widget.items.length) {
      // Items list changed — reset page and timer
      _autoAdvanceTimer?.cancel();
      _currentPage = 0;
      _pageController.dispose();
      _pageController = PageController();
      _startAutoAdvance();
    }
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
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
    }
  }

  void _startAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    if (widget.items.length <= 1) return;

    _autoAdvanceTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_isUserInteracting || !mounted) return;

      final nextPage = (_currentPage + 1) % widget.items.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
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
      default:
        return BrandGradient.goldOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

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
                itemCount: widget.items.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return _buildCard(widget.items[index]);
                },
              ),
            ),
          ),
          if (widget.items.length > 1) ...[
            const SizedBox(height: 10),
            _buildDotIndicators(),
          ],
        ],
      ),
    );
  }

  /// Parse a hex color string like '#FF6429' to a [Color].
  Color _hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }

  Widget _buildCard(FeaturedItem item) {
    final List<Color> bgColors;
    final double intensity;
    final double imgOpacity;
    final isFullImage = item.imageLayout == 'full';

    if (item.bgGradientType == 'custom' && item.bgColorHex != null) {
      // Custom: use hex color(s) with configurable intensity/opacity
      final hex = item.bgColorHex!;
      if (hex.contains(',')) {
        final parts = hex.split(',');
        bgColors = parts.map((h) => _hexToColor(h.trim())).toList();
      } else {
        final c = _hexToColor(hex);
        bgColors = [c, c];
      }
      intensity = item.colorIntensity;
      imgOpacity = item.imageOpacity;
    } else {
      // Preset gradient (existing behavior — unchanged)
      bgColors = BrandCard.colorsFor(_gradientForType(item.bgGradientType));
      intensity = 0.4;
      imgOpacity = 0.3;
    }

    // Bold dark gradient background
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
      onTap: () => widget.onItemTap(item),
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
              // Decorative circles (preset gradients only)
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

              // Optional background image
              if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  left: isFullImage ? 0 : null,
                  width: isFullImage ? null : 160,
                  child: item.bgGradientType == 'custom'
                      // Custom: uniform opacity, image scaled to fit (no crop)
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
                            placeholder: (_, __) =>
                                const SizedBox.shrink(),
                            errorWidget: (_, __, ___) =>
                                const SizedBox.shrink(),
                          ),
                        )
                      // Preset: directional fade into background
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
                            placeholder: (_, __) =>
                                const SizedBox.shrink(),
                            errorWidget: (_, __, ___) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge chip
                    _buildBadge(item.type),
                    const SizedBox(height: 8),

                    // Brand name
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

                    // Title (flexible — absorbs remaining space)
                    Expanded(
                      child: Align(
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
                      ),
                    ),

                    // Subtitle
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

                    // CTA button
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

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.items.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.textTertiary,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
