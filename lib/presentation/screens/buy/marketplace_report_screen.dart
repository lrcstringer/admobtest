import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

/// Report a marketplace listing or provider.
/// Reason picker + optional description.
class MarketplaceReportScreen extends StatefulWidget {
  final String targetType; // 'listing' or 'provider'
  final String targetId;

  const MarketplaceReportScreen({
    super.key,
    required this.targetType,
    required this.targetId,
  });

  @override
  State<MarketplaceReportScreen> createState() =>
      _MarketplaceReportScreenState();
}

class _MarketplaceReportScreenState extends State<MarketplaceReportScreen> {
  String? _selectedReason;
  final _descriptionController = TextEditingController();

  static const _reasons = [
    'Inappropriate content',
    'Scam / fraud',
    'Wrong category',
    'Offensive language',
    'Other',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isListing = widget.targetType == 'listing';

    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        title: Text('Report ${isListing ? 'Listing' : 'Seller'}'),
        backgroundColor: AppColors.background,
      ),
      body: BlocConsumer<MarketplaceBloc, MarketplaceState>(
        listener: (context, state) {
          if (state.reportSuccessMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.reportSuccessMessage!),
                backgroundColor: AppColors.buySuccess,
              ),
            );
            context
                .read<MarketplaceBloc>()
                .add(const MarketplaceEvent.clearMessages());
            context.pop();
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.buyError,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why are you reporting this '
                        '${isListing ? 'listing' : 'seller'}?',
                        style: const TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your report helps keep the marketplace safe',
                        style: TextStyle(
                          color: AppColors.buyTextSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Reason selection
                      ..._reasons.map((reason) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedReason = reason),
                              child: Container(
                                padding:
                                    const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: _selectedReason == reason
                                      ? AppColors.buyMarketplaceAccent
                                          .withValues(alpha: 0.1)
                                      : AppColors.buyCard,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _selectedReason == reason
                                        ? AppColors.buyMarketplaceAccent
                                        : AppColors.buyCardBorder,
                                    width: _selectedReason == reason
                                        ? 1.5
                                        : 0.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _selectedReason == reason
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: _selectedReason == reason
                                          ? AppColors.buyMarketplaceAccent
                                          : AppColors.buyTextSecondary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Text(
                                      reason,
                                      style: TextStyle(
                                        color: _selectedReason == reason
                                            ? AppColors.buyMarketplaceAccent
                                            : AppColors.buyTextPrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: AppSpacing.md),

                      // Description
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        maxLength: 300,
                        decoration: const InputDecoration(
                          labelText: 'Additional details (optional)',
                          hintText: 'Tell us more about the issue...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Submit
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: const BoxDecoration(
                  color: AppColors.buyCard,
                  border: Border(
                    top: BorderSide(color: AppColors.buyCardBorder, width: 0.5),
                  ),
                ),
                child: SafeArea(
                  child: AppButton(
                    text: 'Submit Report',
                    variant: AppButtonVariant.primary,
                    onPressed: _selectedReason == null ? null : _onSubmit,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onSubmit() {
    if (_selectedReason == null) return;

    final description = _descriptionController.text.trim().isEmpty
        ? null
        : _descriptionController.text.trim();

    if (widget.targetType == 'listing') {
      context.read<MarketplaceBloc>().add(
            MarketplaceEvent.reportListing(
              listingId: widget.targetId,
              reason: _selectedReason!,
              description: description,
            ),
          );
    } else {
      context.read<MarketplaceBloc>().add(
            MarketplaceEvent.reportProvider(
              providerId: widget.targetId,
              reason: _selectedReason!,
              description: description,
            ),
          );
    }
  }
}
