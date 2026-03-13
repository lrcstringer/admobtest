import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

/// Screen for making an offer on a marketplace listing.
class MakeOfferScreen extends StatefulWidget {
  final String listingId;
  final int listingPriceTokens;
  final String listingTitle;

  const MakeOfferScreen({
    super.key,
    required this.listingId,
    required this.listingPriceTokens,
    required this.listingTitle,
  });

  @override
  State<MakeOfferScreen> createState() => _MakeOfferScreenState();
}

class _MakeOfferScreenState extends State<MakeOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();

  double get _priceZar => widget.listingPriceTokens / 100;

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitOffer() {
    final isMakingOffer = context.read<MarketplaceBloc>().state.isMakingOffer;
    if (!_formKey.currentState!.validate() || isMakingOffer) return;

    final offerZar = double.tryParse(_amountController.text);
    if (offerZar == null || offerZar <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final offerTokens = (offerZar * 100).round();

    context.read<MarketplaceBloc>().add(
          MarketplaceEvent.makeOffer(
            listingId: widget.listingId,
            offerAmount: offerTokens,
            message: _messageController.text.trim().isNotEmpty
                ? _messageController.text.trim()
                : null,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MarketplaceBloc, MarketplaceState>(
      listenWhen: (prev, curr) =>
          prev.isMakingOffer && !curr.isMakingOffer,
      listener: (context, state) {
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Offer of R${_amountController.text} submitted for ${widget.listingTitle}',
              ),
              backgroundColor: AppColors.buySuccess,
            ),
          );
          context.pop();
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        title: const Text('Make an Offer'),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Listing info
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.buyCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.listingTitle,
                      style: const TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Listed price: R${_priceZar.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.buyTextSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Offer amount
              TextFormField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: AppColors.buyTextPrimary),
                decoration: InputDecoration(
                  labelText: 'Your offer (ZAR)',
                  prefixText: 'R',
                  hintText: '0.00',
                  filled: true,
                  fillColor: AppColors.buyCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyCardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyCardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyMarketplaceAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter an amount';
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  if ((amount * 100).round() >= widget.listingPriceTokens) {
                    return 'Offer must be less than listing price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Optional message
              TextFormField(
                controller: _messageController,
                maxLines: 3,
                maxLength: 500,
                style: const TextStyle(color: AppColors.buyTextPrimary),
                decoration: InputDecoration(
                  labelText: 'Message to seller (optional)',
                  hintText: 'Explain your offer...',
                  filled: true,
                  fillColor: AppColors.buyCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyCardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyCardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyMarketplaceAccent),
                  ),
                ),
              ),

              const Spacer(),

              // Submit button
              BlocBuilder<MarketplaceBloc, MarketplaceState>(
                buildWhen: (prev, curr) =>
                    prev.isMakingOffer != curr.isMakingOffer,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      text: 'Submit Offer',
                      variant: AppButtonVariant.primary,
                      isLoading: state.isMakingOffer,
                      loadingText: 'Submitting...',
                      onPressed: state.isMakingOffer ? null : _submitOffer,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
