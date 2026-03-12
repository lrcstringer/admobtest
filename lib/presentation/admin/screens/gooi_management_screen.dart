import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class GooiManagementScreen extends StatefulWidget {
  const GooiManagementScreen({super.key});

  @override
  State<GooiManagementScreen> createState() => _GooiManagementScreenState();
}

class _GooiManagementScreenState extends State<GooiManagementScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _groups = [];
  Map<String, int> _stats = {};

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
          .collection('gooiGroups')
          .orderBy('createdAt', descending: true)
          .limit(200)
          .get();

      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      final forming = items.where((g) => g['status'] == 'FORMING').length;
      final active = items.where((g) => g['status'] == 'ACTIVE').length;
      final completed = items.where((g) => g['status'] == 'COMPLETED').length;
      final dissolved = items.where((g) => g['status'] == 'DISSOLVED').length;

      setState(() {
        _groups = items;
        _stats = {
          'forming': forming,
          'active': active,
          'completed': completed,
          'dissolved': dissolved,
          'total': items.length,
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gooi-Gooi Management'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Active (${_stats['active'] ?? 0})'),
            Tab(text: 'Forming (${_stats['forming'] ?? 0})'),
            Tab(text: 'Completed (${_stats['completed'] ?? 0})'),
            Tab(text: 'Dissolved (${_stats['dissolved'] ?? 0})'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildStatsBar(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildGroupList('ACTIVE'),
                      _buildGroupList('FORMING'),
                      _buildGroupList('COMPLETED'),
                      _buildGroupList('DISSOLVED'),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatChip(label: 'Total', value: '${_stats['total'] ?? 0}', color: Colors.blue),
          _StatChip(label: 'Active', value: '${_stats['active'] ?? 0}', color: AppColors.teal),
          _StatChip(label: 'Forming', value: '${_stats['forming'] ?? 0}', color: AppColors.gold),
          _StatChip(label: 'Completed', value: '${_stats['completed'] ?? 0}', color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildGroupList(String status) {
    final filtered = _groups.where((g) => g['status'] == status).toList();
    if (filtered.isEmpty) {
      return const Center(child: Text('No groups'));
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final group = filtered[index];
          final name = group['name'] as String? ?? 'Unnamed';
          final memberCount = group['memberCount'] as int? ?? 0;
          final totalCycles = group['totalCycles'] as int? ?? 0;
          final currentCycleNumber = group['currentCycleNumber'] as int? ?? 0;
          final contributionAmount = (group['contributionAmount'] as int? ?? 0) / 100;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.teal.withValues(alpha: 0.15),
              child: const Icon(Icons.groups, color: AppColors.teal),
            ),
            title: Text(name),
            subtitle: Text(
              'R${contributionAmount.toStringAsFixed(0)} · $memberCount members · Cycle $currentCycleNumber/$totalCycles',
            ),
            trailing: Text(
              status,
              style: TextStyle(
                color: _statusColor(status),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            onTap: () => _showGroupDetail(context, group),
          );
        },
      ),
    );
  }

  Color _statusColor(String status) {
    return switch (status) {
      'FORMING' => AppColors.gold,
      'ACTIVE' => AppColors.teal,
      'COMPLETED' => Colors.green,
      'DISSOLVED' => Colors.grey,
      _ => Colors.grey,
    };
  }

  void _showGroupDetail(BuildContext context, Map<String, dynamic> group) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, controller) => _GroupDetailSheet(
          group: group,
          scrollController: controller,
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _GroupDetailSheet extends StatelessWidget {
  final Map<String, dynamic> group;
  final ScrollController scrollController;

  const _GroupDetailSheet({required this.group, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final name = group['name'] as String? ?? 'Unnamed';
    final status = group['status'] as String? ?? 'UNKNOWN';
    final memberCount = group['memberCount'] as int? ?? 0;
    final totalCycles = group['totalCycles'] as int? ?? 0;
    final currentCycleNumber = group['currentCycleNumber'] as int? ?? 0;
    final contributionAmount = (group['contributionAmount'] as int? ?? 0) / 100;
    final reserveRate = (group['reserveRate'] as num? ?? 0.03) * 100;
    final gracePeriodHours = group['gracePeriodHours'] as int? ?? 48;
    final lateFeePercent = group['lateFeePercent'] as int? ?? 5;
    final rosterMethod = group['rosterMethod'] as String? ?? 'AGREED';
    final initiatorUserId = group['initiatorUserId'] as String? ?? '';

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            Chip(label: Text(status)),
            Chip(label: Text(rosterMethod)),
          ],
        ),
        const Divider(height: 24),
        _DetailRow(label: 'Contribution', value: 'R${contributionAmount.toStringAsFixed(0)}'),
        _DetailRow(label: 'Members', value: '$memberCount'),
        _DetailRow(label: 'Cycle Progress', value: '$currentCycleNumber / $totalCycles'),
        _DetailRow(label: 'Reserve Rate', value: '${reserveRate.toStringAsFixed(0)}%'),
        _DetailRow(label: 'Grace Period', value: '${gracePeriodHours}h'),
        _DetailRow(label: 'Late Fee', value: '$lateFeePercent%'),
        _DetailRow(label: 'Initiator', value: initiatorUserId),
        _DetailRow(label: 'Group ID', value: group['id'] as String? ?? ''),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
