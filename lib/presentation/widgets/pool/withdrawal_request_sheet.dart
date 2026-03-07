import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/entities/token_pool.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet for requesting a withdrawal from a Group Save pool.
class WithdrawalRequestSheet extends StatefulWidget {
  final TokenPool pool;
  final String currentUserId;
  final void Function(int amount) onWithdraw;

  const WithdrawalRequestSheet({
    super.key,
    required this.pool,
    required this.currentUserId,
    required this.onWithdraw,
  });

  @override
  State<WithdrawalRequestSheet> createState() => _WithdrawalRequestSheetState();
}

class _WithdrawalRequestSheetState extends State<WithdrawalRequestSheet> {
  final _amountController = TextEditingController();
  String? _error;

  int get _maxAmount => widget.pool.contributionFor(widget.currentUserId);

  List<int> get _quickAmounts {
    final max = _maxAmount;
    if (max <= 0) return [];
    final amounts = <int>[];
    if (max >= 50) amounts.add(50);
    if (max >= 100) amounts.add(100);
    if (max >= 200) amounts.add(200);
    // Always include "All"
    if (!amounts.contains(max)) amounts.add(max);
    return amounts;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  int get _amount => int.tryParse(_amountController.text) ?? 0;

  void _setAmount(int amount) {
    _amountController.text = amount.toString();
    setState(() => _error = null);
  }

  void _submit() {
    final amount = _amount;
    if (amount <= 0) {
      setState(() => _error = 'Enter an amount to withdraw');
      return;
    }
    if (amount > _maxAmount) {
      setState(() => _error = 'Maximum withdrawal is $_maxAmount tokens');
      return;
    }
    widget.onWithdraw(amount);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            AppSpacing.verticalMd,

            // Title
            Text(
              'Withdraw',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.verticalSm,

            // Max withdrawal info
            Text(
              'Your contribution: $_maxAmount tokens',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            AppSpacing.verticalMd,

            // Amount input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Amount',
                suffixText: 'tokens',
                errorText: _error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (_) => setState(() => _error = null),
            ),
            AppSpacing.verticalSm,

            // Quick amount chips
            Wrap(
              spacing: 8,
              children: _quickAmounts.map((amount) {
                final isAll = amount == _maxAmount;
                return ActionChip(
                  label: Text(isAll ? 'All ($amount)' : '$amount'),
                  onPressed: () => _setAmount(amount),
                  backgroundColor: AppColors.warning.withValues(alpha: 0.1),
                  labelStyle: TextStyle(color: AppColors.warning),
                );
              }).toList(),
            ),
            AppSpacing.verticalMd,

            // Withdraw button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _amount > 0 && _amount <= _maxAmount ? _submit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warning,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Withdraw'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
