import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

const _roleLabels = {
  'platformAdmin': 'Platform Admin',
  'superAdmin': 'Super Admin',
  'financeAdmin': 'Finance Admin',
  'campaignAdmin': 'Campaign Admin',
  'auditor': 'Auditor',
};

const _roleKeys = [
  'superAdmin',
  'financeAdmin',
  'campaignAdmin',
  'platformAdmin',
  'auditor',
];

/// Extract roles array from admin doc, with fallback to single role string.
List<String> _extractAdminRoles(Map<String, dynamic> admin) {
  final roles = admin['roles'];
  if (roles is List && roles.isNotEmpty) {
    return roles.cast<String>();
  }
  final role = admin['role'] as String?;
  if (role != null && role.isNotEmpty) return [role];
  return [];
}

Color _roleBadgeColor(String role) {
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
      return AppColors.textSecondary;
    default:
      return AppColors.textSecondary;
  }
}

/// Admin User Management screen (SuperAdmin only).
///
/// Allows listing, creating, and managing admin users and their roles.
class AdminUserManagementScreen extends StatefulWidget {
  const AdminUserManagementScreen({super.key});

  @override
  State<AdminUserManagementScreen> createState() =>
      _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState extends State<AdminUserManagementScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  List<Map<String, dynamic>> _admins = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAdmins();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAdmins() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminListAdmins');
      final result = await callable.call<dynamic>();
      final data = result.data as Map<String, dynamic>;
      final adminsList = (data['admins'] as List<dynamic>?) ?? [];

