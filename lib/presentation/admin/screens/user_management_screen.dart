import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// User management screen for admin portal.
///
/// Displays consumer user accounts from the ledger, with search, filtering,
/// and the ability to view sub-accounts per user.
class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------
  // Data loading
  // ---------------------------------------------------------------

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminListUsers');
      final result = await callable.call<dynamic>();
      final data = result.data as Map<String, dynamic>;
      final usersList = (data['users'] as List<dynamic>?) ?? [];

      if (!mounted) return;
      setState(() {
        _users = usersList.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  // ---------------------------------------------------------------
  // Filtering
  // ---------------------------------------------------------------

  List<Map<String, dynamic>> get _filteredUsers {
    final query = _searchController.text.toLowerCase();

    return _users.where((user) {
      // Status filter
      final status = (user['status'] ?? '').toString().toLowerCase();
      if (_selectedFilter == 'active' && status != 'active') return false;
      if (_selectedFilter == 'frozen' && status != 'frozen') return false;

      // Text search
      if (query.isNotEmpty) {
        final name = (user['displayName'] ?? user['name'] ?? '')
            .toString()
            .toLowerCase();
        final phone = (user['phoneNumber'] ?? '').toString().toLowerCase();
        final uid = (user['id'] ?? '').toString().toLowerCase();
        final email = (user['email'] ?? '').toString().toLowerCase();
        if (!name.contains(query) &&
            !phone.contains(query) &&
            !uid.contains(query) &&
            !email.contains(query)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  int get _activeCount =>
      _users.where((u) => u['status'] == 'active').length;

  int get _frozenCount =>
      _users.where((u) => u['status'] == 'frozen').length;

  // ---------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------

  String _formatBalance(dynamic balance) {
    if (balance == null) return '0';
    final num = (balance is int) ? balance : int.tryParse(balance.toString());
    if (num == null) return balance.toString();
    final formatter = NumberFormat('#,###');
    return formatter.format(num);
  }

  String _formatTimestamp(dynamic ts) {
    try {
      if (ts is String && ts.isNotEmpty) {
        final dt = DateTime.parse(ts).toLocal();
        return DateFormat('dd MMM yyyy').format(dt);
      }
      if (ts is Map) {
        final seconds = ts['_seconds'];
        if (seconds is int) {
          final dt = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
          return DateFormat('dd MMM yyyy').format(dt);
        }
      }
      return '--';
    } catch (_) {
      return '--';
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.success;
      case 'frozen':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  // ---------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------

  Future<void> _viewSubAccounts(Map<String, dynamic> user) async {
    final userId = user['id'] as String?;
    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID not available'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Show loading dialog with visible indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 16),
            const Text(
              'Loading sub-accounts...',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
          ],
        ),
      ),
    );

    try {
      final callable = FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminListUserSubAccounts');
      final result = await callable.call<dynamic>({'userId': userId});
      final data = result.data as Map<String, dynamic>;
      final subAccounts =
          (data['subAccounts'] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>() ??
          [];

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading

      _showSubAccountsDialog(user, subAccounts);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load sub-accounts: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showSubAccountsDialog(
    Map<String, dynamic> user,
    List<Map<String, dynamic>> subAccounts,
  ) {
    final displayName =
        user['displayName'] ?? user['name'] ?? user['id'] ?? '--';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text(
          'Sub-Accounts — $displayName',
          style: const TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: SizedBox(
          width: 600,
          child: subAccounts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'No sub-accounts found for this user.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: subAccounts.map((sa) {
                      final isDefault = sa['isDefault'] == true;
                      final isActive = sa['isActive'] == true;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundDark,
                          borderRadius: BorderRadius.circular(8),
                          border: isDefault
                              ? Border.all(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.4),
                                )
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    sa['name'] ?? sa['id'] ?? '--',
                                    style: const TextStyle(
                                      color: AppColors.textPrimaryDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (isDefault)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withValues(alpha: 0.15),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          'Default',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (isActive
                                                ? AppColors.success
                                                : AppColors.error)
                                            .withValues(alpha: 0.15),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        isActive ? 'Active' : 'Inactive',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isActive
                                              ? AppColors.success
                                              : AppColors.error,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _saDetail(
                                  'Balance',
                                  _formatBalance(sa['balance']),
                                ),
                                _saDetail(
                                  'Credits',
                                  _formatBalance(sa['lifetimeCredits']),
                                ),
                                _saDetail(
                                  'Debits',
                                  _formatBalance(sa['lifetimeDebits']),
                                ),
                              ],
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

  Widget _saDetail(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimaryDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          'User Details',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: SizedBox(
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow('UID', user['id']?.toString() ?? '--'),
                _detailRow(
                  'Ledger ID',
                  user['ledgerAccountId']?.toString() ?? '--',
                ),
                _detailRow(
                  'Display Name',
                  user['displayName']?.toString() ?? '--',
                ),
                _detailRow(
                  'Ledger Name',
                  user['name']?.toString() ?? '--',
                ),
                _detailRow(
                  'Phone',
                  user['phoneNumber']?.toString() ?? '--',
                ),
                _detailRow(
                  'Email',
                  user['email']?.toString() ?? '--',
                ),
                _detailRow(
                  'Balance',
                  '${_formatBalance(user['balance'])} tokens',
                ),
                _detailRow(
                  'Status',
                  user['status']?.toString() ?? '--',
                ),
                _detailRow(
                  'Joined',
                  _formatTimestamp(user['createdAt']),
                ),
                _detailRow(
                  'Last Login',
                  _formatTimestamp(user['lastLoginAt']),
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
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
    final filtered = _filteredUsers;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
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
                      'User Management',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'View and manage consumer user accounts',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _isLoading ? null : _loadUsers,
                      icon: const Icon(Icons.refresh),
                      color: AppColors.textPrimaryDark,
                      tooltip: 'Refresh',
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Export coming soon'),
                            backgroundColor: AppColors.warning,
                          ),
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Export Users'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                      ),
                    ),
                  ],
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
                  title: 'Total Users',
                  value: _isLoading ? '--' : '${_users.length}',
                  icon: Icons.people,
                  color: AppColors.primary,
                ),
                _StatCard(
                  title: 'Active',
                  value: _isLoading ? '--' : '$_activeCount',
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
                _StatCard(
                  title: 'Frozen',
                  value: _isLoading ? '--' : '$_frozenCount',
                  icon: Icons.ac_unit,
                  color: AppColors.error,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Search and filters
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
                        hintText: 'Search by name, phone, email, or UID...',
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
                    label: 'All Users',
                    isSelected: _selectedFilter == 'all',
                    onTap: () => setState(() => _selectedFilter = 'all'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Active',
                    isSelected: _selectedFilter == 'active',
                    onTap: () => setState(() => _selectedFilter = 'active'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Frozen',
                    isSelected: _selectedFilter == 'frozen',
                    onTap: () => setState(() => _selectedFilter = 'frozen'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Users table
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
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  else if (_errorMessage != null)
                    _buildErrorState()
                  else if (filtered.isEmpty)
                    _buildEmptyState()
                  else
                    ...filtered.map(_buildUserRow),
                ],
              ),
            ),
          ],
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
          _headerCell('Phone', flex: 1),
          _headerCell('Balance', flex: 1),
          _headerCell('Status', flex: 1),
          _headerCell('Joined', flex: 1),
          _headerCell('Last Login', flex: 1),
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

  Widget _buildUserRow(Map<String, dynamic> user) {
    final displayName =
        user['displayName'] ?? user['name'] ?? user['id'] ?? '--';
    final phone = user['phoneNumber'] ?? '--';
    final balance = _formatBalance(user['balance']);
    final status = (user['status'] ?? 'unknown').toString();
    final joined = _formatTimestamp(user['createdAt']);
    final lastLogin = _formatTimestamp(user['lastLoginAt']);
    final sColor = _statusColor(status);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // User name + email
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user['email'] != null)
                      Text(
                        user['email'].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),

              // Phone
              Expanded(
                flex: 1,
                child: Text(
                  phone.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimaryDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Balance
              Expanded(
                flex: 1,
                child: Text(
                  balance,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Status badge
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
                      color: sColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status[0].toUpperCase() + status.substring(1),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: sColor,
                      ),
                    ),
                  ),
                ),
              ),

              // Joined
              Expanded(
                flex: 1,
                child: Text(
                  joined,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              // Last Login
              Expanded(
                flex: 1,
                child: Text(
                  lastLogin,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              // Actions
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    _ActionButton(
                      icon: Icons.info_outline,
                      tooltip: 'View Details',
                      color: AppColors.secondary,
                      onPressed: () => _showUserDetails(user),
                    ),
                    const SizedBox(width: 4),
                    _ActionButton(
                      icon: Icons.account_balance_wallet_outlined,
                      tooltip: 'View Sub-Accounts',
                      color: AppColors.primary,
                      onPressed: () => _viewSubAccounts(user),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.dividerDark),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              _selectedFilter != 'all' || _searchController.text.isNotEmpty
                  ? 'No users match your filter criteria.'
                  : 'No user accounts found.',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load users',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Unknown error',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _loadUsers,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// =================================================================
// Private helper widgets
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }
}
