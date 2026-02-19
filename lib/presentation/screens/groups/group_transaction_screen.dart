import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/group/group_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

enum TransactionType { contribute, withdraw }

@Deprecated('Use CommunityTransactionScreen instead. Will be removed in a future cleanup PR.')
class GroupTransactionScreen extends StatefulWidget {
  final String groupId;
  final TransactionType type;

  const GroupTransactionScreen({
    super.key,
    required this.groupId,
    required this.type,
  });

  @override
  State<GroupTransactionScreen> createState() => _GroupTransactionScreenState();
}

class _GroupTransactionScreenState extends State<GroupTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get isContribution => widget.type == TransactionType.contribute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: isContribution ? 'Contribute' : 'Withdraw'),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state.operationStatus == GroupOperationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? 'Transaction successful!'),
                backgroundColor: AppColors.success,
              ),
            );
            context.pop();
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
          final isLoading = state.operationStatus == GroupOperationStatus.processing;
          final group = state.selectedGroup;

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Group balance info
                  if (group != null)
                    Container(
                      width: double.infinity,
                      padding: AppSpacing.cardPadding,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppSpacing.borderRadiusMd,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          AppSpacing.verticalXs,
                          Text(
                            'Current Balance: R${(group.totalBalance / 100).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  AppSpacing.verticalLg,

                  // Transaction type indicator
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.cardPadding,
                    decoration: BoxDecoration(
                      color: (isContribution ? AppColors.success : AppColors.primary)
                          .withValues(alpha: 0.1),
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isContribution ? Icons.add_circle : Icons.remove_circle,
                          color: isContribution ? AppColors.success : AppColors.primary,
                          size: 32,
                        ),
                        AppSpacing.horizontalMd,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isContribution
                                  ? 'Contributing to Group'
                                  : 'Withdrawing from Group',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              isContribution
                                  ? 'Add tokens from your wallet to this group'
                                  : 'Transfer tokens from group to your wallet',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalLg,

                  // Amount field
                  Text(
                    'Amount (ZAR)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      hintText: '0.00',
                      prefixText: 'R ',
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: isContribution ? AppColors.success : AppColors.primary,
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: Theme.of(context).textTheme.headlineSmall,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      if (!isContribution && group != null) {
                        final tokensAmount = (amount * 100).round();
                        if (tokensAmount > group.totalBalance) {
                          return 'Amount exceeds group balance';
                        }
                      }
                      return null;
                    },
                  ),
                  AppSpacing.verticalMd,

                  // Description field
                  Text(
                    'Description (optional)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'What is this for?',
                      prefixIcon: Icon(Icons.note),
                    ),
                    maxLines: 2,
                  ),
                  AppSpacing.verticalXl,

                  // Approval notice
                  if (!isContribution && group != null)
                    Container(
                      width: double.infinity,
                      padding: AppSpacing.cardPadding,
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: AppSpacing.borderRadiusMd,
                        border: Border.all(
                          color: AppColors.warning.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.warning),
                          AppSpacing.horizontalMd,
                          Expanded(
                            child: Text(
                              'Withdrawals above R${(group.settings.requireApprovalAbove / 100).toStringAsFixed(2)} require approval from group admins.',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.warning,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  AppSpacing.verticalXl,

                  // Submit button
                  if (isContribution)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitTransaction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          isLoading ? 'Processing...' : 'Contribute',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  else
                    AppButton(
                      text: 'Request Withdrawal',
                      onPressed: isLoading ? null : _submitTransaction,
                      isLoading: isLoading,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitTransaction() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    final tokensAmount = (amount * 100).round();
    final description = _descriptionController.text.trim();

    if (isContribution) {
      context.read<GroupBloc>().add(
            GroupEvent.contributeToGroup(
              groupId: widget.groupId,
              amount: tokensAmount,
              description: description.isNotEmpty ? description : null,
            ),
          );
    } else {
      context.read<GroupBloc>().add(
            GroupEvent.withdrawFromGroup(
              groupId: widget.groupId,
              amount: tokensAmount,
              description: description.isNotEmpty ? description : null,
            ),
          );
    }
  }
}
