import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for moderating marketplace listings.
/// Tabs: Flagged/Reported, All Active, Removed.
class MarketplaceListingModerationScreen extends StatefulWidget {
  const MarketplaceListingModerationScreen({super.key});

  @override
  State<MarketplaceListingModerationScreen> createState() =>
      _MarketplaceListingModerationScreenState();
}

class _MarketplaceListingModerationScreenState
    extends State<MarketplaceListingModerationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _listings = [];
  List<Map<String, dynamic>> _reports = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final [listingsSnap, reportsSnap] = await Future.wait([
        FirebaseFirestore.instance
            .collection('marketplaceListings')
            .orderBy('createdAt', descending: true)
            .limit(200)
            .get(),
        FirebaseFirestore.instance
            .collection('marketplaceReports')
            .orderBy('createdAt', descending: true)
            .limit(100)
            .get(),
      ]);

      final listings = listingsSnap.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      final reports = reportsSnap.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (mounted) {
        setState(() {
          _listings = listings;
          _reports = reports;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading listings: $e')),
        );
      }
    }
  }

  List<Map<String, dynamic>> get _flaggedListings =>
      _listings.where((l) => l['status'] == 'flagged').toList();
  List<Map<String, dynamic>> get _activeListings =>
      _listings.where((l) => l['status'] == 'active').toList();
  List<Map<String, dynamic>> get _removedListings =>
      _listings.where((l) => l['status'] == 'removed').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Listing Moderation',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Review flagged listings and moderate content',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _loadData,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _StatCard(
                          title: 'Flagged',
                          value: '${_flaggedListings.length}',
                          icon: Icons.flag,
                          color: AppColors.error),
                      _StatCard(
                          title: 'Active',
                          value: '${_activeListings.length}',
                          icon: Icons.storefront,
                          color: AppColors.success),
                      _StatCard(
                          title: 'Removed',
                          value: '${_removedListings.length}',
                          icon: Icons.delete_outline,
                          color: AppColors.textTertiary),
                      _StatCard(
                          title: 'Reports',
                          value: '${_reports.length}',
                          icon: Icons.report,
                          color: AppColors.warning),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Flagged (${_flaggedListings.length})'),
                      Tab(text: 'Active (${_activeListings.length})'),
                      Tab(text: 'Removed (${_removedListings.length})'),
                    ],
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildListingTable(_flaggedListings,
                          showDismiss: true, showRemove: true),
                      _buildListingTable(_activeListings,
                          showFlag: true, showRemove: true),
                      _buildListingTable(_removedListings,
                          showReinstate: true),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildListingTable(
    List<Map<String, dynamic>> listings, {
    bool showDismiss = false,
    bool showRemove = false,
    bool showFlag = false,
    bool showReinstate = false,
  }) {
    if (listings.isEmpty) {
      return Center(
        child: Text('No listings',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _headerCell('Title', flex: 2),
              _headerCell('Category', flex: 1),
              _headerCell('Provider', flex: 2),
              _headerCell('Price', flex: 1),
              _headerCell('Reports', flex: 1),
              _headerCell('Status', flex: 1),
              _headerCell('Actions', flex: 2),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: listings.length,
            itemBuilder: (_, i) => _buildListingRow(
              listings[i],
              showDismiss: showDismiss,
              showRemove: showRemove,
              showFlag: showFlag,
              showReinstate: showReinstate,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListingRow(
    Map<String, dynamic> listing, {
    bool showDismiss = false,
    bool showRemove = false,
    bool showFlag = false,
    bool showReinstate = false,
  }) {
    final status = listing['status'] ?? 'unknown';
    final reportCount = listing['reportCount'] ?? 0;
    final priceTokens = listing['priceTokens'] ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(listing['title'] ?? '—',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 1,
            child: Text(listing['category'] ?? '—',
                style: TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 2,
            child: Text(listing['providerName'] ?? '—',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child: Text('$priceTokens',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tokenGold)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '$reportCount',
              style: TextStyle(
                fontSize: 13,
                color: reportCount > 0 ? AppColors.error : AppColors.textSecondary,
                fontWeight: reportCount > 0 ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Expanded(flex: 1, child: _buildStatusBadge(status)),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  color: AppColors.textSecondary,
                  onPressed: () => _showListingDetail(listing),
                  tooltip: 'View details',
                ),
                if (showDismiss)
                  IconButton(
                    icon: const Icon(Icons.check_circle, size: 18),
                    color: AppColors.success,
                    onPressed: () => _dismissFlags(listing['id']),
                    tooltip: 'Dismiss flags',
                  ),
                if (showFlag)
                  IconButton(
                    icon: const Icon(Icons.flag, size: 18),
                    color: AppColors.warning,
                    onPressed: () => _flagListing(listing['id']),
                    tooltip: 'Flag',
                  ),
                if (showRemove)
                  IconButton(
                    icon: const Icon(Icons.delete, size: 18),
                    color: AppColors.error,
                    onPressed: () => _removeListing(listing['id']),
                    tooltip: 'Remove',
                  ),
                if (showReinstate)
                  IconButton(
                    icon: const Icon(Icons.restore, size: 18),
                    color: AppColors.success,
                    onPressed: () => _reinstateListing(listing['id']),
                    tooltip: 'Reinstate',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'active':
        color = AppColors.success;
      case 'flagged':
        color = AppColors.error;
      case 'removed':
        color = AppColors.textTertiary;
      case 'soldOut':
        color = AppColors.warning;
      default:
        color = AppColors.textTertiary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }

  Widget _headerCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(text,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary)),
    );
  }

  void _showListingDetail(Map<String, dynamic> listing) {
    // Gather reports for this listing
    final listingReports =
        _reports.where((r) => r['targetId'] == listing['id']).toList();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text(listing['title'] ?? 'Listing',
            style: const TextStyle(fontSize: 16)),
        content: SizedBox(
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Listing fields
                ...listing.entries.map((e) {
                  final val = e.value is Timestamp
                      ? _formatTimestamp(e.value as Timestamp)
                      : '${e.value}';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(e.key,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: AppColors.textSecondary)),
                        ),
                        Expanded(
                          child: Text(val,
                              style: const TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                  );
                }),
                // Reports section
                if (listingReports.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text('Reports (${listingReports.length})',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 8),
                  ...listingReports.map((r) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r['reason'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                              if (r['description'] != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(r['description'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              AppColors.textSecondary)),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'Reporter: ${r['reporterId'] ?? '—'}',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textTertiary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _dismissFlags(String listingId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminDismissListingFlags')
          .call({'listingId': listingId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flags dismissed — listing approved')),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _flagListing(String listingId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminFlagListing')
          .call({'listingId': listingId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listing flagged')),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _removeListing(String listingId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Remove Listing?',
            style: TextStyle(fontSize: 16)),
        content: const Text(
            'This will remove the listing and notify the provider.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child:
                const Text('Remove', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminRemoveListing')
          .call({'listingId': listingId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listing removed')),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _reinstateListing(String listingId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminReinstateListing')
          .call({'listingId': listingId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listing reinstated')),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  String _formatTimestamp(Timestamp ts) {
    final dt = ts.toDate();
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(value,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
