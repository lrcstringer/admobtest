import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Live countdown timer that ticks every second.
///
/// Displays HH:MM:SS or MM:SS in monospace digits. Turns red when < 24 h,
/// shows "Expired" when the deadline has passed.
class CountdownTimerWidget extends StatefulWidget {
  final DateTime deadline;
  final double fontSize;
  final TextAlign textAlign;

  const CountdownTimerWidget({
    super.key,
    required this.deadline,
    this.fontSize = 18,
    this.textAlign = TextAlign.start,
  });

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  bool get _isExpired => _remaining <= Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    if (!_isExpired) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        _updateRemaining();
      });
    }
  }

  @override
  void didUpdateWidget(covariant CountdownTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.deadline != widget.deadline) {
      _timer?.cancel();
      _updateRemaining();
      if (!_isExpired) {
        _timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (!mounted) return;
          _updateRemaining();
        });
      }
    }
  }

  void _updateRemaining() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.deadline.isAfter(now)
          ? widget.deadline.difference(now)
          : Duration.zero;
    });
    if (_isExpired) _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isExpired) {
      return Text(
        'Expired',
        textAlign: widget.textAlign,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.buyTextTertiary,
        ),
      );
    }

    final isUrgent = _remaining.inHours < 24;
    final color = isUrgent ? AppColors.buyError : AppColors.primary;

    return Text(
      _formatDuration(_remaining),
      textAlign: widget.textAlign,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'monospace',
        color: color,
      ),
    );
  }

  String _formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}d ${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
