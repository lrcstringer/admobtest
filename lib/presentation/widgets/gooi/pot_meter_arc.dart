import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../domain/entities/gooi_contribution.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class PotMeterArc extends StatelessWidget {
  final int totalExpected;
  final int totalCollected;
  final int memberCount;
  final List<GooiContribution> contributions;

  const PotMeterArc({
    super.key,
    required this.totalExpected,
    required this.totalCollected,
    required this.memberCount,
    required this.contributions,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalExpected > 0 ? totalCollected / totalExpected : 0.0;
    final collectedZar = (totalCollected / 100).toStringAsFixed(0);
    final expectedZar = (totalExpected / 100).toStringAsFixed(0);

    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(180, 180),
            painter: _ArcPainter(
              progress: progress.clamp(0.0, 1.0),
              paidCount: contributions.where((c) => c.isPaid).length,
              totalCount: memberCount,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'R$collectedZar',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.teal,
                    ),
              ),
              Text(
                'of R$expectedZar',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.teal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final int paidCount;
  final int totalCount;

  _ArcPainter({
    required this.progress,
    required this.paidCount,
    required this.totalCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const startAngle = math.pi * 0.75;
    const sweepAngle = math.pi * 1.5;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Progress arc
    final progressPaint = Paint()
      ..color = AppColors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      progressPaint,
    );

    // Member segment dots
    if (totalCount > 0) {
      for (var i = 0; i < totalCount; i++) {
        final angle = startAngle + (sweepAngle * (i + 0.5) / totalCount);
        final dotCenter = Offset(
          center.dx + (radius + 16) * math.cos(angle),
          center.dy + (radius + 16) * math.sin(angle),
        );

        final dotPaint = Paint()
          ..color = i < paidCount ? AppColors.teal : Colors.grey.shade600;

        canvas.drawCircle(dotCenter, 4, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      paidCount != oldDelegate.paidCount ||
      totalCount != oldDelegate.totalCount;
}
