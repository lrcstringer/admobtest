import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/vas_category.dart';
import '../../theme/app_colors.dart';

/// Dense chip for VAS category: 18px SVG icon + 11px label, 8px radius.
class VasCategoryTile extends StatelessWidget {
  final VasCategory category;
  final VoidCallback onTap;

  const VasCategoryTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            SvgPicture.asset(
              category.iconSvgPath,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.buyTextPrimary,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (_) => const Icon(
                Icons.category,
                size: 14,
                color: AppColors.buyTextTertiary,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
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
