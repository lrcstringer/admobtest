import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

/// Form screen for users to suggest a group buy deal for admin review.
///
/// Previously "Create Hlangana Deal" — repurposed because group buys
/// are now admin-curated. Users suggest deals, admins create them.
class CreateGroupBuyScreen extends StatefulWidget {
  const CreateGroupBuyScreen({super.key});

  @override
  State<CreateGroupBuyScreen> createState() => _CreateGroupBuyScreenState();
}

class _CreateGroupBuyScreenState extends State<CreateGroupBuyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _brandOrStoreController = TextEditingController();
  final _estimatedPriceController = TextEditingController();
  final _sourceUrlController = TextEditingController();
  bool _wantsToJoin = true;

  @override
  void dispose() {
    _descriptionController.dispose();
    _brandOrStoreController.dispose();
    _estimatedPriceController.dispose();
    _sourceUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBuyBloc, GroupBuyState>(
      listenWhen: (prev, curr) =>
          prev.successId != curr.successId ||
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        if (state.successId != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage ?? 'Deal suggestion submitted!'),
              backgroundColor: AppColors.buySuccess,
            ),
          );
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
          context.pop();
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.buyError,
            ),
          );
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.buyBackground,
          appBar: AppBar(
            title: const Text('Suggest a Deal'),
            backgroundColor: AppColors.background,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.buyGroupBuyAccent.withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(
                        color: AppColors.buyGroupBuyAccent.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb_outline,
                            color: AppColors.buyGroupBuyAccent, size: 20),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Suggest a product or deal you\'d like to buy together. '
                            'Our team will review it and set up a group buy if there\'s enough interest!',
                            style: TextStyle(
                              color: AppColors.buyGroupBuyAccent,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Brand / Store
                  _buildLabel('Brand or Store'),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextField(
                    controller: _brandOrStoreController,
                    hint: 'e.g. Makro, PnP, Shoprite',
                    validator: (v) => v == null || v.trim().length < 2
                        ? 'Brand or store name is required'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Description
                  _buildLabel('What do you want to buy?'),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextField(
                    controller: _descriptionController,
                    hint: 'e.g. 25kg rice bags at bulk price, '
                        'or 12-pack cooking oil at wholesale rate',
                    maxLines: 3,
                    validator: (v) => v == null || v.trim().length < 10
                        ? 'Please describe the deal (at least 10 characters)'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Estimated price
                  _buildLabel('Estimated Price (tokens, optional)'),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextField(
                    controller: _estimatedPriceController,
                    hint: 'e.g. 5000',
                    keyboardType: TextInputType.number,
                  ),
                  if (_estimatedPriceController.text.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      '= R${((int.tryParse(_estimatedPriceController.text) ?? 0) / 100).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),

                  // Source URL
                  _buildLabel('Link to product (optional)'),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextField(
                    controller: _sourceUrlController,
                    hint: 'https://...',
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Wants to join toggle
                  SwitchListTile.adaptive(
                    value: _wantsToJoin,
                    onChanged: (v) => setState(() => _wantsToJoin = v),
                    title: const Text(
                      'I want to be first to join',
                      style: TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      'We\'ll notify you when the deal goes live',
                      style: TextStyle(
                        color: AppColors.buyTextSecondary,
                        fontSize: 12,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: AppColors.buyGroupBuyAccent,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Submit button
                  AppButton(
                    text: 'Submit Suggestion',
                    isLoading: state.isSuggestingDeal,
                    loadingText: 'Submitting...',
                    onPressed: _onSubmit,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.buyTextPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: AppColors.buyTextPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.buyTextTertiary),
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
          borderSide: const BorderSide(color: AppColors.buyGroupBuyAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.buyError),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      onChanged: (_) {
        if (controller == _estimatedPriceController) setState(() {});
      },
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final estimatedPrice = int.tryParse(_estimatedPriceController.text);
    final sourceUrl = _sourceUrlController.text.trim();

    context.read<GroupBuyBloc>().add(
          GroupBuyEvent.suggestDeal(
            description: _descriptionController.text.trim(),
            brandOrStore: _brandOrStoreController.text.trim(),
            estimatedPrice: estimatedPrice,
            sourceUrl: sourceUrl.isNotEmpty ? sourceUrl : null,
            wantsToJoin: _wantsToJoin,
          ),
        );
  }
}
