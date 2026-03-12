import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Inline review prompt shown after order completion (Spec §8.14).
///
/// Star rating (1-5) + optional comment text field + submit button.
class ReviewPromptWidget extends StatefulWidget {
  final String sellerName;
  final ValueChanged<({int rating, String? comment})> onSubmit;
  final VoidCallback? onSkip;

  const ReviewPromptWidget({
    super.key,
    required this.sellerName,
    required this.onSubmit,
    this.onSkip,
  });

  @override
  State<ReviewPromptWidget> createState() => _ReviewPromptWidgetState();
}

class _ReviewPromptWidgetState extends State<ReviewPromptWidget> {
  int _rating = 0;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How was your experience with ${widget.sellerName}?',
            style: const TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final starIndex = i + 1;
              return GestureDetector(
                onTap: () => setState(() => _rating = starIndex),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    starIndex <= _rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: 36,
                    color: starIndex <= _rating
                        ? AppColors.buyWarning
                        : AppColors.buyTextTertiary,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // Comment
          TextField(
            controller: _commentController,
            maxLines: 2,
            maxLength: 300,
            style: const TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              hintText: 'Add a comment (optional)',
              hintStyle: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 13,
              ),
              filled: true,
              fillColor: AppColors.buyBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide:
                    const BorderSide(color: AppColors.buyCardBorder, width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide:
                    const BorderSide(color: AppColors.buyCardBorder, width: 0.5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              counterStyle: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Actions
          Row(
            children: [
              if (widget.onSkip != null)
                TextButton(
                  onPressed: widget.onSkip,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.buyTextTertiary,
                  ),
                  child: const Text('Skip'),
                ),
              const Spacer(),
              FilledButton(
                onPressed: _rating > 0
                    ? () {
                        final comment = _commentController.text.trim();
                        widget.onSubmit((
                          rating: _rating,
                          comment: comment.isEmpty ? null : comment,
                        ));
                      }
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.buyMarketplaceAccent,
                  disabledBackgroundColor:
                      AppColors.buyMarketplaceAccent.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                ),
                child: const Text('Submit Review'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
