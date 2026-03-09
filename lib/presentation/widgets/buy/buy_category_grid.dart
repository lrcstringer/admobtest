import 'package:flutter/material.dart';

import '../../../domain/entities/buy_category.dart';
import 'buy_category_tile.dart';

/// 4-column adaptive grid of buy category tiles.
class BuyCategoryGrid extends StatelessWidget {
  final List<BuyCategory> categories;
  final void Function(BuyCategory category) onCategoryTap;

  const BuyCategoryGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 12,
        runSpacing: 16,
        alignment: WrapAlignment.start,
        children: categories.map((category) {
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 24 - 36) / 4,
            child: BuyCategoryTile(
              category: category,
              onTap: () => onCategoryTap(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}
