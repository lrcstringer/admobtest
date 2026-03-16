import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/group_transaction.dart';
import '../../blocs/group/group_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

@Deprecated('Use community/PendingApprovalsScreen instead. Will be removed in a future cleanup PR.')
class PendingApprovalsScreen extends StatelessWidget {
  final String groupId;

  const PendingApprovalsScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Pending Approvals'),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state.operationStatus == GroupOperationStatus.success &&
              state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            context.read<GroupBloc>().add(const GroupEvent.clearError());
          } else if (state.operationStatus == GroupOperationStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<GroupBloc>().add(const GroupEvent.clearError());
          }
        },
        builder: (context, state) {
          final approvals = state.selectedGroupApprovals;
          final isLoading = state.operationStatus == GroupOperationStatus.processing;

          if (approvals.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: AppColors.success.withValues(alpha: 0.5),
                  ),
                  AppSpacing.verticalMd,
                  Text(
                    'No pending approvals',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'All transactions have been processed',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              ListView.builder(
                padding: AppSpacing.pagePadding,
                itemCount: approvals.length,
                itemBuilder: (context, index) {
                  final approval = approvals[index];
                  return _buildApprovalCard(context, approval);
                },
              ),
              if (isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildApprovalCard(BuildContext context, PendingApproval approval) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      color: Color.alphaBlend(
        AppColors.tertiaryGradient[0].withValues(alpha: 0.04),
        Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.warning.withValues(alpha: 0.2),
                  child: Icon(
                    Icons.pending_actions,
                    color: AppColors.warning,
                  ),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (approval.transactionType?.name ?? 'TRANSACTION').toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Requested ${_formatDate(approval.createdAt)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'R${((approval.amount ?? 0) / 100).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
            AppSpacing.verticalMd,

            // Description
            if (approval.description != null && approval.description!.isNotEmpty)
              Container(
                width: double.infinity,
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Text(
                  approval.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            if (approval.description != null && approval.description!.isNotEmpty)
              AppSpacing.verticalMd,

            // Approval progress
            _buildApprovalProgress(context, approval),
            AppSpacing.verticalMd,

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showRejectDialog(context, approval),
                    icon: const Icon(Icons.close),
                    label: const Text('Reject'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                    ),
                  ),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<GroupBloc>().add(
                            GroupEvent.approveTransaction(
                              groupId: groupId,
                              transactionId: approval.transactionId,
                            ),
                          );
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Approve'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalProgress(BuildContext context, PendingApproval approval) {
    final approvedCount = approval.approvers.length;
    final requiredCount = approval.requiredApprovers.length;

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Approval Progress',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              Text(
                '$approvedCount / $requiredCount',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          AppSpacing.verticalSm,
          LinearProgressIndicator(
            value: requiredCount > 0 ? approvedCount / requiredCount : 0,
            backgroundColor: Theme.of(context).colorScheme.outline,
            valueColor: AlwaysStoppedAnimation(
              approvedCount >= requiredCount ? AppColors.success : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, PendingApproval approval) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reject Transaction'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to reject this transaction?'),
            AppSpacing.verticalMd,
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (optional)',
                hintText: 'Why are you rejecting?',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<GroupBloc>().add(
                    GroupEvent.rejectTransaction(
                      groupId: groupId,
                      transactionId: approval.transactionId,
                      reason: reasonController.text.trim().isNotEmpty
                          ? reasonController.text.trim()
                          : null,
                    ),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      if (diff.inHours == 0) return '${diff.inMinutes}m ago';
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}
