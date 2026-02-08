import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Admin dashboard screen with treasury metrics and seed action
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _functions = FirebaseFunctions.instance;
  final _numberFormat = NumberFormat('#,###');

  int? _treasuryBalance;
  int? _mintBalance;
  int? _tokensInCirculation;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTreasuryStatus();
  }

  Future<void> _loadTreasuryStatus() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _functions.httpsCallable('adminGetTreasuryStatus').call();
      final data = result.data as Map<String, dynamic>;

      setState(() {
        _treasuryBalance = (data['treasuryBalance'] as num).toInt();
        _mintBalance = (data['mintBalance'] as num).toInt();
        _tokensInCirculation = (data['tokensInCirculation'] as num).toInt();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Color _treasuryStatusColor() {
    if (_treasuryBalance == null) return AppColors.textSecondary;
    if (_treasuryBalance! <= 0) return AppColors.error;
    if (_treasuryBalance! < 100000) return AppColors.warning;
    return AppColors.success;
  }

  Future<void> _initializeLedger() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          'Initialize Trust Ledger',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'This creates all system accounts (mint, treasury, pots, etc.) '
          'in Firestore. Safe to call multiple times \u2014 existing accounts '
          'are not affected.\n\nProceed?',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Initialize'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await _functions.httpsCallable('initializeTrustLedger').call();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trust Ledger initialized \u2014 system accounts created'),
            backgroundColor: AppColors.success,
          ),
        );
        _loadTreasuryStatus();
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
    }
  }

  Future<void> _showSeedDialog() async {
    final amountController = TextEditingController();
    final reasonController = TextEditingController();
    bool isSeeding = false;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.cardDark,
          title: const Text(
            'Seed Treasury',
            style: TextStyle(color: AppColors.textPrimaryDark),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Mint new tokens into the treasury. '
                '100 tokens = R1 ZAR.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textPrimaryDark),
                decoration: InputDecoration(
                  labelText: 'Amount (tokens)',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                  hintText: 'e.g. 10000000 (= R100,000)',
                  hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.5)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                style: const TextStyle(color: AppColors.textPrimaryDark),
                decoration: InputDecoration(
                  labelText: 'Reason',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                  hintText: 'e.g. Initial seed, Monthly top-up',
                  hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.5)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isSeeding ? null : () => Navigator.pop(ctx),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: isSeeding
                  ? null
                  : () async {
                      final amount = int.tryParse(amountController.text.trim());
                      final reason = reasonController.text.trim();

                      if (amount == null || amount <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter a valid positive amount')),
                        );
                        return;
                      }
                      if (reason.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter a reason')),
                        );
                        return;
                      }

                      setDialogState(() => isSeeding = true);

                      try {
                        final result = await _functions
                            .httpsCallable('adminSeedTreasury')
                            .call({'amount': amount, 'reason': reason});
                        final data = result.data as Map<String, dynamic>;

                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Treasury seeded with ${_numberFormat.format(amount)} tokens. '
                                'Balance: ${_numberFormat.format(data['treasuryBalanceAfter'])}',
                              ),
                              backgroundColor: AppColors.success,
                            ),
                          );
                          _loadTreasuryStatus();
                        }
                      } catch (e) {
                        setDialogState(() => isSeeding = false);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Seed failed: $e'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: isSeeding
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Mint Tokens'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final treasuryValue = _isLoading
        ? '...'
        : _treasuryBalance != null
            ? _numberFormat.format(_treasuryBalance)
            : '--';

    final mintedValue = _isLoading
        ? '...'
        : _mintBalance != null
            ? _numberFormat.format(_mintBalance!.abs())
            : '--';

    final circulationValue = _isLoading
        ? '...'
        : _tokensInCirculation != null
            ? _numberFormat.format(_tokensInCirculation)
            : '--';

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Overview of iMali system metrics',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),

            // Error banner
            if (_error != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Failed to load treasury status: $_error',
                        style: const TextStyle(color: AppColors.error, fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: AppColors.error, size: 20),
                      onPressed: _loadTreasuryStatus,
                    ),
                  ],
                ),
              ),

            // Stats cards row
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _StatCard(
                  title: 'Treasury Balance',
                  value: treasuryValue,
                  icon: Icons.account_balance_wallet,
                  color: _treasuryStatusColor(),
                ),
                _StatCard(
                  title: 'Total Minted',
                  value: mintedValue,
                  icon: Icons.toll,
                  color: AppColors.secondary,
                ),
                _StatCard(
                  title: 'In Circulation',
                  value: circulationValue,
                  icon: Icons.swap_horiz,
                  color: AppColors.primary,
                ),
                _StatCard(
                  title: 'Pending Cashouts',
                  value: '--',
                  icon: Icons.payments,
                  color: AppColors.warning,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Quick actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ActionButton(
                  label: 'Initialize Ledger',
                  icon: Icons.settings_suggest,
                  onTap: _initializeLedger,
                ),
                _ActionButton(
                  label: 'Seed Treasury',
                  icon: Icons.add_circle,
                  onTap: _showSeedDialog,
                ),
                _ActionButton(
                  label: 'Run Ledger Recon',
                  icon: Icons.account_balance,
                  onTap: () {},
                ),
                _ActionButton(
                  label: 'Distribute Daily Pot',
                  icon: Icons.emoji_events,
                  onTap: () {},
                ),
                _ActionButton(
                  label: 'Approve Cashouts',
                  icon: Icons.check_circle,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Recent activity placeholder
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Dashboard data will be populated once\nFirestore admin queries are connected.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardDark,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
