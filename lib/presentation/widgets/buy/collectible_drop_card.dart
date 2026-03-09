import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/entities/featured_item.dart';
import '../../theme/app_colors.dart';

/// A dark card for limited-edition collectible drops with countdown timer
/// and quantity remaining progress bar.
class CollectibleDropCard extends StatefulWidget {
  final FeaturedItem item;
  final VoidCallback onClaimTap;

  /// Total available quantity (from featured item data map if present).
  final int totalQuantity;

  /// Quantity already claimed.
  final int claimedQuantity;

  const CollectibleDropCard({
    super.key,
    required this.item,
    required this.onClaimTap,
    this.totalQuantity = 100,
    this.claimedQuantity = 0,
  });

  @override
  State<CollectibleDropCard> createState() => _CollectibleDropCardState();
}

class _CollectibleDropCardState extends State<CollectibleDropCard> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  bool get _isExpired => _remaining <= Duration.zero;
  bool get _isSoldOut => widget.claimedQuantity >= widget.totalQuantity;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    if (!_isExpired) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        _updateRemaining();
      });
    }
  }

  void _updateRemaining() {
    final end = widget.item.scheduledEnd;
    if (end == null) {
      setState(() => _remaining = Duration.zero);
      return;
    }
    final now = DateTime.now();
    setState(() {
      _remaining = end.isAfter(now) ? end.difference(now) : Duration.zero;
    });
    if (_isExpired) _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.totalQuantity > 0
        ? widget.claimedQuantity / widget.totalQuantity
        : 0.0;
    final spotsLeft = widget.totalQuantity - widget.claimedQuantity;
    final isDisabled = _isExpired || _isSoldOut;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDisabled
              ? AppColors.border
              : AppColors.gold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDisabled
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDisabled
                      ? AppColors.border
                      : AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _isSoldOut
                      ? 'Sold Out'
                      : _isExpired
                          ? 'Expired'
                          : 'Limited Edition',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isDisabled ? AppColors.textTertiary : AppColors.gold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Countdown timer
          if (!_isExpired && !_isSoldOut) ...[
            Text(
              _formatDuration(_remaining),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Progress bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(
                      isDisabled ? AppColors.textTertiary : AppColors.success,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${widget.claimedQuantity} of ${widget.totalQuantity}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          if (!isDisabled) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (spotsLeft <= 10)
                  Text(
                    '$spotsLeft spots left!',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.error,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                ElevatedButton(
                  onPressed: widget.onClaimTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.textOnPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Claim',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
