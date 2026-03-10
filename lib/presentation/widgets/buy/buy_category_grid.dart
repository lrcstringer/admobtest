import 'package:flutter/material.dart';

import '../../../domain/entities/buy_category.dart';
import 'buy_category_tile.dart';

/// Flat wrap of pill-shaped category chips — no sub-category grouping.
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
        spacing: 8,
        runSpacing: 8,
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
