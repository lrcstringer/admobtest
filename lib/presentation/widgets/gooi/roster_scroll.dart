import 'package:flutter/material.dart';

import '../../../domain/entities/gooi_cycle.dart';
import '../../../domain/entities/gooi_group.dart';
import '../../../domain/entities/gooi_member.dart';
import '../../../domain/entities/gooi_payout.dart';
import '../../../domain/enums/gooi_payout_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'trust_score_badge.dart';

class RosterScroll extends StatelessWidget {
  final List<GooiMember> members;
  final List<GooiCycle> cycles;
  final List<GooiPayout> payouts;
  final GooiGroup? group;

  const RosterScroll({
    super.key,
    required this.members,
    required this.cycles,
    required this.payouts,
    this.group,
  });

  @override
  Widget build(BuildContext context) {
    final sortedMembers = List<GooiMember>.from(members)
      ..sort((a, b) => a.position.compareTo(b.position));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Roster', style: Theme.of(context).textTheme.titleMedium),
                if (group != null)
                  Text(
                    'Cycle ${group!.currentCycleNumber}/${group!.totalCycles}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...sortedMembers.asMap().entries.map((entry) {
              final index = entry.key;
              final member = entry.value;
              final payout = payouts
                  .where((p) => p.recipientUserId == member.userId)
                  .firstOrNull;
              final hasReceived = payout?.status == GooiPayoutStatus.completed;

              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: hasReceived
                      ? AppColors.teal
                      : AppColors.teal.withValues(alpha: 0.15),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: hasReceived ? Colors.white : AppColors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                title: Text(member.displayName),
                subtitle: TrustScoreBadge(member: member),
                trailing: hasReceived
                    ? const Icon(Icons.check_circle, color: AppColors.teal, size: 20)
                    : payout != null
                        ? Icon(Icons.hourglass_bottom, color: AppColors.gold, size: 20)
                        : null,
              );
            }),
          ],
        ),
      ),
    );
  }
}
