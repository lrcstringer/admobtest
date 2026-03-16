import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Cashout approval screen for admin portal
class CashoutApprovalScreen extends StatefulWidget {
  const CashoutApprovalScreen({super.key});

  @override
  State<CashoutApprovalScreen> createState() => _CashoutApprovalScreenState();
}

class _CashoutApprovalScreenState extends State<CashoutApprovalScreen> {
  final _db = FirebaseFirestore.instance;
  final _functions = FirebaseFunctions.instanceFor(region: 'africa-south1');
  final _numberFormat = NumberFormat('#,###');
  final _zarFormat = NumberFormat.currency(symbol: 'R', decimalDigits: 2);

  String _statusFilter = 'pending';
  List<Map<String, dynamic>> _cashouts = [];
  bool _isLoading = true;
  String? _error;

  // Summary counts
  int _pendingCount = 0;
  int _approvedTodayCount = 0;
  double _approvedTodayZar = 0;
  int _rejectedTodayCount = 0;
  double _rejectedTodayZar = 0;
  int _processingCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCashouts();
    _loadSummary();
  }

  Future<void> _refresh() async {
    await Future.wait([
      _loadCashouts(),
      _loadSummary(),
    ]);
  }

  Future<void> _loadSummary() async {
    try {
      // Pending count
      final pendingQuery = await _db
          .collection('cashouts')
          .where('status', isEqualTo: 'pending')
          .get();
      _pendingCount = pendingQuery.size;

      // Processing count
      final processingQuery = await _db
          .collection('cashouts')
          .where('status', isEqualTo: 'processing')
          .get();
      _processingCount = processingQuery.size;

      // Today's approved/rejected
      final todayStart = DateTime.now();
      final startOfDay = DateTime(todayStart.year, todayStart.month, todayStart.day);
      final startTimestamp = Timestamp.fromDate(startOfDay);

      final completedToday = await _db
          .collection('cashouts')
          .where('status', isEqualTo: 'completed')
          .where('completedAt', isGreaterThanOrEqualTo: startTimestamp)
          .get();

      double approvedZar = 0;
      for (final doc in completedToday.docs) {
        approvedZar += (doc.data()['zarAmount'] as num?)?.toDouble() ?? 0;
      }

      final failedToday = await _db
          .collection('cashouts')
          .where('status', isEqualTo: 'failed')
          .where('failedAt', isGreaterThanOrEqualTo: startTimestamp)
          .get();

      double rejectedZar = 0;
      for (final doc in failedToday.docs) {
        rejectedZar += (doc.data()['zarAmount'] as num?)?.toDouble() ?? 0;
      }

      setState(() {
        _approvedTodayCount = completedToday.size;
        _approvedTodayZar = approvedZar;
        _rejectedTodayCount = failedToday.size;
        _rejectedTodayZar = rejectedZar;
      });
    } catch (_) {}
  }

  Future<void> _loadCashouts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final query = await _db
          .collection('cashouts')
          .where('status', isEqualTo: _statusFilter)
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();

      setState(() {
        _cashouts = query.docs.map((d) {
          final data = d.data();
          data['docId'] = d.id;
          return data;
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _approveCashout(String cashoutId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text('Approve Cashout',
            style: TextStyle(color: AppColors.textPrimaryDark)),
        content: const Text(
          'This will create a pending action that requires approval from a second admin (maker-checker).',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success),
            child: const Text('Submit for Approval'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await _functions.httpsCallable('completeCashoutRequest').call({
        'cashoutId': cashoutId,
        'adminNotes': 'Approved via admin portal',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cashout submitted for maker-checker approval'),
          backgroundColor: AppColors.success,
        ),
      );
      _refresh();
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _rejectCashout(String cashoutId) async {
    final reasonController = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text('Reject Cashout',
            style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This will refund the tokens back to the user\'s wallet.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Rejection reason',
                hintText: 'Enter reason for rejection',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: AppColors.textPrimaryDark),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isNotEmpty) {
                Navigator.pop(ctx, reasonController.text.trim());
              }
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Reject & Refund'),
          ),
        ],
      ),
    );

    if (reason == null || !mounted) return;

    try {
      await _functions.httpsCallable('failCashoutRequest').call({
        'cashoutId': cashoutId,
        'reason': reason,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cashout rejected and tokens refunded'),
          backgroundColor: AppColors.warning,
        ),
      );
      _refresh();
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  String _timeSince(dynamic ts) {
    try {
      DateTime dt;
      if (ts is Timestamp) {
        dt = ts.toDate();
      } else {
        return '--';
      }
      final diff = DateTime.now().difference(dt);
      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      if (diff.inDays < 7) return '${diff.inDays}d ago';
      return DateFormat('dd MMM').format(dt);
    } catch (_) {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                        'Cashout Approvals',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Review and approve withdrawal requests',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Refresh'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Summary cards
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _SummaryCard(
                    title: 'Pending',
                    value: _numberFormat.format(_pendingCount),
                    subtitle: 'Awaiting review',
                    color: AppColors.warning,
                    icon: Icons.pending_actions,
                  ),
                  _SummaryCard(
                    title: 'Approved Today',
                    value: _numberFormat.format(_approvedTodayCount),
                    subtitle: _zarFormat.format(_approvedTodayZar),
                    color: AppColors.success,
                    icon: Icons.check_circle,
                  ),
                  _SummaryCard(
                    title: 'Rejected Today',
                    value: _numberFormat.format(_rejectedTodayCount),
                    subtitle: _zarFormat.format(_rejectedTodayZar),
                    color: AppColors.error,
                    icon: Icons.cancel,
                  ),
                  _SummaryCard(
                    title: 'Processing',
                    value: _numberFormat.format(_processingCount),
                    subtitle: 'With payment provider',
                    color: AppColors.secondary,
                    icon: Icons.sync,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Status filter tabs
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.adminCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildFilterChip('pending', 'Pending'),
                        const SizedBox(width: 8),
                        _buildFilterChip('processing', 'Processing'),
                        const SizedBox(width: 8),
                        _buildFilterChip('completed', 'Completed'),
                        const SizedBox(width: 8),
                        _buildFilterChip('failed', 'Failed/Rejected'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTableHeader(),
                    const Divider(height: 1),
                    _buildCashoutRows(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String status, String label) {
    final isSelected = _statusFilter == status;
    return Material(
      color: isSelected
          ? AppColors.primary.withValues(alpha: 0.15)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          setState(() => _statusFilter = status);
          _loadCashouts();
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          _headerCell('User', flex: 2),
          _headerCell('Amount', flex: 1),
          _headerCell('ZAR', flex: 1),
          _headerCell('Requested', flex: 2),
          _headerCell('Status', flex: 1),
          if (_statusFilter == 'pending') _headerCell('Actions', flex: 2),
        ],
      ),
    );
  }

  Widget _buildCashoutRows() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Failed to load: $_error',
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      );
    }

    if (_cashouts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            children: [
              Icon(Icons.payments_outlined,
                  size: 48, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              Text(
                'No $_statusFilter cashout requests',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: _cashouts.map((cashout) {
        final userId = cashout['userId'] as String? ?? '--';
        final tokenAmount = (cashout['tokenAmount'] as num?)?.toInt() ?? 0;
        final zarAmount = (cashout['zarAmount'] as num?)?.toDouble() ?? 0;
        final cashoutId = cashout['docId'] as String? ?? cashout['id'] as String? ?? '';
        final status = cashout['status'] as String? ?? '';

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      userId.length > 12
                          ? '${userId.substring(0, 12)}...'
                          : userId,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _numberFormat.format(tokenAmount),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _zarFormat.format(zarAmount),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _timeSince(cashout['createdAt']),
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildStatusBadge(status),
                  ),
                  if (_statusFilter == 'pending')
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 32,
                            child: ElevatedButton.icon(
                              onPressed: () => _approveCashout(cashoutId),
                              icon: const Icon(Icons.check, size: 14),
                              label: const Text('Approve',
                                  style: TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.success,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 32,
                            child: OutlinedButton.icon(
                              onPressed: () => _rejectCashout(cashoutId),
                              icon: const Icon(Icons.close,
                                  size: 14, color: AppColors.error),
                              label: const Text('Reject',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.error)),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.error, width: 1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: AppColors.textSecondary.withValues(alpha: 0.15),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;
    switch (status) {
      case 'pending':
        color = AppColors.warning;
        label = 'Pending';
        break;
      case 'processing':
        color = AppColors.secondary;
        label = 'Processing';
        break;
      case 'completed':
        color = AppColors.success;
        label = 'Completed';
        break;
      case 'failed':
        color = AppColors.error;
        label = 'Failed';
        break;
      default:
        color = AppColors.textSecondary;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _headerCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.adminCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
