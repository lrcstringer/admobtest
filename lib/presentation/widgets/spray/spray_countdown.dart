import 'dart:async';

import 'package:flutter/material.dart';

/// Animated countdown timer showing hours:minutes:seconds remaining
/// until a token spray expires.
class SprayCountdown extends StatefulWidget {
  final DateTime expiresAt;
  final TextStyle? style;

  const SprayCountdown({
    super.key,
    required this.expiresAt,
    this.style,
  });

  @override
  State<SprayCountdown> createState() => _SprayCountdownState();
}

class _SprayCountdownState extends State<SprayCountdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  @override
  void didUpdateWidget(covariant SprayCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expiresAt != widget.expiresAt) {
      _updateRemaining();
    }
  }

  void _updateRemaining() {
    final diff = widget.expiresAt.difference(DateTime.now());
    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
    if (diff.isNegative) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
    }
    if (minutes > 0) {
      return '${minutes}m ${seconds.toString().padLeft(2, '0')}s';
    }
    return '${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = _remaining == Duration.zero;
    final isUrgent = _remaining.inMinutes < 30 && !isExpired;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isExpired
            ? Colors.grey.withValues(alpha: 0.15)
            : isUrgent
                ? Colors.red.withValues(alpha: 0.15)
                : Colors.orange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isExpired ? Icons.timer_off : Icons.timer,
            size: 14,
            color: isExpired
                ? Colors.grey
                : isUrgent
                    ? Colors.red
                    : Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            isExpired ? 'Ended' : _formatDuration(_remaining),
            style: widget.style ??
                TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isExpired
                      ? Colors.grey
                      : isUrgent
                          ? Colors.red
                          : Colors.orange,
                ),
          ),
        ],
      ),
    );
  }
}
