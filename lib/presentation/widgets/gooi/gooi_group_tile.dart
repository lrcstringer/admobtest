import 'package:flutter/material.dart';

import '../../../domain/entities/gooi_group.dart';
import '../../../domain/enums/gooi_group_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiGroupTile extends StatelessWidget {
  final GooiGroup group;
  final VoidCallback? onTap;

  const GooiGroupTile({
    super.key,
    required this.group,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: _statusColor(group.status).withValues(alpha: 0.2),
                child: Icon(
                  _statusIcon(group.status),
                  color: _statusColor(group.status),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'R${group.contributionZar.toStringAsFixed(0)} · ${group.cycleFrequency.name} · ${group.memberCount} members',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                    if (group.currentCycle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Cycle ${group.currentCycleNumber}/${group.totalCycles}: ${group.currentCycle!.status}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.teal,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              _StatusChip(status: group.status),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(GooiGroupStatus status) {
    switch (status) {
      case GooiGroupStatus.forming:
        return AppColors.secondary;
      case GooiGroupStatus.active:
        return AppColors.teal;
      case GooiGroupStatus.completed:
        return AppColors.gold;
      case GooiGroupStatus.dissolved:
        return Colors.grey;
    }
  }

  IconData _statusIcon(GooiGroupStatus status) {
    switch (status) {
      case GooiGroupStatus.forming:
        return Icons.group_add;
      case GooiGroupStatus.active:
        return Icons.sync;
      case GooiGroupStatus.completed:
        return Icons.check_circle;
      case GooiGroupStatus.dissolved:
        return Icons.cancel;
    }
  }
}

class _StatusChip extends StatelessWidget {
  final GooiGroupStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      GooiGroupStatus.forming => AppColors.secondary,
      GooiGroupStatus.active => AppColors.teal,
      GooiGroupStatus.completed => AppColors.gold,
      GooiGroupStatus.dissolved => Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
