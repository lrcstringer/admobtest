import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/buy_category.dart';
import '../../theme/app_colors.dart';

/// Dense chip: 18px icon + 11px label, 8px radius, compact padding.
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
          padding: const EdgeInsets.fromLTRB(5, 4, 8, 4),
          decoration: BoxDecoration(
            color: AppColors.buyCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.buyCardBorder),
            boxShadow: const [
              BoxShadow(
                color: AppColors.buyShadow,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(context),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDisabled
                        ? AppColors.buyTextTertiary
                        : AppColors.buyTextPrimary,
                  ),
                ),
              ),
              if (category.isComingSoon) ...[
                const SizedBox(width: 3),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.buyWarning,
                    borderRadius: BorderRadius.circular(4),
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

  Widget _buildIcon(BuildContext context) {
    // Priority: logoUrl (network) > SVG asset > emoji fallback
    if (category.logoUrl != null && category.logoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: CachedNetworkImage(
          imageUrl: category.logoUrl!,
          width: 18,
          height: 18,
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
        category.isComingSoon ? AppColors.buyTextTertiary : AppColors.buyTextPrimary;
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
        style: const TextStyle(fontSize: 14),
      );
}
