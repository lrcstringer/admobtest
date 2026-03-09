import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/featured_item.dart';
import '../../theme/app_colors.dart';

/// Horizontal scrolling strip of trending items with live indicator.
class TrendingStrip extends StatelessWidget {
  final List<FeaturedItem> items;
  final String communityName;
  final ValueChanged<FeaturedItem> onItemTap;

  const TrendingStrip({
    super.key,
    required this.items,
    this.communityName = 'your area',
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) => _buildTrendingCard(items[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Pulsing red dot
          const _PulsingDot(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Trending in $communityName',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingCard(FeaturedItem item) {
    return GestureDetector(
      onTap: () => onItemTap(item),
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: item.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: AppColors.surface,
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.surface,
                          child: const Icon(
                            Icons.image,
                            color: AppColors.textTertiary,
                            size: 24,
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.surface,
                        child: const Icon(
                          Icons.local_fire_department,
                          color: AppColors.tertiary,
                          size: 28,
                        ),
                      ),
              ),
            ),
            // Text content
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (item.subtitle != null)
                    Text(
                      item.subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pulsing red dot indicator for "LIVE" trending content.
class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppColors.error,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
