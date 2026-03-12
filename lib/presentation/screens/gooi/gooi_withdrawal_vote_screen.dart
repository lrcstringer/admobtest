import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/gooi/gooi_dashboard_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiWithdrawalVoteScreen extends StatelessWidget {
  final String groupId;
  final String withdrawalId;
  final String memberName;
  final String? reason;

  const GooiWithdrawalVoteScreen({
    super.key,
    required this.groupId,
    required this.withdrawalId,
    required this.memberName,
    this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Withdrawal Vote')),
      body: BlocConsumer<GooiDashboardBloc, GooiDashboardState>(
        listener: (context, state) {
          if (state.actionSuccess != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionSuccess!)),
            );
            Navigator.pop(context);
          }
          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: AppColors.gold.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.how_to_vote, color: AppColors.gold),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                '$memberName wants to withdraw',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        if (reason != null && reason!.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Reason: $reason',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Withdrawal Rules',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildRule(context, 'Requires 80% group approval'),
                _buildRule(context, 'Refund based on contributions minus payouts'),
                _buildRule(context, 'Outstanding debts deducted from refund'),
                _buildRule(context, 'Reserve share is forfeited'),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: state.isActionInProgress
                            ? null
                            : () {
                                context.read<GooiDashboardBloc>().add(
                                      GooiDashboardEvent.voteWithdrawal(
                                        withdrawalId: withdrawalId,
                                        approve: false,
                                      ),
                                    );
                              },
                        icon: const Icon(Icons.close),
                        label: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: state.isActionInProgress
                            ? null
                            : () {
                                context.read<GooiDashboardBloc>().add(
                                      GooiDashboardEvent.voteWithdrawal(
                                        withdrawalId: withdrawalId,
                                        approve: true,
                                      ),
                                    );
                              },
                        icon: const Icon(Icons.check),
                        label: const Text('Approve'),
                        style: FilledButton.styleFrom(backgroundColor: AppColors.teal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRule(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 16, color: Colors.grey),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
