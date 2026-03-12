import 'package:flutter/material.dart';

import '../../../domain/enums/seller_level.dart';
import '../../theme/app_colors.dart';

/// Size variants for seller level badge (Spec §8.7).
enum SellerBadgeSize {
  /// 14px — used on listing cards
  small,

  /// 18px — used on listing detail, icon + text
  medium,

  /// 24px — used on seller profile, with progress
  large,
}

/// Displays a seller level badge with colour-coded icon.
///
/// 4 levels:
/// - New Seller (grey)
/// - Active Seller (blue)
/// - Trusted (green shield)
/// - Star (gold star)
class SellerLevelBadge extends StatelessWidget {
  final SellerLevel level;
  final SellerBadgeSize size;
  final bool showLabel;

  const SellerLevelBadge({
    super.key,
    required this.level,
    this.size = SellerBadgeSize.medium,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = _icon;
    final color = _color;
    final iconSize = _iconSize;

    if (!showLabel) {
      return Icon(iconData, size: iconSize, color: color);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: iconSize, color: color),
        SizedBox(width: size == SellerBadgeSize.small ? 2 : 4),
        Text(
          level.displayName,
          style: TextStyle(
            color: color,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  IconData get _icon {
    switch (level) {
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

  Color get _color {
    switch (level) {
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

  double get _iconSize {
    switch (size) {
      case SellerBadgeSize.small:
        return 14;
      case SellerBadgeSize.medium:
        return 18;
      case SellerBadgeSize.large:
        return 24;
    }
  }

  double get _fontSize {
    switch (size) {
      case SellerBadgeSize.small:
        return 10;
      case SellerBadgeSize.medium:
        return 12;
      case SellerBadgeSize.large:
        return 14;
    }
  }
}

/// Seller level badge with progress bar towards the next level.
///
/// Used on the seller profile (large size).
class SellerLevelProgress extends StatelessWidget {
  final SellerLevel level;
  final int completedOrders;

  const SellerLevelProgress({
    super.key,
    required this.level,
    required this.completedOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SellerLevelBadge(
                level: level,
                size: SellerBadgeSize.large,
              ),
              const Spacer(),
              if (_nextLevel != null)
                Text(
                  '$completedOrders / $_nextThreshold orders',
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 11,
                  ),
                ),
            ],
          ),
          if (_nextLevel != null) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: AppColors.buyDivider,
                valueColor: AlwaysStoppedAnimation(_progressColor),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _progressLabel,
              style: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 11,
              ),
            ),
          ],
          if (_nextLevel == null)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                'You\'ve reached the highest seller level!',
                style: TextStyle(
                  color: AppColors.buyWarning,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  SellerLevel? get _nextLevel {
    switch (level) {
      case SellerLevel.newSeller:
        return SellerLevel.active;
      case SellerLevel.active:
        return SellerLevel.trusted;
      case SellerLevel.trusted:
        return SellerLevel.star;
      case SellerLevel.star:
        return null;
    }
  }

  int get _nextThreshold {
    switch (level) {
      case SellerLevel.newSeller:
        return 3; // 3 orders → Active
      case SellerLevel.active:
        return 15; // 15 orders → Trusted
      case SellerLevel.trusted:
        return 50; // 50 orders → Star
      case SellerLevel.star:
        return completedOrders;
    }
  }

  double get _progress {
    if (_nextLevel == null) return 1.0;
    return (completedOrders / _nextThreshold).clamp(0.0, 1.0);
  }

  Color get _progressColor {
    if (_nextLevel == null) return AppColors.buyWarning;
    switch (_nextLevel!) {
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

  String get _progressLabel {
    if (_nextLevel == null) return '';
    final remaining = _nextThreshold - completedOrders;
    if (remaining <= 0) return 'Level up available!';
    return '$remaining more ${remaining == 1 ? 'order' : 'orders'} to ${_nextLevel!.displayName}';
  }
}
