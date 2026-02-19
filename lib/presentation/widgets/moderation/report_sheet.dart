import 'package:flutter/material.dart';

import '../../../domain/enums/report_reason.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet for reporting a user, message, or community.
class ReportSheet extends StatefulWidget {
  final String targetName;
  final void Function(ReportReason reason, String? additionalInfo) onSubmit;

  const ReportSheet({
    super.key,
    required this.targetName,
    required this.onSubmit,
  });

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  ReportReason? _selectedReason;
  final _additionalInfoController = TextEditingController();

  @override
  void dispose() {
    _additionalInfoController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedReason == null) return;
    final info = _additionalInfoController.text.trim();
    widget.onSubmit(_selectedReason!, info.isEmpty ? null : info);
    Navigator.of(context).pop();
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
            'Report ${widget.targetName}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),

          Text(
            'Select a reason for your report:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Reason selection
          RadioGroup<ReportReason>(
            groupValue: _selectedReason,
            onChanged: (val) => setState(() => _selectedReason = val),
            child: Column(
              children: ReportReason.values.map((reason) {
                return RadioListTile<ReportReason>(
                  title: Text(reason.displayName),
                  value: reason,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Additional info
          TextField(
            controller: _additionalInfoController,
            maxLines: 3,
            maxLength: 500,
            decoration: const InputDecoration(
              hintText: 'Additional details (optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Submit
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _selectedReason != null ? _submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.textOnPrimary,
              ),
              child: const Text('Submit Report'),
            ),
          ),
        ],
      ),
    );
  }
}
