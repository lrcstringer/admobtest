import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing marketplace providers (sellers).
/// Tabs: Pending, Active, Suspended/Rejected.
class MarketplaceProviderManagementScreen extends StatefulWidget {
  const MarketplaceProviderManagementScreen({super.key});

  @override
  State<MarketplaceProviderManagementScreen> createState() =>
      _MarketplaceProviderManagementScreenState();
}

class _MarketplaceProviderManagementScreenState
    extends State<MarketplaceProviderManagementScreen>
    with SingleTickerProviderStateMixin {
  static const _pageSize = 50;

  late final TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _providers = [];
  DocumentSnapshot? _lastDoc;
  bool _hasMore = true;

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
      final snapshot = await FirebaseFirestore.instance
          .collection('providers')
          .orderBy('createdAt', descending: true)
          .limit(_pageSize)
          .get();
      final providers = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (mounted) {
        setState(() {
          _providers = providers;
          _lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
          _hasMore = snapshot.docs.length >= _pageSize;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading providers: $e')),
        );
      }
    }
  }

  Future<void> _loadMore() async {
    if (!_hasMore || _isLoading || _lastDoc == null) return;
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('providers')
          .orderBy('createdAt', descending: true)
          .startAfterDocument(_lastDoc!)
          .limit(_pageSize)
          .get();
      final moreProviders = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (mounted) {
        setState(() {
          _providers.addAll(moreProviders);
          _lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
          _hasMore = snapshot.docs.length >= _pageSize;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading more providers: $e')),
        );
      }
    }
  }

  List<Map<String, dynamic>> _filterByStatus(List<String> statuses) {
    return _providers
        .where((p) => statuses.contains(p['status']))
        .toList();
  }

  int get _pendingCount =>
      _providers.where((p) => p['status'] == 'pending').length;
  int get _activeCount =>
      _providers.where((p) => p['status'] == 'approved').length;
  int get _suspendedCount =>
      _providers.where((p) => p['status'] == 'suspended' || p['status'] == 'rejected').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
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
                          Text('Marketplace Providers',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark)),
                          SizedBox(height: 4),
                          Text('Manage seller registrations and accounts',
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
                          title: 'Pending',
                          value: '$_pendingCount',
                          icon: Icons.hourglass_top,
                          color: AppColors.warning),
                      _StatCard(
                          title: 'Active',
                          value: '$_activeCount',
                          icon: Icons.storefront,
                          color: AppColors.success),
                      _StatCard(
                          title: 'Suspended',
                          value: '$_suspendedCount',
                          icon: Icons.block,
                          color: AppColors.error),
                      _StatCard(
                          title: 'Total',
                          value: '${_providers.length}',
                          icon: Icons.people,
                          color: AppColors.secondary),
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
                      Tab(text: 'Pending ($_pendingCount)'),
                      Tab(text: 'Active ($_activeCount)'),
                      Tab(text: 'Suspended ($_suspendedCount)'),
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
                      _buildProviderList(_filterByStatus(['pending']),
                          showApproveReject: true),
                      _buildProviderList(_filterByStatus(['approved']),
                          showSuspend: true),
                      _buildProviderList(
                          _filterByStatus(['suspended', 'rejected']),
                          showUnsuspend: true),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProviderList(
    List<Map<String, dynamic>> providers, {
    bool showApproveReject = false,
    bool showSuspend = false,
    bool showUnsuspend = false,
  }) {
    if (providers.isEmpty) {
      return Center(
        child: Text('No providers',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return Column(
      children: [
        // Table header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _headerCell('Name', flex: 2),
              _headerCell('Community', flex: 2),
              _headerCell('Trust', flex: 1),
              _headerCell('Orders', flex: 1),
              _headerCell('Vouches', flex: 1),
              _headerCell('Status', flex: 1),
              _headerCell('Actions', flex: 2),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: providers.length + (_hasMore ? 1 : 0),
            itemBuilder: (_, i) {
              if (i >= providers.length) {
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
              return _buildProviderRow(
                providers[i],
                showApproveReject: showApproveReject,
                showSuspend: showSuspend,
                showUnsuspend: showUnsuspend,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProviderRow(
    Map<String, dynamic> provider, {
    bool showApproveReject = false,
    bool showSuspend = false,
    bool showUnsuspend = false,
  }) {
    final status = provider['status'] ?? 'unknown';
    final trustScore = (provider['trustScore'] ?? 0).toDouble();
    final completedOrders = provider['completedOrders'] ?? 0;
    final vouchCount = provider['vouchCount'] ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(provider['displayName'] ?? '—',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                if (provider['bio'] != null)
                  Text(provider['bio'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(provider['communityId'] ?? '—',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Icon(Icons.star, size: 14, color: AppColors.tokenGold),
                const SizedBox(width: 4),
                Text(trustScore.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('$completedOrders',
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 1,
            child: Text('$vouchCount',
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(flex: 1, child: _buildStatusBadge(status)),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  color: AppColors.textSecondary,
                  onPressed: () => _showProviderDetail(provider),
                  tooltip: 'View details',
                ),
                if (showApproveReject) ...[
                  IconButton(
                    icon: const Icon(Icons.check_circle, size: 18),
                    color: AppColors.success,
                    onPressed: () => _approveProvider(provider['id']),
                    tooltip: 'Approve',
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, size: 18),
                    color: AppColors.error,
                    onPressed: () => _rejectProvider(provider['id']),
                    tooltip: 'Reject',
                  ),
                ],
                if (showSuspend)
                  IconButton(
                    icon: const Icon(Icons.block, size: 18),
                    color: AppColors.error,
                    onPressed: () => _suspendProvider(provider['id']),
                    tooltip: 'Suspend',
                  ),
                if (showUnsuspend && status == 'suspended')
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    color: AppColors.success,
                    onPressed: () => _unsuspendProvider(provider['id']),
                    tooltip: 'Unsuspend',
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
      case 'approved':
        color = AppColors.success;
      case 'pending':
        color = AppColors.warning;
      case 'suspended':
        color = AppColors.error;
      case 'rejected':
        color = AppColors.error;
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

  void _showProviderDetail(Map<String, dynamic> provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: Text(provider['displayName'] ?? 'Provider',
            style: const TextStyle(fontSize: 16)),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: provider.entries.map((e) {
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

  Future<void> _approveProvider(String providerId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminApproveProvider')
          .call({'providerId': providerId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Provider approved')),
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

  Future<void> _rejectProvider(String providerId) async {
    final reason = await _showReasonDialog('Reject Provider');
    if (reason == null) return;
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminRejectProvider')
          .call({'providerId': providerId, 'reason': reason});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Provider rejected')),
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

  Future<void> _suspendProvider(String providerId) async {
    final reason = await _showReasonDialog('Suspend Provider');
    if (reason == null) return;
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminSuspendProvider')
          .call({'providerId': providerId, 'reason': reason});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Provider suspended')),
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

  Future<void> _unsuspendProvider(String providerId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUnsuspendProvider')
          .call({'providerId': providerId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Provider unsuspended')),
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

  Future<String?> _showReasonDialog(String title) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: Text(title, style: const TextStyle(fontSize: 16)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Provide a reason...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              Navigator.of(ctx).pop(controller.text.trim());
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
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
