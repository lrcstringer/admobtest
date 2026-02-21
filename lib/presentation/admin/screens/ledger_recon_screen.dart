import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Ledger reconciliation screen for admin portal
class LedgerReconScreen extends StatefulWidget {
  const LedgerReconScreen({super.key});

  @override
  State<LedgerReconScreen> createState() => _LedgerReconScreenState();
}

class _LedgerReconScreenState extends State<LedgerReconScreen> {
  final _functions = FirebaseFunctions.instanceFor(region: 'africa-south1');
  final _numberFormat = NumberFormat('#,###');
  final _dateFormat = DateFormat('dd MMM yyyy HH:mm');

  bool _isLoading = true;
  bool _isReconciling = false;
  String? _error;

  // System balance
  Map<String, dynamic>? _systemBalance;

  // Statistics
  Map<String, dynamic>? _statistics;

  // Accounts list
  List<Map<String, dynamic>> _accounts = [];

  // Recent journals
  List<Map<String, dynamic>> _recentJournals = [];

  // Reconciliation results (after running full recon)
  Map<String, dynamic>? _reconResults;
  Map<String, dynamic>? _journalIntegrity;

  @override
  void initState() {
    super.initState();
    _loadOverview();
  }

  Future<void> _loadOverview() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _functions
          .httpsCallable('adminRunLedgerRecon')
          .call({'runFullRecon': false});
      final data = result.data as Map<String, dynamic>;

