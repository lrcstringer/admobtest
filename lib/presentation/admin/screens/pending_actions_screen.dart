import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Pending Actions screen -- maker-checker approval queue.
///
/// Shows financial actions that require a second admin's approval before
/// they are executed. Admins can approve or reject each pending action.
class PendingActionsScreen extends StatefulWidget {
  const PendingActionsScreen({super.key});

  @override
  State<PendingActionsScreen> createState() => _PendingActionsScreenState();
}

class _PendingActionsScreenState extends State<PendingActionsScreen> {
  List<Map<String, dynamic>> _actions = [];
  bool _isLoading = true;
  bool _isProcessing = false;
  String? _errorMessage;
  String _selectedFilter = 'all';

  final _dateFormat = DateFormat('dd MMM yyyy HH:mm');

  @override
  void initState() {
    super.initState();
    _loadActions();
  }

  Future<void> _loadActions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminListPendingActions')
          .call({'status': 'all'});

      final data = result.data as Map<String, dynamic>;
      final actions = (data['actions'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      if (!mounted) return;
      setState(() {
        _actions = actions;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load pending actions: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  List<Map<String, dynamic>> get _filteredActions {
    if (_selectedFilter == 'all') return _actions;
    return _actions
        .where((a) => a['status'] == _selectedFilter)
        .toList();
  }

  int _countByStatus(String status) {
    return _actions.where((a) => a['status'] == status).length;
  }

  int get _rejectedOrExpiredCount {
    return _actions
        .where((a) => a['status'] == 'rejected' || a['status'] == 'expired')
        .length;
  }

  DateTime? _parseTimestamp(dynamic ts) {
    if (ts == null) return null;
    if (ts is String && ts.isNotEmpty) {
      return DateTime.tryParse(ts)?.toLocal();
    }
    if (ts is Map) {
      final seconds = ts['_seconds'];
      if (seconds is int) {
        return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
      }
    }
    return null;
  }

  String _formatTimestamp(dynamic ts) {
    final dt = _parseTimestamp(ts);
    if (dt == null) return '--';
    return _dateFormat.format(dt);
  }

  bool _isExpired(Map<String, dynamic> action) {
    final expiresAt = _parseTimestamp(action['expiresAt']);
    if (expiresAt == null) return false;
    return expiresAt.isBefore(DateTime.now());
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'pending':
        return AppColors.warning;
      case 'approved':
        return AppColors.success;
      case 'rejected':
        return AppColors.error;
      case 'expired':
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  Future<void> _approveAction(Map<String, dynamic> action) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          'Confirm Approval',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to approve this action?',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      action['description'] ?? 'No description',
                      style: const TextStyle(
                        color: AppColors.textPrimaryDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (_extractAmount(action) != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Amount: ${_extractAmount(action)}',
                        style: const TextStyle(
                          color: AppColors.warning,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      'Requested by: ${action['makerEmail'] ?? 'Unknown'}',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
            ),
            child: const Text('Approve'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isProcessing = true);

    try {
      await FirebaseFunctions.instance
          .httpsCallable('adminApproveAction')
          .call({'pendingActionId': action['id']});

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Action approved successfully'),
          backgroundColor: AppColors.success,
        ),
      );
      await _loadActions();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to approve action: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _rejectAction(Map<String, dynamic> action) async {
    final reasonController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          'Reject Action',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: SizedBox(
          width: 450,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action['description'] ?? 'No description',
                  style: const TextStyle(
                    color: AppColors.textPrimaryDark,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: reasonController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Rejection Reason',
                    hintText: 'Enter the reason for rejecting this action...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'A rejection reason is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(ctx).pop(true);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isProcessing = true);

    try {
      await FirebaseFunctions.instance
          .httpsCallable('adminRejectAction')
          .call({
        'pendingActionId': action['id'],
        'reason': reasonController.text.trim(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Action rejected'),
          backgroundColor: AppColors.warning,
        ),
      );
      await _loadActions();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reject action: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }

    reasonController.dispose();
  }

  void _showPayloadDetails(Map<String, dynamic> action) {
    final payload = action['payload'] as Map<String, dynamic>? ?? {};

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          'Action Details',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Action metadata
                _detailSection('Action Info', [
                  _detailRow('ID', action['id'] ?? '--'),
                  _detailRow('Type', action['actionType'] ?? '--'),
                  _detailRow('Function', action['functionName'] ?? '--'),
                  _detailRow(
                    'Description',
                    action['description'] ?? '--',
                  ),
                  _detailRow('Status', action['status'] ?? '--'),
                ]),
                const SizedBox(height: 16),

                // Maker info
                _detailSection('Maker', [
                  _detailRow('Email', action['makerEmail'] ?? '--'),
                  _detailRow('Role', action['makerRole'] ?? '--'),
                  _detailRow('UID', action['makerUid'] ?? '--'),
                ]),
                const SizedBox(height: 16),

                // Checker info (if completed)
                if (action['checkerEmail'] != null) ...[
                  _detailSection('Checker', [
                    _detailRow('Email', action['checkerEmail'] ?? '--'),
                    _detailRow('Role', action['checkerRole'] ?? '--'),
                    _detailRow('UID', action['checkerUid'] ?? '--'),
                  ]),
                  const SizedBox(height: 16),
                ],

                // Rejection reason
                if (action['rejectionReason'] != null) ...[
                  _detailSection('Rejection', [
                    _detailRow('Reason', action['rejectionReason']),
                  ]),
                  const SizedBox(height: 16),
                ],

                // Timestamps
                _detailSection('Timestamps', [
                  _detailRow('Created', _formatTimestamp(action['createdAt'])),
                  _detailRow('Expires', _formatTimestamp(action['expiresAt'])),
                  if (action['completedAt'] != null)
                    _detailRow(
                      'Completed',
                      _formatTimestamp(action['completedAt']),
                    ),
                ]),
                const SizedBox(height: 16),

                // Payload
                _detailSection('Payload', _buildPayloadRows(payload)),
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

  List<Widget> _buildPayloadRows(Map<String, dynamic> payload) {
    final highlightKeys = {
      'tokenAmount',
      'clientId',
      'userId',
      'cashoutId',
    };
    final rows = <Widget>[];

    // Show highlighted keys first
    for (final key in highlightKeys) {
      if (payload.containsKey(key)) {
        String value = payload[key].toString();
        if (key == 'tokenAmount') {
          value = '$value tokens';
        }
        rows.add(_detailRow(
          key,
          value,
          highlight: true,
        ));
      }
    }

    // Show remaining keys
    for (final entry in payload.entries) {
      if (!highlightKeys.contains(entry.key)) {
        rows.add(_detailRow(
          entry.key,
          entry.value?.toString() ?? 'null',
        ));
      }
    }

    if (rows.isEmpty) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            'No payload data',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ),
      );
    }

    return rows;
  }

  Widget _detailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: highlight
                    ? AppColors.warning
                    : AppColors.textPrimaryDark,
                fontWeight: highlight ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _extractAmount(Map<String, dynamic> action) {
    final payload = action['payload'] as Map<String, dynamic>?;
    if (payload == null) return null;

    if (payload.containsKey('tokenAmount')) {
      return '${payload['tokenAmount']} tokens';
    }
    if (payload.containsKey('amount')) {
      return payload['amount'].toString();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredActions;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                          'Pending Actions',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Maker-checker approval queue for financial actions',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _isLoading ? null : _loadActions,
                      icon: const Icon(Icons.refresh),
                      color: AppColors.textPrimaryDark,
                      tooltip: 'Refresh',
                      iconSize: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Stats cards
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _StatCard(
                      title: 'Total Actions',
                      value:
                          _isLoading ? '--' : _actions.length.toString(),
                      icon: Icons.pending_actions,
                      color: AppColors.primary,
                    ),
                    _StatCard(
                      title: 'Pending',
                      value: _isLoading
                          ? '--'
                          : _countByStatus('pending').toString(),
                      icon: Icons.hourglass_empty,
                      color: AppColors.warning,
                    ),
                    _StatCard(
                      title: 'Approved',
                      value: _isLoading
                          ? '--'
                          : _countByStatus('approved').toString(),
                      icon: Icons.check_circle,
                      color: AppColors.success,
                    ),
                    _StatCard(
                      title: 'Rejected / Expired',
                      value: _isLoading
                          ? '--'
                          : _rejectedOrExpiredCount.toString(),
                      icon: Icons.cancel,
                      color: AppColors.error,
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Filter chips
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        isSelected: _selectedFilter == 'all',
                        onTap: () =>
                            setState(() => _selectedFilter = 'all'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Pending',
                        isSelected: _selectedFilter == 'pending',
                        onTap: () =>
                            setState(() => _selectedFilter = 'pending'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Approved',
                        isSelected: _selectedFilter == 'approved',
                        onTap: () =>
                            setState(() => _selectedFilter = 'approved'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Rejected',
                        isSelected: _selectedFilter == 'rejected',
                        onTap: () =>
                            setState(() => _selectedFilter = 'rejected'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Expired',
                        isSelected: _selectedFilter == 'expired',
                        onTap: () =>
                            setState(() => _selectedFilter = 'expired'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Actions table
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.cardDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildTableHeader(),
                      const Divider(height: 1),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.all(48),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (_errorMessage != null)
                        _buildErrorPlaceholder()
                      else if (filtered.isEmpty)
                        _buildEmptyPlaceholder()
                      else
                        ...filtered.map(_buildActionRow),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Processing overlay
          if (_isProcessing)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: const Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Processing...'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          _headerCell('Created', flex: 1),
          _headerCell('Maker', flex: 1),
          _headerCell('Action', flex: 2),
          _headerCell('Status', flex: 1),
          _headerCell('Expires', flex: 1),
          _headerCell('Actions', flex: 1),
        ],
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

  Widget _buildActionRow(Map<String, dynamic> action) {
    final status = action['status'] as String? ?? 'unknown';
    final isPending = status == 'pending';
    final expired = isPending && _isExpired(action);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.dividerDark,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Created
          Expanded(
            flex: 1,
            child: Text(
              _formatTimestamp(action['createdAt']),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),

          // Maker
          Expanded(
            flex: 1,
            child: Text(
              action['makerEmail'] ?? '--',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimaryDark,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Action (description + info icon)
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    action['description'] ?? '--',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimaryDark,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => _showPayloadDetails(action),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Status badge
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(status).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status[0].toUpperCase() + status.substring(1),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _statusColor(status),
                  ),
                ),
              ),
            ),
          ),

          // Expires
          Expanded(
            flex: 1,
            child: expired
                ? Text(
                    'Expired',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.error,
                    ),
                  )
                : Text(
                    _formatTimestamp(action['expiresAt']),
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
          ),

          // Actions
          Expanded(
            flex: 1,
            child: isPending && !expired
                ? Row(
                    children: [
                      _ActionButton(
                        icon: Icons.check,
                        color: AppColors.success,
                        tooltip: 'Approve',
                        onTap: () => _approveAction(action),
                      ),
                      const SizedBox(width: 8),
                      _ActionButton(
                        icon: Icons.close,
                        color: AppColors.error,
                        tooltip: 'Reject',
                        onTap: () => _rejectAction(action),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPlaceholder() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No pending actions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedFilter == 'all'
                  ? 'There are no actions in the approval queue.'
                  : 'No actions match the selected filter.',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load actions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'An unknown error occurred.',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _loadActions,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private helper widgets
// ---------------------------------------------------------------------------

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
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
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
          ? AppColors.primary.withValues(alpha: 0.15)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderDark,
            ),
          ),
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
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 18, color: color),
          ),
        ),
      ),
    );
  }
}
