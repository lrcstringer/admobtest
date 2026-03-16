import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';

/// Admin screen for account-related actions (Initialize Ledger, Fund Client, etc.)
class AccountsActionScreen extends StatefulWidget {
  const AccountsActionScreen({super.key});

  @override
  State<AccountsActionScreen> createState() => _AccountsActionScreenState();
}

class _AccountsActionScreenState extends State<AccountsActionScreen> {
  final _functions = FirebaseFunctions.instanceFor(region: 'africa-south1');
  bool _isInitializing = false;

  // Clients list for funding dropdowns
  List<Map<String, dynamic>> _clients = [];
  bool _isLoadingClients = false;

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    setState(() => _isLoadingClients = true);
    try {
      final result =
          await _functions.httpsCallable('adminListClients').call();
      final list = (result.data['clients'] as List?)
              ?.map((c) => Map<String, dynamic>.from(c as Map))
              .where((c) => c['isDeleted'] != true)
              .toList() ??
          [];
      list.sort((a, b) => (a['companyName'] ?? '')
          .toString()
          .toLowerCase()
          .compareTo((b['companyName'] ?? '').toString().toLowerCase()));
      if (mounted) setState(() => _clients = list);
    } catch (_) {
      // Silent fail — dropdowns will be empty
    } finally {
      if (mounted) setState(() => _isLoadingClients = false);
    }
  }

  Future<void> _initializeLedger() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text(
          'Initialize Trust Ledger',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'This creates all system accounts (cbook:bus, cbook:trust, pots, '
          'cashout_pending, client:imalichat) in Firestore. Safe to call '
          'multiple times \u2014 existing accounts are not affected.\n\nProceed?',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:
                Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Initialize'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isInitializing = true);

    try {
      await _functions.httpsCallable('initializeTrustLedger').call();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Trust Ledger initialized \u2014 system accounts created'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Initialization failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isInitializing = false);
    }
  }

  void _showFundClientDialog() {
    showDialog(
      context: context,
      builder: (context) => _FundClientDialog(
        clients: _clients,
        onFunded: _loadClients,
      ),
    );
  }

  void _showFundSubAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => _FundSubAccountDialog(
        clients: _clients,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Accounts Actions',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'System-level account operations and funding',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isLoadingClients)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 32),

            // SYSTEM SETUP section header
            _sectionHeader('SYSTEM SETUP'),
            const SizedBox(height: 12),

            // Initialize Ledger action card
            _buildActionCard(
              icon: Icons.settings_suggest,
              iconColor: AppColors.primary,
              title: 'Initialize Ledger',
              description:
                  'Creates all system accounts: CashBook Business, '
                  'CashBook Trust, Daily Pot, Weekly Pot, '
                  'Cashout Pending, and iMaliChat Client.',
              infoText:
                  'Safe to call multiple times \u2014 existing accounts are not affected.',
              buttonLabel: _isInitializing ? 'Initializing...' : 'Run',
              isLoading: _isInitializing,
              onPressed: _isInitializing ? null : _initializeLedger,
            ),

            const SizedBox(height: 32),

            // FUNDING section header
            _sectionHeader('FUNDING'),
            const SizedBox(height: 12),

            // Fund Client Account card
            _buildActionCard(
              icon: Icons.account_balance_wallet,
              iconColor: AppColors.tokenGold,
              title: 'Fund Client Account',
              description:
                  'Add tokens to a client\'s main ledger account. '
                  'This posts a DR CashBook / CR Client journal entry, '
                  'creating tokens into the system.',
              infoText:
                  'Requires a payment reference. The CashBook (asset) balance increases alongside the client balance.',
              buttonLabel: 'Fund Client',
              onPressed: _clients.isEmpty ? null : _showFundClientDialog,
            ),

            const SizedBox(height: 16),

            // Fund Sub-Account card
            _buildActionCard(
              icon: Icons.folder_special,
              iconColor: AppColors.secondary,
              title: 'Fund Client Sub-Account',
              description:
                  'Transfer tokens from a client\'s main account to one of their sub-accounts. '
                  'This posts a DR Client / CR Sub-Account journal entry.',
              infoText:
                  'The client must have sufficient balance on their main account. '
                  'Sub-accounts are used as token sources for earn campaigns.',
              buttonLabel: 'Top Up Sub-Account',
              onPressed: _clients.isEmpty ? null : _showFundSubAccountDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String infoText,
    required String buttonLabel,
    bool isLoading = false,
    VoidCallback? onPressed,
  }) {
    return Container(
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondaryDark,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.info, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    infoText,
                    style:
                        const TextStyle(fontSize: 12, color: AppColors.info),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 220,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.play_arrow, size: 20),
              label: Text(buttonLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: iconColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Fund Client Dialog
// ---------------------------------------------------------------------------

class _FundClientDialog extends StatefulWidget {
  final List<Map<String, dynamic>> clients;
  final VoidCallback onFunded;
  const _FundClientDialog({required this.clients, required this.onFunded});

  @override
  State<_FundClientDialog> createState() => _FundClientDialogState();
}

class _FundClientDialogState extends State<_FundClientDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();
  String? _selectedClientId;
  String _paymentMethod = 'bank_transfer';
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  Map<String, dynamic>? get _selectedClient {
    if (_selectedClientId == null) return null;
    return widget.clients.cast<Map<String, dynamic>?>().firstWhere(
          (c) => c?['id'] == _selectedClientId,
          orElse: () => null,
        );
  }

  Future<void> _handleFund() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminFundClientAccount')
          .call({
        'clientId': _selectedClientId,
        'amount': int.parse(_amountController.text.trim()),
        'reference': _referenceController.text.trim(),
        'paymentMethod': _paymentMethod,
      });
      if (mounted) {
        final newBalance = result.data['newBalance'];
        Navigator.of(context).pop();
        widget.onFunded();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account funded successfully. New balance: ${newBalance ?? "refreshing..."}',
            ),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error funding account: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = _selectedClient;
    final currentBalance = client != null
        ? ((client['balance'] as num?)?.toInt() ?? 0)
        : 0;

    return AlertDialog(
      backgroundColor: AppColors.adminCard,
      title: const Text(
        'Fund Client Account',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client selector
              DropdownButtonFormField<String>(
                initialValue: _selectedClientId,
                decoration:
                    const InputDecoration(labelText: 'Select Client'),
                items: widget.clients
                    .map((c) => DropdownMenuItem<String>(
                          value: c['id'] as String,
                          child: Text(
                            '${c['companyName'] ?? c['displayName'] ?? c['id']}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedClientId = v),
                validator: (v) => v == null ? 'Select a client' : null,
              ),

              // Show current balance when client selected
              if (client != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.tokenGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.business, color: AppColors.tokenGold),
                      const SizedBox(width: 12),
                      Text(
                        'Current balance: $currentBalance tokens',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount (tokens)',
                  hintText: 'e.g., 10000',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Amount is required';
                  final n = int.tryParse(v);
                  if (n == null || n <= 0) return 'Must be greater than 0';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _referenceController,
                decoration: const InputDecoration(
                  labelText: 'Reference',
                  hintText: 'e.g., INV-2026-001',
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Reference is required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _paymentMethod,
                decoration:
                    const InputDecoration(labelText: 'Payment Method'),
                items: const [
                  DropdownMenuItem(
                      value: 'bank_transfer', child: Text('Bank Transfer')),
                  DropdownMenuItem(
                      value: 'invoice', child: Text('Invoice')),
                  DropdownMenuItem(
                      value: 'promo_credit', child: Text('Promo Credit')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _paymentMethod = v);
                },
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
          onPressed: _isLoading ? null : _handleFund,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Fund Account'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Fund Sub-Account Dialog
// ---------------------------------------------------------------------------

class _FundSubAccountDialog extends StatefulWidget {
  final List<Map<String, dynamic>> clients;
  const _FundSubAccountDialog({required this.clients});

  @override
  State<_FundSubAccountDialog> createState() => _FundSubAccountDialogState();
}

class _FundSubAccountDialogState extends State<_FundSubAccountDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();

  String? _selectedClientId;
  String? _selectedSubAccountId;
  List<Map<String, dynamic>> _subAccounts = [];
  bool _isLoadingSubAccounts = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  Future<void> _loadSubAccounts(String clientId) async {
    setState(() {
      _isLoadingSubAccounts = true;
      _selectedSubAccountId = null;
      _subAccounts = [];
    });
    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminListClientSubAccounts')
          .call({'clientId': clientId});
      final list = (result.data['subAccounts'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _subAccounts = list);
    } catch (_) {
      if (mounted) setState(() => _subAccounts = []);
    } finally {
      if (mounted) setState(() => _isLoadingSubAccounts = false);
    }
  }

  Map<String, dynamic>? get _selectedSubAccount {
    if (_selectedSubAccountId == null) return null;
    return _subAccounts.cast<Map<String, dynamic>?>().firstWhere(
          (s) => s?['id'] == _selectedSubAccountId,
          orElse: () => null,
        );
  }

  Future<void> _handleFund() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminFundClientSubAccount')
          .call({
        'clientId': _selectedClientId,
        'subAccountId': _selectedSubAccountId,
        'amount': int.parse(_amountController.text.trim()),
        'reference': _referenceController.text.trim(),
      });
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sub-account funded successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error funding sub-account: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subAcc = _selectedSubAccount;
    final subBalance =
        subAcc != null ? ((subAcc['balance'] as num?)?.toInt() ?? 0) : 0;

    return AlertDialog(
      backgroundColor: AppColors.adminCard,
      title: const Text(
        'Fund Client Sub-Account',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client selector
              DropdownButtonFormField<String>(
                initialValue: _selectedClientId,
                decoration:
                    const InputDecoration(labelText: 'Select Client'),
                items: widget.clients
                    .map((c) => DropdownMenuItem<String>(
                          value: c['id'] as String,
                          child: Text(
                            '${c['companyName'] ?? c['displayName'] ?? c['id']}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    setState(() => _selectedClientId = v);
                    _loadSubAccounts(v);
                  }
                },
                validator: (v) => v == null ? 'Select a client' : null,
              ),

              const SizedBox(height: 16),

              // Sub-account selector
              if (_isLoadingSubAccounts)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else if (_selectedClientId != null) ...[
                DropdownButtonFormField<String>(
                  initialValue: _selectedSubAccountId,
                  decoration: const InputDecoration(
                      labelText: 'Select Sub-Account'),
                  items: _subAccounts
                      .map((s) => DropdownMenuItem<String>(
                            value: s['id'] as String,
                            child: Text(
                              '${s['name'] ?? s['id']} (${(s['balance'] as num?)?.toInt() ?? 0} tokens)',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _selectedSubAccountId = v),
                  validator: (v) =>
                      v == null ? 'Select a sub-account' : null,
                ),

                // Show sub-account balance
                if (subAcc != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.folder_special,
                            color: AppColors.secondary, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          'Current balance: $subBalance tokens',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],

              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount (tokens)',
                  hintText: 'e.g., 5000',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Amount is required';
                  final n = int.tryParse(v);
                  if (n == null || n <= 0) return 'Must be greater than 0';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _referenceController,
                decoration: const InputDecoration(
                  labelText: 'Reference',
                  hintText: 'e.g., TOPUP-001',
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Reference is required' : null,
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
          onPressed: _isLoading ? null : _handleFund,
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.success),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Top Up'),
        ),
      ],
    );
  }
}
