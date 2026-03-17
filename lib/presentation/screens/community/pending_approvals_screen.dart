import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/community_transaction.dart';
import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Screen showing pending transaction approvals for a community.
///
/// Admin / treasurer users can approve or reject transactions here.
class PendingApprovalsScreen extends StatelessWidget {
  final String communityId;

  const PendingApprovalsScreen({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state.operationStatus == CommunityOperationStatus.success &&
            state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.success,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        } else if (state.operationStatus == CommunityOperationStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Operation failed'),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        }
      },
      builder: (context, state) {
        final approvals = state.selectedCommunityApprovals;

        return Scaffold(
          backgroundColor: AppColors.chatBackground,
          appBar: IMaliAppBar(
            title: 'Approvals (${approvals.length})',
            backgroundColor: AppColors.chatBackground,
          ),
          body: approvals.isEmpty
              ? _buildEmptyState(context)
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: approvals.length,
                  itemBuilder: (context, index) => _ApprovalCard(
                    approval: approvals[index],
                    communityId: communityId,
                  ),
                ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          AppSpacing.verticalSm,
          Text(
            'All transactions have been processed',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// APPROVAL CARD
// =============================================================================

class _ApprovalCard extends StatelessWidget {
  final CommunityApproval approval;
  final String communityId;

  const _ApprovalCard({
    required this.approval,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) {
    // 8.10 Check processing state to disable buttons during operations
    final isProcessing = context.select<CommunityBloc, bool>(
      (bloc) => bloc.state.operationStatus == CommunityOperationStatus.processing,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      AppColors.warning.withValues(alpha: 0.2),
                  child:
                      const Icon(Icons.pending_actions, color: AppColors.warning),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        approval.type.name.toUpperCase(),
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'By ${approval.requestedByName}',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'R${(approval.amount / 100).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),

            // ── Description ──
            if (approval.description != null &&
                approval.description!.isNotEmpty) ...[
              AppSpacing.verticalMd,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.chatSurface,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Text(
                  approval.description!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],

            // ── Approval Progress ──
            AppSpacing.verticalMd,
            _buildProgress(context),

            // ── Actions ──
            // 8.10 Disable buttons during processing
            if (approval.isPending) ...[
              AppSpacing.verticalMd,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isProcessing ? null : () => _showRejectDialog(context),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Reject'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      // 8.7 Confirmation dialog before approve
                      onPressed: isProcessing ? null : () => _showApproveDialog(context),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // ── Timestamp ──
            AppSpacing.verticalSm,
            Text(
              'Requested ${_formatDate(approval.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress(BuildContext context) {
    final approved = approval.approvalCount;
    final required = approval.requiredApprovals;
    final progress = required > 0 ? approved / required : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Approvals',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            Text(
              '$approved / $required',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        AppSpacing.verticalXs,
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.chatSurface,
          valueColor: AlwaysStoppedAnimation(
            approved >= required ? AppColors.success : AppColors.primary,
          ),
        ),
      ],
    );
  }

  // 8.7 Confirmation dialog before approve
  void _showApproveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Approve Transaction'),
        content: Text(
          'Approve ${approval.type.name} of R${(approval.amount / 100).toStringAsFixed(2)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CommunityBloc>().add(
                    CommunityEvent.approveTransaction(
                      communityId: communityId,
                      transactionId: approval.transactionId,
                    ),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.success),
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
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
              context.read<CommunityBloc>().add(
                    CommunityEvent.rejectTransaction(
                      communityId: communityId,
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
    // 8.14 Dispose reasonController when dialog closes
    ).then((_) => reasonController.dispose());
  }

  String _formatDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';
}
