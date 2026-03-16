import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for monitoring VAS purchases (airtime, electricity, etc.).
class BuyPurchaseMonitoringScreen extends StatefulWidget {
  const BuyPurchaseMonitoringScreen({super.key});

  @override
  State<BuyPurchaseMonitoringScreen> createState() =>
      _BuyPurchaseMonitoringScreenState();
}

class _BuyPurchaseMonitoringScreenState
    extends State<BuyPurchaseMonitoringScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isLoading = false;
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _transactions = [];
  String _statusFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      // Load stats from CF
      final statsResult =
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminGetBuyPurchaseStats')
              .call();
      final stats =
          Map<String, dynamic>.from(statsResult.data as Map? ?? {});

      // Load recent transactions from Firestore
      final txnSnapshot = await FirebaseFirestore.instance
          .collection('purchases')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();
      final transactions = txnSnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (mounted) {
        setState(() {
          _stats = stats;
          _transactions = transactions;
          _isLoading = false;
        });
      }
    } catch (_) {
      // Fallback: load transactions only from Firestore
      try {
        final txnSnapshot = await FirebaseFirestore.instance
            .collection('purchases')
            .orderBy('createdAt', descending: true)
            .limit(50)
            .get();
        final transactions = txnSnapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
        if (mounted) {
          setState(() {
            _transactions = transactions;
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading data: $e')),
          );
        }
      }
    }
  }

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_statusFilter == 'all') return _transactions;
    return _transactions
        .where((t) => t['status'] == _statusFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header + tabs
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('VAS Purchases',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark)),
                          SizedBox(height: 4),
                          Text('Monitor airtime, data, electricity purchases',
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
                // Tab bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Transactions'),
                    ],
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                // Tab views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOverviewTab(),
                      _buildTransactionsTab(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOverviewTab() {
    final todayCount = _stats['todayCount'] ?? _transactions.length;
    final successRate = _stats['successRate'] ?? 0;
    final revenue = _stats['totalRevenue'] ?? 0;
    final failedCount = _stats['failedCount'] ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _StatCard(
                  title: "Today's Purchases",
                  value: '$todayCount',
                  icon: Icons.shopping_cart,
                  color: AppColors.secondary),
              _StatCard(
                  title: 'Success Rate',
                  value: '$successRate%',
                  icon: Icons.check_circle,
                  color: AppColors.success),
              _StatCard(
                  title: 'Revenue (tokens)',
                  value: '$revenue',
                  icon: Icons.toll,
                  color: AppColors.tokenGold),
              _StatCard(
                  title: 'Failed',
                  value: '$failedCount',
                  icon: Icons.error,
                  color: AppColors.error),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Recent Activity',
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          // Last 10 transactions as a quick list
          ..._transactions.take(10).map(_buildQuickRow),
        ],
      ),
    );
  }

  Widget _buildQuickRow(Map<String, dynamic> txn) {
    final status = txn['status'] ?? 'unknown';
    final category = txn['category'] ?? '';
    final amount = txn['amountTokens'] ?? txn['priceTokens'] ?? 0;
    final createdAt = txn['createdAt'];
    final dateStr = createdAt is Timestamp
        ? _formatTimestamp(createdAt)
        : '$createdAt';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Icon(_getCategoryIcon(category),
              size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(txn['productName'] ?? category,
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 1,
            child: Text('$amount tokens',
                style: TextStyle(
                    fontSize: 13, color: AppColors.tokenGold)),
          ),
          Expanded(
            flex: 1,
            child: _buildStatusBadge(status),
          ),
          Expanded(
            flex: 1,
            child: Text(dateStr,
                style: TextStyle(
                    fontSize: 12, color: AppColors.textTertiary)),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return Column(
      children: [
        // Filters
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _FilterChip(
                  label: 'All',
                  isSelected: _statusFilter == 'all',
                  onTap: () =>
                      setState(() => _statusFilter = 'all')),
              const SizedBox(width: 8),
              _FilterChip(
                  label: 'Completed',
                  isSelected: _statusFilter == 'completed',
                  onTap: () =>
                      setState(() => _statusFilter = 'completed')),
              const SizedBox(width: 8),
              _FilterChip(
                  label: 'Pending',
                  isSelected: _statusFilter == 'pending',
                  onTap: () =>
                      setState(() => _statusFilter = 'pending')),
              const SizedBox(width: 8),
              _FilterChip(
                  label: 'Failed',
                  isSelected: _statusFilter == 'failed',
                  onTap: () =>
                      setState(() => _statusFilter = 'failed')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Table header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildTxnTableHeader(),
        ),
        // Table rows
        Expanded(
          child: _filteredTransactions.isEmpty
              ? Center(
                  child: Text('No transactions found',
                      style: TextStyle(color: AppColors.textSecondary)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _filteredTransactions.length,
                  itemBuilder: (_, i) =>
                      _buildTxnRow(_filteredTransactions[i]),
                ),
        ),
      ],
    );
  }

  Widget _buildTxnTableHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          _headerCell('Category', flex: 1),
          _headerCell('Product', flex: 2),
          _headerCell('Recipient', flex: 2),
          _headerCell('Amount', flex: 1),
          _headerCell('Status', flex: 1),
          _headerCell('Date', flex: 1),
          _headerCell('Actions', flex: 1),
        ],
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

  Widget _buildTxnRow(Map<String, dynamic> txn) {
    final status = txn['status'] ?? 'unknown';
    final category = txn['category'] ?? '';
    final amount = txn['amountTokens'] ?? txn['priceTokens'] ?? 0;
    final createdAt = txn['createdAt'];
    final dateStr = createdAt is Timestamp
        ? _formatTimestamp(createdAt)
        : '$createdAt';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Icon(_getCategoryIcon(category),
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(category,
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(txn['productName'] ?? '—',
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text(txn['recipientNumber'] ?? '—',
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
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.visibility, size: 18),
              color: AppColors.textSecondary,
              onPressed: () => _showTxnDetail(txn),
              tooltip: 'View details',
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
      case 'processing':
        color = AppColors.warning;
      case 'failed':
        color = AppColors.error;
      case 'refunded':
        color = AppColors.secondary;
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

  void _showTxnDetail(Map<String, dynamic> txn) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: Text('Purchase: ${txn['id'] ?? ''}',
            style: const TextStyle(fontSize: 16)),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: txn.entries.map((e) {
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'airtime':
        return Icons.phone_android;
      case 'data':
        return Icons.wifi;
      case 'electricity':
        return Icons.bolt;
      case 'voucher':
        return Icons.card_giftcard;
      default:
        return Icons.shopping_bag;
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColors.secondary.withValues(alpha: 0.15)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? AppColors.secondary
                  : AppColors.borderDark,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? AppColors.secondary
                  : AppColors.textSecondary,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
