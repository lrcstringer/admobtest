import 'package:flutter/material.dart';

import '../../../domain/entities/vas_category.dart';
import 'vas_category_tile.dart';

/// Flat wrap of dense VAS category chips — same layout as BuyCategoryGrid.
class VasCategoryGrid extends StatelessWidget {
  final List<VasCategory> categories;
  final void Function(VasCategory category) onCategoryTap;

  const VasCategoryGrid({
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
          return VasCategoryTile(
            category: category,
            onTap: () => onCategoryTap(category),
          );
        }).toList(),
      ),
    );
  }
}
