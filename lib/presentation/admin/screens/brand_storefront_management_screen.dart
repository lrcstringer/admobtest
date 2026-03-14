import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

class BrandStorefrontManagementScreen extends StatefulWidget {
  const BrandStorefrontManagementScreen({super.key});

  @override
  State<BrandStorefrontManagementScreen> createState() =>
      _BrandStorefrontManagementScreenState();
}

class _BrandStorefrontManagementScreenState
    extends State<BrandStorefrontManagementScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _storefronts = [];

  @override
  void initState() {
    super.initState();
    _loadStorefronts();
  }

  Future<void> _loadStorefronts() async {
    setState(() => _isLoading = true);
    try {
      final result =
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminListBrandStorefronts')
              .call<dynamic>({});
      final data = result.data as Map<String, dynamic>?;
      final list = (data?['storefronts'] as List<dynamic>?) ?? [];
      if (mounted) {
        setState(() {
          _storefronts = list
              .map((e) => Map<String, dynamic>.from(e as Map))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      // Fallback: direct Firestore read
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('brandStorefronts')
            .where('isDeleted', isEqualTo: false)
            .get();
        if (mounted) {
          setState(() {
            _storefronts = snapshot.docs.map((d) {
              final data = d.data();
              data['id'] = d.id;
              return data;
            }).toList();
            _isLoading = false;
          });
        }
      } catch (_) {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final active =
        _storefronts.where((s) => s['isActive'] == true).length;
    final premium =
        _storefronts.where((s) => s['isPremium'] == true).length;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Brand Storefronts',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage branded storefront pages',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh,
                          color: AppColors.textPrimary),
                      onPressed: _loadStorefronts,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Create Storefront'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 40),
                      ),
                      onPressed: () => context.go('/buy-storefront-builder'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatCard(
                  icon: Icons.storefront,
                  color: AppColors.secondary,
                  title: 'Total',
                  value: '${_storefronts.length}',
                ),
                _StatCard(
                  icon: Icons.check_circle,
                  color: AppColors.success,
                  title: 'Active',
                  value: '$active',
                ),
                _StatCard(
                  icon: Icons.star,
                  color: AppColors.gold,
                  title: 'Premium',
                  value: '$premium',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table header
            _buildTableHeader(),
            const Divider(color: AppColors.borderDark, height: 1),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _storefronts.isEmpty
                      ? const Center(
                          child: Text(
                            'No storefronts configured yet',
                            style:
                                TextStyle(color: AppColors.textTertiary),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _storefronts.length,
                          separatorBuilder: (context, index) => Divider(
                            color: AppColors.borderDark,
                            height: 1,
                          ),
                          itemBuilder: (_, i) =>
                              _buildRow(_storefronts[i]),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const [
          Expanded(
              flex: 3,
              child: Text('Brand',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          Expanded(
              flex: 2,
              child: Text('Sections',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          Expanded(
              child: Text('Premium',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          Expanded(
              child: Text('Status',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> sf) {
    final isActive = sf['isActive'] == true;
    final isPremium = sf['isPremium'] == true;
    final sections = (sf['sections'] as List<dynamic>?)?.length ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Brand name + ID
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sf['brandName'] as String? ?? 'Unknown',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  sf['tagline'] as String? ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          // Sections count
          Expanded(
            flex: 2,
            child: Text(
              '$sections section${sections != 1 ? 's' : ''}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          // Premium
          Expanded(
            child: isPremium
                ? const Icon(Icons.star, color: AppColors.gold, size: 18)
                : const Text('—',
                    style: TextStyle(color: AppColors.textTertiary)),
          ),
          // Status
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.success.withValues(alpha: 0.15)
                    : AppColors.textTertiary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isActive ? 'Active' : 'Inactive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      isActive ? AppColors.success : AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Actions
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert,
                color: AppColors.textSecondary),
            color: AppColors.cardDark,
            onSelected: (action) => _onAction(action, sf),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: 'edit', child: Text('Open Builder')),
              PopupMenuItem(
                value: 'toggle',
                child: Text(isActive ? 'Deactivate' : 'Activate'),
              ),
              const PopupMenuItem(
                value: 'reviews',
                child: Text('Manage Reviews'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete',
                    style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onAction(String action, Map<String, dynamic> sf) async {
    switch (action) {
      case 'edit':
        final id = sf['id'] as String?;
        if (id != null) {
          context.go('/buy-storefront-builder?storefrontId=$id');
        }
      case 'toggle':
        try {
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminUpdateBrandStorefront')
              .call<dynamic>({
            'storefrontId': sf['id'],
            'isActive': !(sf['isActive'] == true),
          });
          _loadStorefronts();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: $e')),
            );
          }
        }
      case 'reviews':
        _showReviewsDialog(sf);
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: const Text('Delete Storefront?'),
            content: Text(
                'Delete "${sf['brandName']}" storefront? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
        try {
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminDeleteBrandStorefront')
              .call<dynamic>({'storefrontId': sf['id']});
          _loadStorefronts();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: $e')),
            );
          }
        }
    }
  }

  // ---------------------------------------------------------------------------
  // Reviews Dialog
  // ---------------------------------------------------------------------------

  void _showReviewsDialog(Map<String, dynamic> sf) {
    final brandId = sf['brandId'] as String? ?? sf['id'] as String? ?? '';
    final brandName = sf['brandName'] as String? ?? 'Unknown';

    showDialog(
      context: context,
      builder: (ctx) => _ReviewsDialogContent(
        brandId: brandId,
        brandName: brandName,
      ),
    );
  }

}

// =============================================================================
// Reviews Dialog (Stateful - loads from Firestore, supports remove/restore)
// =============================================================================

class _ReviewsDialogContent extends StatefulWidget {
  final String brandId;
  final String brandName;

  const _ReviewsDialogContent({
    required this.brandId,
    required this.brandName,
  });

  @override
  State<_ReviewsDialogContent> createState() => _ReviewsDialogContentState();
}

class _ReviewsDialogContentState extends State<_ReviewsDialogContent> {
  bool _loading = true;
  List<Map<String, dynamic>> _reviews = [];
  final Set<String> _togglingIds = {};

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() => _loading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('brandReviews')
          .where('brandId', isEqualTo: widget.brandId)
          .orderBy('createdAt', descending: true)
          .limit(100)
          .get();
      if (mounted) {
        setState(() {
          _reviews = snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return data;
          }).toList();
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading reviews: $e')),
        );
      }
    }
  }

  Future<void> _toggleReviewFlag(Map<String, dynamic> review) async {
    final reviewId = review['id'] as String;
    final isCurrentlyRemoved = review['isRemovedByAdmin'] == true;

    setState(() => _togglingIds.add(reviewId));
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminFlagBrandReview')
          .call<dynamic>({
        'reviewId': reviewId,
        'isRemovedByAdmin': !isCurrentlyRemoved,
      });
      // Update local state immediately for responsiveness
      if (mounted) {
        setState(() {
          final idx = _reviews.indexWhere((r) => r['id'] == reviewId);
          if (idx >= 0) {
            _reviews[idx]['isRemovedByAdmin'] = !isCurrentlyRemoved;
          }
          _togglingIds.remove(reviewId);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _togglingIds.remove(reviewId));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: Text('Reviews: ${widget.brandName}'),
      content: SizedBox(
        width: 560,
        height: 480,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _reviews.isEmpty
                ? const Center(
                    child: Text(
                      'No reviews yet',
                      style: TextStyle(color: AppColors.textTertiary),
                    ),
                  )
                : ListView.separated(
                    itemCount: _reviews.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColors.borderDark,
                      height: 1,
                    ),
                    itemBuilder: (_, i) => _buildReviewItem(_reviews[i]),
                  ),
      ),
      actions: [
        TextButton(
          onPressed: _loadReviews,
          child: const Text('Refresh'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    final userName = review['userName'] as String? ?? 'Anonymous';
    final rating = (review['overallRating'] as num?)?.toDouble() ?? 0.0;
    final comment = review['comment'] as String? ?? '';
    final isRemoved = review['isRemovedByAdmin'] == true;
    final reviewId = review['id'] as String;
    final isToggling = _togglingIds.contains(reviewId);

    // Format createdAt
    String createdAtStr = '';
    final createdAt = review['createdAt'];
    if (createdAt != null) {
      final dt = createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.tryParse(createdAt.toString());
      if (dt != null) {
        createdAtStr =
            '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isRemoved
                            ? AppColors.textTertiary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Stars
                    ...List.generate(5, (starIdx) {
                      return Icon(
                        starIdx < rating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.gold,
                        size: 16,
                      );
                    }),
                    const Spacer(),
                    if (isRemoved)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'REMOVED',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                  ],
                ),
                if (comment.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    comment,
                    style: TextStyle(
                      color: isRemoved
                          ? AppColors.textTertiary
                          : AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
                if (createdAtStr.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    createdAtStr,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Toggle button
          isToggling
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : TextButton(
                  onPressed: () => _toggleReviewFlag(review),
                  style: TextButton.styleFrom(
                    foregroundColor:
                        isRemoved ? AppColors.success : AppColors.error,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 32),
                  ),
                  child: Text(isRemoved ? 'Restore' : 'Remove'),
                ),
        ],
      ),
    );
  }
}

// =============================================================================
// Stat Card
// =============================================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
