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
    final topRow = categories.take(3).toList();
    final rest = categories.skip(3).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // First 3 pills — centred, larger
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < topRow.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                VasCategoryTile(
                  category: topRow[i],
                  onTap: () => onCategoryTap(topRow[i]),
                  prominent: true,
                ),
              ],
            ],
          ),
          if (rest.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: rest.map((category) {
                return VasCategoryTile(
                  category: category,
                  onTap: () => onCategoryTap(category),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