      if (!mounted) return;
      setState(() {
        _admins = adminsList.cast<Map<String, dynamic>>();
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

  List<Map<String, dynamic>> get _filteredAdmins {
    final query = _searchController.text.toLowerCase();
    return _admins.where((admin) {
      // Role filter
      if (_selectedFilter != 'all') {
        final roles = _extractAdminRoles(admin);
        if (!roles.contains(_selectedFilter)) return false;
      }
      // Search filter
      if (query.isNotEmpty) {
        final email = (admin['email'] ?? '').toString().toLowerCase();
        final name = (admin['displayName'] ?? '').toString().toLowerCase();
        final uid = (admin['uid'] ?? '').toString().toLowerCase();
        if (!email.contains(query) &&
            !name.contains(query) &&
            !uid.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  int _countByRole(String role) =>
      _admins.where((a) => _extractAdminRoles(a).contains(role)).length;

  String _formatTimestamp(dynamic ts) {
    if (ts == null) return '--';
    try {
      if (ts is Map) {
        final seconds = ts['_seconds'] as int?;
        if (seconds != null) {
          final dt = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
          return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)}';
        }
      }
      return ts.toString();
    } catch (_) {
      return '--';
    }
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');

  // ======================== Actions ========================

  Future<void> _changeRole(Map<String, dynamic> admin) async {
    final currentRoles = _extractAdminRoles(admin);
    final uid = admin['uid'] as String? ?? '';
    final email = admin['email'] ?? uid;

    final selectedRoles = Set<String>.from(currentRoles);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            final hasChanged = !_setEquals(selectedRoles, currentRoles.toSet());
            return AlertDialog(
              backgroundColor: AppColors.adminCard,
              title: const Text(
                'Change Roles',
                style: TextStyle(color: AppColors.textPrimaryDark),
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update roles for $email',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ..._roleKeys.map((r) => CheckboxListTile(
                          title: Text(
                            _roleLabels[r] ?? r,
                            style: const TextStyle(
                                color: AppColors.textPrimaryDark),
                          ),
                          value: selectedRoles.contains(r),
                          activeColor: _roleBadgeColor(r),
                          onChanged: (v) {
                            setDialogState(() {
                              if (v == true) {
                                selectedRoles.add(r);
                              } else {
                                selectedRoles.remove(r);
                              }
                            });
                          },
                        )),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: selectedRoles.isEmpty || !hasChanged
                      ? null
                      : () => Navigator.of(ctx).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmed != true) return;

    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminSetRole');
      await callable.call<dynamic>({
        'targetUid': uid,
        'roles': selectedRoles.toList(),
      });

      if (!mounted) return;
      final labels =
          selectedRoles.map((r) => _roleLabels[r] ?? r).join(', ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Roles updated to $labels'),
          backgroundColor: AppColors.success,
        ),
      );
      _loadAdmins();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to change roles: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  static bool _setEquals(Set<String> a, Set<String> b) =>
      a.length == b.length && a.containsAll(b);

  Future<void> _forceSignOut(Map<String, dynamic> admin) async {
    final uid = admin['uid'] as String? ?? '';
    final email = admin['email'] ?? uid;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text(
          'Force Sign Out',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'Force sign out $email?\n\nThis will invalidate all their active sessions.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
            ),
            child: const Text('Force Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminForceSignOut');
      await callable.call<dynamic>({'targetUid': uid});

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$email has been signed out'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to force sign out: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _revokeAccess(Map<String, dynamic> admin) async {
    final uid = admin['uid'] as String? ?? '';
    final email = admin['email'] ?? uid;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text(
          'Revoke Access',
          style: TextStyle(color: AppColors.error),
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to revoke admin access for $email?',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: AppColors.error, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This action will remove all admin privileges. '
                        'The user will no longer be able to access the admin portal.',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 13,
                        ),
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
              backgroundColor: AppColors.error,
            ),
            child: const Text('Revoke Access'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminRevokeRole');
      await callable.call<dynamic>({'targetUid': uid});

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Access revoked for $email'),
          backgroundColor: AppColors.success,
        ),
      );
      _loadAdmins();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to revoke access: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showAddAdminDialog() {
    showDialog(
      context: context,
      builder: (context) => _AddAdminDialog(
        onSuccess: () {
          _loadAdmins();
        },
      ),
    );
  }

  // ======================== Build ========================

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredAdmins;

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
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
                      'Admin User Management',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage admin users and role assignments',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _showAddAdminDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Admin'),
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
                  title: 'Total Admins',
                  value: _isLoading ? '--' : '${_admins.length}',
                  icon: Icons.admin_panel_settings,
                  color: AppColors.primary,
                ),
                _StatCard(
                  title: 'Super Admins',
                  value:
                      _isLoading ? '--' : '${_countByRole('superAdmin')}',
                  icon: Icons.shield,
                  color: AppColors.error,
                ),
                _StatCard(
                  title: 'Finance Admins',
                  value:
                      _isLoading ? '--' : '${_countByRole('financeAdmin')}',
                  icon: Icons.account_balance,
                  color: AppColors.warning,
                ),
                _StatCard(
                  title: 'Campaign Admins',
                  value: _isLoading
                      ? '--'
                      : '${_countByRole('campaignAdmin')}',
                  icon: Icons.campaign,
                  color: AppColors.secondary,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Search and filters
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.adminCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Search by email, name, or UID...',
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
                    isSelected: _selectedFilter == 'all',
                    onTap: () => setState(() => _selectedFilter = 'all'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Super Admin',
                    isSelected: _selectedFilter == 'superAdmin',
                    onTap: () =>
                        setState(() => _selectedFilter = 'superAdmin'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Finance',
                    isSelected: _selectedFilter == 'financeAdmin',
                    onTap: () =>
                        setState(() => _selectedFilter = 'financeAdmin'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Campaign',
                    isSelected: _selectedFilter == 'campaignAdmin',
                    onTap: () =>
                        setState(() => _selectedFilter = 'campaignAdmin'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Platform',
                    isSelected: _selectedFilter == 'platformAdmin',
                    onTap: () =>
                        setState(() => _selectedFilter = 'platformAdmin'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Auditor',
                    isSelected: _selectedFilter == 'auditor',
                    onTap: () =>
                        setState(() => _selectedFilter = 'auditor'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Table
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.adminCard,
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
                    ...filtered.map((admin) => _buildAdminRow(admin)),
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
          _headerCell('Email', flex: 2),
          _headerCell('Display Name', flex: 1),
          _headerCell('Roles', flex: 2),
          _headerCell('Created', flex: 1),
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

  Widget _buildAdminRow(Map<String, dynamic> admin) {
    final email = admin['email'] ?? '--';
    final displayName = admin['displayName'] ?? '--';
    final roles = _extractAdminRoles(admin);
    final createdAt = _formatTimestamp(admin['createdAt']);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // Email
              Expanded(
                flex: 2,
                child: Text(
                  email.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Display Name
              Expanded(
                flex: 1,
                child: Text(
                  displayName.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Role badges
              Expanded(
                flex: 2,
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: roles.isEmpty
                      ? [
                          Text('--',
                              style: TextStyle(color: AppColors.textSecondary))
                        ]
                      : roles.map((r) {
                          final badgeColor = _roleBadgeColor(r);
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _roleLabels[r] ?? r,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: badgeColor,
                              ),
                            ),
                          );
                        }).toList(),
                ),
              ),
              // Created
              Expanded(
                flex: 1,
                child: Text(
                  createdAt,
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
                      icon: Icons.swap_horiz,
                      tooltip: 'Change Role',
                      color: AppColors.secondary,
                      onPressed: () => _changeRole(admin),
                    ),
                    const SizedBox(width: 4),
                    _ActionButton(
                      icon: Icons.logout,
                      tooltip: 'Force Sign Out',
                      color: AppColors.warning,
                      onPressed: () => _forceSignOut(admin),
                    ),
                    const SizedBox(width: 4),
                    _ActionButton(
                      icon: Icons.block,
                      tooltip: 'Revoke Access',
                      color: AppColors.error,
                      onPressed: () => _revokeAccess(admin),
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
              Icons.admin_panel_settings_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              _selectedFilter != 'all' || _searchController.text.isNotEmpty
                  ? 'No admins match your filter criteria.'
                  : 'No admin users found.\nClick "Add Admin" to assign a role.',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (_selectedFilter == 'all' &&
                _searchController.text.isEmpty) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _showAddAdminDialog,
                icon: const Icon(Icons.add),
                label: const Text('Add Your First Admin'),
              ),
            ],
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
            Text(
              'Failed to load admin users',
              style: const TextStyle(
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
              onPressed: _loadAdmins,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================== Reusable Widgets ========================

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

// ======================== Add Admin Dialog ========================

class _AddAdminDialog extends StatefulWidget {
  final VoidCallback onSuccess;

  const _AddAdminDialog({required this.onSuccess});

  @override
  State<_AddAdminDialog> createState() => _AddAdminDialogState();
}

class _AddAdminDialogState extends State<_AddAdminDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _selectedRoles = <String>{'campaignAdmin'};
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRoles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select at least one role'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminCreateAdmin');
      final result = await callable.call<dynamic>({
        'email': _emailController.text.trim(),
        'displayName': _displayNameController.text.trim(),
        'roles': _selectedRoles.toList(),
      });

      if (!mounted) return;
      Navigator.of(context).pop();

      final data = result.data as Map<String, dynamic>?;
      final wasCreated = data?['created'] == true;
      final resetLink = data?['passwordResetLink'] as String?;

      final labels =
          _selectedRoles.map((r) => _roleLabels[r] ?? r).join(', ');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasCreated
                ? 'Admin created with roles: $labels. A password reset email has been sent.'
                : 'Admin roles updated to: $labels',
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 5),
        ),
      );

      // If a reset link was returned, show it in a dialog for copying
      if (resetLink != null && resetLink.isNotEmpty && context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.adminCard,
            title: const Text(
              'Password Reset Link',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
            content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share this link with the new admin to set their password:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    resetLink,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Done'),
              ),
            ],
          ),
        );
      }

      widget.onSuccess();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create admin: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.adminCard,
      title: const Text(
        'Add Admin User',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'e.g., admin@example.com',
                  helperText:
                      'A new Firebase account will be created if one doesn\'t exist',
                  helperMaxLines: 2,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  hintText: 'e.g., John Smith',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Display name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Roles',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ..._roleKeys.map((r) => CheckboxListTile(
                    title: Text(
                      _roleLabels[r] ?? r,
                      style:
                          const TextStyle(color: AppColors.textPrimaryDark),
                    ),
                    value: _selectedRoles.contains(r),
                    activeColor: _roleBadgeColor(r),
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          _selectedRoles.add(r);
                        } else {
                          _selectedRoles.remove(r);
                        }
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed:
              _isLoading || _selectedRoles.isEmpty ? null : _handleCreate,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Add Admin'),
        ),
      ],
    );
  }
}
