import 'package:flutter/material.dart';

import '../../../domain/enums/spray_status.dart';

/// A token spray card rendered inside a community message bubble.
/// Shows occasion, progress, contributor count, countdown, and contribute button.
class SprayBubble extends StatelessWidget {
  final String sprayId;
  final String recipientName;
  final String occasion;
  final int currentTotal;
  final int contributorCount;
  final int? targetAmount;
  final SprayStatus status;
  final DateTime expiresAt;
  final String currentUserId;
  final String recipientId;
  final VoidCallback? onContribute;
  final VoidCallback? onTap;

  const SprayBubble({
    super.key,
    required this.sprayId,
    required this.recipientName,
    required this.occasion,
    required this.currentTotal,
    required this.contributorCount,
    this.targetAmount,
    required this.status,
    required this.expiresAt,
    required this.currentUserId,
    required this.recipientId,
    this.onContribute,
    this.onTap,
  });

  bool get _isRecipient => recipientId == currentUserId;
  bool get _isActive => status == SprayStatus.active;

  String get _remainingTime {
    final diff = expiresAt.difference(DateTime.now());
    if (diff.isNegative) return 'Ended';
    if (diff.inHours > 0) return '${diff.inHours}h ${diff.inMinutes % 60}m left';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m left';
    return 'Ending soon';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.withValues(alpha: 0.15),
              Colors.amber.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.celebration, color: Colors.orange, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Token Spray',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_isActive)
                  Text(
                    _remainingTime,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.orange,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Recipient + occasion
            Text(
              'For $recipientName',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              occasion,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),

            // Progress
            if (targetAmount != null && targetAmount! > 0) ...[
              LinearProgressIndicator(
                value: (currentTotal / targetAmount!).clamp(0.0, 1.0),
                backgroundColor: Colors.orange.withValues(alpha: 0.15),
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 4),
              Text(
                '$currentTotal / $targetAmount tokens',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ] else ...[
              Text(
                '$currentTotal tokens',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 4),

            // Contributor count
            Text(
              '$contributorCount contributor${contributorCount == 1 ? '' : 's'}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),

            // Action
            if (_isActive && !_isRecipient)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onContribute,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 32),
                  ),
                  child: const Text('Contribute'),
                ),
              )
            else if (!_isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status == SprayStatus.claimed ? 'Claimed' : 'Closed',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
