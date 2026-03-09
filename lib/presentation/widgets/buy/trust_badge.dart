import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Size variants for the trust badge.
enum TrustBadgeSize { small, medium, large }

/// Displays a provider's trust score with color coding and optional verified indicator.
///
/// Color gradient: red < 2.0, amber 2.0–3.5, green > 3.5
class TrustBadge extends StatelessWidget {
  final double score;
  final bool isVerified;
  final TrustBadgeSize size;

  const TrustBadge({
    super.key,
    required this.score,
    this.isVerified = false,
    this.size = TrustBadgeSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerified) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            color: AppColors.success,
            size: _iconSize,
          ),
          if (size != TrustBadgeSize.small) ...[
            const SizedBox(width: 4),
            Text(
              'Verified',
              style: TextStyle(
                color: AppColors.success,
                fontSize: _fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: _scoreColor, size: _iconSize),
        const SizedBox(width: 2),
        Text(
          score.toStringAsFixed(1),
          style: TextStyle(
            color: _scoreColor,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color get _scoreColor {
    if (score < 2.0) return AppColors.error;
    if (score < 3.5) return AppColors.warning;
    return AppColors.success;
  }

  double get _iconSize {
    switch (size) {
      case TrustBadgeSize.small:
        return 14;
      case TrustBadgeSize.medium:
        return 18;
      case TrustBadgeSize.large:
        return 22;
    }
  }

  double get _fontSize {
    switch (size) {
      case TrustBadgeSize.small:
        return 11;
      case TrustBadgeSize.medium:
        return 13;
      case TrustBadgeSize.large:
        return 15;
    }
  }
}
