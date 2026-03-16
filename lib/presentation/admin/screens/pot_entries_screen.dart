import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Displays all participant entries for a given pot.
///
/// Daily pots show a flat ranked list.
/// Weekly pots show entries grouped by day in expandable sections,
/// sorted in decreasing day order.
class PotEntriesScreen extends StatefulWidget {
  final String potId;

  const PotEntriesScreen({super.key, required this.potId});

  @override
  State<PotEntriesScreen> createState() => _PotEntriesScreenState();
}

class _PotEntriesScreenState extends State<PotEntriesScreen> {
  final _functions = FirebaseFunctions.instanceFor(region: 'africa-south1');
  final _numberFormat = NumberFormat('#,###');
  final _dateFormat = DateFormat('EEE, d MMM yyyy');

  bool _loading = true;
  String? _error;

  String _potType = 'daily';
  String? _periodStart;
  String? _periodEnd;
  int _totalEntries = 0;
  List<_EntryRow> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final result = await _functions
          .httpsCallable('adminGetPotEntries')
          .call({'potId': widget.potId});

      final data = result.data as Map<String, dynamic>;
      final rawEntries = (data['entries'] as List<dynamic>?) ?? [];

      setState(() {
        _potType = data['potType'] as String? ?? 'daily';
        _periodStart = data['periodStart'] as String?;
        _periodEnd = data['periodEnd'] as String?;
        _totalEntries = data['totalEntries'] as int? ?? 0;
        _entries = rawEntries.map((e) {
          final m = e as Map<String, dynamic>;
          return _EntryRow(
            userId: m['userId'] as String? ?? '',
            displayName: m['displayName'] as String? ?? 'User',
            username: m['username'] as String?,
            avatarUrl: m['avatarUrl'] as String?,
            finalScore: (m['finalScore'] as num?)?.toInt() ?? 0,
            engagementsCompleted:
                (m['engagementsCompleted'] as num?)?.toInt() ?? 0,
            date: m['date'] as String? ?? '',
          );
        }).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeLabel = _potType == 'weekly' ? 'Weekly' : 'Daily';

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: Text('$typeLabel Pot Entries'),
        backgroundColor: AppColors.adminSurface,
      ),
      body: _loading
          ? const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : _error != null
              ? _buildError()
              : _entries.isEmpty
                  ? _buildEmpty()
                  : RefreshIndicator(
                      onRefresh: _loadEntries,
                      child: _buildContent(),
                    ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,
                color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text(
              'Failed to load entries',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _loadEntries,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined,
              color: AppColors.textSecondary, size: 48),
          const SizedBox(height: 16),
          Text(
            'No entries yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Participants will appear here once they complete engagements.',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummary(),
          const SizedBox(height: 24),
          if (_potType == 'weekly')
            _buildWeeklyGrouped()
          else
            _buildDailyFlat(),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    String periodText = '';
    if (_periodStart != null && _periodEnd != null) {
      try {
        final start = DateTime.parse(_periodStart!);
        final end = DateTime.parse(_periodEnd!);
        periodText =
            '${_dateFormat.format(start)} — ${_dateFormat.format(end)}';
      } catch (_) {
        periodText = '$_periodStart — $_periodEnd';
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.adminCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceElevated),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Participants',
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  _numberFormat.format(_totalEntries),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ],
            ),
          ),
          if (periodText.isNotEmpty)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Period',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    periodText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimaryDark,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ── Daily: flat ranked list ──────────────────────────────────────

  Widget _buildDailyFlat() {
    // Already sorted by finalScore DESC from server
    final sorted = List<_EntryRow>.from(_entries)
      ..sort((a, b) => b.finalScore.compareTo(a.finalScore));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ranked by Score',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(sorted.length, (i) {
          return _buildEntryCard(sorted[i], rank: i + 1);
        }),
      ],
    );
  }

  // ── Weekly: grouped by day ───────────────────────────────────────

  Widget _buildWeeklyGrouped() {
    // Group entries by date
    final grouped = <String, List<_EntryRow>>{};
    for (final entry in _entries) {
      grouped.putIfAbsent(entry.date, () => []).add(entry);
    }

    // Sort each group by finalScore DESC
    for (final list in grouped.values) {
      list.sort((a, b) => b.finalScore.compareTo(a.finalScore));
    }

    // Sort groups by date DESC
    final sortedDates = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entries by Day',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        ...sortedDates.map((date) {
          final dayEntries = grouped[date]!;
          String displayDate;
          try {
            displayDate = _dateFormat.format(DateTime.parse(date));
          } catch (_) {
            displayDate = date;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.adminCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.surfaceElevated),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                initiallyExpanded: sortedDates.indexOf(date) == 0,
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                childrenPadding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                title: Text(
                  displayDate,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${dayEntries.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.expand_more,
                        color: AppColors.textPrimaryDark, size: 20),
                  ],
                ),
                children: List.generate(dayEntries.length, (i) {
                  return _buildEntryCard(dayEntries[i],
                      rank: i + 1, compact: true);
                }),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ── Entry card ───────────────────────────────────────────────────

  Widget _buildEntryCard(_EntryRow entry,
      {required int rank, bool compact = false}) {
    final Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700); // gold
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0); // silver
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32); // bronze
    } else {
      rankColor = AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: compact ? 8 : 12, horizontal: compact ? 0 : 16),
      decoration: compact
          ? null
          : BoxDecoration(
              color: AppColors.adminCard,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.surfaceElevated),
            ),
      margin: EdgeInsets.only(bottom: compact ? 4 : 8),
      child: Row(
        children: [
          // Rank badge
          SizedBox(
            width: 36,
            child: Center(
              child: rank <= 3
                  ? CircleAvatar(
                      radius: 14,
                      backgroundColor: rankColor.withValues(alpha: 0.2),
                      child: Text(
                        '#$rank',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: rankColor,
                        ),
                      ),
                    )
                  : Text(
                      '#$rank',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.displayName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (entry.username != null && entry.username!.isNotEmpty)
                  Text(
                    '@${entry.username}',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          // Score
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _numberFormat.format(entry.finalScore),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '${entry.engagementsCompleted} task${entry.engagementsCompleted == 1 ? '' : 's'}',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EntryRow {
  final String userId;
  final String displayName;
  final String? username;
  final String? avatarUrl;
  final int finalScore;
  final int engagementsCompleted;
  final String date;

  const _EntryRow({
    required this.userId,
    required this.displayName,
    this.username,
    this.avatarUrl,
    required this.finalScore,
    required this.engagementsCompleted,
    required this.date,
  });
}
