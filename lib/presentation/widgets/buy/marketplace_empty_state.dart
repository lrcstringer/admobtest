import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Empty state widget with personality variants for the marketplace (Spec §8.21).
///
/// Different icon + message per context:
/// - noResults: search returned nothing
/// - emptyCategory: category has no listings
/// - error: something went wrong
/// - noListings: marketplace is empty
class MarketplaceEmptyState extends StatelessWidget {
  final MarketplaceEmptyType type;
  final String? searchQuery;
  final String? categoryName;
  final VoidCallback? onAction;

  const MarketplaceEmptyState({
    super.key,
    required this.type,
    this.searchQuery,
    this.categoryName,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon,
              size: 56,
              color: AppColors.buyTextTertiary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              _title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.buyTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            if (onAction != null && _actionLabel != null) ...[
              const SizedBox(height: 20),
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.buyMarketplaceAccent,
                ),
                child: Text(_actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    switch (type) {
      case MarketplaceEmptyType.noResults:
        return Icons.search_off_rounded;
      case MarketplaceEmptyType.emptyCategory:
        return Icons.category_outlined;
      case MarketplaceEmptyType.error:
        return Icons.cloud_off_rounded;
      case MarketplaceEmptyType.noListings:
        return Icons.storefront_outlined;
    }
  }

  String get _title {
    switch (type) {
      case MarketplaceEmptyType.noResults:
        return searchQuery != null
            ? 'No results for "$searchQuery"'
            : 'No results found';
      case MarketplaceEmptyType.emptyCategory:
        return categoryName != null
            ? 'Nothing in $categoryName yet'
            : 'This category is empty';
      case MarketplaceEmptyType.error:
        return 'Something went wrong';
      case MarketplaceEmptyType.noListings:
        return 'The marketplace is quiet';
    }
  }

  String get _subtitle {
    switch (type) {
      case MarketplaceEmptyType.noResults:
        return 'Try different keywords or browse categories instead';
      case MarketplaceEmptyType.emptyCategory:
        return 'Be the first to list something here!';
      case MarketplaceEmptyType.error:
        return 'We couldn\'t load the marketplace. Check your connection and try again.';
      case MarketplaceEmptyType.noListings:
        return 'No one has listed anything yet. You could be the first seller!';
    }
  }

  String? get _actionLabel {
    switch (type) {
      case MarketplaceEmptyType.noResults:
        return 'Clear search';
      case MarketplaceEmptyType.emptyCategory:
        return 'Start selling';
      case MarketplaceEmptyType.error:
        return 'Try again';
      case MarketplaceEmptyType.noListings:
        return 'List an item';
    }
  }
}

enum MarketplaceEmptyType {
  noResults,
  emptyCategory,
  error,
  noListings,
}
