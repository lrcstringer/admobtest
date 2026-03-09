import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for consolidated escrow overview across marketplace + group buys.
/// Shows KPI cards, breakdowns, and reconciliation checks.
class EscrowOverviewScreen extends StatefulWidget {
  const EscrowOverviewScreen({super.key});

  @override
  State<EscrowOverviewScreen> createState() => _EscrowOverviewScreenState();
}

class _EscrowOverviewScreenState extends State<EscrowOverviewScreen> {
  bool _isLoading = false;
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _marketplaceEscrows = [];
  List<Map<String, dynamic>> _groupBuyEscrows = [];

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
              .httpsCallable('adminGetEscrowOverview')
              .call();
      final data = Map<String, dynamic>.from(result.data as Map? ?? {});

      if (mounted) {
        setState(() {
          _stats = data;
          _marketplaceEscrows = List<Map<String, dynamic>>.from(
              data['marketplaceEscrows'] ?? []);
          _groupBuyEscrows = List<Map<String, dynamic>>.from(
              data['groupBuyEscrows'] ?? []);
          _isLoading = false;
        });
      }
    } catch (_) {
      // Fallback: compute from Firestore
      await _loadFromFirestore();
    }
  }

  Future<void> _loadFromFirestore() async {
    try {
      final [ordersSnap, groupBuysSnap] = await Future.wait([
        FirebaseFirestore.instance
            .collection('buyOrders')
            .where('status', whereIn: ['escrowed', 'fulfilled', 'disputed'])
            .get(),
        FirebaseFirestore.instance
            .collection('groupBuys')
            .where('status', whereIn: ['open', 'targetMet'])
            .get(),
      ]);

      final marketplaceItems = ordersSnap.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      final groupBuyItems = groupBuysSnap.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      final marketplaceTotal = marketplaceItems.fold<int>(
          0, (t, o) => t + ((o['amount'] as num?) ?? 0).toInt());
      final groupBuyTotal = groupBuyItems.fold<int>(
          0, (t, g) => t + ((g['currentAmount'] as num?) ?? 0).toInt());

      // Stale check: marketplace orders older than 14 days
      final fourteenDaysAgo =
          DateTime.now().subtract(const Duration(days: 14));
      final staleCount = marketplaceItems.where((o) {
        final created = o['createdAt'];
        if (created == null) return false;
        final dt = created is Timestamp
            ? created.toDate()
            : DateTime.tryParse(created.toString());
        return dt != null && dt.isBefore(fourteenDaysAgo);
      }).length;

      if (mounted) {
        setState(() {
          _stats = {
            'totalEscrow': marketplaceTotal + groupBuyTotal,
            'marketplaceEscrow': marketplaceTotal,
            'groupBuyEscrow': groupBuyTotal,
            'marketplaceCount': marketplaceItems.length,
            'groupBuyCount': groupBuyItems.length,
            'staleEscrowCount': staleCount,
          };
          _marketplaceEscrows = marketplaceItems;
          _groupBuyEscrows = groupBuyItems;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading escrow data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                          Text('Escrow Overview',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Consolidated view of all escrowed tokens',
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
                          title: 'Total Escrow',
                          value: '${_stats['totalEscrow'] ?? 0} tokens',
                          icon: Icons.account_balance,
                          color: AppColors.tokenGold),
                      _StatCard(
                          title: 'Marketplace',
                          value: '${_stats['marketplaceEscrow'] ?? 0} tokens',
                          subtitle: '${_stats['marketplaceCount'] ?? 0} orders',
                          icon: Icons.storefront,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'Group Buys',
                          value: '${_stats['groupBuyEscrow'] ?? 0} tokens',
                          subtitle: '${_stats['groupBuyCount'] ?? 0} deals',
                          icon: Icons.group_work,
                          color: AppColors.primary),
                      _StatCard(
                          title: 'Stale (>14 days)',
                          value: '${_stats['staleEscrowCount'] ?? 0}',
                          icon: Icons.warning_amber,
                          color: (_stats['staleEscrowCount'] ?? 0) > 0
                              ? AppColors.error
                              : AppColors.textSecondary),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Reconciliation
                  _buildReconciliationCard(),
                  const SizedBox(height: 32),

                  // Marketplace breakdown
                  const Text('Marketplace Escrow',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _buildMarketplaceTable(),
                  const SizedBox(height: 32),

                  // Group buy breakdown
                  const Text('Group Buy Escrow',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _buildGroupBuyTable(),
                ],
              ),
            ),
    );
  }

  Widget _buildReconciliationCard() {
    final reconStatus = _stats['reconciliationStatus'] as String?;
    final isOk = reconStatus == 'balanced' || reconStatus == null;
    final marketplaceLedger =
        (_stats['marketplaceLedgerBalance'] as num?)?.toInt();
    final groupBuyLedger = (_stats['groupBuyLedgerBalance'] as num?)?.toInt();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isOk
            ? AppColors.success.withAlpha(15)
            : AppColors.error.withAlpha(15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOk ? AppColors.success.withAlpha(60) : AppColors.error.withAlpha(60),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isOk ? Icons.check_circle : Icons.error,
                color: isOk ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 8),
              Text(
                'Reconciliation ${isOk ? "OK" : "DISCREPANCY"}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isOk ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (marketplaceLedger != null)
            Text(
              'MARKETPLACE_ESCROW ledger: $marketplaceLedger tokens  |  '
              'Active orders sum: ${_stats['marketplaceEscrow'] ?? 0} tokens',
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          if (groupBuyLedger != null) ...[
            const SizedBox(height: 4),
            Text(
              'GROUP_BUY_ESCROW ledger: $groupBuyLedger tokens  |  '
              'Active deals sum: ${_stats['groupBuyEscrow'] ?? 0} tokens',
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
          if (marketplaceLedger == null && groupBuyLedger == null)
            const Text(
              'Reconciliation data available via adminGetEscrowOverview CF. '
              'Showing Firestore counts only.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
        ],
      ),
    );
  }

  Widget _buildMarketplaceTable() {
    if (_marketplaceEscrows.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text('No marketplace escrows',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            _headerCell('Listing', flex: 3),
            _headerCell('Buyer', flex: 2),
            _headerCell('Seller', flex: 2),
            _headerCell('Amount', flex: 1),
            _headerCell('Status', flex: 1),
            _headerCell('Created', flex: 2),
          ],
        ),
        const SizedBox(height: 8),
        ..._marketplaceEscrows.take(50).map(_buildMarketplaceRow),
      ],
    );
  }

  Widget _buildMarketplaceRow(Map<String, dynamic> order) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(order['listingTitle'] as String? ?? '—',
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text(order['buyerName'] ?? order['buyerId'] ?? '—',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text(order['sellerName'] ?? order['sellerId'] ?? '—',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 1,
            child: Text('${order['amount'] ?? 0}',
                style: const TextStyle(
                    color: AppColors.tokenGold, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            flex: 1,
            child: _buildStatusChip(order['status'] ?? ''),
          ),
          Expanded(
            flex: 2,
            child: Text(_formatTimestamp(order['createdAt']),
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupBuyTable() {
    if (_groupBuyEscrows.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text('No group buy escrows',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            _headerCell('Title', flex: 3),
            _headerCell('Progress', flex: 2),
            _headerCell('Escrowed', flex: 1),
            _headerCell('Participants', flex: 1),
            _headerCell('Status', flex: 1),
            _headerCell('Deadline', flex: 2),
          ],
        ),
        const SizedBox(height: 8),
        ..._groupBuyEscrows.take(50).map(_buildGroupBuyRow),
      ],
    );
  }

  Widget _buildGroupBuyRow(Map<String, dynamic> gb) {
    final current = ((gb['currentAmount'] as num?) ?? 0).toInt();
    final target = ((gb['targetAmount'] as num?) ?? 0).toInt();
    final percent = target > 0 ? ((current / target) * 100).round() : 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(gb['title'] as String? ?? '—',
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: (percent / 100).clamp(0.0, 1.0),
                      backgroundColor: AppColors.border,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.success),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text('$current / $target ($percent%)',
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('$current',
                style: const TextStyle(
                    color: AppColors.tokenGold, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            flex: 1,
            child: Text('${gb['participantCount'] ?? 0}',
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 1,
            child: _buildStatusChip(gb['status'] ?? ''),
          ),
          Expanded(
            flex: 2,
            child: Text(_formatTimestamp(gb['deadline']),
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(text,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary)),
    );
  }

  Widget _buildStatusChip(String status) {
    final (Color color, String label) = switch (status) {
      'escrowed' => (AppColors.tokenGold, 'Escrowed'),
      'fulfilled' => (AppColors.secondary, 'Fulfilled'),
      'disputed' => (AppColors.error, 'Disputed'),
      'open' => (AppColors.secondary, 'Open'),
      'targetMet' => (AppColors.success, 'Target Met'),
      _ => (AppColors.textSecondary, status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
    );
  }

  String _formatTimestamp(dynamic value) {
    if (value == null) return '—';
    final dt = value is Timestamp
        ? value.toDate()
        : DateTime.tryParse(value.toString());
    if (dt == null) return '—';
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textTertiary)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
