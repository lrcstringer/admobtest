import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/entities/token_pool.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet for distributing pool tokens (save mode).
class PoolDistributeSheet extends StatefulWidget {
  final TokenPool pool;
  final void Function(List<Map<String, dynamic>> payouts, bool keepOpen) onDistribute;

  const PoolDistributeSheet({
    super.key,
    required this.pool,
    required this.onDistribute,
  });

  @override
  State<PoolDistributeSheet> createState() => _PoolDistributeSheetState();
}

class _PoolDistributeSheetState extends State<PoolDistributeSheet> {
  late final Map<String, TextEditingController> _controllers;
  late final List<_ParticipantEntry> _participants;
  bool _keepOpen = false;

  @override
  void initState() {
    super.initState();
    _controllers = {};
    _participants = [];

    // Build participant list: organizer + invitees
    final pool = widget.pool;
    _addParticipant(pool.organizerId, pool.organizerName);
    for (final inviteeId in pool.inviteeIds) {
      final contrib = pool.contributions[inviteeId];
      _addParticipant(inviteeId, contrib?.displayName ?? 'Invitee');
    }
  }

  void _addParticipant(String userId, String name) {
    final controller = TextEditingController(text: '0');
    _controllers[userId] = controller;
    _participants.add(_ParticipantEntry(
      userId: userId,
      displayName: name,
      controller: controller,
    ));
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  int get _totalAllocated {
    int sum = 0;
    for (final c in _controllers.values) {
      sum += int.tryParse(c.text) ?? 0;
    }
    return sum;
  }

  int get _available => widget.pool.availableBalance;

  bool get _isValid =>
      _totalAllocated > 0 && _totalAllocated <= _available;

  bool get _isFullDistribution => _totalAllocated == _available;

  void _equalSplit() {
    final total = _available;
    final count = _participants.length;
    final base = total ~/ count;
    final remainder = total % count;

    for (int i = 0; i < _participants.length; i++) {
      final amount = base + (i < remainder ? 1 : 0);
      _controllers[_participants[i].userId]?.text = amount.toString();
    }
    setState(() {});
  }

  void _submit() {
    if (!_isValid) return;

    final payouts = _participants
        .map((p) => {
              'userId': p.userId,
              'amount': int.tryParse(_controllers[p.userId]?.text ?? '0') ?? 0,
            })
        .where((p) => (p['amount'] as int) > 0)
        .toList();

    widget.onDistribute(payouts, _keepOpen);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final available = _available;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            AppSpacing.verticalMd,

            // Title
            Text(
              'Distribute Pool',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.verticalSm,

            // Running total
            _buildTotalIndicator(theme, available),
            AppSpacing.verticalSm,

            // Quick actions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: _equalSplit,
                  icon: const Icon(Icons.balance, size: 18),
                  label: const Text('Equal Split'),
                ),
              ],
            ),
            AppSpacing.verticalSm,

            // Participant list
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _participants.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final p = _participants[index];
                  return _buildParticipantRow(theme, p);
                },
              ),
            ),

            // Keep-open toggle (shown when distributing full available balance)
            if (_isFullDistribution)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CheckboxListTile(
                  value: _keepOpen,
                  onChanged: (v) => setState(() => _keepOpen = v ?? false),
                  title: Text(
                    'Keep pool open for next round',
                    style: theme.textTheme.bodyMedium,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            AppSpacing.verticalMd,

            // Confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isValid ? _submit : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(_isFullDistribution && !_keepOpen
                    ? 'Distribute & Close'
                    : 'Distribute'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalIndicator(ThemeData theme, int available) {
    final allocated = _totalAllocated;
    final isOver = allocated > available;
    final isValid = allocated > 0 && allocated <= available;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isValid
            ? AppColors.success.withValues(alpha: 0.1)
            : isOver
                ? AppColors.error.withValues(alpha: 0.1)
                : AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.info_outline,
            size: 18,
            color: isValid
                ? AppColors.success
                : isOver
                    ? AppColors.error
                    : AppColors.warning,
          ),
          const SizedBox(width: 8),
          Text(
            '$allocated / $available available',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isValid
                  ? AppColors.success
                  : isOver
                      ? AppColors.error
                      : AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantRow(ThemeData theme, _ParticipantEntry p) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
          child: Text(
            p.displayName.isNotEmpty ? p.displayName[0].toUpperCase() : '?',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Name
        Expanded(
          child: Text(
            p.displayName,
            style: theme.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Amount input
        SizedBox(
          width: 100,
          child: TextField(
            controller: p.controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              suffixText: 'T',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
      ],
    );
  }
}

class _ParticipantEntry {
  final String userId;
  final String displayName;
  final TextEditingController controller;

  _ParticipantEntry({
    required this.userId,
    required this.displayName,
    required this.controller,
  });
}
