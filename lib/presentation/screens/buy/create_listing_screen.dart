import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
  final List<File> _selectedImages = [];
  final _imagePicker = ImagePicker();
  bool _isUploadingImages = false;

  static const int _maxImages = 5;

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
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        title: const Text('Create Listing'),
        backgroundColor: AppColors.background,
      ),
      body: BlocConsumer<MarketplaceBloc, MarketplaceState>(
        listener: (context, state) {
          if (state.createSuccessId != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Listing created — now live!'),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'What are you selling?',
                          style: TextStyle(
                            color: AppColors.buyTextPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Your listing goes live immediately',
                          style: TextStyle(
                            color: AppColors.buyTextSecondary,
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
                            color: AppColors.buyTextPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: MarketplaceCategory.values
                              .map((cat) {
                            final isSelected = _selectedCategory == cat;
                            return ChoiceChip(
                              label:
                                  Text('${cat.emoji} ${cat.displayName}'),
                              selected: isSelected,
                              onSelected: (_) =>
                                  setState(() => _selectedCategory = cat),
                              selectedColor:
                                  AppColors.buyMarketplaceAccent.withValues(alpha: 0.2),
                              backgroundColor: AppColors.buyCard,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? AppColors.buyMarketplaceAccent
                                    : AppColors.buyTextPrimary,
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
                          builder: (_, value, _) {
                            final tokens = int.tryParse(value.text) ?? 0;
                            if (tokens <= 0) return const SizedBox.shrink();
                            final zar = tokens / 100;
                            return Text(
                              '≈ R${zar.toStringAsFixed(2)} ZAR',
                              style: const TextStyle(
                                color: AppColors.buyTextSecondary,
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
                            color: AppColors.buyTextPrimary,
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
                  color: AppColors.buyCard,
                  border: Border(
                    top: BorderSide(color: AppColors.buyCardBorder, width: 0.5),
                  ),
                ),
                child: SafeArea(
                  child: AppButton(
                    text: 'Publish Listing',
                    variant: AppButtonVariant.primary,
                    isLoading: state.isCreating || _isUploadingImages,
                    loadingText: _isUploadingImages
                        ? 'Uploading photos...'
                        : 'Publishing...',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Selected images
              ..._selectedImages.asMap().entries.map((entry) {
                final index = entry.key;
                final file = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                        child: Image.file(
                          file,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedImages.removeAt(index));
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: AppColors.buyError,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              // Add button
              if (_selectedImages.length < _maxImages)
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.buyCardBorder),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                      color: AppColors.buyCard,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_photo_alternate_outlined,
                          color: AppColors.buyTextTertiary,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_selectedImages.length}/$_maxImages',
                          style: const TextStyle(
                            color: AppColors.buyTextTertiary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (_selectedImages.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Add up to 5 photos',
              style: TextStyle(color: AppColors.buyTextTertiary, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (picked == null) return;

    final file = File(picked.path);
    if (_selectedImages.length >= _maxImages) return;

    setState(() => _selectedImages.add(file));
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
          backgroundColor: AppColors.buyError,
        ),
      );
      return;
    }

    final bloc = context.read<MarketplaceBloc>();

    // Upload selected images first via BLoC
    if (_selectedImages.isNotEmpty) {
      setState(() => _isUploadingImages = true);

      try {
        final userId = context.read<MarketplaceBloc>().state.currentSellerProfile?.id ?? 'unknown';
        final tempId = 'draft_${userId}_${DateTime.now().millisecondsSinceEpoch}';
        final imageData = await Future.wait(
          _selectedImages.map((f) => f.readAsBytes()),
        );

        bloc.add(MarketplaceEvent.uploadImages(
          imageData: imageData,
          listingId: tempId,
        ));

        // Wait for the upload to complete by listening to state changes
        final resultState = await bloc.stream.firstWhere(
          (s) => !s.isUploadingImages,
        );

        if (!mounted) return;
        setState(() => _isUploadingImages = false);

        if (resultState.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resultState.errorMessage!),
              backgroundColor: AppColors.buyError,
            ),
          );
          return;
        }

        if (resultState.uploadedImageUrls.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to upload images'),
              backgroundColor: AppColors.buyError,
            ),
          );
          return;
        }

        if (!mounted) return;

        bloc.add(MarketplaceEvent.createListing(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory!.name,
          priceTokens: int.parse(_priceController.text.trim()),
          imageUrls: resultState.uploadedImageUrls,
          location: _locationController.text.trim().isEmpty
              ? null
              : _locationController.text.trim(),
        ));
        return;
      } catch (e) {
        if (!mounted) return;
        setState(() => _isUploadingImages = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload images: $e'),
            backgroundColor: AppColors.buyError,
          ),
        );
        return;
      }
    }

    if (!mounted) return;

    bloc.add(MarketplaceEvent.createListing(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory!.name,
      priceTokens: int.parse(_priceController.text.trim()),
      imageUrls: const [],
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
    ));
  }
}
