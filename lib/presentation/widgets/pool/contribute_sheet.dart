import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/entities/token_pool.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet for contributing tokens to a pool.
class ContributeSheet extends StatefulWidget {
  final TokenPool pool;
  final int availableBalance;
  final void Function(int amount, bool anonymous) onContribute;

  const ContributeSheet({
    super.key,
    required this.pool,
    required this.availableBalance,
    required this.onContribute,
  });

  @override
  State<ContributeSheet> createState() => _ContributeSheetState();
}

class _ContributeSheetState extends State<ContributeSheet> {
  final _amountController = TextEditingController();
  bool _anonymous = false;
  String? _error;

  static const _quickAmounts = [50, 100, 200, 500];

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
    if (amount < 10) {
      setState(() => _error = 'Minimum contribution is 10 tokens');
      return;
    }
    if (amount > 100000) {
      setState(() => _error = 'Maximum contribution is 100,000 tokens');
      return;
    }
    if (amount > widget.availableBalance) {
      setState(() => _error = 'Insufficient balance');
      return;
    }
    widget.onContribute(amount, _anonymous);
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
              'Contribute',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.verticalSm,

            // Balance
            Text(
              'Available: ${widget.availableBalance} tokens',
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
                return ActionChip(
                  label: Text('$amount'),
                  onPressed: () => _setAmount(amount),
                  backgroundColor: AppColors.tokenGold.withValues(alpha: 0.1),
                  labelStyle: TextStyle(color: AppColors.tokenGold),
                );
              }).toList(),
            ),
            AppSpacing.verticalMd,

            // Anonymous toggle (sasaza mode only)
            if (widget.pool.isSasaza)
              CheckboxListTile(
                value: _anonymous,
                onChanged: (v) => setState(() => _anonymous = v ?? false),
                title: Text(
                  'Hide my name from ${widget.pool.recipientName ?? 'the recipient'}',
                  style: theme.textTheme.bodyMedium,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            AppSpacing.verticalMd,

            // Contribute button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _amount >= 10 ? _submit : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Contribute'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
