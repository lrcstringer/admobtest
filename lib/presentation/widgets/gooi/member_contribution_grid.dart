import 'package:flutter/material.dart';

import '../../../domain/entities/gooi_contribution.dart';
import '../../../domain/entities/gooi_cycle.dart';
import '../../../domain/entities/gooi_member.dart';
import '../../../domain/enums/gooi_contribution_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class MemberContributionGrid extends StatelessWidget {
  final List<GooiMember> members;
  final List<GooiContribution> contributions;
  final GooiCycle? currentCycle;

  const MemberContributionGrid({
    super.key,
    required this.members,
    required this.contributions,
    this.currentCycle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: members.map((member) {
        final contribution = contributions
            .where((c) => c.userId == member.userId)
            .firstOrNull;

        final isRecipient = currentCycle?.recipientUserId == member.userId;

        return _MemberTile(
          member: member,
          contribution: contribution,
          isRecipient: isRecipient,
        );
      }).toList(),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final GooiMember member;
  final GooiContribution? contribution;
  final bool isRecipient;

  const _MemberTile({
    required this.member,
    this.contribution,
    required this.isRecipient,
  });

  @override
  Widget build(BuildContext context) {
    final status = contribution?.status;
    final color = _statusColor(status, isRecipient);
    final label = _statusLabel(status, isRecipient);

    return SizedBox(
      width: 72,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.2),
                child: member.avatarUrl != null
                    ? ClipOval(child: Image.network(member.avatarUrl!, width: 48, height: 48, fit: BoxFit.cover))
                    : Text(
                        member.displayName.isNotEmpty ? member.displayName[0].toUpperCase() : '?',
                        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                  ),
                  child: Icon(_statusIcon(status, isRecipient), size: 10, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            member.displayName.split(' ').first,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Color _statusColor(GooiContributionStatus? status, bool isRecipient) {
    if (isRecipient) return AppColors.gold;
    if (status == null) return Colors.grey;
    switch (status) {
      case GooiContributionStatus.paid:
        return AppColors.teal;
      case GooiContributionStatus.pending:
        return AppColors.secondary;
      case GooiContributionStatus.late_:
        return AppColors.orange;
      case GooiContributionStatus.missed:
        return AppColors.error;
    }
  }

  IconData _statusIcon(GooiContributionStatus? status, bool isRecipient) {
    if (isRecipient) return Icons.star;
    if (status == null) return Icons.hourglass_empty;
    switch (status) {
      case GooiContributionStatus.paid:
        return Icons.check;
      case GooiContributionStatus.pending:
        return Icons.schedule;
      case GooiContributionStatus.late_:
        return Icons.warning;
      case GooiContributionStatus.missed:
        return Icons.close;
    }
  }

  String _statusLabel(GooiContributionStatus? status, bool isRecipient) {
    if (isRecipient) return 'RECIPIENT';
    if (status == null) return 'WAITING';
    switch (status) {
      case GooiContributionStatus.paid:
        return 'PAID';
      case GooiContributionStatus.pending:
        return 'PENDING';
      case GooiContributionStatus.late_:
        return 'LATE';
      case GooiContributionStatus.missed:
        return 'MISSED';
    }
  }
}
