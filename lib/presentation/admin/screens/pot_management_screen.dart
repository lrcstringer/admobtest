import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Pot management screen for distributing daily/weekly pots
class PotManagementScreen extends StatefulWidget {
  const PotManagementScreen({super.key});

  @override
  State<PotManagementScreen> createState() => _PotManagementScreenState();
}

class _PotManagementScreenState extends State<PotManagementScreen> {
  final _functions = FirebaseFunctions.instance;
  final _db = FirebaseFirestore.instance;
  final _numberFormat = NumberFormat('#,###');

  // Pot balances
  int? _dailyPotBalance;
  int? _weeklyPotBalance;
  bool _balancesLoading = true;

  // Active pots
  Map<String, dynamic>? _activeDailyPot;
  Map<String, dynamic>? _activeWeeklyPot;

  // Distribution history
  List<Map<String, dynamic>> _distributions = [];
  bool _historyLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBalances();
    _loadActivePots();
    _loadDistributionHistory();
  }

  Future<void> _refresh() async {
    await Future.wait([
      _loadBalances(),
      _loadActivePots(),
      _loadDistributionHistory(),
    ]);
  }

  Future<void> _loadBalances() async {
    try {
      final result = await _functions
          .httpsCallable('adminGetSystemAccountStatus')
          .call();
      final data = result.data as Map<String, dynamic>;
      setState(() {
        _dailyPotBalance = (data['dailyPot'] as num?)?.toInt() ?? 0;
        _weeklyPotBalance = (data['weeklyPot'] as num?)?.toInt() ?? 0;
        _balancesLoading = false;
      });
    } catch (_) {
      setState(() => _balancesLoading = false);
    }
  }

  Future<void> _loadActivePots() async {
    try {
      final dailyQuery = await _db
          .collection('pots')
          .where('type', isEqualTo: 'daily')
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      final weeklyQuery = await _db
          .collection('pots')
          .where('type', isEqualTo: 'weekly')
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      setState(() {
        _activeDailyPot = dailyQuery.docs.isNotEmpty
            ? dailyQuery.docs.first.data()
            : null;
        _activeWeeklyPot = weeklyQuery.docs.isNotEmpty
            ? weeklyQuery.docs.first.data()
            : null;
      });
    } catch (_) {}
  }

  Future<void> _loadDistributionHistory() async {
    try {
      final query = await _db
          .collection('pots')
          .where('isDistributed', isEqualTo: true)
          .orderBy('distributedAt', descending: true)
          .limit(20)
          .get();

      setState(() {
        _distributions = query.docs.map((d) => d.data()).toList();
        _historyLoading = false;
      });
    } catch (_) {
      setState(() => _historyLoading = false);
    }
  }

  String _fmtBalance(int? value) {
    if (_balancesLoading) return '...';
    return value != null ? _numberFormat.format(value) : '--';
  }

  String _fmtTimestamp(dynamic ts) {
    try {
      if (ts is Timestamp) {
        return DateFormat('dd MMM yyyy HH:mm').format(ts.toDate().toLocal());
      }
      return '--';
    } catch (_) {
      return '--';
    }
  }

  String _timeRemaining(dynamic periodEnd) {
    try {
      DateTime end;
      if (periodEnd is Timestamp) {
        end = periodEnd.toDate();
      } else {
        return '--';
      }
      final diff = end.difference(DateTime.now());
      if (diff.isNegative) return 'Ended';
      if (diff.inHours >= 24) return '${diff.inDays}d ${diff.inHours % 24}h';
      if (diff.inHours >= 1) return '${diff.inHours}h ${diff.inMinutes % 60}m';
      return '${diff.inMinutes}m';
    } catch (_) {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                        'Pot Management',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Manage daily and weekly pot distributions',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Refresh'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Current pots
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildPotCard(
                      type: 'Daily',
                      balance: _dailyPotBalance,
                      activePot: _activeDailyPot,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildPotCard(
                      type: 'Weekly',
                      balance: _weeklyPotBalance,
                      activePot: _activeWeeklyPot,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Distribution history
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
                      'Distribution History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildHistoryTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPotCard({
    required String type,
    required int? balance,
    required Map<String, dynamic>? activePot,
    required Color color,
  }) {
    final participants = activePot?['participantCount'] as int? ?? 0;
    final periodEnd = activePot?['periodEnd'];
    final isActive = activePot?['isActive'] == true;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.emoji_events, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                '$type Pot',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.success.withValues(alpha: 0.15)
                      : AppColors.textSecondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isActive ? 'Active' : 'No active pot',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isActive ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Current Balance',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            '${_fmtBalance(balance)} tokens',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Participants',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isActive ? _numberFormat.format(participants) : '--',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time Remaining',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isActive ? _timeRemaining(periodEnd) : '--',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Distribution runs automatically at the end of each ${type == 'Daily' ? 'day (8 PM SAST)' : 'week (Sun 8 PM SAST)'}',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTable() {
    if (_historyLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_distributions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(Icons.emoji_events_outlined,
                  size: 48, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              Text(
                'No distributions yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Table header
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              _headerCell('Type', flex: 1),
              _headerCell('Date', flex: 2),
              _headerCell('Tokens', flex: 1),
              _headerCell('Participants', flex: 1),
              _headerCell('Winners', flex: 1),
            ],
          ),
        ),
        const Divider(height: 1),
        ..._distributions.map((dist) {
          final type = dist['type'] as String? ?? '';
          final isDaily = type == 'daily';
          final winners = dist['winners'] as List<dynamic>? ?? [];
          final totalParticipants = dist['totalParticipants'] as int? ?? dist['participantCount'] as int? ?? 0;
          final totalTokens = dist['totalTokens'] as int? ?? 0;

          return Column(
            children: [
              InkWell(
                onTap: winners.isNotEmpty
                    ? () => _showWinnersDialog(dist)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: (isDaily
                                        ? AppColors.primary
                                        : AppColors.secondary)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                isDaily ? 'Daily' : 'Weekly',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDaily
                                      ? AppColors.primary
                                      : AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          _fmtTimestamp(dist['distributedAt']),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _numberFormat.format(totalTokens),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _numberFormat.format(totalParticipants),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${winners.length}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: AppColors.textSecondary.withValues(alpha: 0.15),
              ),
            ],
          );
        }),
      ],
    );
  }

  void _showWinnersDialog(Map<String, dynamic> dist) {
    final winners = (dist['winners'] as List<dynamic>?) ?? [];
    final type = dist['type'] as String? ?? 'daily';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text(
          '${type == 'daily' ? 'Daily' : 'Weekly'} Pot Winners',
          style: const TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: SizedBox(
          width: 500,
          child: winners.isEmpty
              ? const Text('No winners',
                  style: TextStyle(color: AppColors.textSecondary))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: winners.map((w) {
                      final winner = w as Map<String, dynamic>;
                      final rank = winner['rank'] as int? ?? 0;
                      final name =
                          winner['displayName'] as String? ?? 'User';
                      final tokens = winner['tokensWon'] as int? ?? 0;
                      final pct = winner['percentage'] as num? ?? 0;

                      return ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: rank <= 3
                              ? AppColors.warning.withValues(alpha: 0.15)
                              : AppColors.textSecondary
                                  .withValues(alpha: 0.15),
                          child: Text(
                            '#$rank',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: rank <= 3
                                  ? AppColors.warning
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                        title: Text(name,
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimaryDark)),
                        trailing: Text(
                          '${_numberFormat.format(tokens)} (${pct.toStringAsFixed(0)}%)',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.success,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
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
}
