import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Unified Accounts Overview screen showing all Clients, Suppliers, and Users
/// with their main ledger account balances and expandable sub-accounts.
class AccountsOverviewScreen extends StatefulWidget {
  const AccountsOverviewScreen({super.key});

  @override
  State<AccountsOverviewScreen> createState() =>
      _AccountsOverviewScreenState();
}

class _AccountsOverviewScreenState extends State<AccountsOverviewScreen> {
  // Tab selection: 0=Clients, 1=Suppliers, 2=Users
  int _selectedTab = 0;

  // Data
  List<Map<String, dynamic>> _clients = [];
  List<Map<String, dynamic>> _suppliers = [];
  List<Map<String, dynamic>> _users = [];

  // Loading
  bool _isLoadingClients = false;
  bool _isLoadingSuppliers = false;
  bool _isLoadingUsers = false;

  // Search
  final _searchController = TextEditingController();
  String _searchQuery = '';

  // Sort
  String _sortField = 'name';
  bool _sortAscending = true;

  // Status filter
  String _statusFilter = 'all';

  // Expansion
  final Set<String> _expandedIds = {};
  final Map<String, List<Map<String, dynamic>>> _subAccountCache = {};
  final Set<String> _loadingSubAccounts = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.toLowerCase());
    });
    _loadAllData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAllData() async {
    await Future.wait([
      _loadClients(),
      _loadSuppliers(),
      _loadUsers(),
    ]);
  }

  Future<void> _loadClients() async {
    setState(() => _isLoadingClients = true);
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminListClients')
          .call();
      final list = (result.data['clients'] as List?)
              ?.map((c) => Map<String, dynamic>.from(c as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _clients = list);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading clients: $e'),
              backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoadingClients = false);
    }
  }

  Future<void> _loadSuppliers() async {
    setState(() => _isLoadingSuppliers = true);
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminListSuppliers')
          .call();
      final list = (result.data['suppliers'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _suppliers = list);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading suppliers: $e'),
              backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoadingSuppliers = false);
    }
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoadingUsers = true);
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminListUsers')
          .call();
      final list = (result.data['users'] as List?)
              ?.map((u) => Map<String, dynamic>.from(u as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _users = list);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading users: $e'),
              backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoadingUsers = false);
    }
  }

  Future<void> _loadSubAccounts(String entityId, String entityType) async {
    if (_subAccountCache.containsKey(entityId)) return;

    setState(() => _loadingSubAccounts.add(entityId));
    try {
      final String functionName;
      final Map<String, dynamic> params;

      if (entityType == 'client') {
        functionName = 'adminListClientSubAccounts';
        params = {'clientId': entityId};
      } else if (entityType == 'user') {
        functionName = 'adminListUserSubAccounts';
        params = {'userId': entityId};
      } else {
        return;
      }

      final result = await FirebaseFunctions.instance
          .httpsCallable(functionName)
          .call(params);

      final list = (result.data['subAccounts'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];

      if (mounted) setState(() => _subAccountCache[entityId] = list);
    } catch (_) {
      if (mounted) setState(() => _subAccountCache[entityId] = []);
    } finally {
      if (mounted) setState(() => _loadingSubAccounts.remove(entityId));
    }
  }

  // ==================== COMPUTED GETTERS ====================

  List<Map<String, dynamic>> get _currentList {
    final raw = switch (_selectedTab) {
      0 => _clients,
      1 => _suppliers,
      2 => _users,
      _ => <Map<String, dynamic>>[],
    };
    return _filterAndSort(raw);
  }

  bool get _isCurrentTabLoading => switch (_selectedTab) {
        0 => _isLoadingClients,
        1 => _isLoadingSuppliers,
        2 => _isLoadingUsers,
        _ => false,
      };

  String get _currentEntityType => switch (_selectedTab) {
        0 => 'client',
        1 => 'supplier',
        2 => 'user',
        _ => '',
      };

  bool get _hasExpandableSubAccounts => _selectedTab != 1; // not suppliers

  List<Map<String, dynamic>> _filterAndSort(List<Map<String, dynamic>> data) {
    var filtered = data.where((item) {
      // Status filter
      if (_statusFilter != 'all') {
        final status = item['status']?.toString() ?? '';
        if (status != _statusFilter) return false;
      }

      // Search filter
      if (_searchQuery.isNotEmpty) {
        final searchFields = [
          item['name'],
          item['displayName'],
          item['companyName'],
          item['contactName'],
          item['contactEmail'],
          item['phoneNumber'],
          item['email'],
          item['id'],
          item['category'],
          item['industry'],
        ];
        return searchFields.any((f) =>
            f != null && f.toString().toLowerCase().contains(_searchQuery));
      }
      return true;
    }).toList();

    // Sort
    filtered.sort((a, b) {
      int cmp;
      switch (_sortField) {
        case 'name':
          final aName = (a['displayName'] ?? a['companyName'] ?? a['name'] ?? '')
              .toString();
          final bName = (b['displayName'] ?? b['companyName'] ?? b['name'] ?? '')
              .toString();
          cmp = aName.toLowerCase().compareTo(bName.toLowerCase());
        case 'balance':
          final aBalance = (a['balance'] as num?) ?? 0;
          final bBalance = (b['balance'] as num?) ?? 0;
          cmp = aBalance.compareTo(bBalance);
        case 'status':
          cmp = (a['status'] ?? '').toString().compareTo(
              (b['status'] ?? '').toString());
        default:
          cmp = 0;
      }
      return _sortAscending ? cmp : -cmp;
    });

    return filtered;
  }

  int _sumBalance(List<Map<String, dynamic>> list) {
    return list.fold<int>(
        0, (sum, item) => sum + ((item['balance'] as num?)?.toInt() ?? 0));
  }

  // ==================== BUILD ====================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatCards(),
            const SizedBox(height: 24),
            _buildTabs(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Accounts Overview',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'View all ledger accounts and sub-accounts across Clients, Suppliers, and Users',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _isCurrentTabLoading ? null : _loadAllData,
          icon: const Icon(Icons.refresh),
          color: AppColors.textSecondaryDark,
          tooltip: 'Refresh all',
        ),
      ],
    );
  }

  Widget _buildStatCards() {
    final totalAccounts = _clients.length + _suppliers.length + _users.length;
    final totalBalance =
        _sumBalance(_clients) + _sumBalance(_suppliers) + _sumBalance(_users);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _StatCard(
          icon: Icons.account_balance,
          color: AppColors.info,
          title: 'Total Accounts',
          value: NumberFormat.compact().format(totalAccounts),
          subtitle: '${NumberFormat.compact().format(totalBalance)} tokens',
        ),
        _StatCard(
          icon: Icons.business_center,
          color: AppColors.tokenGold,
          title: 'Clients',
          value: _clients.length.toString(),
          subtitle: '${NumberFormat.compact().format(_sumBalance(_clients))} tokens',
        ),
        _StatCard(
          icon: Icons.business,
          color: AppColors.success,
          title: 'Suppliers',
          value: _suppliers.length.toString(),
          subtitle: '${NumberFormat.compact().format(_sumBalance(_suppliers))} tokens',
        ),
        _StatCard(
          icon: Icons.people,
          color: AppColors.primary,
          title: 'Users',
          value: _users.length.toString(),
          subtitle: '${NumberFormat.compact().format(_sumBalance(_users))} tokens',
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _TabChip(
          label: 'Clients (${_clients.length})',
          isSelected: _selectedTab == 0,
          onTap: () => setState(() {
            _selectedTab = 0;
            _expandedIds.clear();
          }),
        ),
        const SizedBox(width: 8),
        _TabChip(
          label: 'Suppliers (${_suppliers.length})',
          isSelected: _selectedTab == 1,
          onTap: () => setState(() {
            _selectedTab = 1;
            _expandedIds.clear();
          }),
        ),
        const SizedBox(width: 8),
        _TabChip(
          label: 'Users (${_users.length})',
          isSelected: _selectedTab == 2,
          onTap: () => setState(() {
            _selectedTab = 2;
            _expandedIds.clear();
          }),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
                hintText: 'Search by name, email, phone, or ID...',
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
            isSelected: _statusFilter == 'all',
            onTap: () => setState(() => _statusFilter = 'all'),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Active',
            isSelected: _statusFilter == 'active',
            onTap: () => setState(() => _statusFilter = 'active'),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Frozen',
            isSelected: _statusFilter == 'frozen',
            onTap: () => setState(() => _statusFilter = 'frozen'),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          const Divider(height: 1, color: AppColors.dividerDark),
          if (_isCurrentTabLoading)
            const Padding(
              padding: EdgeInsets.all(48),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_currentList.isEmpty)
            Padding(
              padding: const EdgeInsets.all(48),
              child: Center(
                child: Text(
                  _searchQuery.isNotEmpty || _statusFilter != 'all'
                      ? 'No matching accounts found'
                      : 'No accounts found',
                  style: const TextStyle(color: AppColors.textSecondaryDark),
                ),
              ),
            )
          else
            ..._currentList.map((item) =>
                _buildExpandableRow(item, _currentEntityType)),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (_hasExpandableSubAccounts)
            const SizedBox(width: 32), // space for expand icon
          ..._getHeaderColumns(),
        ],
      ),
    );
  }

  List<Widget> _getHeaderColumns() {
    switch (_selectedTab) {
      case 0: // Clients
        return [
          _sortableHeader('Name', 'name', flex: 2),
          _sortableHeader('Contact', 'contact', flex: 2),
          _sortableHeader('Industry', 'industry', flex: 1),
          _sortableHeader('Balance', 'balance', flex: 1),
          _sortableHeader('Status', 'status', flex: 1),
        ];
      case 1: // Suppliers
        return [
          _sortableHeader('Name', 'name', flex: 2),
          _sortableHeader('Category', 'category', flex: 1),
          _sortableHeader('Contact', 'contact', flex: 2),
          _sortableHeader('Balance', 'balance', flex: 1),
          _sortableHeader('Status', 'status', flex: 1),
        ];
      case 2: // Users
        return [
          _sortableHeader('Name', 'name', flex: 2),
          _sortableHeader('Phone', 'phone', flex: 1),
          _sortableHeader('Email', 'email', flex: 1),
          _sortableHeader('Balance', 'balance', flex: 1),
          _sortableHeader('Status', 'status', flex: 1),
        ];
      default:
        return [];
    }
  }

  Widget _sortableHeader(String text, String field, {int flex = 1}) {
    final isActive = _sortField == field;
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () => setState(() {
          if (_sortField == field) {
            _sortAscending = !_sortAscending;
          } else {
            _sortField = field;
            _sortAscending = true;
          }
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? AppColors.textPrimaryDark
                    : AppColors.textSecondaryDark,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 4),
              Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: AppColors.textPrimaryDark,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableRow(Map<String, dynamic> item, String entityType) {
    final id = item['id']?.toString() ?? '';
    final isExpanded = _expandedIds.contains(id);
    final hasSubAccounts = entityType != 'supplier';

    return Column(
      children: [
        InkWell(
          onTap: hasSubAccounts
              ? () {
                  setState(() {
                    if (isExpanded) {
                      _expandedIds.remove(id);
                    } else {
                      _expandedIds.add(id);
                      _loadSubAccounts(id, entityType);
                    }
                  });
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                if (_hasExpandableSubAccounts)
                  SizedBox(
                    width: 32,
                    child: hasSubAccounts
                        ? Icon(
                            isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 20,
                            color: AppColors.textSecondaryDark,
                          )
                        : null,
                  ),
                ..._getRowCells(item, entityType),
              ],
            ),
          ),
        ),
        if (isExpanded && hasSubAccounts) _buildSubAccountsSection(id),
        const Divider(height: 1, color: AppColors.dividerDark),
      ],
    );
  }

  List<Widget> _getRowCells(Map<String, dynamic> item, String entityType) {
    final balance = (item['balance'] as num?)?.toInt() ?? 0;
    final status = item['status']?.toString() ?? 'unknown';

    switch (entityType) {
      case 'client':
        return [
          Expanded(
            flex: 2,
            child: Text(
              item['displayName']?.toString() ??
                  item['companyName']?.toString() ??
                  item['id']?.toString() ??
                  '-',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['contactName']?.toString() ?? '-',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textPrimaryDark),
                ),
                if (item['contactEmail'] != null)
                  Text(
                    item['contactEmail'].toString(),
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondaryDark),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item['industry']?.toString() ?? '-',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondaryDark),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              NumberFormat.compact().format(balance),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: balance > 0 ? AppColors.tokenGold : AppColors.textSecondaryDark,
              ),
            ),
          ),
          Expanded(flex: 1, child: _StatusBadge(status: status)),
        ];

      case 'supplier':
        return [
          Expanded(
            flex: 2,
            child: Text(
              item['name']?.toString() ?? item['id']?.toString() ?? '-',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item['category']?.toString() ?? '-',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondaryDark),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['contactName']?.toString() ?? '-',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textPrimaryDark),
                ),
                if (item['contactEmail'] != null)
                  Text(
                    item['contactEmail'].toString(),
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondaryDark),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              NumberFormat.compact().format(balance),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: balance > 0 ? AppColors.tokenGold : AppColors.textSecondaryDark,
              ),
            ),
          ),
          Expanded(flex: 1, child: _StatusBadge(status: status)),
        ];

      case 'user':
        return [
          Expanded(
            flex: 2,
            child: Text(
              item['displayName']?.toString() ??
                  item['name']?.toString() ??
                  item['id']?.toString() ??
                  '-',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item['phoneNumber']?.toString() ?? '-',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondaryDark),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item['email']?.toString() ?? '-',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondaryDark),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              NumberFormat.compact().format(balance),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: balance > 0 ? AppColors.tokenGold : AppColors.textSecondaryDark,
              ),
            ),
          ),
          Expanded(flex: 1, child: _StatusBadge(status: status)),
        ];

      default:
        return [];
    }
  }

  Widget _buildSubAccountsSection(String entityId) {
    if (_loadingSubAccounts.contains(entityId)) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    final subAccounts = _subAccountCache[entityId] ?? [];

    if (subAccounts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        child: Text(
          'No sub-accounts',
          style: TextStyle(
            fontSize: 13,
            fontStyle: FontStyle.italic,
            color: AppColors.textSecondaryDark,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 32, right: 16, bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        children: [
          // Sub-account header
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                _subHeader('Sub-Account', flex: 3),
                _subHeader('Balance', flex: 2),
                _subHeader('Type', flex: 2),
                _subHeader('Default', flex: 1),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.dividerDark),
          ...subAccounts.map(_buildSubAccountRow),
        ],
      ),
    );
  }

  Widget _subHeader(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondaryDark,
        ),
      ),
    );
  }

  Widget _buildSubAccountRow(Map<String, dynamic> sa) {
    final balance = (sa['balance'] as num?)?.toInt() ?? 0;
    final isDefault = sa['isDefault'] == true;
    final name = sa['name']?.toString() ?? sa['id']?.toString() ?? '-';

    // Determine type label
    String typeLabel;
    if (sa['accountTypeId'] != null) {
      typeLabel = 'Restricted';
    } else if (sa['initialBudget'] != null) {
      // Client sub-account
      typeLabel = 'Budget';
    } else {
      typeLabel = 'Unrestricted';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textPrimaryDark),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              NumberFormat.compact().format(balance),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: balance > 0
                    ? AppColors.tokenGold
                    : AppColors.textSecondaryDark,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              typeLabel,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondaryDark),
            ),
          ),
          Expanded(
            flex: 1,
            child: isDefault
                ? const Icon(Icons.star, size: 16, color: AppColors.tokenGold)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

// ==================== HELPER WIDGETS ====================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondaryDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabChip({
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
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSecondaryDark,
            ),
          ),
        ),
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
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSecondaryDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final Color color;
    switch (status) {
      case 'active':
        color = AppColors.success;
      case 'frozen':
        color = AppColors.error;
      default:
        color = AppColors.textSecondaryDark;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          status[0].toUpperCase() + status.substring(1),
          style: TextStyle(fontSize: 13, color: color),
        ),
      ],
    );
  }
}
