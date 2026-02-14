import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Admin dashboard screen with system account metrics
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _functions = FirebaseFunctions.instance;
  final _numberFormat = NumberFormat('#,###');

  // Ledger balances
  int? _cbookBus;
  int? _cbookTrust;
  int? _dailyPot;
  int? _weeklyPot;
  int? _cashoutPending;
  int? _imalichat;
  int? _otherClientsBalance;
  // Earn activity
  int? _activeCampaigns;
  int? _activeOpportunities;
  int? _activeOpportunitiesTokens;
  // User activity
  int? _totalUsers;
  int? _uniqueLoginsLast24h;
  int? _tokensEarnedLast24h;

  bool _isLoading = true;
  String? _error;

  List<Map<String, dynamic>> _recentActivity = [];
  bool _activityLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSystemStatus();
    _loadRecentActivity();
  }

  Future<void> _loadSystemStatus() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _functions.httpsCallable('adminGetSystemAccountStatus').call();
      final data = result.data as Map<String, dynamic>;

      setState(() {
        _cbookBus = (data['cbookBus'] as num?)?.toInt() ?? 0;
        _cbookTrust = (data['cbookTrust'] as num?)?.toInt() ?? 0;
        _dailyPot = (data['dailyPot'] as num?)?.toInt() ?? 0;
        _weeklyPot = (data['weeklyPot'] as num?)?.toInt() ?? 0;
        _cashoutPending = (data['cashoutPending'] as num?)?.toInt() ?? 0;
        _imalichat = (data['imalichat'] as num?)?.toInt() ?? 0;
        _otherClientsBalance = (data['otherClientsBalance'] as num?)?.toInt() ?? 0;
        _activeCampaigns = (data['activeCampaigns'] as num?)?.toInt() ?? 0;
        _activeOpportunities = (data['activeOpportunities'] as num?)?.toInt() ?? 0;
        _activeOpportunitiesTokens = (data['activeOpportunitiesTokens'] as num?)?.toInt() ?? 0;
        _totalUsers = (data['totalUsers'] as num?)?.toInt() ?? 0;
        _uniqueLoginsLast24h = (data['uniqueLoginsLast24h'] as num?)?.toInt() ?? 0;
        _tokensEarnedLast24h = (data['tokensEarnedLast24h'] as num?)?.toInt() ?? 0;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadRecentActivity() async {
    try {
      final result = await _functions.httpsCallable('adminGetAuditLogs').call({
        'limit': 10,
      });
      final data = result.data as Map<String, dynamic>;
      final logs = (data['logs'] as List<dynamic>?) ?? [];
      setState(() {
        _recentActivity = logs.cast<Map<String, dynamic>>();
        _activityLoading = false;
      });
    } catch (_) {
      setState(() => _activityLoading = false);
    }
  }

  String _formatActivityTime(dynamic ts) {
    try {
      if (ts is String && ts.isNotEmpty) {
        final dt = DateTime.parse(ts).toLocal();
        final now = DateTime.now();
        final diff = now.difference(dt);
        if (diff.inMinutes < 1) return 'Just now';
        if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
        if (diff.inHours < 24) return '${diff.inHours}h ago';
        if (diff.inDays < 7) return '${diff.inDays}d ago';
        return DateFormat('dd MMM').format(dt);
      }
      if (ts is Map) {
        final seconds = ts['_seconds'];
        if (seconds is int) {
          final dt = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
          final now = DateTime.now();
          final diff = now.difference(dt);
          if (diff.inMinutes < 1) return 'Just now';
          if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
          if (diff.inHours < 24) return '${diff.inHours}h ago';
          if (diff.inDays < 7) return '${diff.inDays}d ago';
          return DateFormat('dd MMM').format(dt);
        }
      }
      return '';
    } catch (_) {
      return '';
    }
  }

  IconData _activityIcon(String action) {
    if (action.contains('Create') || action.contains('create')) return Icons.add_circle_outline;
    if (action.contains('Delete') || action.contains('delete') || action.contains('Soft')) return Icons.delete_outline;
    if (action.contains('Fund') || action.contains('fund')) return Icons.payments_outlined;
    if (action.contains('Update') || action.contains('update')) return Icons.edit_outlined;
    if (action.contains('Review') || action.contains('review')) return Icons.rate_review_outlined;
    if (action.contains('Poll') || action.contains('poll') || action.contains('open') || action.contains('close')) return Icons.poll_outlined;
    if (action.contains('Reward') || action.contains('reward') || action.contains('import')) return Icons.card_giftcard_outlined;
    if (action.contains('Approve') || action.contains('approve')) return Icons.check_circle_outline;
    if (action.contains('Reject') || action.contains('reject')) return Icons.cancel_outlined;
    return Icons.history;
  }

  Color _outcomeColor(String? outcome) {
    switch (outcome) {
      case 'success':
        return AppColors.success;
      case 'denied':
        return AppColors.error;
      case 'error':
        return AppColors.error;
      case 'maker_created':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  String _fmt(int? value) => _isLoading ? '...' : value != null ? _numberFormat.format(value) : '--';

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 20),

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
                        'Failed to load system status: $_error',
                        style: const TextStyle(color: AppColors.error, fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: AppColors.error, size: 20),
                      onPressed: _loadSystemStatus,
                    ),
                  ],
                ),
              ),

            // ── Ledger Balances ──
            _sectionHeader('Ledger Balances'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _StatChip(title: 'CashBook Business', value: _fmt(_cbookBus), icon: Icons.account_balance, color: AppColors.primary),
                _StatChip(title: 'CashBook Trust', value: _fmt(_cbookTrust), icon: Icons.account_balance, color: AppColors.secondary),
                _StatChip(title: 'iMaliChat Client', value: _fmt(_imalichat), icon: Icons.business, color: AppColors.success),
                _StatChip(title: 'Other Clients', value: _fmt(_otherClientsBalance), icon: Icons.business_center, color: AppColors.accent),
                _StatChip(title: 'Daily Pot', value: _fmt(_dailyPot), icon: Icons.emoji_events, color: AppColors.warning),
                _StatChip(title: 'Weekly Pot', value: _fmt(_weeklyPot), icon: Icons.emoji_events, color: AppColors.warning),
                _StatChip(title: 'Pending Cashouts', value: _fmt(_cashoutPending), icon: Icons.payments, color: AppColors.error),
              ],
            ),
            const SizedBox(height: 20),

            // ── Earn Activity ──
            _sectionHeader('Earn Activity'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _StatChip(title: 'Active Campaigns', value: _fmt(_activeCampaigns), icon: Icons.campaign, color: AppColors.primary),
                _StatChip(title: 'Active Opportunities', value: _fmt(_activeOpportunities), icon: Icons.play_circle_outline, color: AppColors.secondary),
                _StatChip(title: 'Opportunity Tokens', value: _fmt(_activeOpportunitiesTokens), icon: Icons.toll, color: AppColors.warning),
              ],
            ),
            const SizedBox(height: 20),

            // ── User Activity ──
            _sectionHeader('User Activity'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _StatChip(title: 'Registered Users', value: _fmt(_totalUsers), icon: Icons.people, color: AppColors.primary),
                _StatChip(title: 'Logins (24h)', value: _fmt(_uniqueLoginsLast24h), icon: Icons.login, color: AppColors.success),
                _StatChip(title: 'Tokens Earned (24h)', value: _fmt(_tokensEarnedLast24h), icon: Icons.toll, color: AppColors.accent),
              ],
            ),
            const SizedBox(height: 24),

            // Recent activity
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
                  if (_activityLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  else if (_recentActivity.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          'No recent activity',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    ...List.generate(
                      _recentActivity.length,
                      (i) {
                        final log = _recentActivity[i];
                        final action = (log['action'] as String?) ?? '';
                        final outcome = (log['outcome'] as String?) ?? '';
                        final email = (log['actorEmail'] as String?) ?? 'Unknown';
                        final time = _formatActivityTime(log['timestamp']);
                        return Column(
                          children: [
                            if (i > 0)
                              Divider(
                                color: AppColors.textSecondary.withValues(alpha: 0.15),
                                height: 1,
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: _outcomeColor(outcome).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      _activityIcon(action),
                                      size: 18,
                                      color: _outcomeColor(outcome),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          action,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textPrimaryDark,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          email,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
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

class _StatChip extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatChip({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDark,
                  height: 1.1,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
