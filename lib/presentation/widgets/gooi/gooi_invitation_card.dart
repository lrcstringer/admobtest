import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiInvitationCard extends StatelessWidget {
  final String groupName;
  final String inviterName;
  final int contributionAmount;
  final String frequency;
  final int totalCycles;
  final bool isLoading;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const GooiInvitationCard({
    super.key,
    required this.groupName,
    required this.inviterName,
    required this.contributionAmount,
    required this.frequency,
    required this.totalCycles,
    this.isLoading = false,
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.groups, color: AppColors.teal, size: 24),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Gooi-Gooi Invitation',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            groupName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Invited by $inviterName', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'R${(contributionAmount / 100).toStringAsFixed(0)} · $frequency · $totalCycles cycles',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: AppSpacing.md),
          if (onAccept != null || onDecline != null)
            Row(
              children: [
                if (onDecline != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isLoading ? null : onDecline,
                      child: const Text('Decline'),
                    ),
                  ),
                if (onAccept != null && onDecline != null) const SizedBox(width: AppSpacing.sm),
                if (onAccept != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : onAccept,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal),
                      child: isLoading
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Accept'),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
