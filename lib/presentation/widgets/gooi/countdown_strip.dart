import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/enums/gooi_cycle_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class CountdownStrip extends StatefulWidget {
  final DateTime dueDate;
  final DateTime graceCloseDate;
  final GooiCycleStatus cycleStatus;

  const CountdownStrip({
    super.key,
    required this.dueDate,
    required this.graceCloseDate,
    required this.cycleStatus,
  });

  @override
  State<CountdownStrip> createState() => _CountdownStripState();
}

class _CountdownStripState extends State<CountdownStrip> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _calculateRemaining());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateRemaining() {
    final now = DateTime.now();
    final target = widget.cycleStatus == GooiCycleStatus.collecting
        ? widget.dueDate
        : widget.graceCloseDate;
    setState(() {
      _remaining = target.difference(now);
      if (_remaining.isNegative) _remaining = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    // Color transitions: teal (>3d) → gold (1-3d) → pink (<1d)
    Color accentColor;
    if (_remaining.inDays >= 3) {
      accentColor = AppColors.teal;
    } else if (_remaining.inDays >= 1) {
      accentColor = AppColors.gold;
    } else {
      accentColor = AppColors.primary;
    }

    final label = widget.cycleStatus == GooiCycleStatus.collecting
        ? 'Due in'
        : widget.cycleStatus == GooiCycleStatus.awaitingTrigger
            ? 'Grace closes in'
            : 'Cycle';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer, color: accentColor, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '$label  ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: accentColor),
          ),
          _TimeSegment(value: days, label: 'd', color: accentColor),
          _TimeSegment(value: hours, label: 'h', color: accentColor),
          _TimeSegment(value: minutes, label: 'm', color: accentColor),
          _TimeSegment(value: seconds, label: 's', color: accentColor),
        ],
      ),
    );
  }
}

class _TimeSegment extends StatelessWidget {
  final int value;
  final String label;
  final Color color;

  const _TimeSegment({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
          children: [
            TextSpan(text: value.toString().padLeft(2, '0')),
            TextSpan(
              text: label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
