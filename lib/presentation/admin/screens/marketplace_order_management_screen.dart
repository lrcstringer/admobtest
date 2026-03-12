import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing marketplace orders and disputes.
/// Tabs: Active, Disputed, Completed, Cancelled/Refunded.
class MarketplaceOrderManagementScreen extends StatefulWidget {
  const MarketplaceOrderManagementScreen({super.key});

  @override
  State<MarketplaceOrderManagementScreen> createState() =>
      _MarketplaceOrderManagementScreenState();
}

class _MarketplaceOrderManagementScreenState
    extends State<MarketplaceOrderManagementScreen>
    with SingleTickerProviderStateMixin {
  static const _pageSize = 50;

  late final TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _orders = [];
  DocumentSnapshot? _lastDoc;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      final snapshot = await FirebaseFirestore.instance
          .collection('buyOrders')
          .orderBy('createdAt', descending: true)
          .limit(_pageSize)
          .get();
      final orders = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (mounted) {
        setState(() {
          _orders = orders;
          _lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
          _hasMore = snapshot.docs.length >= _pageSize;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading orders: $e')),
        );
      }
    }
  }

  Future<void> _loadMore() async {
    if (!_hasMore || _isLoading || _lastDoc == null) return;
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('buyOrders')
          .orderBy('createdAt', descending: true)
          .startAfterDocument(_lastDoc!)
          .limit(_pageSize)
          .get();
      final moreOrders = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (mounted) {
        setState(() {
          _orders.addAll(moreOrders);
          _lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
          _hasMore = snapshot.docs.length >= _pageSize;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading more orders: $e')),
        );
      }
    }
  }

  List<Map<String, dynamic>> _filterByStatuses(List<String> statuses) {
    return _orders
        .where((o) => statuses.contains(o['status']))
        .toList();
  }

  int get _activeCount =>
      _orders.where((o) => ['pending', 'escrowed', 'fulfilled'].contains(o['status'])).length;
  int get _disputedCount =>
      _orders.where((o) => o['status'] == 'disputed').length;
  int get _completedCount =>
      _orders.where((o) => o['status'] == 'completed').length;
  int get _cancelledCount =>
      _orders.where((o) => ['cancelled', 'refunded'].contains(o['status'])).length;

  int get _totalEscrowTokens {
    return _orders
        .where((o) => ['escrowed', 'fulfilled', 'disputed'].contains(o['status']))
        .fold<int>(0, (total, o) => total + ((o['amount'] as num?) ?? 0).toInt());
  }

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
                          Text('Orders & Disputes',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Manage marketplace orders and resolve disputes',
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
                          title: 'Active',
                          value: '$_activeCount',
                          icon: Icons.pending_actions,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'In Escrow',
                          value: '$_totalEscrowTokens tokens',
                          icon: Icons.lock,
                          color: AppColors.tokenGold),
                      _StatCard(
                          title: 'Disputed',
                          value: '$_disputedCount',
                          icon: Icons.warning_amber,
                          color: AppColors.error),
                      _StatCard(
                          title: 'Completed',
                          value: '$_completedCount',
                          icon: Icons.check_circle,
                          color: AppColors.success),
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
                      Tab(text: 'Active ($_activeCount)'),
                      Tab(text: 'Disputed ($_disputedCount)'),
                      Tab(text: 'Completed ($_completedCount)'),
                      Tab(text: 'Cancelled ($_cancelledCount)'),
                    ],
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    isScrollable: true,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOrderTable(
                        _filterByStatuses(['pending', 'escrowed', 'fulfilled']),
                        showForceCancel: true,
                      ),
                      _buildOrderTable(
                        _filterByStatuses(['disputed']),
                        showResolve: true,
                      ),
                      _buildOrderTable(
                        _filterByStatuses(['completed']),
                      ),
                      _buildOrderTable(
                        _filterByStatuses(['cancelled', 'refunded']),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOrderTable(
    List<Map<String, dynamic>> orders, {
    bool showForceCancel = false,
    bool showResolve = false,
  }) {
    if (orders.isEmpty) {
      return Center(
        child: Text('No orders',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _headerCell('Listing', flex: 2),
              _headerCell('Buyer', flex: 2),
              _headerCell('Seller', flex: 2),
              _headerCell('Amount', flex: 1),
              _headerCell('Status', flex: 1),
              _headerCell('Created', flex: 1),
              _headerCell('Actions', flex: 2),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: orders.length + (_hasMore ? 1 : 0),
            itemBuilder: (_, i) {
              if (i >= orders.length) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : _loadMore,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Load More'),
                    ),
                  ),
                );
              }
              return _buildOrderRow(
                orders[i],
                showForceCancel: showForceCancel,
                showResolve: showResolve,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderRow(
    Map<String, dynamic> order, {
    bool showForceCancel = false,
    bool showResolve = false,
  }) {
    final status = order['status'] ?? 'unknown';
    final amount = order['amount'] ?? 0;
    final createdAt = order['createdAt'];
    final dateStr =
        createdAt is Timestamp ? _formatTimestamp(createdAt) : '$createdAt';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(order['listingTitle'] ?? '—',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text(order['buyerName'] ?? order['buyerId'] ?? '—',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 2,
            child: Text(order['sellerName'] ?? order['sellerId'] ?? '—',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child: Text('$amount',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tokenGold)),
          ),
          Expanded(flex: 1, child: _buildStatusBadge(status)),
          Expanded(
            flex: 1,
            child: Text(dateStr,
                style: TextStyle(
                    fontSize: 12, color: AppColors.textTertiary)),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  color: AppColors.textSecondary,
                  onPressed: () => _showOrderDetail(order),
                  tooltip: 'View details',
                ),
                if (showForceCancel)
                  IconButton(
                    icon: const Icon(Icons.cancel, size: 18),
                    color: AppColors.error,
                    onPressed: () => _forceCancelOrder(order['id']),
                    tooltip: 'Force cancel + refund',
                  ),
                if (showResolve) ...[
                  IconButton(
                    icon: const Icon(Icons.gavel, size: 18),
                    color: AppColors.warning,
                    onPressed: () => _resolveDispute(order),
                    tooltip: 'Resolve dispute',
                  ),
                ],
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
      case 'completed':
        color = AppColors.success;
      case 'pending':
        color = AppColors.warning;
      case 'escrowed':
        color = AppColors.secondary;
      case 'fulfilled':
        color = AppColors.secondary;
      case 'disputed':
        color = AppColors.error;
      case 'cancelled':
      case 'refunded':
        color = AppColors.textTertiary;
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

  void _showOrderDetail(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text('Order: ${order['id'] ?? ''}',
            style: const TextStyle(fontSize: 16)),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: order.entries.map((e) {
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
              }).toList(),
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

  Future<void> _forceCancelOrder(String orderId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Force Cancel Order?',
            style: TextStyle(fontSize: 16)),
        content: const Text(
            'This will cancel the order and refund the buyer. '
            'This action requires maker-checker approval.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Confirm',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminForceCancelOrder')
          .call({'orderId': orderId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order cancelled and refunded')),
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

  Future<void> _resolveDispute(Map<String, dynamic> order) async {
    String? resolution;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Resolve Dispute',
            style: TextStyle(fontSize: 16)),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (order['disputeReason'] != null) ...[
                const Text('Dispute reason:',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(order['disputeReason'],
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 16),
              ],
              const Text('Resolution:',
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 8),
              _ResolutionButton(
                label: 'Refund buyer',
                description: 'Full refund to buyer, seller gets nothing',
                onTap: () {
                  resolution = 'refund_buyer';
                  Navigator.of(ctx).pop();
                },
              ),
              const SizedBox(height: 8),
              _ResolutionButton(
                label: 'Release to seller',
                description: 'Release escrow to seller, buyer gets nothing',
                onTap: () {
                  resolution = 'release_seller';
                  Navigator.of(ctx).pop();
                },
              ),
              const SizedBox(height: 8),
              _ResolutionButton(
                label: 'Cancel',
                description: 'Go back without resolving',
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      ),
    );

    if (resolution == null) return;

    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminResolveDispute')
          .call({
        'orderId': order['id'],
        'resolution': resolution,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dispute resolved')),
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

class _ResolutionButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback onTap;

  const _ResolutionButton({
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 2),
              Text(description,
                  style: TextStyle(
                      fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
