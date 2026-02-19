import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet for contributing tokens to a spray.
class SprayContributeSheet extends StatefulWidget {
  final String sprayId;
  final String recipientName;
  final bool isContributing;
  final void Function(int amount, String? message) onContribute;

  const SprayContributeSheet({
    super.key,
    required this.sprayId,
    required this.recipientName,
    required this.isContributing,
    required this.onContribute,
  });

  @override
  State<SprayContributeSheet> createState() => _SprayContributeSheetState();
}

class _SprayContributeSheetState extends State<SprayContributeSheet> {
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount < 10) return;

    final message = _messageController.text.trim();
    widget.onContribute(amount, message.isEmpty ? null : message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textHint.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            Text(
              'Contribute to ${widget.recipientName}\'s spray',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),

            // Amount
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Amount (min 10 tokens)',
                prefixIcon: Icon(Icons.toll),
              ),
              validator: (value) {
                final amount = int.tryParse(value ?? '');
                if (amount == null || amount < 10) {
                  return 'Minimum contribution is 10 tokens';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.sm),

            // Quick chips
            Wrap(
              spacing: AppSpacing.sm,
              children: [50, 100, 200, 500].map((amount) {
                return ActionChip(
                  label: Text('$amount'),
                  onPressed: () => _amountController.text = '$amount',
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),

            // Optional message
            TextFormField(
              controller: _messageController,
              maxLength: 100,
              decoration: const InputDecoration(
                hintText: 'Add a message (optional)',
                prefixIcon: Icon(Icons.message_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Submit
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: widget.isContributing ? null : _onSubmit,
                icon: widget.isContributing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.volunteer_activism),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tertiary,
                  foregroundColor: AppColors.textOnPrimary,
                ),
                label: Text(widget.isContributing ? 'Contributing...' : 'Contribute'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
