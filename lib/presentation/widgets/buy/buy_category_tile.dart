import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/buy_category.dart';
import '../../theme/app_colors.dart';

/// Compact pill-shaped chip: inline SVG icon + text.
class BuyCategoryTile extends StatelessWidget {
  final BuyCategory category;
  final VoidCallback onTap;

  const BuyCategoryTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = category.isComingSoon;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: isDisabled ? 0.55 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(context),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDisabled
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              if (category.isComingSoon) ...[
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'SOON',
                    style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color get _bgColor {
    if (category.backgroundColor != null) {
      return AppColors.parseHex(category.backgroundColor!)
          .withValues(alpha: 0.12);
    }
    return AppColors.surfaceElevated;
  }

  Widget _buildIcon(BuildContext context) {
    // Priority: logoUrl (network) > SVG asset > emoji fallback
    if (category.logoUrl != null && category.logoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: category.logoUrl!,
          width: 20,
          height: 20,
          fit: BoxFit.contain,
          placeholder: (_, _) => _svgOrEmojiIcon(context),
          errorWidget: (_, _, _) => _svgOrEmojiIcon(context),
        ),
      );
    }
    return _svgOrEmojiIcon(context);
  }

  Widget _svgOrEmojiIcon(BuildContext context) {
    final iconColor =
        category.isComingSoon ? AppColors.textTertiary : AppColors.textPrimary;
    return SvgPicture.asset(
      category.iconSvgPath,
      width: 18,
      height: 18,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      placeholderBuilder: (_) => _emojiIcon,
    );
  }

  Widget get _emojiIcon => Text(
        category.iconEmoji,
        style: const TextStyle(fontSize: 16),
      );
}
