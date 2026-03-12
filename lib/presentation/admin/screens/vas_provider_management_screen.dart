import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/purchase.dart';
import '../../theme/app_colors.dart';

/// Admin screen for managing VAS (Value Added Services) providers.
///
/// Phase 6.1 — Route: `/buy-vas-providers`
/// Features: list with category filter, CRUD, toggle, delete, seed defaults,
/// navigate to product management.
class VasProviderManagementScreen extends StatefulWidget {
  const VasProviderManagementScreen({super.key});

  @override
  State<VasProviderManagementScreen> createState() =>
      _VasProviderManagementScreenState();
}

class _VasProviderManagementScreenState
    extends State<VasProviderManagementScreen> {
  bool _isLoading = false;
  bool _isSeeding = false;
  List<Map<String, dynamic>> _providers = [];
  PurchaseCategory? _selectedCategory;
  final _searchController = TextEditingController();

  final _functions =
      FirebaseFunctions.instanceFor(region: 'africa-south1');

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProviders() async {
    setState(() => _isLoading = true);
    try {
      final result = await _functions.httpsCallable('adminListVasProviders')
          .call({
        if (_selectedCategory != null)
          'category': _selectedCategory!.name,
        'includeInactive': true,
      });
      final list = (result.data['providers'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      if (mounted) {
        setState(() {
          _providers = list;
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

  List<Map<String, dynamic>> get _filteredProviders {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _providers;
    return _providers.where((p) {
      final name = (p['name'] as String? ?? '').toLowerCase();
      final code = (p['code'] as String? ?? '').toLowerCase();
      return name.contains(query) || code.contains(query);
    }).toList();
  }

  int get _activeCount =>
      _providers.where((p) => p['isActive'] == true).length;
  int get _inactiveCount =>
      _providers.where((p) => p['isActive'] != true).length;

  Map<String, int> get _categoryCounts {
    final counts = <String, int>{};
    for (final p in _providers) {
      final cat = p['category'] as String? ?? 'other';
      counts[cat] = (counts[cat] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProviders;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildStatsRow(),
                  const SizedBox(height: 24),
                  _buildFilters(),
                  const SizedBox(height: 24),
                  _buildTable(filtered),
                ],
              ),
            ),
    );
  }

  // ─── Header ──────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('VAS Providers',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Manage service providers (airtime, data, electricity, vouchers)',
                style: TextStyle(
                    fontSize: 14, color: AppColors.textSecondary)),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _isSeeding ? null : _seedDefaults,
              icon: _isSeeding
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_fix_high, size: 18),
              label: const Text('Seed Defaults'),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadProviders,
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () => _showCreateEditDialog(null),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Provider'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 40),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Stats Row ──────────────────────────────────────

  Widget _buildStatsRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _StatCard(
          title: 'Total',
          value: '${_providers.length}',
          icon: Icons.electrical_services,
          color: AppColors.secondary,
        ),
        _StatCard(
          title: 'Active',
          value: '$_activeCount',
          icon: Icons.check_circle,
          color: AppColors.success,
        ),
        _StatCard(
          title: 'Inactive',
          value: '$_inactiveCount',
          icon: Icons.cancel,
          color: AppColors.error,
        ),
        ..._categoryCounts.entries.map((e) => _StatCard(
              title: _categoryLabel(e.key),
              value: '${e.value}',
              icon: _categoryIcon(e.key),
              color: AppColors.primary,
            )),
      ],
    );
  }

  // ─── Filters ────────────────────────────────────────

  Widget _buildFilters() {
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
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search by name or code...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 200,
            child: DropdownButtonFormField<PurchaseCategory?>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 12),
              ),
              items: [
                const DropdownMenuItem<PurchaseCategory?>(
                  value: null,
                  child: Text('All'),
                ),
                ...PurchaseCategory.values.map((c) =>
                    DropdownMenuItem(
                      value: c,
                      child: Text(_categoryLabel(c.name)),
                    )),
              ],
              onChanged: (value) {
                setState(() => _selectedCategory = value);
                _loadProviders();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─── Table ──────────────────────────────────────────

  Widget _buildTable(List<Map<String, dynamic>> providers) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Table header
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                _headerCell('Name', flex: 2),
                _headerCell('Code', flex: 1),
                _headerCell('Category', flex: 1),
                _headerCell('Products', flex: 1),
                _headerCell('Sort', flex: 1),
                _headerCell('Status', flex: 1),
                _headerCell('Actions', flex: 2),
              ],
            ),
          ),
          const Divider(height: 1),
          if (providers.isEmpty)
            Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                children: [
                  Icon(Icons.electrical_services,
                      size: 48, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    'No providers found.\nUse "Seed Defaults" or "Add Provider" to get started.',
                    style: TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...providers.map(_buildRow),
        ],
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> provider) {
    final isActive = provider['isActive'] == true;
    final productCount = provider['productCount'] ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          // Name + logo
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (provider['logoUrl'] != null &&
                    (provider['logoUrl'] as String).isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      provider['logoUrl'] as String,
                      width: 24,
                      height: 24,
                      errorBuilder: (_, _, _) =>
                          _buildInitials(provider['name'] as String? ?? ''),
                    ),
                  )
                else
                  _buildInitials(provider['name'] as String? ?? ''),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider['name'] as String? ?? '—',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      if (provider['description'] != null)
                        Text(
                          provider['description'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11, color: AppColors.textTertiary),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Code
          Expanded(
            flex: 1,
            child: Text(
              provider['code'] as String? ?? '—',
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: AppColors.textSecondary),
            ),
          ),
          // Category
          Expanded(
            flex: 1,
            child: _CategoryChip(
                label: _categoryLabel(provider['category'] as String? ?? '')),
          ),
          // Products count
          Expanded(
            flex: 1,
            child: Text('$productCount',
                style: const TextStyle(fontSize: 13)),
          ),
          // Sort order
          Expanded(
            flex: 1,
            child: Text('${provider['sortOrder'] ?? 0}',
                style: const TextStyle(fontSize: 13)),
          ),
          // Status
          Expanded(
            flex: 1,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isActive ? AppColors.success : AppColors.error)
                    .withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isActive ? 'Active' : 'Inactive',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.success : AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Actions
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.inventory_2, size: 18),
                  color: AppColors.primary,
                  onPressed: () => context.push(
                      '/buy-vas-products?providerId=${provider['id']}'),
                  tooltip: 'View products',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  color: AppColors.textSecondary,
                  onPressed: () => _showCreateEditDialog(provider),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: Icon(
                    isActive
                        ? Icons.toggle_off_outlined
                        : Icons.toggle_on_outlined,
                    size: 20,
                  ),
                  color: isActive ? AppColors.warning : AppColors.success,
                  onPressed: () => _toggleProvider(provider),
                  tooltip: isActive ? 'Deactivate' : 'Activate',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  color: AppColors.error,
                  onPressed: () => _deleteProvider(provider),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitials(String name) {
    String initials = '??';
    if (name.isNotEmpty) {
      final words = name.split(' ');
      if (words.length >= 2) {
        initials = '${words[0][0]}${words[1][0]}'.toUpperCase();
      } else {
        initials =
            name.substring(0, name.length.clamp(0, 2)).toUpperCase();
      }
    }
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(initials,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
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

  // ─── Actions ────────────────────────────────────────

  Future<void> _toggleProvider(Map<String, dynamic> provider) async {
    final id = provider['id'] as String;
    final isActive = provider['isActive'] == true;
    try {
      await _functions.httpsCallable('adminToggleVasProvider')
          .call({'providerId': id});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Provider ${isActive ? 'deactivated' : 'activated'}')),
        );
        _loadProviders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _deleteProvider(Map<String, dynamic> provider) async {
    final id = provider['id'] as String;
    final name = provider['name'] as String? ?? 'this provider';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Delete Provider', style: TextStyle(fontSize: 16)),
        content: Text(
          'Are you sure you want to delete "$name"? This will soft-delete the provider (set inactive and deleted).',
          style: const TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await _functions.httpsCallable('adminDeleteVasProvider')
          .call({'providerId': id});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Provider deleted')),
        );
        _loadProviders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _seedDefaults() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title:
            const Text('Seed Default Providers', style: TextStyle(fontSize: 16)),
        content: const Text(
          'This will create 15 default South African service providers '
          '(Eskom, City Power, Tshwane, Vodacom, MTN, Cell C, Telkom, '
          '1ForYou, Blu Voucher, Flash, OTT, etc.).\n\n'
          'Existing providers with matching codes will be skipped.',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Seed'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _isSeeding = true);
    try {
      final result = await _functions
          .httpsCallable('adminSeedVasProviders')
          .call({});
      final created = result.data['createdCount'] ?? 0;
      final skipped = result.data['skippedCount'] ?? 0;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Seeded: $created created, $skipped skipped')),
        );
        _loadProviders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seed error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSeeding = false);
    }
  }

  // ─── Create / Edit Dialog ──────────────────────────

  void _showCreateEditDialog(Map<String, dynamic>? existing) {
    final isEdit = existing != null;
    final nameCtrl = TextEditingController(text: existing?['name'] as String? ?? '');
    final codeCtrl = TextEditingController(text: existing?['code'] as String? ?? '');
    final logoCtrl =
        TextEditingController(text: existing?['logoUrl'] as String? ?? '');
    final descCtrl =
        TextEditingController(text: existing?['description'] as String? ?? '');
    final sortCtrl = TextEditingController(
        text: '${existing?['sortOrder'] ?? 0}');
    var selectedCategory = existing?['category'] as String? ?? 'airtime';
    var isActive = existing?['isActive'] as bool? ?? true;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text(
              isEdit ? 'Edit Provider' : 'Add Provider',
              style: const TextStyle(fontSize: 16),
            ),
            content: SizedBox(
              width: 500,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Name *'),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Required'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: codeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Code *',
                          hintText: 'e.g., vodacom, eskom',
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Required';
                          }
                          if (!RegExp(r'^[a-z0-9_-]+$').hasMatch(v)) {
                            return 'Lowercase, numbers, hyphens, underscores only';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        decoration:
                            const InputDecoration(labelText: 'Category *'),
                        items: PurchaseCategory.values
                            .map((c) => DropdownMenuItem(
                                  value: c.name,
                                  child: Text(_categoryLabel(c.name)),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setDialogState(
                                () => selectedCategory = v);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: logoCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Logo URL'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: sortCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Sort Order'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: const Text('Active'),
                        value: isActive,
                        onChanged: (v) =>
                            setDialogState(() => isActive = v),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  nameCtrl.dispose();
                  codeCtrl.dispose();
                  logoCtrl.dispose();
                  descCtrl.dispose();
                  sortCtrl.dispose();
                  Navigator.of(ctx).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final data = {
                    'name': nameCtrl.text.trim(),
                    'code': codeCtrl.text.trim(),
                    'category': selectedCategory,
                    if (logoCtrl.text.trim().isNotEmpty)
                      'logoUrl': logoCtrl.text.trim(),
                    if (descCtrl.text.trim().isNotEmpty)
                      'description': descCtrl.text.trim(),
                    'sortOrder': int.tryParse(sortCtrl.text) ?? 0,
                  };

                  try {
                    if (isEdit) {
                      data['providerId'] = existing['id'] as String;
                      await _functions
                          .httpsCallable('adminUpdateVasProvider')
                          .call(data);
                    } else {
                      await _functions
                          .httpsCallable('adminCreateVasProvider')
                          .call(data);
                    }
                    nameCtrl.dispose();
                    codeCtrl.dispose();
                    logoCtrl.dispose();
                    descCtrl.dispose();
                    sortCtrl.dispose();
                    if (ctx.mounted) Navigator.of(ctx).pop();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(isEdit
                                ? 'Provider updated'
                                : 'Provider created')),
                      );
                      _loadProviders();
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: Text(isEdit ? 'Save' : 'Create'),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────

  String _categoryLabel(String category) {
    switch (category) {
      case 'airtime':
        return 'Airtime';
      case 'data':
        return 'Data';
      case 'electricity':
        return 'Electricity';
      case 'voucher':
        return 'Vouchers';
      case 'marketplace':
        return 'Marketplace';
      case 'school':
        return 'School';
      case 'municipal':
        return 'Municipal';
      case 'insurance':
        return 'Insurance';
      case 'funeral':
        return 'Funeral';
      case 'stokvel':
        return 'Stokvel';
      case 'gaming':
        return 'Gaming';
      case 'other':
        return 'Other';
      default:
        return category;
    }
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'airtime':
        return Icons.phone_android;
      case 'data':
        return Icons.wifi;
      case 'electricity':
        return Icons.bolt;
      case 'voucher':
        return Icons.card_giftcard;
      case 'marketplace':
        return Icons.storefront;
      case 'school':
        return Icons.school;
      case 'municipal':
        return Icons.account_balance;
      case 'insurance':
        return Icons.shield;
      case 'funeral':
        return Icons.sentiment_very_dissatisfied;
      case 'stokvel':
        return Icons.groups;
      case 'gaming':
        return Icons.sports_esports;
      default:
        return Icons.category;
    }
  }
}

// ─── Private Widgets ──────────────────────────────────

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
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
