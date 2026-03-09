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
            height: 160,
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

  Widget _buildCard(FeaturedItem item) {
    return GestureDetector(
      onTap: () => widget.onItemTap(item),
      child: BrandCard(
        gradient: _gradientForType(item.bgGradientType),
        tintOpacity: 0.10,
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image if available
              if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const SizedBox.shrink(),
                    errorWidget: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              // Gradient overlay for text readability
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.background.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),
              // Text content
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
