import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing account types and their rules.
///
/// Account types define restrictions for brand sub-accounts (P2P, cashout,
/// offramps, expiry). Changes to rules take effect immediately for all
/// future operations.
class AccountTypeManagementScreen extends StatefulWidget {
  const AccountTypeManagementScreen({super.key});

  @override
  State<AccountTypeManagementScreen> createState() =>
      _AccountTypeManagementScreenState();
}

class _AccountTypeManagementScreenState
    extends State<AccountTypeManagementScreen> {
  final _searchController = TextEditingController();
  final _functions =
      FirebaseFunctions.instanceFor(region: 'africa-south1');
  String _selectedFilter = 'all';
  bool _isLoading = false;
  List<Map<String, dynamic>> _accountTypes = [];

  @override
  void initState() {
    super.initState();
    _loadAccountTypes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAccountTypes() async {
    setState(() => _isLoading = true);
    try {
      final result = await _functions
          .httpsCallable('adminListAccountTypes')
          .call<Map<String, dynamic>>({'includeInactive': true});
      final list = (result.data['accountTypes'] as List?)
              ?.map((item) => Map<String, dynamic>.from(item as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _accountTypes = list);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading account types: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> get _filteredAccountTypes {
    final query = _searchController.text.toLowerCase();
    return _accountTypes.where((at) {
      if (_selectedFilter == 'active' && at['isActive'] != true) return false;
      if (_selectedFilter == 'inactive' && at['isActive'] != false) return false;
      if (_selectedFilter == 'restricted' && at['isRestricted'] != true) {
        return false;
      }
      if (query.isNotEmpty) {
        final name = (at['name'] as String? ?? '').toLowerCase();
        final id = (at['id'] as String? ?? '').toLowerCase();
        final advertiser =
            (at['advertiserName'] as String? ?? '').toLowerCase();
        if (!name.contains(query) &&
            !id.contains(query) &&
            !advertiser.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  int get _activeCount =>
      _accountTypes.where((at) => at['isActive'] == true).length;
  int get _inactiveCount =>
      _accountTypes.where((at) => at['isActive'] == false).length;
  int get _restrictedCount =>
      _accountTypes.where((at) => at['isRestricted'] == true).length;

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => _AccountTypeFormDialog(
        onSaved: _loadAccountTypes,
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> accountType) {
    showDialog(
      context: context,
      builder: (context) => _AccountTypeFormDialog(
        accountType: accountType,
        onSaved: _loadAccountTypes,
      ),
    );
  }

  Future<void> _deactivate(Map<String, dynamic> accountType) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Deactivate Account Type',
            style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Text(
          'Deactivate "${accountType['name']}"?\n\n'
          'Existing sub-accounts will continue to work with their current rules.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await _functions
          .httpsCallable('adminDeactivateAccountType')
          .call({'accountTypeId': accountType['id']});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account type deactivated'),
            backgroundColor: AppColors.success,
          ),
        );
      }
      _loadAccountTypes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _reactivate(Map<String, dynamic> accountType) async {
    try {
      await _functions
          .httpsCallable('adminUpdateAccountType')
          .call({
        'accountTypeId': accountType['id'],
        'updates': {'isActive': true},
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account type reactivated'),
            backgroundColor: AppColors.success,
          ),
        );
      }
      _loadAccountTypes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredAccountTypes;

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
                      'Account Types',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage sub-account type definitions and their rules',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _showCreateDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Account Type'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(0, 40),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Stats
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _StatCard(
                  title: 'Total',
                  value: '${_accountTypes.length}',
                  icon: Icons.rule,
                  color: AppColors.primary,
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
                  icon: Icons.pause_circle,
                  color: AppColors.warning,
                ),
                _StatCard(
                  title: 'Restricted',
                  value: '$_restrictedCount',
                  icon: Icons.lock,
                  color: AppColors.tertiary,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Search + filters
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
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(color: AppColors.textPrimaryDark),
                      decoration: InputDecoration(
                        hintText: 'Search by name, ID, or advertiser...',
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: AppColors.backgroundDark,
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
                    label: 'Active',
                    isSelected: _selectedFilter == 'active',
                    onTap: () => setState(() => _selectedFilter = 'active'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Inactive',
                    isSelected: _selectedFilter == 'inactive',
                    onTap: () => setState(() => _selectedFilter = 'inactive'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Restricted',
                    isSelected: _selectedFilter == 'restricted',
                    onTap: () =>
                        setState(() => _selectedFilter = 'restricted'),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.refresh,
                        color: AppColors.textSecondary),
                    onPressed: _loadAccountTypes,
                    tooltip: 'Refresh',
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
                  // Table header
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('Account Type',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                        Expanded(
                          child: Text('Advertiser',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Rules',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                        Expanded(
                          child: Text('Expiry',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                        Expanded(
                          child: Text('Status',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text('Actions',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.dividerDark),

                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.all(48),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(48),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.rule_outlined,
                                size: 48, color: AppColors.textSecondary),
                            const SizedBox(height: 12),
                            Text(
                              _accountTypes.isEmpty
                                  ? 'No account types yet'
                                  : 'No matching account types',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...filtered.map((at) => _buildRow(at)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> at) {
    final rules = at['rules'] as Map<String, dynamic>? ?? {};
    final isActive = at['isActive'] == true;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // Name + ID
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      at['name'] as String? ?? '',
                      style: const TextStyle(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      at['id'] as String? ?? '',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),

              // Advertiser
              Expanded(
                child: Text(
                  at['advertiserName'] as String? ?? 'Platform',
                  style: TextStyle(
                    color: at['advertiserName'] != null
                        ? AppColors.textPrimaryDark
                        : AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),

              // Rules icons
              Expanded(
                flex: 2,
                child: Wrap(
                  spacing: 6,
                  children: [
                    _RuleIcon(
                      icon: Icons.send,
                      label: 'P2P Send',
                      enabled: rules['allowP2pSend'] != false,
                    ),
                    _RuleIcon(
                      icon: Icons.call_received,
                      label: 'P2P Receive',
                      enabled: rules['allowP2pReceive'] != false,
                    ),
                    _RuleIcon(
                      icon: Icons.arrow_upward,
                      label: 'Cashout',
                      enabled: rules['allowCashout'] != false,
                    ),
                    if (rules['p2pRestrictToSameAccountType'] == true)
                      _RuleIcon(
                        icon: Icons.lock_outline,
                        label: 'Same Type Only',
                        enabled: true,
                        color: AppColors.warning,
                      ),
                    if (at['isRestricted'] == true)
                      _RuleIcon(
                        icon: Icons.storefront,
                        label: 'Restricted Offramps',
                        enabled: true,
                        color: AppColors.tertiary,
                      ),
                  ],
                ),
              ),

              // Expiry
              Expanded(
                child: Text(
                  rules['expiryDays'] != null
                      ? '${rules['expiryDays']} days'
                      : 'None',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),

              // Status
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.success.withValues(alpha: 0.15)
                        : Colors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isActive ? 'Active' : 'Inactive',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isActive ? AppColors.success : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Actions
              SizedBox(
                width: 80,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      color: AppColors.textSecondary,
                      tooltip: 'Edit',
                      onPressed: () => _showEditDialog(at),
                    ),
                    IconButton(
                      icon: Icon(
                        isActive
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                        size: 18,
                      ),
                      color: isActive ? AppColors.warning : AppColors.success,
                      tooltip: isActive ? 'Deactivate' : 'Reactivate',
                      onPressed: () =>
                          isActive ? _deactivate(at) : _reactivate(at),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// CREATE / EDIT DIALOG
// ─────────────────────────────────────────────────────────────────────────────

class _AccountTypeFormDialog extends StatefulWidget {
  final Map<String, dynamic>? accountType;
  final VoidCallback onSaved;

  const _AccountTypeFormDialog({
    this.accountType,
    required this.onSaved,
  });

  @override
  State<_AccountTypeFormDialog> createState() => _AccountTypeFormDialogState();
}

class _AccountTypeFormDialogState extends State<_AccountTypeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _functions =
      FirebaseFunctions.instanceFor(region: 'africa-south1');

  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _iconUrlController;
  late final TextEditingController _offrampsController;
  late final TextEditingController _expiryDaysController;

  bool _allowP2pSend = true;
  bool _allowP2pReceive = true;
  bool _allowCashout = true;
  bool _p2pRestrictToSameAccountType = false;

  String? _selectedAdvertiserId;
  List<Map<String, dynamic>> _clients = [];
  bool _isSaving = false;
  bool _isLoadingClients = false;
  bool _clientLoadFailed = false;

  // Original values for edit-mode diff tracking
  late final String _origName;
  late final String _origDescription;
  late final String _origIconUrl;
  late final String _origOfframps;
  late final String _origExpiryDays;
  late final bool _origAllowP2pSend;
  late final bool _origAllowP2pReceive;
  late final bool _origAllowCashout;
  late final bool _origP2pRestrictToSameAccountType;

  bool get _isEditing => widget.accountType != null;

  @override
  void initState() {
    super.initState();
    final at = widget.accountType;
    final rules = at?['rules'] as Map<String, dynamic>? ?? {};

    _idController = TextEditingController(text: at?['id'] as String? ?? '');
    _nameController =
        TextEditingController(text: at?['name'] as String? ?? '');
    _descriptionController =
        TextEditingController(text: at?['description'] as String? ?? '');
    _iconUrlController =
        TextEditingController(text: at?['iconUrl'] as String? ?? '');

    final offramps = rules['allowedOfframps'] as List?;
    _offrampsController = TextEditingController(
      text: offramps != null ? offramps.join(', ') : '*',
    );

    _expiryDaysController = TextEditingController(
      text: rules['expiryDays'] != null ? '${rules['expiryDays']}' : '',
    );

    _allowP2pSend = rules['allowP2pSend'] != false;
    _allowP2pReceive = rules['allowP2pReceive'] != false;
    _allowCashout = rules['allowCashout'] != false;
    _p2pRestrictToSameAccountType =
        rules['p2pRestrictToSameAccountType'] == true;

    _selectedAdvertiserId = at?['advertiserId'] as String?;

    // Snapshot originals for edit-mode diff
    _origName = _nameController.text;
    _origDescription = _descriptionController.text;
    _origIconUrl = _iconUrlController.text;
    _origOfframps = _offrampsController.text;
    _origExpiryDays = _expiryDaysController.text;
    _origAllowP2pSend = _allowP2pSend;
    _origAllowP2pReceive = _allowP2pReceive;
    _origAllowCashout = _allowCashout;
    _origP2pRestrictToSameAccountType = _p2pRestrictToSameAccountType;

    _loadClients();
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _iconUrlController.dispose();
    _offrampsController.dispose();
    _expiryDaysController.dispose();
    super.dispose();
  }

  Future<void> _loadClients() async {
    setState(() => _isLoadingClients = true);
    try {
      final result = await _functions
          .httpsCallable('adminListClients')
          .call<Map<String, dynamic>>({});
      final list = (result.data['clients'] as List?)
              ?.map((c) => Map<String, dynamic>.from(c as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _clients = list);
    } catch (_) {
      if (mounted) setState(() => _clientLoadFailed = true);
    } finally {
      if (mounted) setState(() => _isLoadingClients = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final offrampsText = _offrampsController.text.trim();
      final offramps = offrampsText.isEmpty
          ? ['*']
          : offrampsText.split(',').map((s) => s.trim()).toList();

      final expiryText = _expiryDaysController.text.trim();
      final expiryDays =
          expiryText.isNotEmpty ? int.tryParse(expiryText) : null;

      if (_isEditing) {
        // Build diff — only send fields that actually changed.
        final updates = <String, dynamic>{};
        final name = _nameController.text.trim();
        final description = _descriptionController.text.trim();
        final iconUrl = _iconUrlController.text.trim();

        if (name != _origName) updates['name'] = name;
        if (description != _origDescription) {
          updates['description'] = description;
        }
        if (iconUrl != _origIconUrl) {
          updates['iconUrl'] = iconUrl.isEmpty ? null : iconUrl;
        }

        // Rules diff
        final rulesDiff = <String, dynamic>{};
        if (offrampsText != _origOfframps) {
          rulesDiff['allowedOfframps'] = offramps;
        }
        if (_allowP2pSend != _origAllowP2pSend) {
          rulesDiff['allowP2pSend'] = _allowP2pSend;
        }
        if (_allowP2pReceive != _origAllowP2pReceive) {
          rulesDiff['allowP2pReceive'] = _allowP2pReceive;
        }
        if (_allowCashout != _origAllowCashout) {
          rulesDiff['allowCashout'] = _allowCashout;
        }
        if (expiryText != _origExpiryDays) {
          rulesDiff['expiryDays'] = expiryDays;
        }
        if (_p2pRestrictToSameAccountType !=
            _origP2pRestrictToSameAccountType) {
          rulesDiff['p2pRestrictToSameAccountType'] =
              _p2pRestrictToSameAccountType;
        }
        if (rulesDiff.isNotEmpty) updates['rules'] = rulesDiff;

        if (updates.isEmpty) {
          if (mounted) Navigator.pop(context);
          return;
        }

        await _functions
            .httpsCallable('adminUpdateAccountType')
            .call({
          'accountTypeId': widget.accountType!['id'],
          'updates': updates,
        });
      } else {
        await _functions
            .httpsCallable('adminCreateAccountType')
            .call({
          'id': _idController.text.trim(),
          'name': _nameController.text.trim(),
          'description': _descriptionController.text.trim(),
          'iconUrl': _iconUrlController.text.trim().isEmpty
              ? null
              : _iconUrlController.text.trim(),
          'advertiserId': _selectedAdvertiserId,
          'rules': {
            'allowedOfframps': offramps,
            'allowP2pSend': _allowP2pSend,
            'allowP2pReceive': _allowP2pReceive,
            'allowCashout': _allowCashout,
            'expiryDays': expiryDays,
            'p2pRestrictToSameAccountType': _p2pRestrictToSameAccountType,
          },
        });
      }

      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.pop(context);
        widget.onSaved();
        messenger.showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Account type updated'
                : 'Account type created'),
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
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: Text(
        _isEditing ? 'Edit Account Type' : 'Create Account Type',
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
                // ID
                TextFormField(
                  controller: _idController,
                  enabled: !_isEditing,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  decoration: InputDecoration(
                    labelText: 'ID',
                    hintText: 'e.g. shoprite_rewards',
                    helperText: 'Lowercase letters, numbers, underscores',
                    filled: _isEditing,
                    fillColor:
                        _isEditing ? AppColors.backgroundDark : null,
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    if (!RegExp(r'^[a-z0-9_]+$').hasMatch(v.trim())) {
                      return 'Only lowercase letters, numbers, underscores';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Name
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                    hintText: 'e.g. Shoprite Rewards',
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Advertiser dropdown
                DropdownButtonFormField<String?>(
                  initialValue: _selectedAdvertiserId,
                  dropdownColor: AppColors.cardDark,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  decoration: InputDecoration(
                    labelText: 'Advertiser (Client)',
                    helperText: _clientLoadFailed
                        ? 'Failed to load clients'
                        : null,
                    helperStyle:
                        const TextStyle(color: AppColors.warning),
                    suffixIcon: _isLoadingClients
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : null,
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Platform Default (no client)'),
                    ),
                    ..._clients.map((c) => DropdownMenuItem<String?>(
                          value: c['id'] as String?,
                          child: Text(
                              c['displayName'] as String? ??
                                  c['companyName'] as String? ??
                                  c['id'] as String? ??
                                  ''),
                        )),
                  ],
                  onChanged: _isEditing
                      ? null
                      : (v) => setState(() => _selectedAdvertiserId = v),
                ),
                const SizedBox(height: 16),

                // Icon URL
                TextFormField(
                  controller: _iconUrlController,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  decoration: const InputDecoration(
                    labelText: 'Icon URL (optional)',
                  ),
                ),
                const SizedBox(height: 24),

                // Rules section header
                const Text(
                  'RULES',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
                const Divider(color: AppColors.dividerDark),
                const SizedBox(height: 8),

                // P2P Send
                SwitchListTile(
                  title: const Text('Allow P2P Send',
                      style: TextStyle(color: AppColors.textPrimaryDark)),
                  subtitle: const Text('Users can send tokens from this wallet',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
                  value: _allowP2pSend,
                  onChanged: (v) => setState(() => _allowP2pSend = v),
                  contentPadding: EdgeInsets.zero,
                ),

                // P2P Receive
                SwitchListTile(
                  title: const Text('Allow P2P Receive',
                      style: TextStyle(color: AppColors.textPrimaryDark)),
                  subtitle: const Text(
                      'Users can receive tokens into this wallet',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
                  value: _allowP2pReceive,
                  onChanged: (v) => setState(() => _allowP2pReceive = v),
                  contentPadding: EdgeInsets.zero,
                ),

                // Cashout
                SwitchListTile(
                  title: const Text('Allow Cashout',
                      style: TextStyle(color: AppColors.textPrimaryDark)),
                  subtitle: const Text('Users can cash out from this wallet',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
                  value: _allowCashout,
                  onChanged: (v) => setState(() => _allowCashout = v),
                  contentPadding: EdgeInsets.zero,
                ),

                // Restrict to same account type
                SwitchListTile(
                  title: const Text('P2P Restrict to Same Type',
                      style: TextStyle(color: AppColors.textPrimaryDark)),
                  subtitle: const Text(
                      'Only allow P2P with recipients who have the same brand wallet',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
                  value: _p2pRestrictToSameAccountType,
                  onChanged: (v) =>
                      setState(() => _p2pRestrictToSameAccountType = v),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 12),

                // Allowed Offramps
                TextFormField(
                  controller: _offrampsController,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  decoration: const InputDecoration(
                    labelText: 'Allowed Offramps',
                    hintText: '* for all, or comma-separated list',
                    helperText: 'e.g. shoprite_voucher, spar_voucher',
                  ),
                ),
                const SizedBox(height: 16),

                // Expiry Days
                TextFormField(
                  controller: _expiryDaysController,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Expiry (days)',
                    hintText: 'Leave empty for no expiry',
                  ),
                  validator: (v) {
                    if (v != null && v.trim().isNotEmpty) {
                      final n = int.tryParse(v.trim());
                      if (n == null || n <= 0) return 'Must be a positive number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Text(_isEditing ? 'Save Changes' : 'Create'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

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
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerDark),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryDark)),
              Text(title,
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
            ],
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.dividerDark,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _RuleIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final Color? color;

  const _RuleIcon({
    required this.icon,
    required this.label,
    required this.enabled,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? (enabled ? AppColors.success : Colors.grey);
    return Tooltip(
      message: '$label: ${enabled ? "Yes" : "No"}',
      child: Icon(
        icon,
        size: 16,
        color: enabled ? c : c.withValues(alpha: 0.3),
      ),
    );
  }
}
