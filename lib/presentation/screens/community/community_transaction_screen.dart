import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';

/// Reusable screen for community contribute / withdraw operations.
///
/// Pass [type] to control the mode.
enum CommunityTransactionType { contribute, withdraw }

class CommunityTransactionScreen extends StatefulWidget {
  final String communityId;
  final CommunityTransactionType type;

  const CommunityTransactionScreen({
    super.key,
    required this.communityId,
    required this.type,
  });

  @override
  State<CommunityTransactionScreen> createState() =>
      _CommunityTransactionScreenState();
}

class _CommunityTransactionScreenState
    extends State<CommunityTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool get isContribution =>
      widget.type == CommunityTransactionType.contribute;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state.operationStatus == CommunityOperationStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMessage ??
                    (isContribution
                        ? 'Contribution successful!'
                        : 'Withdrawal requested!'),
              ),
              backgroundColor: AppColors.success,
            ),
          );
          context.pop();
        } else if (state.operationStatus == CommunityOperationStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Transaction failed'),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        }
      },
      builder: (context, state) {
        final community = state.selectedCommunity;
        final isLoading =
            state.operationStatus == CommunityOperationStatus.processing;

        return Scaffold(
          appBar: IMaliAppBar(title: isContribution ? 'Contribute' : 'Withdraw'),
          body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
        overlayAsset: AppColors.waveOverlay,
            child: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Balance Card ──
                  if (community != null) _buildBalanceCard(context, community),
                  AppSpacing.verticalLg,

                  // ── Amount Field ──
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount (ZAR)',
                      hintText: '0.00',
                      prefixText: 'R ',
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: isContribution
                            ? AppColors.success
                            : AppColors.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: Theme.of(context).textTheme.headlineSmall,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      if (!isContribution && community != null) {
                        final tokens = (amount * 100).round();
                        if (tokens > community.totalBalance) {
                          return 'Amount exceeds community balance';
                        }
                      }
                      return null;
                    },
                  ),
                  AppSpacing.verticalMd,

                  // ── Description ──
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description (optional)',
                      hintText: isContribution
                          ? 'e.g. Monthly contribution'
                          : 'e.g. Emergency withdrawal',
                      prefixIcon: const Icon(Icons.note_outlined),
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                    ),
                    maxLength: 100,
                  ),
                  AppSpacing.verticalMd,

                  // ── Approval Notice (withdrawals) ──
                  if (!isContribution && community != null)
                    _buildApprovalNotice(context, community),
                  AppSpacing.verticalLg,

                  // ── Submit ──
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isContribution
                            ? AppColors.success
                            : AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.textOnPrimary,
                              ),
                            )
                          : Text(
                              isContribution ? 'Contribute' : 'Request Withdrawal',
                              style: const TextStyle(fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
        );
      },
    );
  }

  Widget _buildBalanceCard(BuildContext context, dynamic community) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.chatSurface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.chatSurface),
      ),
      child: Column(
        children: [
          Text(
            'Community Balance',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          AppSpacing.verticalXs,
          Text(
            'R${(community.totalBalance / 100).toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalNotice(BuildContext context, dynamic community) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusMd,
        border:
            Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.warning, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Withdrawals above R${(community.settings.requireApprovalAbove / 100).toStringAsFixed(2)} require admin approval.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.warning,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    // Fix force-unwrap on currentState
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;
    final tokens = (amount * 100).round();
    final description = _descriptionController.text.trim();

    // 8.8 Confirmation dialog before financial operations
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isContribution ? 'Confirm Contribution' : 'Confirm Withdrawal'),
        content: Text(
          '${isContribution ? "Contribute" : "Withdraw"} R${amount.toStringAsFixed(2)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (isContribution) {
                context.read<CommunityBloc>().add(
                      CommunityEvent.contribute(
                        communityId: widget.communityId,
                        amount: tokens,
                        description: description.isNotEmpty ? description : null,
                      ),
                    );
              } else {
                context.read<CommunityBloc>().add(
                      CommunityEvent.withdraw(
                        communityId: widget.communityId,
                        amount: tokens,
                        description: description.isNotEmpty ? description : null,
                      ),
                    );
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: isContribution ? AppColors.success : AppColors.primary,
            ),
            child: Text(isContribution ? 'Contribute' : 'Withdraw'),
          ),
        ],
      ),
    );
  }
}
