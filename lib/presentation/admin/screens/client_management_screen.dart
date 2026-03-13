import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/image_resize_utils.dart';
import '../../theme/app_colors.dart';

const _industries = [
  ('platform', 'Platform (Internal)'),
  ('retail', 'Retail & E-commerce'),
  ('fmcg', 'FMCG & Consumer Goods'),
  ('fintech', 'Fintech & Banking'),
  ('telecom', 'Telecommunications'),
  ('entertainment', 'Entertainment & Media'),
  ('automotive', 'Automotive'),
  ('travel', 'Travel & Hospitality'),
  ('healthcare', 'Healthcare'),
  ('education', 'Education'),
  ('other', 'Other'),
];

/// Client (Brand Partner) management screen for admin portal
class ClientManagementScreen extends StatefulWidget {
  const ClientManagementScreen({super.key});

  @override
  State<ClientManagementScreen> createState() => _ClientManagementScreenState();
}

class _ClientManagementScreenState extends State<ClientManagementScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';
  bool _isLoading = false;
  List<Map<String, dynamic>> _clients = [];

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadClients() async {
    setState(() => _isLoading = true);
    try {
      // Load clients via Cloud Function (includes ledger balance) + live thread counts
      final results = await Future.wait([
        FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminListClients').call(),
        FirebaseFirestore.instance.collection('earnThreads').get(),
      ]);

      final cfResult = results[0] as HttpsCallableResult;
      final threadSnapshot = results[1] as QuerySnapshot;

      final clientsList = (cfResult.data['clients'] as List?)
              ?.map((c) => Map<String, dynamic>.from(c as Map))
              .toList() ??
          [];

      // Count threads per client (live, not stale counters), skip deleted
      final totalByClient = <String, int>{};
      final activeByClient = <String, int>{};
      for (final doc in threadSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['isDeleted'] == true) continue;
        final clientId = data['clientId'] as String?;
        if (clientId == null) continue;
        totalByClient[clientId] = (totalByClient[clientId] ?? 0) + 1;
        if (data['isActive'] == true) {
          activeByClient[clientId] = (activeByClient[clientId] ?? 0) + 1;
        }
      }

      _clients = clientsList
          .where((c) => c['isDeleted'] != true)
          .map((c) {
        c['totalCampaigns'] = totalByClient[c['id']] ?? 0;
        c['activeCampaigns'] = activeByClient[c['id']] ?? 0;
        return c;
      }).toList();

      _clients.sort((a, b) => (a['companyName'] ?? '')
          .toString()
          .toLowerCase()
          .compareTo((b['companyName'] ?? '').toString().toLowerCase()));
    } catch (e) {
      // Fallback to direct Firestore if Cloud Function fails
      try {
        final results = await Future.wait([
          FirebaseFirestore.instance.collection('clients').get(),
          FirebaseFirestore.instance.collection('earnThreads').get(),
        ]);
        final clientSnapshot = results[0];
        final threadSnapshot = results[1];

        final totalByClient = <String, int>{};
        final activeByClient = <String, int>{};
        for (final doc in threadSnapshot.docs) {
          final d = doc.data();
          if (d['isDeleted'] == true) continue;
          final clientId = d['clientId'] as String?;
          if (clientId == null) continue;
          totalByClient[clientId] = (totalByClient[clientId] ?? 0) + 1;
          if (d['isActive'] == true) {
            activeByClient[clientId] = (activeByClient[clientId] ?? 0) + 1;
          }
        }

        _clients = clientSnapshot.docs
            .where((doc) => doc.data()['isDeleted'] != true)
            .map((doc) {
          final data = {'id': doc.id, ...doc.data()};
          data['totalCampaigns'] = totalByClient[doc.id] ?? 0;
          data['activeCampaigns'] = activeByClient[doc.id] ?? 0;
          return data;
        }).toList();

        _clients.sort((a, b) => (a['companyName'] ?? '')
            .toString()
            .toLowerCase()
            .compareTo((b['companyName'] ?? '').toString().toLowerCase()));
      } catch (fallbackError) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading clients: $fallbackError')),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> get _filteredClients {
    var result = _clients;

    if (_selectedFilter == 'active') {
      result = result.where((c) => c['isActive'] == true || c['status'] == 'active').toList();
    } else if (_selectedFilter == 'frozen') {
      result = result.where((c) => c['isActive'] != true && c['status'] != 'active').toList();
    } else if (_selectedFilter == 'campaigns') {
      result = result.where((c) => (c['activeCampaigns'] ?? 0) > 0).toList();
    }

    final query = _searchController.text.toLowerCase().trim();
    if (query.isNotEmpty) {
      result = result.where((c) {
        final name = (c['companyName'] ?? '').toString().toLowerCase();
        final contact = (c['contactName'] ?? '').toString().toLowerCase();
        final email = (c['contactEmail'] ?? '').toString().toLowerCase();
        return name.contains(query) ||
            contact.contains(query) ||
            email.contains(query);
      }).toList();
    }

    return result;
  }

  void _showCreateClientDialog() {
    showDialog(
      context: context,
      builder: (context) => _CreateClientDialog(onCreated: _loadClients),
    );
  }

  void _showEditClientDialog(Map<String, dynamic> client) {
    showDialog(
      context: context,
      builder: (context) => _EditClientDialog(
        client: client,
        onUpdated: _loadClients,
      ),
    );
  }

  void _showSubAccountsDialog(Map<String, dynamic> client) {
    showDialog(
      context: context,
      builder: (context) => _SubAccountsDialog(
        clientId: client['id'] as String,
        clientName: client['companyName'] as String? ?? 'Unknown',
      ),
    );
  }

  void _showToggleStatusDialog(Map<String, dynamic> client) {
    showDialog(
      context: context,
      builder: (context) => _ToggleStatusDialog(
        client: client,
        onUpdated: _loadClients,
      ),
    );
  }

  Future<void> _confirmDeleteClient(Map<String, dynamic> client) async {
    final companyName = client['companyName'] ?? client['displayName'] ?? 'Unknown';
    final balance = client['balance'] ?? 0;
    final campaigns = client['totalCampaigns'] ?? 0;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Delete Client: $companyName?',
            style: const TextStyle(color: AppColors.textPrimaryDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This will:',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            if (balance > 0)
              Text('  - Refund $balance tokens to Treasury',
                  style: const TextStyle(color: AppColors.textSecondary)),
            if (campaigns > 0)
              Text('  - Delete all $campaigns campaigns and their opportunities',
                  style: const TextStyle(color: AppColors.textSecondary)),
            const Text('  - Close the ledger account',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 12),
            const Text('This cannot be undone.',
                style: TextStyle(
                    color: AppColors.error, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminSoftDeleteClient')
          .call({'clientId': client['id']});
      final data = result.data as Map<String, dynamic>;
      final refunded = data['refundedAmount'] ?? 0;
      final threads = data['deletedThreads'] ?? 0;
      final opps = data['deletedOpportunities'] ?? 0;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Client deleted (refunded: $refunded tokens, '
                '$threads campaigns, $opps opportunities removed)'),
            backgroundColor: AppColors.success,
          ),
        );
        _loadClients();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting client: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  String _formatBalance(dynamic balance) {
    if (balance == null) return '--';
    final val = (balance is int) ? balance : (balance as double).toInt();
    if (val >= 1000) {
      return '${(val / 1000).toStringAsFixed(1)}k';
    }
    return '$val';
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredClients;
    final totalClients = _clients.length;
    final activeClients =
        _clients.where((c) => c['isActive'] == true || c['status'] == 'active').length;
    final withCampaigns =
        _clients.where((c) => (c['activeCampaigns'] ?? 0) > 0).length;
    final totalBalance = _clients.fold<int>(
        0, (acc, c) {
      final b = c['balance'];
      return acc + (b is int ? b : (b is double ? b.toInt() : 0));
    });

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
                      'Client Management',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage brand partner accounts and campaign budgets',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _loadClients,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _showCreateClientDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Client'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
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
                  title: 'Total Clients',
                  value: '$totalClients',
                  icon: Icons.business_center,
                  color: AppColors.secondary,
                ),
                _StatCard(
                  title: 'Active Clients',
                  value: '$activeClients',
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
                _StatCard(
                  title: 'With Campaigns',
                  value: '$withCampaigns',
                  icon: Icons.campaign,
                  color: AppColors.tertiary,
                ),
                _StatCard(
                  title: 'Total Balance',
                  value: _formatBalance(totalBalance),
                  icon: Icons.account_balance_wallet,
                  color: AppColors.tokenGold,
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
                        hintText: 'Search by company name or contact...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
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
                    label: 'Active',
                    isSelected: _selectedFilter == 'active',
                    onTap: () => setState(() => _selectedFilter = 'active'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'With Campaigns',
                    isSelected: _selectedFilter == 'campaigns',
                    onTap: () => setState(() => _selectedFilter = 'campaigns'),
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

            // Clients table
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(48),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : filtered.isEmpty
                      ? _buildEmptyState()
                      : Column(
                          children: [
                            _buildTableHeader(),
                            const Divider(height: 1),
                            ...filtered.map(_buildClientRow),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final hasClients = _clients.isNotEmpty;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              hasClients ? Icons.search_off : Icons.business_center_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              hasClients
                  ? 'No clients match the current filters.'
                  : 'No brand partners configured yet.\nClick "Add Client" to onboard a new brand partner.',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (!hasClients) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _showCreateClientDialog,
                icon: const Icon(Icons.add),
                label: const Text('Onboard First Client'),
              ),
            ],
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
          _headerCell('Company', flex: 2),
          _headerCell('Contact', flex: 2),
          _headerCell('Industry', flex: 1),
          _headerCell('Campaigns', flex: 1),
          _headerCell('Balance', flex: 1),
          _headerCell('Status', flex: 1),
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

  Widget _buildClientRow(Map<String, dynamic> client) {
    final isActive = client['isActive'] == true || client['status'] == 'active';
    final rawBal = client['balance'];
    final balance = rawBal is int ? rawBal : (rawBal is double ? rawBal.toInt() : 0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderDark, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Company
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _avatarColor(client),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: (client['avatarImage'] as String?)?.isNotEmpty == true
                      ? Image.network(
                          client['avatarImage'] as String,
                          fit: BoxFit.cover,
                          width: 36,
                          height: 36,
                          errorBuilder: (_, _, _) => Center(
                            child: Text(
                              _clientInitial(client),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            _clientInitial(client),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              client['companyName'] ?? 'Unknown',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimaryDark,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (client['isPinned'] == true)
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(Icons.push_pin,
                                  size: 14, color: AppColors.warning),
                            ),
                          if (client['isFeatured'] == true)
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(Icons.star,
                                  size: 14, color: AppColors.gold),
                            ),
                        ],
                      ),
                      Text(
                        client['id'] ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Contact
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client['contactName'] ?? '-',
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  client['contactEmail'] ?? '-',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Industry
          Expanded(
            flex: 1,
            child: Text(
              _formatIndustry(client['industry']),
              style: TextStyle(color: AppColors.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Campaigns
          Expanded(
            flex: 1,
            child: Text(
              '${client['activeCampaigns'] ?? 0} / ${client['totalCampaigns'] ?? 0}',
              style: const TextStyle(
                color: AppColors.textPrimaryDark,
                fontSize: 13,
              ),
            ),
          ),
          // Balance
          Expanded(
            flex: 1,
            child: Text(
              _formatBalance(balance),
              style: TextStyle(
                color: balance > 0 ? AppColors.tokenGold : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          // Status
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.success.withValues(alpha: 0.15)
                    : AppColors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isActive ? 'Active' : 'Frozen',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.success : AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Actions
          Expanded(
            flex: 1,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: AppColors.textSecondary),
              tooltip: 'Actions',
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditClientDialog(client);
                  case 'sub_accounts':
                    _showSubAccountsDialog(client);
                  case 'toggle_status':
                    _showToggleStatusDialog(client);
                  case 'delete':
                    _confirmDeleteClient(client);
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Edit Client'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'sub_accounts',
                  child: Row(
                    children: [
                      Icon(Icons.folder_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Sub-Accounts'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'toggle_status',
                  child: Row(
                    children: [
                      Icon(
                        isActive
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                        size: 18,
                        color: isActive ? AppColors.warning : AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      Text(isActive ? 'Freeze Client' : 'Activate Client'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, size: 18,
                          color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Delete Client',
                          style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _clientInitial(Map<String, dynamic> client) {
    final name = (client['displayName'] ?? client['companyName'] ?? '')
        .toString();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Color _avatarColor(Map<String, dynamic> client) {
    final colorStr = client['avatarColor'] as String?;
    if (colorStr != null && colorStr.startsWith('#')) {
      try {
        return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    return AppColors.secondary;
  }

  String _formatIndustry(dynamic industry) {
    if (industry == null) return '-';
    final str = industry.toString();
    return str.split('_').map((w) {
      if (w.isEmpty) return w;
      return w[0].toUpperCase() + w.substring(1);
    }).join(' ');
  }
}

// ---------------------------------------------------------------------------
// Shared widgets
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
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
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
          ? AppColors.secondary.withValues(alpha: 0.15)
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
              color: isSelected ? AppColors.secondary : AppColors.borderDark,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color:
                  isSelected ? AppColors.secondary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Create Client Dialog (existing)
// ---------------------------------------------------------------------------

class _CreateClientDialog extends StatefulWidget {
  final VoidCallback onCreated;
  const _CreateClientDialog({required this.onCreated});

  @override
  State<_CreateClientDialog> createState() => _CreateClientDialogState();
}

class _CreateClientDialogState extends State<_CreateClientDialog> {
  final _formKey = GlobalKey<FormState>();
  final _clientIdController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _companyRegController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _billingAddressController = TextEditingController();
  final _avatarColorController = TextEditingController();
  final _budgetThresholdController = TextEditingController(text: '0.2');
  String _selectedIndustry = 'retail';
  String? _selectedAccountTypeId;
  List<Map<String, dynamic>> _accountTypes = [];
  bool _isLoading = false;
  bool _isRewardSponsor = false;
  bool _isPinned = false;
  bool _isFeatured = false;

  // Logo upload state
  String? _pickedLogoName;
  Uint8List? _pickedLogoBytes;
  double _uploadProgress = 0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadAccountTypes();
  }

  Future<void> _loadAccountTypes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('accountTypes')
          .where('isActive', isEqualTo: true)
          .get();
      if (mounted) {
        setState(() {
          _accountTypes = snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList();
        });
      }
    } catch (_) {
      // Non-critical — dropdown just stays empty
    }
  }

  @override
  void dispose() {
    _clientIdController.dispose();
    _companyNameController.dispose();
    _displayNameController.dispose();
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _companyRegController.dispose();
    _vatNumberController.dispose();
    _billingAddressController.dispose();
    _avatarColorController.dispose();
    _budgetThresholdController.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _pickedLogoName = result.files.single.name;
          _pickedLogoBytes = result.files.single.bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<String> _uploadLogoToStorage(String clientId) async {
    final resized = resizeImageForUpload(
      _pickedLogoBytes!,
      ImageResizeTarget.clientLogo,
    );
    if (resized == null) throw Exception('Failed to process image');

    final ref = FirebaseStorage.instance
        .ref()
        .child('client_logos')
        .child('$clientId.${resized.extension}');

    final uploadTask = ref.putData(
      resized.bytes,
      SettableMetadata(contentType: resized.contentType),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _isUploading = _pickedLogoBytes != null;
    });
    try {
      final clientId = _clientIdController.text.trim();

      // Upload logo if picked
      String? avatarImage;
      if (_pickedLogoBytes != null) {
        avatarImage = await _uploadLogoToStorage(clientId);
      }
      setState(() => _isUploading = false);

      await FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('adminCreateClient').call({
        'clientId': clientId,
        'companyName': _companyNameController.text.trim(),
        'contactName': _contactNameController.text.trim(),
        'contactEmail': _contactEmailController.text.trim(),
        'industry': _selectedIndustry,
        if (_displayNameController.text.trim().isNotEmpty)
          'displayName': _displayNameController.text.trim(),
        if (_companyRegController.text.trim().isNotEmpty)
          'companyRegistration': _companyRegController.text.trim(),
        if (_vatNumberController.text.trim().isNotEmpty)
          'vatNumber': _vatNumberController.text.trim(),
        if (_billingAddressController.text.trim().isNotEmpty)
          'billingAddress': _billingAddressController.text.trim(),
        if (_avatarColorController.text.trim().isNotEmpty)
          'avatarColor': _avatarColorController.text.trim(),
        if (_budgetThresholdController.text.trim().isNotEmpty)
          'budgetWarningThreshold':
              double.tryParse(_budgetThresholdController.text.trim()),
        if (_selectedAccountTypeId != null)
          'brandAccountTypeId': _selectedAccountTypeId,
        if (avatarImage != null) 'avatarImage': avatarImage,
        'isRewardSponsor': _isRewardSponsor,
        'isPinned': _isPinned,
        'isFeatured': _isFeatured,
      });
      if (mounted) {
        Navigator.of(context).pop();
        widget.onCreated();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Client created successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating client: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() {
          _isLoading = false;
          _isUploading = false;
        });
      }
    }
  }

  Widget _buildLogoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderDark),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client Logo',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Preview
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: _pickedLogoBytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.memory(
                          _pickedLogoBytes!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.business,
                        color: AppColors.textSecondary,
                        size: 28,
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_pickedLogoName != null) ...[
                      Text(
                        _pickedLogoName!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimaryDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (_isUploading)
                        LinearProgressIndicator(
                          value: _uploadProgress,
                          backgroundColor: AppColors.borderDark,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.secondary),
                        ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: _isLoading ? null : _pickLogo,
                          icon: const Icon(Icons.upload_file, size: 18),
                          label: Text(
                              _pickedLogoBytes != null ? 'Change' : 'Upload'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 36),
                          ),
                        ),
                        if (_pickedLogoBytes != null) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            color: AppColors.textSecondary,
                            onPressed: _isLoading
                                ? null
                                : () => setState(() {
                                      _pickedLogoName = null;
                                      _pickedLogoBytes = null;
                                      _uploadProgress = 0;
                                    }),
                            tooltip: 'Remove',
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: const Text(
        'Onboard New Client',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo upload
                _buildLogoSection(),
                const SizedBox(height: 24),
                Text(
                  'Company Information',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _clientIdController,
                  decoration: const InputDecoration(
                    labelText: 'Client ID',
                    hintText: 'e.g., cocacola_sa, mtn_brands',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Client ID is required';
                    }
                    if (!RegExp(r'^[a-z0-9_]+$').hasMatch(value)) {
                      return 'Use lowercase letters, numbers, and underscores only';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    hintText: 'e.g., Coca-Cola South Africa',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Company name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name (optional)',
                    hintText: 'Shown to users (defaults to Company Name)',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedIndustry,
                  decoration: const InputDecoration(labelText: 'Industry'),
                  items: _industries
                      .map((i) =>
                          DropdownMenuItem(value: i.$1, child: Text(i.$2)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedIndustry = v);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _companyRegController,
                        decoration: const InputDecoration(
                          labelText: 'Company Reg. (optional)',
                          hintText: 'e.g., 2000/000001/07',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _vatNumberController,
                        decoration: const InputDecoration(
                          labelText: 'VAT Number (optional)',
                          hintText: 'e.g., 4000000000',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _billingAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Billing Address (optional)',
                    hintText: 'e.g., 123 Main St, Johannesburg, 2000',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                Text(
                  'Primary Contact',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _contactNameController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Name',
                    hintText: 'e.g., John Smith',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Email',
                    hintText: 'e.g., john@company.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Branding & Configuration',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _avatarColorController,
                        decoration: const InputDecoration(
                          labelText: 'Brand Color (optional)',
                          hintText: '#FF5722',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _budgetThresholdController,
                        decoration: const InputDecoration(
                          labelText: 'Budget Warning %',
                          hintText: '0.2 = 20%',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                if (_accountTypes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedAccountTypeId,
                    decoration: const InputDecoration(
                      labelText: 'Brand Wallet Type (optional)',
                      hintText: 'Select account type',
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('None (default)'),
                      ),
                      ..._accountTypes.map((at) => DropdownMenuItem<String>(
                            value: at['id'] as String,
                            child: Text(
                              '${at['name']}${at['isRestricted'] == true ? ' (restricted)' : ''}',
                            ),
                          )),
                    ],
                    onChanged: (v) =>
                        setState(() => _selectedAccountTypeId = v),
                  ),
                ],
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Reward Sponsor'),
                  subtitle: const Text(
                    'Enable to allow linking reward campaigns to this client',
                  ),
                  value: _isRewardSponsor,
                  onChanged: (v) => setState(() => _isRewardSponsor = v),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(),
                const Text('Inbox Display',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    )),
                const SizedBox(height: 4),
                SwitchListTile(
                  title: const Text('Pinned'),
                  subtitle: const Text(
                    'Pin this client to the top of the earn inbox',
                  ),
                  value: _isPinned,
                  onChanged: (v) => setState(() => _isPinned = v),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  title: const Text('Featured'),
                  subtitle: const Text(
                    'Highlight this client as featured in the earn inbox',
                  ),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleCreate,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
          child: _isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    if (_isUploading) ...[
                      const SizedBox(width: 8),
                      Text(
                          'Uploading ${(_uploadProgress * 100).toInt()}%'),
                    ],
                  ],
                )
              : const Text('Create Client'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Edit Client Dialog → adminUpdateClient
// ---------------------------------------------------------------------------

class _EditClientDialog extends StatefulWidget {
  final Map<String, dynamic> client;
  final VoidCallback onUpdated;
  const _EditClientDialog({required this.client, required this.onUpdated});

  @override
  State<_EditClientDialog> createState() => _EditClientDialogState();
}

class _EditClientDialogState extends State<_EditClientDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _companyNameController;
  late final TextEditingController _displayNameController;
  late final TextEditingController _contactNameController;
  late final TextEditingController _contactEmailController;
  late final TextEditingController _companyRegController;
  late final TextEditingController _vatNumberController;
  late final TextEditingController _billingAddressController;
  late final TextEditingController _avatarColorController;
  late final TextEditingController _budgetThresholdController;
  late String _selectedIndustry;
  String? _selectedAccountTypeId;
  List<Map<String, dynamic>> _accountTypes = [];
  bool _isLoading = false;
  late bool _isRewardSponsor;
  late bool _isPinned;
  late bool _isFeatured;

  // Logo upload state
  String? _existingLogoUrl;
  String? _pickedLogoName;
  Uint8List? _pickedLogoBytes;
  double _uploadProgress = 0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadAccountTypes();
    final c = widget.client;
    _companyNameController =
        TextEditingController(text: c['companyName']?.toString() ?? '');
    _displayNameController =
        TextEditingController(text: c['displayName']?.toString() ?? '');
    _contactNameController =
        TextEditingController(text: c['contactName']?.toString() ?? '');
    _contactEmailController =
        TextEditingController(text: c['contactEmail']?.toString() ?? '');
    _companyRegController = TextEditingController(
        text: c['companyRegistration']?.toString() ?? '');
    _vatNumberController =
        TextEditingController(text: c['vatNumber']?.toString() ?? '');
    _billingAddressController =
        TextEditingController(text: c['billingAddress']?.toString() ?? '');
    _avatarColorController =
        TextEditingController(text: c['avatarColor']?.toString() ?? '');
    _budgetThresholdController = TextEditingController(
        text: c['budgetWarningThreshold']?.toString() ?? '0.2');
    final rawIndustry = c['industry']?.toString() ?? 'other';
    _selectedIndustry = _industries.any((i) => i.$1 == rawIndustry)
        ? rawIndustry
        : 'other';
    _selectedAccountTypeId = c['brandAccountTypeId']?.toString();
    _isRewardSponsor = c['isRewardSponsor'] == true;
    _isPinned = c['isPinned'] == true;
    _isFeatured = c['isFeatured'] == true;
    _existingLogoUrl = c['avatarImage']?.toString();
  }

  Future<void> _loadAccountTypes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('accountTypes')
          .where('isActive', isEqualTo: true)
          .get();
      if (mounted) {
        setState(() {
          _accountTypes = snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList();
        });
      }
    } catch (_) {
      // Non-critical — dropdown just stays empty
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _displayNameController.dispose();
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _companyRegController.dispose();
    _vatNumberController.dispose();
    _billingAddressController.dispose();
    _avatarColorController.dispose();
    _budgetThresholdController.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _pickedLogoName = result.files.single.name;
          _pickedLogoBytes = result.files.single.bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<String> _uploadLogoToStorage() async {
    final clientId = widget.client['id'] as String;
    final resized = resizeImageForUpload(
      _pickedLogoBytes!,
      ImageResizeTarget.clientLogo,
    );
    if (resized == null) throw Exception('Failed to process image');

    final ref = FirebaseStorage.instance
        .ref()
        .child('client_logos')
        .child('$clientId.${resized.extension}');

    final uploadTask = ref.putData(
      resized.bytes,
      SettableMetadata(contentType: resized.contentType),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _isUploading = _pickedLogoBytes != null;
    });
    try {
      // Upload new logo if picked
      String? avatarImage;
      if (_pickedLogoBytes != null) {
        avatarImage = await _uploadLogoToStorage();
      }
      setState(() => _isUploading = false);

      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUpdateClient')
          .call({
        'clientId': widget.client['id'],
        'updates': {
          'companyName': _companyNameController.text.trim(),
          'displayName': _displayNameController.text.trim(),
          'contactName': _contactNameController.text.trim(),
          'contactEmail': _contactEmailController.text.trim(),
          'industry': _selectedIndustry,
          if (_companyRegController.text.trim().isNotEmpty)
            'companyRegistration': _companyRegController.text.trim(),
          if (_vatNumberController.text.trim().isNotEmpty)
            'vatNumber': _vatNumberController.text.trim(),
          if (_billingAddressController.text.trim().isNotEmpty)
            'billingAddress': _billingAddressController.text.trim(),
          if (_avatarColorController.text.trim().isNotEmpty)
            'avatarColor': _avatarColorController.text.trim(),
          if (_budgetThresholdController.text.trim().isNotEmpty)
            'budgetWarningThreshold':
                double.tryParse(_budgetThresholdController.text.trim()),
          if (_selectedAccountTypeId != null)
            'brandAccountTypeId': _selectedAccountTypeId,
          if (avatarImage != null) 'avatarImage': avatarImage,
          'isRewardSponsor': _isRewardSponsor,
          'isPinned': _isPinned,
          'isFeatured': _isFeatured,
        },
      });
      if (mounted) {
        Navigator.of(context).pop();
        widget.onUpdated();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Client updated successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating client: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() {
          _isLoading = false;
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: Text(
        'Edit: ${widget.client['companyName'] ?? 'Client'}',
        style: const TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Read-only ID
                Text(
                  'Client ID: ${widget.client['id']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Company Information',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _companyNameController,
                  decoration:
                      const InputDecoration(labelText: 'Company Name'),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                    hintText: 'Shown to users in the app',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedIndustry,
                  decoration: const InputDecoration(labelText: 'Industry'),
                  items: _industries
                      .map((i) =>
                          DropdownMenuItem(value: i.$1, child: Text(i.$2)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedIndustry = v);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _companyRegController,
                        decoration: const InputDecoration(
                            labelText: 'Company Reg.'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _vatNumberController,
                        decoration:
                            const InputDecoration(labelText: 'VAT Number'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _billingAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Billing Address',
                    hintText: 'e.g., 123 Main St, Johannesburg, 2000',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                Text(
                  'Primary Contact',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _contactNameController,
                  decoration:
                      const InputDecoration(labelText: 'Contact Name'),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactEmailController,
                  decoration:
                      const InputDecoration(labelText: 'Contact Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Branding & Configuration',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                // Logo upload
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Client Logo',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Preview
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.borderDark),
                            ),
                            child: _pickedLogoBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.memory(
                                      _pickedLogoBytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : _existingLogoUrl != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7),
                                        child: Image.network(
                                          _existingLogoUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, _, _) => Icon(
                                            Icons.business,
                                            color: AppColors.textSecondary,
                                            size: 28,
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.business,
                                        color: AppColors.textSecondary,
                                        size: 28,
                                      ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_pickedLogoName != null) ...[
                                  Text(
                                    _pickedLogoName!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textPrimaryDark,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                ] else if (_existingLogoUrl != null) ...[
                                  Text(
                                    'Current logo',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                                if (_isUploading)
                                  LinearProgressIndicator(
                                    value: _uploadProgress,
                                    backgroundColor: AppColors.borderDark,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            AppColors.secondary),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed:
                                          _isLoading ? null : _pickLogo,
                                      icon: const Icon(Icons.upload_file,
                                          size: 18),
                                      label: Text(
                                          _pickedLogoBytes != null ||
                                                  _existingLogoUrl != null
                                              ? 'Change'
                                              : 'Upload'),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(0, 36),
                                      ),
                                    ),
                                    if (_pickedLogoBytes != null) ...[
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.close, size: 18),
                                        color: AppColors.textSecondary,
                                        onPressed: _isLoading
                                            ? null
                                            : () => setState(() {
                                                  _pickedLogoName = null;
                                                  _pickedLogoBytes = null;
                                                  _uploadProgress = 0;
                                                }),
                                        tooltip: 'Remove new logo',
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _avatarColorController,
                        decoration: const InputDecoration(
                          labelText: 'Fallback Color',
                          hintText: '#FF5722',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _budgetThresholdController,
                        decoration: const InputDecoration(
                          labelText: 'Budget Warning %',
                          hintText: '0.2 = 20%',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                if (_accountTypes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedAccountTypeId,
                    decoration: const InputDecoration(
                      labelText: 'Brand Wallet Type',
                      hintText: 'Select account type',
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('None (default)'),
                      ),
                      ..._accountTypes.map((at) => DropdownMenuItem<String>(
                            value: at['id'] as String,
                            child: Text(
                              '${at['name']}${at['isRestricted'] == true ? ' (restricted)' : ''}',
                            ),
                          )),
                    ],
                    onChanged: (v) =>
                        setState(() => _selectedAccountTypeId = v),
                  ),
                ],
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Reward Sponsor'),
                  subtitle: const Text(
                    'Enable to allow linking reward campaigns to this client',
                  ),
                  value: _isRewardSponsor,
                  onChanged: (v) => setState(() => _isRewardSponsor = v),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(),
                const Text('Inbox Display',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    )),
                const SizedBox(height: 4),
                SwitchListTile(
                  title: const Text('Pinned'),
                  subtitle: const Text(
                    'Pin this client to the top of the earn inbox',
                  ),
                  value: _isPinned,
                  onChanged: (v) => setState(() => _isPinned = v),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  title: const Text('Featured'),
                  subtitle: const Text(
                    'Highlight this client as featured in the earn inbox',
                  ),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleUpdate,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
          child: _isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    if (_isUploading) ...[
                      const SizedBox(width: 8),
                      Text(
                          'Uploading ${(_uploadProgress * 100).toInt()}%'),
                    ],
                  ],
                )
              : const Text('Save Changes'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Toggle Status Dialog → adminUpdateClientStatus
// ---------------------------------------------------------------------------

class _ToggleStatusDialog extends StatefulWidget {
  final Map<String, dynamic> client;
  final VoidCallback onUpdated;
  const _ToggleStatusDialog({required this.client, required this.onUpdated});

  @override
  State<_ToggleStatusDialog> createState() => _ToggleStatusDialogState();
}

class _ToggleStatusDialogState extends State<_ToggleStatusDialog> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  bool _isLoading = false;

  bool get _isActive =>
      widget.client['isActive'] == true || widget.client['status'] == 'active';

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _handleToggle() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUpdateClientStatus')
          .call({
        'clientId': widget.client['id'],
        'action': _isActive ? 'freeze' : 'unfreeze',
        'reason': _reasonController.text.trim(),
      });
      if (mounted) {
        Navigator.of(context).pop();
        widget.onUpdated();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isActive
                  ? 'Client frozen successfully'
                  : 'Client activated successfully',
            ),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: Text(
        _isActive ? 'Freeze Client' : 'Activate Client',
        style: const TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isActive
                    ? 'Freezing "${widget.client['companyName']}" will prevent all earn activity and token disbursements for this client.'
                    : 'Activating "${widget.client['companyName']}" will re-enable earn activity and token disbursements.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  hintText: _isActive
                      ? 'e.g., Unpaid invoice, contract expired'
                      : 'e.g., Payment received, contract renewed',
                ),
                maxLines: 2,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Reason is required' : null,
              ),
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
          onPressed: _isLoading ? null : _handleToggle,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isActive ? AppColors.warning : AppColors.success,
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(_isActive ? 'Freeze' : 'Activate'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-Accounts Dialog → adminListClientSubAccounts + create + fund
// ---------------------------------------------------------------------------

class _SubAccountsDialog extends StatefulWidget {
  final String clientId;
  final String clientName;
  const _SubAccountsDialog(
      {required this.clientId, required this.clientName});

  @override
  State<_SubAccountsDialog> createState() => _SubAccountsDialogState();
}

class _SubAccountsDialogState extends State<_SubAccountsDialog> {
  List<Map<String, dynamic>> _subAccounts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubAccounts();
  }

  Future<void> _loadSubAccounts() async {
    setState(() => _isLoading = true);
    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminListClientSubAccounts')
          .call({'clientId': widget.clientId});
      final list = (result.data['subAccounts'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];
      if (mounted) setState(() { _subAccounts = list; _isLoading = false; });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading sub-accounts: $e')),
        );
      }
    }
  }

  void _showCreateSubAccountDialog() {
    final nameCtrl = TextEditingController();
    final budgetCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    var saving = false;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: const Text('Create Sub-Account',
                style: TextStyle(color: AppColors.textPrimaryDark)),
            content: SizedBox(
              width: 400,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Sub-Account Name'),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: budgetCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Initial Budget (tokens)',
                        hintText: 'e.g., 5000',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        final n = int.tryParse(v);
                        if (n == null || n <= 0) return 'Must be > 0';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: saving ? null : () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: saving
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        setInnerState(() => saving = true);
                        try {
                          await FirebaseFunctions.instanceFor(region: 'africa-south1')
                              .httpsCallable('adminCreateClientSubAccount')
                              .call({
                            'clientId': widget.clientId,
                            'name': nameCtrl.text.trim(),
                            'initialBudget':
                                int.parse(budgetCtrl.text.trim()),
                          });
                          if (ctx.mounted) {
                            Navigator.of(ctx).pop();
                            _loadSubAccounts();
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Sub-account created'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          }
                        } catch (e) {
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            setInnerState(() => saving = false);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary),
                child: saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFundSubAccountDialog(Map<String, dynamic> sa) {
    final amountCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text('Fund: ${sa['name'] ?? 'Sub-Account'}',
                style: const TextStyle(color: AppColors.textPrimaryDark)),
            content: SizedBox(
              width: 400,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Current balance: ${(sa['balance'] as num?)?.toInt() ?? 0} tokens',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: amountCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Amount to add (tokens)',
                        hintText: 'e.g., 10000',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        final n = int.tryParse(v);
                        if (n == null || n <= 0) return 'Must be > 0';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: saving ? null : () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: saving
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        setInnerState(() => saving = true);
                        try {
                          await FirebaseFunctions.instanceFor(region: 'africa-south1')
                              .httpsCallable('adminFundClientSubAccount')
                              .call({
                            'clientId': widget.clientId,
                            'subAccountId': sa['id'],
                            'amount': int.parse(amountCtrl.text.trim()),
                          });
                          if (ctx.mounted) {
                            Navigator.of(ctx).pop();
                            _loadSubAccounts();
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Sub-account funded successfully'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          }
                        } catch (e) {
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            setInnerState(() => saving = false);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary),
                child: saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Fund'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: Text(
        'Sub-Accounts: ${widget.clientName}',
        style: const TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 600,
        height: 400,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_subAccounts.length} sub-account(s)',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      ElevatedButton.icon(
                        onPressed: _showCreateSubAccountDialog,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add Sub-Account'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          minimumSize: const Size(0, 36),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  // Sub-account list
                  Expanded(
                    child: _subAccounts.isEmpty
                        ? Center(
                            child: Text(
                              'No sub-accounts yet',
                              style:
                                  TextStyle(color: AppColors.textSecondary),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _subAccounts.length,
                            itemBuilder: (_, i) =>
                                _buildSubAccountRow(_subAccounts[i]),
                          ),
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildSubAccountRow(Map<String, dynamic> sa) {
    final balance = (sa['balance'] as num?)?.toInt() ?? 0;
    final initialBudget = (sa['initialBudget'] as num?)?.toInt() ?? 0;
    final remaining =
        (sa['remainingPercent'] as num?)?.toDouble() ?? 0.0;
    final isActive = sa['isActive'] == true;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderDark, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Name
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sa['name'] ?? 'Unnamed',
                  style: const TextStyle(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  sa['id'] ?? '',
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Balance
          Expanded(
            flex: 1,
            child: Text(
              '$balance / $initialBudget',
              style: const TextStyle(
                color: AppColors.textPrimaryDark,
                fontSize: 13,
              ),
            ),
          ),
          // Progress
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: remaining.clamp(0.0, 1.0),
                    backgroundColor: AppColors.borderDark,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      remaining > 0.2
                          ? AppColors.success
                          : AppColors.warning,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(remaining * 100).toStringAsFixed(0)}%',
                  style:
                      TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          // Status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.success.withValues(alpha: 0.15)
                    : AppColors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isActive ? 'Active' : 'Depleted',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.success : AppColors.error,
                ),
              ),
            ),
          ),
          // Fund button
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, size: 18),
            color: AppColors.secondary,
            tooltip: 'Fund sub-account',
            onPressed: () => _showFundSubAccountDialog(sa),
          ),
        ],
      ),
    );
  }
}
