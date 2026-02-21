import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Audit Log screen -- immutable log of all admin actions.
///
/// Displays a filterable, searchable table of every admin action recorded by
/// Cloud Functions.  Supports outcome filtering, text search, pagination via
/// "Load More", and detail expansion for each entry.
class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  final _searchController = TextEditingController();
  String _selectedOutcome = 'all';

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = false;
  String? _errorMessage;

  List<Map<String, dynamic>> _logs = [];

  // ---------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
    _loadLogs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------
  // Data loading
  // ---------------------------------------------------------------

  Future<void> _loadLogs() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminGetAuditLogs')
          .call({'limit': 50});

      final data = result.data as Map<String, dynamic>;
      final rawLogs = (data['logs'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      if (!mounted) return;
      setState(() {
        _logs = rawLogs;
        _hasMore = data['hasMore'] == true;
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
          content: Text('Failed to load audit logs: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _loadMore() async {
    if (_logs.isEmpty || _isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final lastId = _logs.last['id'] as String?;
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminGetAuditLogs')
          .call({'limit': 50, 'startAfterId': lastId});

      final data = result.data as Map<String, dynamic>;
      final rawLogs = (data['logs'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      if (!mounted) return;
      setState(() {
        _logs.addAll(rawLogs);
        _hasMore = data['hasMore'] == true;
        _isLoadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingMore = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load more logs: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  // ---------------------------------------------------------------
  // Filtering helpers
  // ---------------------------------------------------------------

  List<Map<String, dynamic>> get _filteredLogs {
    final query = _searchController.text.toLowerCase();

    return _logs.where((log) {
      // Outcome filter
      final outcome = (log['outcome'] ?? '').toString();
      if (_selectedOutcome != 'all') {
        if (_selectedOutcome == 'maker_checker') {
          if (outcome != 'maker_created' &&
              outcome != 'checker_approved' &&
              outcome != 'checker_rejected') {
            return false;
          }
        } else if (outcome != _selectedOutcome) {
          return false;
        }
      }

      // Text search
      if (query.isNotEmpty) {
        final email = (log['actorEmail'] ?? '').toString().toLowerCase();
        final action = (log['action'] ?? '').toString().toLowerCase();
        if (!email.contains(query) && !action.contains(query)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  // ---------------------------------------------------------------
  // Stats helpers
  // ---------------------------------------------------------------

  int get _successCount =>
      _logs.where((l) => l['outcome'] == 'success').length;

  int get _deniedCount =>
      _logs.where((l) => l['outcome'] == 'denied').length;

  int get _errorCount =>
      _logs.where((l) => l['outcome'] == 'error').length;

  // ---------------------------------------------------------------
  // Timestamp parsing
  // ---------------------------------------------------------------

  String _formatTimestamp(dynamic ts) {
    try {
      if (ts is String && ts.isNotEmpty) {
        final dt = DateTime.parse(ts).toLocal();
        return DateFormat('dd MMM yyyy HH:mm').format(dt);
      }
      if (ts is Map) {
        final seconds = ts['_seconds'];
        if (seconds is int) {
          final dt = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
          return DateFormat('dd MMM yyyy HH:mm').format(dt);
        }
      }
      return '--';
    } catch (_) {
      return '--';
    }
  }

  // ---------------------------------------------------------------
  // Outcome styling
  // ---------------------------------------------------------------

  Color _outcomeColor(String outcome) {
    switch (outcome) {
      case 'success':
        return AppColors.success;
      case 'denied':
        return AppColors.error;
      case 'error':
        return AppColors.warning;
      case 'maker_created':
        return AppColors.primary;
      case 'checker_approved':
        return AppColors.success;
      case 'checker_rejected':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _outcomeLabel(String outcome) {
    switch (outcome) {
      case 'success':
        return 'Success';
      case 'denied':
        return 'Denied';
      case 'error':
        return 'Error';
      case 'maker_created':
        return 'Maker Created';
      case 'checker_approved':
        return 'Checker Approved';
      case 'checker_rejected':
        return 'Checker Rejected';
      default:
        return outcome;
    }
  }

  // ---------------------------------------------------------------
  // Role styling (same palette convention as admin screens)
  // ---------------------------------------------------------------

  Color _roleColor(String role) {
    switch (role) {
      case 'superAdmin':
        return AppColors.error;
      case 'financeAdmin':
        return AppColors.warning;
      case 'campaignAdmin':
        return AppColors.primary;
      case 'platformAdmin':
        return AppColors.tertiary;
      case 'auditor':
        return AppColors.secondary;
      default:
        return AppColors.textSecondary;
    }
  }

  // ---------------------------------------------------------------
  // Details dialog
  // ---------------------------------------------------------------

  void _showDetailsDialog(Map<String, dynamic> log) {
    final details = log['details'];
    final entries = <MapEntry<String, dynamic>>[];

    if (details is Map<String, dynamic>) {
      entries.addAll(details.entries);
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          'Log Details',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: SizedBox(
          width: 500,
          child: entries.isEmpty
              ? Text(
                  'No additional details recorded.',
                  style: TextStyle(color: AppColors.textSecondary),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header meta
                      _detailRow('Log ID', log['id']?.toString() ?? '--'),
                      _detailRow('Actor', log['actorEmail']?.toString() ?? '--'),
                      _detailRow('Action', log['action']?.toString() ?? '--'),
                      _detailRow('Target',
                          '${log['targetType'] ?? '--'} / ${log['targetId'] ?? '--'}'),
                      const Divider(color: AppColors.dividerDark),
                      const SizedBox(height: 8),
                      Text(
                        'Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...entries.map(
                        (e) => _detailRow(e.key, e.value?.toString() ?? '--'),
                      ),
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

  Widget _detailRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              key,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Audit Logs',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Immutable log of all admin actions',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: _loadLogs,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(0, 40),
                        ),
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
                        title: 'Total Entries',
                        value: _logs.length.toString(),
                        icon: Icons.receipt_long,
                        color: AppColors.primary,
                      ),
                      _StatCard(
                        title: 'Successful',
                        value: _successCount.toString(),
                        icon: Icons.check_circle,
                        color: AppColors.success,
                      ),
                      _StatCard(
                        title: 'Denied',
                        value: _deniedCount.toString(),
                        icon: Icons.block,
                        color: AppColors.error,
                      ),
                      _StatCard(
                        title: 'Errors',
                        value: _errorCount.toString(),
                        icon: Icons.error_outline,
                        color: AppColors.warning,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Filters row
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by actor email or action...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        _FilterChip(
                          label: 'All',
                          isSelected: _selectedOutcome == 'all',
                          onTap: () =>
                              setState(() => _selectedOutcome = 'all'),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Success',
                          isSelected: _selectedOutcome == 'success',
                          onTap: () =>
                              setState(() => _selectedOutcome = 'success'),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Denied',
                          isSelected: _selectedOutcome == 'denied',
                          onTap: () =>
                              setState(() => _selectedOutcome = 'denied'),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Error',
                          isSelected: _selectedOutcome == 'error',
                          onTap: () =>
                              setState(() => _selectedOutcome = 'error'),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Maker-Checker',
                          isSelected: _selectedOutcome == 'maker_checker',
                          onTap: () =>
                              setState(() => _selectedOutcome = 'maker_checker'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Table
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
                        if (_errorMessage != null && _logs.isEmpty)
                          _buildEmptyState(
                            icon: Icons.error_outline,
                            message:
                                'Failed to load audit logs.\n$_errorMessage',
                          )
                        else if (_filteredLogs.isEmpty)
                          _buildEmptyState(
                            icon: Icons.history_outlined,
                            message: _logs.isEmpty
                                ? 'No audit logs yet.'
                                : 'No logs match your filters.',
                          )
                        else
                          ..._filteredLogs.map(_buildLogRow),
                        if (_hasMore) ...[
                          const SizedBox(height: 16),
                          Center(
                            child: _isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: _loadMore,
                                    child: const Text('Load More'),
                                  ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // ---------------------------------------------------------------
  // Table header
  // ---------------------------------------------------------------

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          _headerCell('Timestamp', flex: 1),
          _headerCell('Actor', flex: 1),
          _headerCell('Roles', flex: 1),
          _headerCell('Action', flex: 2),
          _headerCell('Outcome', flex: 1),
          _headerCell('Details', flex: 1),
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

  // ---------------------------------------------------------------
  // Table row
  // ---------------------------------------------------------------

  Widget _buildLogRow(Map<String, dynamic> log) {
    final outcome = (log['outcome'] ?? '').toString();
    final color = _outcomeColor(outcome);

    // Read actorRoles (array) first, fall back to actorRole (string)
    List<String> roles = [];
    final actorRoles = log['actorRoles'];
    if (actorRoles is List && actorRoles.isNotEmpty) {
      roles = actorRoles.cast<String>();
    } else {
      final role = (log['actorRole'] ?? '').toString();
      if (role.isNotEmpty) roles = [role];
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              // Timestamp
              Expanded(
                flex: 1,
                child: Text(
                  _formatTimestamp(log['timestamp']),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),

              // Actor email
              Expanded(
                flex: 1,
                child: Text(
                  (log['actorEmail'] ?? '--').toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimaryDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Role badges
              Expanded(
                flex: 1,
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: roles.isEmpty
                      ? [
                          Text('--',
                              style: TextStyle(color: AppColors.textSecondary))
                        ]
                      : roles.map((r) {
                          final rColor = _roleColor(r);
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: rColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              r.replaceAll('Admin', '').trim(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: rColor,
                              ),
                            ),
                          );
                        }).toList(),
                ),
              ),

              // Action
              Expanded(
                flex: 2,
                child: Text(
                  (log['action'] ?? '--').toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimaryDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Outcome badge
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _outcomeLabel(outcome),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ),
              ),

              // Details button
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => _showDetailsDialog(log),
                    icon: const Icon(Icons.info_outline, size: 20),
                    color: AppColors.textSecondary,
                    tooltip: 'View details',
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.dividerDark),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Empty / error state
  // ---------------------------------------------------------------

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(icon, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// =================================================================
// Private helper widgets (same pattern as SupplierManagementScreen)
// =================================================================

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
