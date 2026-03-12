import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// "Make an Offer" bottom sheet (Spec §8.6, §8.8).
///
/// Price input pre-filled at 80% of listing price.
/// Shows token amount + ZAR conversion.
/// 24-hour expiry notice.
class MakeOfferSheet extends StatefulWidget {
  final int originalPrice;
  final String listingTitle;
  final void Function(int offerAmount) onSubmit;

  const MakeOfferSheet({
    super.key,
    required this.originalPrice,
    required this.listingTitle,
    required this.onSubmit,
  });

  @override
  State<MakeOfferSheet> createState() => _MakeOfferSheetState();
}

class _MakeOfferSheetState extends State<MakeOfferSheet> {
  late final TextEditingController _controller;
  late int _offerAmount;

  @override
  void initState() {
    super.initState();
    _offerAmount = (widget.originalPrice * 0.8).round();
    _controller = TextEditingController(text: _offerAmount.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _offerAmount > 0 && _offerAmount <= widget.originalPrice;

  int get _discountPercent =>
      widget.originalPrice > 0
          ? ((1 - _offerAmount / widget.originalPrice) * 100).round()
          : 0;

  String get _zarAmount =>
      'R${(_offerAmount / 100.0).toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            bottom: AppSpacing.lg +
                MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.buyDivider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              const Text(
                'Make an Offer',
                style: TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.listingTitle,
                style: const TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.lg),

              // Listed price
              Row(
                children: [
                  const Text(
                    'Listed price: ',
                    style: TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '${widget.originalPrice} tokens',
                    style: const TextStyle(
                      color: AppColors.buyTextPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(R${(widget.originalPrice / 100.0).toStringAsFixed(2)})',
                    style: const TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Offer input
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (v) {
                  setState(() {
                    _offerAmount = int.tryParse(v) ?? 0;
                  });
                },
                style: const TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  labelText: 'Your offer (tokens)',
                  labelStyle:
                      const TextStyle(color: AppColors.buyTextSecondary),
                  suffixText: _zarAmount,
                  suffixStyle: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: AppColors.buyBackground,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(
                        color: AppColors.buyCardBorder, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(
                        color: AppColors.buyCardBorder, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(
                        color: AppColors.buyMarketplaceAccent, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Discount info
              if (_offerAmount > 0 && _discountPercent > 0)
                Text(
                  '$_discountPercent% below listed price',
                  style: TextStyle(
                    color: _discountPercent > 30
                        ? AppColors.buyWarning
                        : AppColors.buySuccess,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

              if (_offerAmount > widget.originalPrice)
                const Text(
                  'Offer cannot exceed listed price',
                  style: TextStyle(
                    color: AppColors.buyError,
                    fontSize: 12,
                  ),
                ),

              const SizedBox(height: AppSpacing.md),

              // Expiry notice
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color:
                      AppColors.buyMarketplaceAccent.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.timer_outlined,
                        size: 14, color: AppColors.buyMarketplaceAccent),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Offers expire after 24 hours if the seller '
                        'doesn\'t respond.',
                        style: TextStyle(
                          color: AppColors.buyTextSecondary,
                          fontSize: 11,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isValid
                      ? () {
                          Navigator.pop(context);
                          widget.onSubmit(_offerAmount);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buyMarketplaceAccent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.buyMarketplaceAccent.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Send Offer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
