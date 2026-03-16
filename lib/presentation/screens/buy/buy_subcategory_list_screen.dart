import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/buy_category.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Subcategory list for marketplace categories.
/// Shows all subcategories of a tapped parent category with SVG icons.
class BuySubcategoryListScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String categoryEmoji;
  final List<BuySubcategory> subcategories;

  const BuySubcategoryListScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryEmoji,
    required this.subcategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: IMaliAppBar(
        title: categoryName,
        backgroundColor: AppColors.buyCard,
        foregroundColor: AppColors.buyTextPrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.35, 1.0],
            colors: [
              AppColors.goldGradient[0].withValues(alpha: 0.15),
              AppColors.buyBackground,
              AppColors.buyBackground,
            ],
          ),
        ),
        child: subcategories.isEmpty
            ? _buildEmptyState()
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                itemCount: subcategories.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return _SubcategoryTile(
                    subcategory: subcategories[index],
                    parentCategoryId: categoryId,
                    parentCategoryEmoji: categoryEmoji,
                    onTap: () =>
                        _onSubcategoryTap(context, subcategories[index]),
                  );
                },
              ),
      ),
    );
  }

  void _onSubcategoryTap(BuildContext context, BuySubcategory sub) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${sub.name} — coming soon!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.buyCard,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category_outlined,
            size: 48,
            color: AppColors.buyTextTertiary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'No subcategories yet',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.buyTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Check back soon!',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.buyTextTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual subcategory row tile with SVG icon + emoji fallback.
class _SubcategoryTile extends StatelessWidget {
  final BuySubcategory subcategory;
  final String parentCategoryId;
  final String parentCategoryEmoji;
  final VoidCallback onTap;

  const _SubcategoryTile({
    required this.subcategory,
    required this.parentCategoryId,
    required this.parentCategoryEmoji,
    required this.onTap,
  });

  String get _iconSvgPath =>
      'assets/icons/buy/$parentCategoryId/${subcategory.id}.svg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.buyCardBorder.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              _iconSvgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                AppColors.buyTextPrimary,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (_) => Text(
                subcategory.iconEmoji.isNotEmpty
                    ? subcategory.iconEmoji
                    : parentCategoryEmoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                subcategory.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.buyTextPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.buyTextTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
