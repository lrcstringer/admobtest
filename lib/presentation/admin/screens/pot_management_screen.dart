import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Pot management screen for distributing daily/weekly pots
class PotManagementScreen extends StatefulWidget {
  const PotManagementScreen({super.key});

  @override
  State<PotManagementScreen> createState() => _PotManagementScreenState();
}

class _PotManagementScreenState extends State<PotManagementScreen> {
  final _functions = FirebaseFunctions.instanceFor(region: 'africa-south1');
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

  // Distribution mode flags
  bool _dailyAutoDistribute = true;
  bool _weeklyAutoDistribute = true;
  bool _flagsLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBalances();
    _loadActivePots();
    _loadDistributionHistory();
    _loadDistributionFlags();
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
            ? {...dailyQuery.docs.first.data(), '__docId__': dailyQuery.docs.first.id}
            : null;
        _activeWeeklyPot = weeklyQuery.docs.isNotEmpty
            ? {...weeklyQuery.docs.first.data(), '__docId__': weeklyQuery.docs.first.id}
            : null;
      });
    } catch (e) {
      debugPrint('PotManagement: Failed to load active pots: $e');
    }
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

  Future<void> _loadDistributionFlags() async {
    try {
      final doc = await _db
          .collection('platformSettings')
          .doc('pots')
          .get();

      if (!mounted) return;

      if (doc.exists) {
        final data = doc.data() ?? {};
        setState(() {
          _dailyAutoDistribute = data['dailyPotAutoDistribute'] ?? true;
          _weeklyAutoDistribute = data['weeklyPotAutoDistribute'] ?? true;
          _flagsLoading = false;
        });
      } else {
        setState(() => _flagsLoading = false);
      }
    } catch (_) {
      if (mounted) setState(() => _flagsLoading = false);
    }
  }

  Future<void> _saveDistributionFlag(String key, bool value) async {
    try {
      await _db
          .collection('platformSettings')
          .doc('pots')
          .set({key: value}, SetOptions(merge: true));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${key == 'dailyPotAutoDistribute' ? 'Daily' : 'Weekly'} pot set to ${value ? 'Scheduled' : 'Manual'}'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showSettingsDialog() {
    // Use local copies so the dialog switches update immediately
    bool dailyAuto = _dailyAutoDistribute;
    bool weeklyAuto = _weeklyAutoDistribute;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.adminCard,
          title: const Text(
            'Distribution Settings',
            style: TextStyle(color: AppColors.textPrimaryDark),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose whether pots are distributed automatically by the scheduled Cloud Function or manually using the buttons on this page.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              if (_flagsLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else ...[
              SwitchListTile(
                title: const Text(
                  'Daily Pot',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                subtitle: Text(
                  dailyAuto ? 'Scheduled (8 PM SAST daily)' : 'Manual only',
                  style: TextStyle(
                    fontSize: 12,
                    color: dailyAuto ? AppColors.success : AppColors.warning,
                  ),
                ),
                value: dailyAuto,
                activeThumbColor: AppColors.success,
                onChanged: (v) {
                  setDialogState(() => dailyAuto = v);
                  setState(() => _dailyAutoDistribute = v);
                  _saveDistributionFlag('dailyPotAutoDistribute', v);
                },
              ),
              SwitchListTile(
                title: const Text(
                  'Weekly Pot',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                subtitle: Text(
                  weeklyAuto ? 'Scheduled (Sun 8 PM SAST)' : 'Manual only',
                  style: TextStyle(
                    fontSize: 12,
                    color: weeklyAuto ? AppColors.success : AppColors.warning,
                  ),
                ),
                value: weeklyAuto,
                activeThumbColor: AppColors.success,
                onChanged: (v) {
                  setDialogState(() => weeklyAuto = v);
                  setState(() => _weeklyAutoDistribute = v);
                  _saveDistributionFlag('weeklyPotAutoDistribute', v);
                },
              ),
              const Divider(height: 24),
              Text(
                'If the scheduled pot creation missed, use this to create today\'s daily pot and this week\'s weekly pot.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _initializePots();
                  },
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: const Text('Initialize Pots'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 40),
                  ),
                ),
              ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _distributeDailyPot() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text(
          'Distribute Daily Pot',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: const Text(
          'This will immediately distribute the daily pot to today\'s top earners. '
          'This action cannot be undone.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Distribute Now'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 16),
            const Text(
              'Distributing daily pot...',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
          ],
        ),
      ),
    );

    try {
      final result = await _functions
          .httpsCallable('adminDistributeDailyPot')
          .call({'potId': _activeDailyPot?['__docId__']});
      final data = result.data as Map<String, dynamic>;

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message'] as String? ?? 'Distribution complete'),
          backgroundColor: AppColors.success,
        ),
      );
      _refresh();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to distribute: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _distributeWeeklyPot() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text(
          'Distribute Weekly Pot',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: const Text(
          'This will immediately distribute the weekly pot to this week\'s top earners. '
          'This action cannot be undone.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Distribute Now'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 16),
            const Text(
              'Distributing weekly pot...',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
          ],
        ),
      ),
    );

    try {
      final result = await _functions
          .httpsCallable('adminDistributeWeeklyPot')
          .call({'potId': _activeWeeklyPot?['__docId__']});
      final data = result.data as Map<String, dynamic>;

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message'] as String? ?? 'Distribution complete'),
          backgroundColor: AppColors.success,
        ),
      );
      _refresh();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to distribute: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _initializePots() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 16),
            const Text(
              'Initializing pots...',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
          ],
        ),
      ),
    );

    try {
      final result = await _functions
          .httpsCallable('adminInitializePots')
          .call();
      final data = result.data as Map<String, dynamic>;

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message'] as String? ?? 'Pots initialized'),
          backgroundColor: AppColors.success,
        ),
      );
      _refresh();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to initialize pots: $e'),
          backgroundColor: AppColors.error,
        ),
      );
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
      if (diff.isNegative) return 'Awaiting draw';
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
      backgroundColor: AppColors.adminBackground,
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: _showSettingsDialog,
                        icon: const Icon(Icons.settings, size: 22),
                        tooltip: 'Distribution Settings',
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
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
                  color: AppColors.adminCard,
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
    final participants = (activePot?['participantCount'] as num?)?.toInt() ?? 0;
    final periodEnd = activePot?['periodEnd'];
    final isActive = activePot?['isActive'] == true;
    // Check if pot period has ended but not yet distributed
    final bool periodEnded = periodEnd is Timestamp &&
        periodEnd.toDate().isBefore(DateTime.now());
    final bool awaitingDraw = isActive && periodEnded;

    // Status badge
    String statusLabel;
    Color statusColor;
    if (awaitingDraw) {
      statusLabel = 'Awaiting draw';
      statusColor = AppColors.warning;
    } else if (isActive) {
      statusLabel = 'Active';
      statusColor = AppColors.success;
    } else {
      statusLabel = 'No active pot';
      statusColor = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.adminCard,
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
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
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
                      awaitingDraw ? 'Status' : 'Time Remaining',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isActive ? _timeRemaining(periodEnd) : '--',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: awaitingDraw
                            ? AppColors.warning
                            : AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isActive && periodEnd is Timestamp) ...[
            const SizedBox(height: 8),
            Text(
              'Period: ${_fmtTimestamp(activePot?['periodStart'])} — ${_fmtTimestamp(periodEnd)}',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
          if (isActive && activePot?['__docId__'] != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go(
                  '/pot-entries?potId=${activePot!['__docId__']}',
                ),
                icon: const Icon(Icons.list_alt, size: 18),
                label: const Text('Show Entries'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color.withValues(alpha: 0.4)),
                  minimumSize: const Size(0, 38),
                ),
              ),
            ),
          ],
          if (isActive) ...[
            const SizedBox(height: 8),
            Builder(builder: (_) {
              final isAuto = type == 'Daily'
                  ? _dailyAutoDistribute
                  : _weeklyAutoDistribute;
              final modeLabel = isAuto ? 'Scheduled' : 'Manual';
              final modeColor = isAuto ? AppColors.success : AppColors.warning;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isAuto ? Icons.schedule : Icons.touch_app,
                    size: 14,
                    color: modeColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Mode: $modeLabel',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: modeColor,
                    ),
                  ),
                  if (isAuto) ...[
                    Text(
                      ' — ${type == 'Daily' ? '8 PM SAST daily' : 'Sun 8 PM SAST'}',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              );
            }),
            if (!(type == 'Daily' ? _dailyAutoDistribute : _weeklyAutoDistribute)) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: type == 'Daily'
                      ? _distributeDailyPot
                      : _distributeWeeklyPot,
                  icon: const Icon(Icons.emoji_events, size: 18),
                  label: Text('Distribute $type Pot'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    minimumSize: const Size(0, 40),
                  ),
                ),
              ),
            ],
          ],
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
          final totalParticipants = (dist['totalParticipants'] as num?)?.toInt() ?? (dist['participantCount'] as num?)?.toInt() ?? 0;
          final totalTokens = (dist['totalTokens'] as num?)?.toInt() ?? 0;

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
        backgroundColor: AppColors.adminCard,
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
                      final rank = (winner['rank'] as num?)?.toInt() ?? 0;
                      final name =
                          winner['displayName'] as String? ?? 'User';
                      final tokens = (winner['tokensWon'] as num?)?.toInt() ?? 0;
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
