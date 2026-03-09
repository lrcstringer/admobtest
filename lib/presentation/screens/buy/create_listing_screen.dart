import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/marketplace_category.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

/// Screen for creating a new marketplace listing.
/// Goes live immediately — no admin approval required.
class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  MarketplaceCategory? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Listing'),
        backgroundColor: AppColors.surface,
      ),
      body: BlocConsumer<MarketplaceBloc, MarketplaceState>(
        listener: (context, state) {
          if (state.createSuccessId != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Listing created — now live!'),
                backgroundColor: AppColors.success,
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
                backgroundColor: AppColors.error,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'What are you selling?',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Your listing goes live immediately',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Title
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            hintText: 'e.g. Fresh Vetkoek — 6 pack',
                          ),
                          maxLength: 100,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Title is required'
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Description
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Describe what you\'re offering...',
                          ),
                          maxLines: 4,
                          maxLength: 500,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Description is required'
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Category
                        const Text(
                          'Category',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: MarketplaceCategory.values
                              .where(
                                  (c) => c != MarketplaceCategory.groupBuys)
                              .map((cat) {
                            final isSelected = _selectedCategory == cat;
                            return ChoiceChip(
                              label:
                                  Text('${cat.emoji} ${cat.displayName}'),
                              selected: isSelected,
                              onSelected: (_) =>
                                  setState(() => _selectedCategory = cat),
                              selectedColor:
                                  AppColors.primary.withValues(alpha: 0.2),
                              backgroundColor: AppColors.surfaceElevated,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Price
                        TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                            labelText: 'Price (tokens)',
                            hintText: 'e.g. 150',
                            suffixText: 'tokens',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Price is required';
                            }
                            final amount = int.tryParse(v.trim());
                            if (amount == null || amount <= 0) {
                              return 'Enter a valid price';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _priceController,
                          builder: (_, value, __) {
                            final tokens = int.tryParse(value.text) ?? 0;
                            if (tokens <= 0) return const SizedBox.shrink();
                            final zar = tokens / 100;
                            return Text(
                              '≈ R${zar.toStringAsFixed(2)} ZAR',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Location
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location (optional)',
                            hintText: 'e.g. Khayelitsha, Cape Town',
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Images placeholder
                        const Text(
                          'Photos',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildImagePicker(),
                      ],
                    ),
                  ),
                ),
              ),

              // Submit button
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(color: AppColors.border, width: 0.5),
                  ),
                ),
                child: SafeArea(
                  child: AppButton(
                    text: 'Publish Listing',
                    variant: AppButtonVariant.primary,
                    isLoading: state.isCreating,
                    onPressed: _onSubmit,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColors.textHint,
              size: 32,
            ),
            SizedBox(height: 4),
            Text(
              'Add up to 5 photos',
              style: TextStyle(color: AppColors.textHint, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    context.read<MarketplaceBloc>().add(
          MarketplaceEvent.createListing(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            category: _selectedCategory!.name,
            priceTokens: int.parse(_priceController.text.trim()),
            imageUrls: const [], // TODO: Image upload integration
            location: _locationController.text.trim().isEmpty
                ? null
                : _locationController.text.trim(),
          ),
        );
  }
}
