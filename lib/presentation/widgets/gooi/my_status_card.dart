import 'package:flutter/material.dart';

import '../../../domain/entities/gooi_contribution.dart';
import '../../../domain/entities/gooi_cycle.dart';
import '../../../domain/entities/gooi_group.dart';
import '../../../domain/entities/gooi_member.dart';
import '../../../domain/enums/gooi_cycle_status.dart';
import '../../../domain/enums/gooi_member_role.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class MyStatusCard extends StatelessWidget {
  final GooiGroup? group;
  final GooiCycle? currentCycle;
  final List<GooiMember> members;
  final List<GooiContribution> contributions;
  final String? currentUserId;
  final bool isActionInProgress;
  final void Function(String? subAccountId) onContribute;
  final VoidCallback onTriggerPayout;

  const MyStatusCard({
    super.key,
    this.group,
    this.currentCycle,
    required this.members,
    required this.contributions,
    this.currentUserId,
    required this.isActionInProgress,
    required this.onContribute,
    required this.onTriggerPayout,
  });

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null || currentCycle == null) {
      return const SizedBox.shrink();
    }

    final myMember = members.where((m) => m.userId == currentUserId).firstOrNull;
    final myContribution = contributions.where((c) => c.userId == currentUserId).firstOrNull;
    final isRecipient = currentCycle!.recipientUserId == currentUserId;
    final isInitiator = myMember?.isInitiator ?? false;
    final canTrigger = isInitiator || (myMember?.role.canTriggerPayout ?? false);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status header
            Row(
              children: [
                Icon(
                  isRecipient ? Icons.star : Icons.person,
                  color: isRecipient ? AppColors.gold : AppColors.teal,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  isRecipient ? 'You are the RECIPIENT this cycle!' : 'Your Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isRecipient ? AppColors.gold : null,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Contribution status
            if (myContribution != null) ...[
              Text(
                myContribution.isPaid
                    ? 'Contribution: PAID (R${(myContribution.amountTotal / 100).toStringAsFixed(0)})'
                    : myContribution.isOutstanding
                        ? 'Contribution: ${myContribution.status.name.toUpperCase()}'
                        : 'Status: ${myContribution.status.name.toUpperCase()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (myContribution.hasLateFee)
                Text(
                  'Late fee: R${(myContribution.lateFee! / 100).toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.error),
                ),
            ],
            const SizedBox(height: AppSpacing.md),

            // Action buttons
            if (myContribution != null && myContribution.isOutstanding && !isRecipient)
              ElevatedButton.icon(
                onPressed: isActionInProgress ? null : () => onContribute(null),
                icon: const Icon(Icons.payment),
                label: Text(isActionInProgress ? 'Processing...' : 'PAY NOW'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teal,
                  minimumSize: const Size.fromHeight(44),
                ),
              ),

            if (canTrigger && currentCycle!.status == GooiCycleStatus.awaitingTrigger) ...[
              const SizedBox(height: AppSpacing.sm),
              ElevatedButton.icon(
                onPressed: isActionInProgress ? null : onTriggerPayout,
                icon: const Icon(Icons.send),
                label: Text(isActionInProgress ? 'Processing...' : 'TRIGGER PAYOUT'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  minimumSize: const Size.fromHeight(44),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