      if (!mounted) return;
      setState(() {
        _systemBalance =
            (data['systemBalance'] as Map?)?.cast<String, dynamic>();
        _statistics = (data['statistics'] as Map?)?.cast<String, dynamic>();
        _accounts = _castList(data['accounts']);
        _recentJournals = _castList(data['recentJournals']);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _runReconciliation() async {
    setState(() => _isReconciling = true);

    try {
      final result = await _functions
          .httpsCallable('adminRunLedgerRecon',
              options: HttpsCallableOptions(timeout: const Duration(seconds: 120)))
          .call({'runFullRecon': true});
      final data = result.data as Map<String, dynamic>;

      if (!mounted) return;
      setState(() {
        _systemBalance =
            (data['systemBalance'] as Map?)?.cast<String, dynamic>();
        _statistics = (data['statistics'] as Map?)?.cast<String, dynamic>();
        _accounts = _castList(data['accounts']);
        _recentJournals = _castList(data['recentJournals']);
        _reconResults =
            (data['reconciliation'] as Map?)?.cast<String, dynamic>();
        _journalIntegrity =
            (data['journalIntegrity'] as Map?)?.cast<String, dynamic>();
        _isReconciling = false;
      });

      if (mounted) {
        final failed = _reconResults?['failed'] ?? 0;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Reconciliation complete \u2014 ${_reconResults?['passed'] ?? 0} passed, $failed failed',
            ),
            backgroundColor: failed > 0 ? AppColors.error : AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isReconciling = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reconciliation failed: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  List<Map<String, dynamic>> _castList(dynamic raw) {
    if (raw is List) {
      return raw.map((e) => (e as Map).cast<String, dynamic>()).toList();
    }
    return [];
  }

  String _fmt(dynamic value) {
    if (value == null) return '--';
    if (value is num) return _numberFormat.format(value.toInt());
    return value.toString();
  }

  String _fmtDate(dynamic millis) {
    if (millis == null || millis == 0) return '--';
    final dt = DateTime.fromMillisecondsSinceEpoch((millis as num).toInt());
    return _dateFormat.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : _error != null
              ? _buildError()
              : _buildContent(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 48),
          const SizedBox(height: 16),
          Text(
            'Failed to load ledger data',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              _error!,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadOverview,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),
          const SizedBox(height: 24),

          // System Balance Invariant
          _buildSystemBalanceSection(),
          const SizedBox(height: 24),

          // Account type breakdown
          _buildAccountTypeBreakdown(),
          const SizedBox(height: 24),

          // Reconciliation Results (if run)
          if (_reconResults != null) ...[
            _buildReconResultsSection(),
            const SizedBox(height: 24),
          ],

          // Journal Integrity (if run)
          if (_journalIntegrity != null) ...[
            _buildJournalIntegritySection(),
            const SizedBox(height: 24),
          ],

          // All accounts table
          _buildAccountsTable(),
          const SizedBox(height: 24),

          // Recent journals
          _buildRecentJournals(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ledger Reconciliation',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Double-entry bookkeeping verification & audit',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            OutlinedButton.icon(
              onPressed: _isReconciling ? null : _loadOverview,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Refresh'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: BorderSide(
                    color: AppColors.textSecondary.withValues(alpha: 0.3)),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _isReconciling ? null : _runReconciliation,
              icon: _isReconciling
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.verified_outlined, size: 18),
              label: Text(
                  _isReconciling ? 'Reconciling...' : 'Run Reconciliation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemBalanceSection() {
    final isValid = _systemBalance?['isValid'] == true;
    final drift = _systemBalance?['drift'] ?? 0;
    final cbookBal = _systemBalance?['cbookBalances'] ?? 0;

    final liabilityTotal = (_systemBalance?['userBalances'] ?? 0) +
        (_systemBalance?['potBalances'] ?? 0) +
        (_systemBalance?['supplierBalances'] ?? 0) +
        (_systemBalance?['clientBalances'] ?? 0) +
        (_systemBalance?['clientSubaccBalances'] ?? 0) +
        (_systemBalance?['systemBalances'] ?? 0) +
        (_systemBalance?['groupBalances'] ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Balance Invariant',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Asset balances (CashBook) must equal liability balances (all other accounts)',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _BalanceCard(
              title: 'CashBook (Assets)',
              value: _fmt(cbookBal),
              subtitle: 'Debit-normal accounts',
              color: AppColors.primary,
            ),
            _BalanceCard(
              title: 'Liabilities',
              value: _fmt(liabilityTotal),
              subtitle: 'All other accounts',
              color: AppColors.secondary,
            ),
            _BalanceCard(
              title: 'Drift',
              value: _fmt(drift),
              subtitle: isValid ? 'Balanced' : 'IMBALANCED',
              color: isValid ? AppColors.success : AppColors.error,
              showIcon: true,
              isValid: isValid,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Breakdown row
        _buildBalanceBreakdown(),
      ],
    );
  }

  Widget _buildBalanceBreakdown() {
    final items = <_BreakdownItem>[
      _BreakdownItem(
          'CashBook', _systemBalance?['cbookBalances'] ?? 0, AppColors.primary),
      _BreakdownItem(
          'Users', _systemBalance?['userBalances'] ?? 0, AppColors.info),
      _BreakdownItem(
          'Pots', _systemBalance?['potBalances'] ?? 0, AppColors.warning),
      _BreakdownItem('Clients', _systemBalance?['clientBalances'] ?? 0,
          AppColors.success),
      _BreakdownItem('Sub-Accounts',
          _systemBalance?['clientSubaccBalances'] ?? 0, AppColors.secondary),
      _BreakdownItem('Suppliers', _systemBalance?['supplierBalances'] ?? 0,
          AppColors.error),
      _BreakdownItem(
          'System', _systemBalance?['systemBalances'] ?? 0, Colors.teal),
      _BreakdownItem(
          'Groups', _systemBalance?['groupBalances'] ?? 0, Colors.purple),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 24,
        runSpacing: 12,
        children: items
            .where((i) => (i.value as num) != 0)
            .map((item) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item.label}: ${_fmt(item.value)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAccountTypeBreakdown() {
    final accountsByType =
        (_statistics?['accountsByType'] as Map?)?.cast<String, dynamic>() ?? {};
    final totalAccounts = _statistics?['totalAccounts'] ?? 0;
    final totalJournals = _statistics?['totalJournals'] ?? 0;
    final journalsByType =
        (_statistics?['journalsByType'] as Map?)?.cast<String, dynamic>() ?? {};

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ledger Statistics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 32,
            runSpacing: 16,
            children: [
              _StatChip(
                  label: 'Total Accounts', value: _fmt(totalAccounts)),
              _StatChip(
                  label: 'Total Journals', value: _fmt(totalJournals)),
              ...accountsByType.entries.map((e) => _StatChip(
                    label: '${_accountTypeLabel(e.key)} Accounts',
                    value: _fmt(e.value),
                  )),
            ],
          ),
          if (journalsByType.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(color: AppColors.dividerDark),
            const SizedBox(height: 12),
            Text(
              'Journals by Type',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: journalsByType.entries
                  .map((e) => _StatChip(
                        label: _journalTypeLabel(e.key),
                        value: _fmt(e.value),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReconResultsSection() {
    final total = _reconResults?['total'] ?? 0;
    final passed = _reconResults?['passed'] ?? 0;
    final failed = _reconResults?['failed'] ?? 0;
    final results = _castList(_reconResults?['results']);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: failed > 0
              ? AppColors.error.withValues(alpha: 0.5)
              : AppColors.success.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                failed > 0 ? Icons.warning_amber : Icons.check_circle,
                color: failed > 0 ? AppColors.error : AppColors.success,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Reconciliation Results',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              const Spacer(),
              _StatChip(label: 'Total', value: '$total'),
              const SizedBox(width: 12),
              _StatChip(
                  label: 'Passed',
                  value: '$passed',
                  color: AppColors.success),
              if (failed > 0) ...[
                const SizedBox(width: 12),
                _StatChip(
                    label: 'Failed', value: '$failed', color: AppColors.error),
              ],
            ],
          ),
          if (failed > 0) ...[
            const SizedBox(height: 16),
            const Text(
              'Accounts with balance drift:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 8),
            ...results.where((r) => r['isReconciled'] != true).map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline,
                              color: AppColors.error, size: 18),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${r['accountId']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimaryDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Stored: ${_fmt(r['storedBalance'])}  |  Calculated: ${_fmt(r['calculatedBalance'])}  |  Drift: ${_fmt(r['discrepancy'])}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }

  Widget _buildJournalIntegritySection() {
    final total = _journalIntegrity?['total'] ?? 0;
    final balanced = _journalIntegrity?['balanced'] ?? 0;
    final unbalanced =
        (_journalIntegrity?['unbalanced'] as List?)?.cast<String>() ?? [];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unbalanced.isNotEmpty
              ? AppColors.error.withValues(alpha: 0.5)
              : AppColors.success.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                unbalanced.isNotEmpty
                    ? Icons.warning_amber
                    : Icons.check_circle,
                color: unbalanced.isNotEmpty
                    ? AppColors.error
                    : AppColors.success,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Journal Integrity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              const Spacer(),
              _StatChip(label: 'Total', value: '$total'),
              const SizedBox(width: 12),
              _StatChip(
                  label: 'Balanced',
                  value: '$balanced',
                  color: AppColors.success),
              if (unbalanced.isNotEmpty) ...[
                const SizedBox(width: 12),
                _StatChip(
                    label: 'Unbalanced',
                    value: '${unbalanced.length}',
                    color: AppColors.error),
              ],
            ],
          ),
          if (unbalanced.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Unbalanced journal IDs: ${unbalanced.join(", ")}',
              style:
                  const TextStyle(fontSize: 13, color: AppColors.error),
            ),
          ] else ...[
            const SizedBox(height: 8),
            Text(
              'All journals have matching debits and credits.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAccountsTable() {
    // Sort: system accounts first, then by type, then by balance descending
    final sortedAccounts = List<Map<String, dynamic>>.from(_accounts)
      ..sort((a, b) {
        final typeOrder = _typeOrder(a['type']) - _typeOrder(b['type']);
        if (typeOrder != 0) return typeOrder;
        return ((b['balance'] ?? 0) as num)
            .compareTo((a['balance'] ?? 0) as num);
      });

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Accounts (${_accounts.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividerDark)),
                ),
                children: [
                  _tableHeader('Account ID'),
                  _tableHeader('Type'),
                  _tableHeader('Balance'),
                  _tableHeader('Status'),
                ],
              ),
              ...sortedAccounts.map((a) => _accountRow(a)),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _accountRow(Map<String, dynamic> account) {
    final status = account['status'] ?? 'unknown';
    final isActive = status == 'active';

    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: AppColors.dividerDark.withValues(alpha: 0.5)),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account['id'] ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                  fontFamily: 'monospace',
                ),
              ),
              if (account['name'] != null)
                Text(
                  account['name'],
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _typeColor(account['type']).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _accountTypeLabel(account['type']),
              style: TextStyle(
                fontSize: 12,
                color: _typeColor(account['type']),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            _fmt(account['balance']),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.success : AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentJournals() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Journal Entries (${_recentJournals.length})',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 16),
          if (_recentJournals.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.receipt_long,
                        size: 48, color: AppColors.textSecondary),
                    const SizedBox(height: 16),
                    Text(
                      'No journal entries found.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            )
          else
            ...List.generate(_recentJournals.length, (i) {
              final j = _recentJournals[i];
              return _journalRow(j, i);
            }),
        ],
      ),
    );
  }

  Widget _journalRow(Map<String, dynamic> journal, int index) {
    final entries = _castList(journal['entries']);
    final isEven = index % 2 == 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color:
            isEven ? Colors.transparent : Colors.white.withValues(alpha: 0.02),
        border: Border(
          bottom: BorderSide(
              color: AppColors.dividerDark.withValues(alpha: 0.3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Type badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _journalTypeLabel(journal['type'] ?? ''),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Description
              Expanded(
                child: Text(
                  journal['description'] ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimaryDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              // Amount
              Text(
                _fmt(journal['totalDebits']),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 16),
              // Date
              Text(
                _fmtDate(journal['postedAt']),
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
          if (entries.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 16,
              runSpacing: 4,
              children: entries
                  .map(
                    (e) => Text(
                      '${e['entryType'] == 'debit' ? 'DR' : 'CR'} ${e['accountId']} ${_fmt(e['amount'])}',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontFamily: 'monospace',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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

  int _typeOrder(dynamic type) {
    switch (type) {
      case 'cbook':
        return 0;
      case 'system':
        return 1;
      case 'pot':
        return 2;
      case 'client':
        return 3;
      case 'client_subacc':
        return 4;
      case 'user':
        return 5;
      case 'supplier':
        return 6;
      case 'group':
        return 7;
      default:
        return 99;
    }
  }

  Color _typeColor(dynamic type) {
    switch (type) {
      case 'cbook':
        return AppColors.primary;
      case 'system':
        return Colors.teal;
      case 'pot':
        return AppColors.warning;
      case 'client':
        return AppColors.success;
      case 'client_subacc':
        return AppColors.secondary;
      case 'user':
        return AppColors.info;
      case 'supplier':
        return AppColors.error;
      case 'group':
        return Colors.purple;
      default:
        return AppColors.textSecondary;
    }
  }

  String _accountTypeLabel(dynamic type) {
    switch (type) {
      case 'cbook':
        return 'CashBook';
      case 'system':
        return 'System';
      case 'pot':
        return 'Pot';
      case 'client':
        return 'Client';
      case 'client_subacc':
        return 'Sub-Account';
      case 'user':
        return 'User';
      case 'supplier':
        return 'Supplier';
      case 'group':
        return 'Group';
      default:
        return type?.toString() ?? 'Unknown';
    }
  }

  String _journalTypeLabel(String type) {
    switch (type) {
      case 'earn':
        return 'Earn';
      case 'pot_contribution':
        return 'Pot Contribution';
      case 'pot_win':
        return 'Pot Win';
      case 'purchase':
        return 'Purchase';
      case 'referral_reward':
        return 'Referral';
      case 'p2p_transfer':
        return 'P2P Transfer';
      case 'cashout_initiate':
        return 'Cashout Start';
      case 'cashout_complete':
        return 'Cashout Done';
      case 'cashout_failed':
        return 'Cashout Failed';
      case 'reversal':
        return 'Reversal';
      case 'adjustment':
        return 'Adjustment';
      case 'client_fund':
        return 'Client Fund';
      case 'client_refund':
        return 'Client Refund';
      case 'subacc_fund':
        return 'Sub-Acc Fund';
      case 'group_contribution':
        return 'Group Contrib';
      case 'group_withdrawal':
        return 'Group Withdraw';
      case 'group_payout':
        return 'Group Payout';
      case 'group_penalty':
        return 'Group Penalty';
      default:
        return type;
    }
  }
}

class _BalanceCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final bool showIcon;
  final bool isValid;

  const _BalanceCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    this.showIcon = false,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              if (showIcon)
                Icon(
                  isValid ? Icons.check_circle : Icons.error,
                  color: color,
                  size: 28,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _StatChip({
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color ?? AppColors.textPrimaryDark,
          ),
        ),
      ],
    );
  }
}

class _BreakdownItem {
  final String label;
  final dynamic value;
  final Color color;

  _BreakdownItem(this.label, this.value, this.color);
}
