import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing group buys (Hlangana).
/// Tabs: Active, Completed, Expired/Cancelled.
class GroupBuyManagementScreen extends StatefulWidget {
  const GroupBuyManagementScreen({super.key});

  @override
  State<GroupBuyManagementScreen> createState() =>
      _GroupBuyManagementScreenState();
}

class _GroupBuyManagementScreenState extends State<GroupBuyManagementScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _groupBuys = [];

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
          .collection('groupBuys')
          .orderBy('createdAt', descending: true)
          .limit(200)
          .get();
      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (mounted) {
        setState(() {
          _groupBuys = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading group buys: $e')),
        );
      }
    }
  }

  List<Map<String, dynamic>> _filterByStatuses(List<String> statuses) {
    return _groupBuys.where((g) => statuses.contains(g['status'])).toList();
  }

  int get _activeCount =>
      _groupBuys.where((g) => ['open', 'targetMet'].contains(g['status'])).length;
  int get _completedCount =>
      _groupBuys.where((g) => g['status'] == 'completed').length;
  int get _expiredCancelledCount =>
      _groupBuys.where((g) => ['expired', 'cancelled'].contains(g['status'])).length;

  int get _totalParticipants {
    return _groupBuys
        .where((g) => ['open', 'targetMet'].contains(g['status']))
        .fold<int>(0, (total, g) => total + ((g['participantCount'] as num?) ?? 0).toInt());
  }

  int get _totalEscrowTokens {
    return _groupBuys
        .where((g) => ['open', 'targetMet'].contains(g['status']))
        .fold<int>(0, (total, g) => total + ((g['currentAmount'] as num?) ?? 0).toInt());
  }

  int get _expiringWithin24h {
    final now = DateTime.now();
    final cutoff = now.add(const Duration(hours: 24));
    return _groupBuys.where((g) {
      if (g['status'] != 'open') return false;
      final deadline = g['deadline'];
      if (deadline == null) return false;
      final dt = deadline is Timestamp ? deadline.toDate() : DateTime.tryParse(deadline.toString());
      return dt != null && dt.isAfter(now) && dt.isBefore(cutoff);
    }).length;
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
                          Text('Group Buys (Hlangana)',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Manage group buying deals and escrow',
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
                          icon: Icons.group_work,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'Participants',
                          value: '$_totalParticipants',
                          icon: Icons.people,
                          color: AppColors.primary),
                      _StatCard(
                          title: 'In Escrow',
                          value: '$_totalEscrowTokens tokens',
                          icon: Icons.lock,
                          color: AppColors.tokenGold),
                      _StatCard(
                          title: 'Expiring < 24h',
                          value: '$_expiringWithin24h',
                          icon: Icons.timer,
                          color: _expiringWithin24h > 0
                              ? AppColors.error
                              : AppColors.textSecondary),
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
                      Tab(text: 'Completed ($_completedCount)'),
                      Tab(text: 'Expired/Cancelled ($_expiredCancelledCount)'),
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
                      _buildTable(
                        _filterByStatuses(['open', 'targetMet']),
                        showActions: true,
                      ),
                      _buildTable(
                        _filterByStatuses(['completed']),
                      ),
                      _buildTable(
                        _filterByStatuses(['expired', 'cancelled']),
                        showRetryRefunds: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTable(
    List<Map<String, dynamic>> items, {
    bool showActions = false,
    bool showRetryRefunds = false,
  }) {
    if (items.isEmpty) {
      return const Center(
        child: Text('No group buys',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _headerCell('Title', flex: 3),
              _headerCell('Progress', flex: 2),
              _headerCell('Participants', flex: 1),
              _headerCell('Deadline', flex: 2),
              _headerCell('Status', flex: 1),
              _headerCell('Actions', flex: 2),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: items.length,
            itemBuilder: (_, i) => _buildRow(
              items[i],
              showActions: showActions,
              showRetryRefunds: showRetryRefunds,
            ),
          ),
        ),
      ],
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

  Widget _buildRow(
    Map<String, dynamic> item, {
    bool showActions = false,
    bool showRetryRefunds = false,
  }) {
    final id = item['id'] as String? ?? '';
    final title = item['title'] as String? ?? 'Untitled';
    final current = ((item['currentAmount'] as num?) ?? 0).toInt();
    final target = ((item['targetAmount'] as num?) ?? 0).toInt();
    final percent = target > 0 ? ((current / target) * 100).round() : 0;
    final participants = ((item['participantCount'] as num?) ?? 0).toInt();
    final maxP = ((item['maxParticipants'] as num?) ?? 0).toInt();
    final status = item['status'] as String? ?? 'unknown';

    final deadline = item['deadline'];
    String deadlineStr = '—';
    bool isExpiringSoon = false;
    if (deadline != null) {
      final dt = deadline is Timestamp
          ? deadline.toDate()
          : DateTime.tryParse(deadline.toString());
      if (dt != null) {
        deadlineStr =
            '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
        final now = DateTime.now();
        isExpiringSoon =
            dt.isAfter(now) && dt.isBefore(now.add(const Duration(hours: 24)));
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textTertiary)),
              ],
            ),
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
                const SizedBox(height: 4),
                Text('$current / $target ($percent%)',
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('$participants${maxP > 0 ? ' / $maxP' : ''}',
                style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              deadlineStr,
              style: TextStyle(
                fontSize: 12,
                color: isExpiringSoon ? AppColors.error : AppColors.textSecondary,
                fontWeight: isExpiringSoon ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _StatusChip(status: status),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  tooltip: 'View details',
                  onPressed: () => _showDetailDialog(item),
                ),
                if (showActions && status == 'open')
                  IconButton(
                    icon: const Icon(Icons.schedule, size: 18),
                    tooltip: 'Extend deadline',
                    onPressed: () => _showExtendDialog(id),
                  ),
                if (showActions && status == 'targetMet')
                  IconButton(
                    icon: Icon(Icons.check_circle, size: 18,
                        color: AppColors.success),
                    tooltip: 'Force complete',
                    onPressed: () => _confirmForceComplete(id, title),
                  ),
                if (showActions)
                  IconButton(
                    icon: Icon(Icons.cancel, size: 18,
                        color: AppColors.error),
                    tooltip: 'Force cancel',
                    onPressed: () => _confirmForceCancel(id, title),
                  ),
                if (showRetryRefunds && status == 'expired')
                  IconButton(
                    icon: const Icon(Icons.replay, size: 18),
                    tooltip: 'Retry refunds',
                    onPressed: () => _retryRefunds(id),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        title: Text(item['title'] as String? ?? 'Group Buy Details'),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailRow('ID', item['id'] ?? ''),
                _detailRow('Status', item['status'] ?? ''),
                _detailRow('Description', item['description'] ?? '—'),
                _detailRow('Organizer', item['organizerName'] ?? item['organizerId'] ?? '—'),
                _detailRow('Community', item['communityId'] ?? '—'),
                _detailRow('Progress',
                    '${item['currentAmount'] ?? 0} / ${item['targetAmount'] ?? 0} tokens'),
                _detailRow('Participants',
                    '${item['participantCount'] ?? 0}${(item['maxParticipants'] != null && (item['maxParticipants'] as num) > 0) ? ' / ${item['maxParticipants']}' : ''}'),
                _detailRow('Min Participants', '${item['minParticipants'] ?? '—'}'),
                _detailRow('Linked Listing', item['linkedListingId'] ?? '—'),
                _detailRow('Sponsor Type', item['sponsorType'] ?? 'community'),
                if (item['brandId'] != null)
                  _detailRow('Brand', item['brandId']),
                _detailRow('Created', _formatTimestamp(item['createdAt'])),
                _detailRow('Deadline', _formatTimestamp(item['deadline'])),
                const SizedBox(height: 16),
                const Text('Contributions',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('groupBuys')
                      .doc(item['id'])
                      .collection('contributions')
                      .orderBy('contributedAt', descending: true)
                      .get(),
                  builder: (ctx, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snap.hasData || snap.data!.docs.isEmpty) {
                      return const Text('No contributions yet',
                          style: TextStyle(color: AppColors.textSecondary));
                    }
                    return Column(
                      children: snap.data!.docs.map((doc) {
                        final d = doc.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(d['userName'] ?? d['userId'] ?? '—',
                                    style: const TextStyle(fontSize: 13)),
                              ),
                              Text('${d['amount'] ?? 0} tokens',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.tokenGold)),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
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

  Future<void> _showExtendDialog(String groupBuyId) async {
    DateTime? newDeadline;
    String? reason;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.surfaceElevated,
          title: const Text('Extend Deadline'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  newDeadline != null
                      ? '${newDeadline!.day}/${newDeadline!.month}/${newDeadline!.year} ${newDeadline!.hour.toString().padLeft(2, '0')}:${newDeadline!.minute.toString().padLeft(2, '0')}'
                      : 'Pick new deadline',
                  style: TextStyle(
                    color: newDeadline != null
                        ? null
                        : AppColors.textSecondary,
                  ),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now().add(const Duration(days: 7)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                  );
                  if (date != null && ctx.mounted) {
                    final time = await showTimePicker(
                      context: ctx,
                      initialTime: const TimeOfDay(hour: 18, minute: 0),
                    );
                    if (time != null) {
                      setDialogState(() {
                        newDeadline = DateTime(
                            date.year, date.month, date.day,
                            time.hour, time.minute);
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => reason = v,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: newDeadline != null
                  ? () {
                      Navigator.pop(ctx);
                      _extendDeadline(groupBuyId, newDeadline!, reason ?? '');
                    }
                  : null,
              child: const Text('Extend'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _extendDeadline(
      String groupBuyId, DateTime newDeadline, String reason) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminExtendGroupBuyDeadline')
          .call({
        'groupBuyId': groupBuyId,
        'newDeadline': newDeadline.toIso8601String(),
        'reason': reason,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deadline extended')),
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

  void _confirmForceComplete(String groupBuyId, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        title: const Text('Force Complete Group Buy'),
        content: Text(
          'This will release all escrowed tokens to the organizer of "$title". '
          'This action requires maker-checker approval.\n\nProceed?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success),
            onPressed: () {
              Navigator.pop(ctx);
              _forceComplete(groupBuyId);
            },
            child: const Text('Force Complete'),
          ),
        ],
      ),
    );
  }

  Future<void> _forceComplete(String groupBuyId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminForceCompleteGroupBuy')
          .call({'groupBuyId': groupBuyId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Force complete submitted (pending approval)')),
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

  void _confirmForceCancel(String groupBuyId, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        title: const Text('Force Cancel Group Buy'),
        content: Text(
          'This will cancel "$title" and refund all participants. '
          'This action requires maker-checker approval.\n\nProceed?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error),
            onPressed: () {
              Navigator.pop(ctx);
              _forceCancel(groupBuyId);
            },
            child: const Text('Force Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _forceCancel(String groupBuyId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminForceCancelGroupBuy')
          .call({'groupBuyId': groupBuyId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Force cancel submitted (pending approval)')),
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

  Future<void> _retryRefunds(String groupBuyId) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminRetryGroupBuyRefunds')
          .call({'groupBuyId': groupBuyId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Refund retry initiated')),
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
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (Color color, String label) = switch (status) {
      'open' => (AppColors.secondary, 'Open'),
      'targetMet' => (AppColors.success, 'Target Met'),
      'completed' => (AppColors.success, 'Completed'),
      'expired' => (AppColors.textTertiary, 'Expired'),
      'cancelled' => (AppColors.error, 'Cancelled'),
      _ => (AppColors.textSecondary, status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
      ),
    );
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
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
