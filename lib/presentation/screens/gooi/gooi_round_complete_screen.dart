import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/gooi_member.dart';
import '../../../domain/entities/gooi_payout.dart';
import '../../../domain/enums/gooi_payout_status.dart';
import '../../blocs/gooi/gooi_dashboard_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiRoundCompleteScreen extends StatelessWidget {
  final String groupId;
  const GooiRoundCompleteScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Round Summary')),
      body: BlocBuilder<GooiDashboardBloc, GooiDashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final group = state.group;
          if (group == null) {
            return const Center(child: Text('No group data'));
          }

          final isInitiator = group.initiatorUserId == state.currentUserId;
          final completedPayouts = state.payouts.where((p) => p.status == GooiPayoutStatus.completed).toList();
          final totalReserve = state.cycles.fold<int>(0, (sum, c) => sum + c.reserveCollected);
          final hasNegativeReserve = totalReserve < 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Completion banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.teal, AppColors.tealLight],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.celebration, color: Colors.white, size: 48),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Round Complete!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${group.totalCycles} cycles · ${group.memberCount} members',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Payout Summary
                Text('Payout Summary', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                ...completedPayouts.map((p) => _PayoutRow(
                      payout: p,
                      member: state.members.where((m) => m.userId == p.recipientUserId).firstOrNull,
                    )),
                const Divider(height: AppSpacing.lg),

                // Reserve Fund
                _SummaryRow(
                  label: 'Reserve Fund Balance',
                  value: 'R${(totalReserve / 100).toStringAsFixed(2)}',
                  valueColor: totalReserve >= 0 ? AppColors.teal : Colors.red,
                ),
                if (group.biddingDiscountPool > 0)
                  _SummaryRow(
                    label: 'Bidding Bonus Pool',
                    value: 'R${(group.biddingDiscountPool / 100).toStringAsFixed(2)}',
                    valueColor: AppColors.gold,
                  ),
                const SizedBox(height: AppSpacing.lg),

                // Bad Debt Write-Off (Initiator only)
                if (isInitiator && hasNegativeReserve) ...[
                  Card(
                    color: Colors.red.withValues(alpha: 0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bad Debt Write-Off Required',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.red),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'The reserve fund is negative (R${(totalReserve / 100).toStringAsFixed(2)}) due to unrecoverable member debts. '
                            'You must write off this bad debt to finalize the round.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: state.isActionInProgress
                                  ? null
                                  : () {
                                      context.read<GooiDashboardBloc>().add(
                                            const GooiDashboardEvent.writeOffBadDebt(),
                                          );
                                    },
                              style: FilledButton.styleFrom(backgroundColor: Colors.red),
                              child: state.isActionInProgress
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                  : const Text('Write Off Bad Debt'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Reserve Return info
                if (totalReserve > 0) ...[
                  Card(
                    color: AppColors.teal.withValues(alpha: 0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reserve Fund Return',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.teal),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'The remaining reserve of R${(totalReserve / 100).toStringAsFixed(2)} '
                            'will be distributed equally among all ${state.members.where((m) => m.status.name == 'active').length} active members.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PayoutRow extends StatelessWidget {
  final GooiPayout payout;
  final GooiMember? member;

  const _PayoutRow({required this.payout, this.member});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: AppColors.teal,
        child: Text(
          '${payout.cycleNumber}',
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(member?.displayName ?? 'Member'),
      subtitle: Text('Cycle ${payout.cycleNumber}'),
      trailing: Text(
        'R${(payout.totalPayoutAmount / 100).toStringAsFixed(0)}',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.teal,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
