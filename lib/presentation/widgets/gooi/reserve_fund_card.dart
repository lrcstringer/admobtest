import 'package:flutter/material.dart';

import '../../../domain/entities/gooi_cycle.dart';
import '../../../domain/entities/gooi_group.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class ReserveFundCard extends StatelessWidget {
  final GooiGroup group;
  final List<GooiCycle> cycles;

  const ReserveFundCard({
    super.key,
    required this.group,
    required this.cycles,
  });

  @override
  Widget build(BuildContext context) {
    final totalReserve = cycles.fold<int>(0, (sum, c) => sum + c.reserveCollected);
    final reserveZar = totalReserve / 100;
    final reserveRate = (group.reserveRate * 100).toStringAsFixed(0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reserve Fund',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.teal.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$reserveRate%',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  totalReserve >= 0 ? Icons.shield : Icons.warning,
                  color: totalReserve >= 0 ? AppColors.teal : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'R${reserveZar.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: totalReserve >= 0 ? AppColors.teal : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            if (totalReserve < 0) ...[
              const SizedBox(height: 4),
              Text(
                'Reserve is negative — Initiator must write off bad debt at round close',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
