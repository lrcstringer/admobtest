import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for marketplace analytics and KPIs.
class MarketplaceAnalyticsScreen extends StatefulWidget {
  const MarketplaceAnalyticsScreen({super.key});

  @override
  State<MarketplaceAnalyticsScreen> createState() =>
      _MarketplaceAnalyticsScreenState();
}

class _MarketplaceAnalyticsScreenState
    extends State<MarketplaceAnalyticsScreen> {
  bool _isLoading = false;
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _topProviders = [];
  List<Map<String, dynamic>> _topCategories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Try loading from CF first
      final result =
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminGetMarketplaceAnalytics')
              .call();
      final data = Map<String, dynamic>.from(result.data as Map? ?? {});

      if (mounted) {
        setState(() {
          _stats = data;
          _topProviders = List<Map<String, dynamic>>.from(
              data['topProviders'] ?? []);
          _topCategories = List<Map<String, dynamic>>.from(
              data['topCategories'] ?? []);
          _isLoading = false;
        });
      }
    } catch (_) {
      // Fallback: compute basic stats from Firestore
      await _loadFromFirestore();
    }
  }

  Future<void> _loadFromFirestore() async {
    try {
      final [ordersSnap, providersSnap, listingsSnap] = await Future.wait([
        FirebaseFirestore.instance.collection('buyOrders').limit(500).get(),
        FirebaseFirestore.instance
            .collection('providers')
            .where('status', isEqualTo: 'approved')
            .get(),
        FirebaseFirestore.instance
            .collection('marketplaceListings')
            .where('status', isEqualTo: 'active')
            .get(),
      ]);

      final orders = ordersSnap.docs.map((d) => d.data()).toList();
      final completedOrders =
          orders.where((o) => o['status'] == 'completed').toList();
      final disputedOrders =
          orders.where((o) => o['status'] == 'disputed').toList();
      final gmv = completedOrders.fold<int>(
          0, (total, o) => total + ((o['amount'] as num?) ?? 0).toInt());
      final escrowTotal = orders
          .where((o) =>
              ['escrowed', 'fulfilled', 'disputed'].contains(o['status']))
          .fold<int>(
              0, (total, o) => total + ((o['amount'] as num?) ?? 0).toInt());

      // Top providers by completed orders
      final providerOrderCounts = <String, int>{};
      for (final o in completedOrders) {
        final sid = o['sellerId'] as String? ?? '';
        providerOrderCounts[sid] = (providerOrderCounts[sid] ?? 0) + 1;
      }
      final sortedProviders = providerOrderCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final topProviders = sortedProviders.take(10).map((e) => {
            'providerId': e.key,
            'completedOrders': e.value,
          }).toList();

      // Top categories
      final categoryCounts = <String, int>{};
      for (final l in listingsSnap.docs) {
        final cat = l.data()['category'] as String? ?? 'other';
        categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1;
      }
      final sortedCategories = categoryCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final topCategories = sortedCategories.take(5).map((e) => {
            'category': e.key,
            'count': e.value,
          }).toList();

      if (mounted) {
        setState(() {
          _stats = {
            'gmv': gmv,
            'activeProviders': providersSnap.size,
            'activeListings': listingsSnap.size,
            'completedOrders': completedOrders.length,
            'escrowBalance': escrowTotal,
            'disputeRate': orders.isEmpty
                ? 0
                : (disputedOrders.length * 100 ~/ orders.length),
            'totalOrders': orders.length,
          };
          _topProviders = topProviders;
          _topCategories = topCategories;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading analytics: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Marketplace Analytics',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark)),
                          SizedBox(height: 4),
                          Text('Performance metrics and insights',
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
                  const SizedBox(height: 24),

                  // KPI cards
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _StatCard(
                          title: 'GMV (tokens)',
                          value: '${_stats['gmv'] ?? 0}',
                          icon: Icons.toll,
                          color: AppColors.tokenGold),
                      _StatCard(
                          title: 'Active Providers',
                          value: '${_stats['activeProviders'] ?? 0}',
                          icon: Icons.storefront,
                          color: AppColors.success),
                      _StatCard(
                          title: 'Active Listings',
                          value: '${_stats['activeListings'] ?? 0}',
                          icon: Icons.inventory_2,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'Completed Orders',
                          value: '${_stats['completedOrders'] ?? 0}',
                          icon: Icons.check_circle,
                          color: AppColors.success),
                      _StatCard(
                          title: 'Escrow Balance',
                          value: '${_stats['escrowBalance'] ?? 0}',
                          icon: Icons.lock,
                          color: AppColors.warning),
                      _StatCard(
                          title: 'Dispute Rate',
                          value: '${_stats['disputeRate'] ?? 0}%',
                          icon: Icons.warning_amber,
                          color: AppColors.error),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Top categories
                  const Text('Top Categories',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  if (_topCategories.isEmpty)
                    Text('No data',
                        style: TextStyle(color: AppColors.textSecondary))
                  else
                    ..._topCategories.map((cat) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: AppColors.adminCard,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(_getCategoryIcon(
                                      cat['category'] ?? ''),
                                  size: 20,
                                  color: AppColors.textSecondary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  cat['category'] ?? '—',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text('${cat['count'] ?? 0} listings',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary)),
                            ],
                          ),
                        )),
                  const SizedBox(height: 32),

                  // Top providers
                  const Text('Top Providers',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  if (_topProviders.isEmpty)
                    Text('No data',
                        style: TextStyle(color: AppColors.textSecondary))
                  else
                    ..._topProviders.asMap().entries.map((entry) {
                      final i = entry.key;
                      final prov = entry.value;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: AppColors.adminCard,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('#${i + 1}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: i < 3
                                          ? AppColors.tokenGold
                                          : AppColors.textSecondary)),
                            ),
                            Expanded(
                              child: Text(
                                prov['providerName'] ??
                                    prov['providerId'] ??
                                    '—',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                                '${prov['completedOrders'] ?? 0} orders',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'services':
        return Icons.build;
      case 'goods':
        return Icons.shopping_bag;
      case 'food':
        return Icons.restaurant;
      case 'gigs':
        return Icons.work;
      case 'groupBuys':
        return Icons.groups;
      default:
        return Icons.category;
    }
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
        color: AppColors.adminCard,
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
                  fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark)),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
