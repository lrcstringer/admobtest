import 'package:flutter/material.dart';

import '../../../domain/entities/buy_category.dart';
import 'buy_category_tile.dart';

/// Flat wrap of dense category chips — no sub-category grouping.
/// 6px spacing, horizontal padding 16px.
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: categories.map((category) {
          return BuyCategoryTile(
            category: category,
            onTap: () => onCategoryTap(category),
          );
        }).toList(),
      ),
    );
  }
}
