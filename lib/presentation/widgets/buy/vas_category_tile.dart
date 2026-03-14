import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/vas_category.dart';
import '../../theme/app_colors.dart';

/// Dense chip for VAS category.
///
/// When [prominent] is true the pill renders larger (22px icon, 13px text,
/// more padding) — used for the top-row featured categories.
class VasCategoryTile extends StatelessWidget {
  final VasCategory category;
  final VoidCallback onTap;
  final bool prominent;

  const VasCategoryTile({
    super.key,
    required this.category,
    required this.onTap,
    this.prominent = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = prominent ? 22.0 : 18.0;
    final fontSize = prominent ? 13.0 : 11.0;
    final padding = prominent
        ? const EdgeInsets.fromLTRB(8, 6, 12, 6)
        : const EdgeInsets.fromLTRB(5, 4, 8, 4);
    final radius = prominent ? 10.0 : 8.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(radius),
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
            SvgPicture.asset(
              category.iconSvgPath,
              width: iconSize,
              height: iconSize,
              colorFilter: const ColorFilter.mode(
                AppColors.buyTextPrimary,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (_) => Icon(
                Icons.category,
                size: iconSize - 4,
                color: AppColors.buyTextTertiary,
              ),
            ),
            SizedBox(width: prominent ? 6 : 4),
            Flexible(
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: AppColors.buyTextPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
