import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/enums/marketplace_category.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Listing Edit screen (Spec §8.2).
///
/// Reuses the create form pattern, pre-filled from existing listing.
/// - Category immutable after creation (shown disabled).
/// - Price locked when active orders or pending offers exist.
class EditListingScreen extends StatefulWidget {
  final String listingId;

  const EditListingScreen({super.key, required this.listingId});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _imagePicker = ImagePicker();

  MarketplaceListing? _listing;
  List<String> _existingImageUrls = [];
  final List<File> _newImages = [];
  bool _isLoading = true;
  bool _isSaving = false;
  // ignore: prefer_final_fields
  bool _priceLocked = false; // Set when active orders/offers exist (Phase 3.27)

  static const int _maxImages = 5;

  @override
  void initState() {
    super.initState();
    _loadListing();
  }

  Future<void> _loadListing() async {
    final bloc = context.read<MarketplaceBloc>();
    bloc.add(MarketplaceEvent.selectListing(widget.listingId));
  }

  void _populateForm(MarketplaceListing listing) {
    if (_listing != null) return; // Already populated
    _listing = listing;
    _titleController.text = listing.title;
    _descriptionController.text = listing.description;
    _priceController.text = listing.priceTokens.toString();
    _existingImageUrls = List.from(listing.images);
    if (listing.locationData?.suburb != null) {
      _locationController.text =
          '${listing.locationData!.suburb ?? ''}, ${listing.locationData!.city ?? ''}';
    }
    setState(() => _isLoading = false);
  }

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
        backgroundColor: AppColors.buyCard,
        foregroundColor: AppColors.buyTextPrimary,
        title: const Text(
          'Edit Listing',
        ),
      ),
      body: BlocConsumer<MarketplaceBloc, MarketplaceState>(
        listenWhen: (prev, curr) =>
            prev.selectedListing != curr.selectedListing ||
            prev.isLoadingDetail != curr.isLoadingDetail ||
            (prev.isUpdating && !curr.isUpdating),
        listener: (context, state) {
          if (state.selectedListing != null && _listing == null) {
            _populateForm(state.selectedListing!);
          }
          if (!state.isUpdating && _isSaving) {
            setState(() => _isSaving = false);
            if (state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Listing updated'),
                  backgroundColor: AppColors.buySuccess,
                ),
              );
              context.read<MarketplaceBloc>().add(const MarketplaceEvent.clearMessages());
              context.pop();
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.buyError,
                ),
              );
            }
          }
        },
        buildWhen: (prev, curr) =>
            prev.isLoadingDetail != curr.isLoadingDetail ||
            prev.selectedListing != curr.selectedListing,
        builder: (context, state) {
          if (state.isLoadingDetail || _isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buyMarketplaceAccent,
              ),
            );
          }

          final listing = _listing;
          if (listing == null) {
            return const Center(
              child: Text(
                'Listing not found',
                style: TextStyle(color: AppColors.buyTextSecondary),
              ),
            );
          }

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
                        // Photos
                        const Text(
                          'Photos',
                          style: TextStyle(
                            color: AppColors.buyTextPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildImageEditor(),
                        const SizedBox(height: AppSpacing.lg),

                        // Title
                        _buildTextField(
                          controller: _titleController,
                          label: 'Title',
                          hint: 'e.g. Fresh Vetkoek — 6 pack',
                          maxLength: 100,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Title is required'
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Category — immutable
                        _buildLockedField(
                          label: 'Category',
                          value: _categoryDisplayName(listing.category),
                          helperText: 'Category can\'t be changed',
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Price
                        _buildTextField(
                          controller: _priceController,
                          label: 'Price (tokens)',
                          hint: 'e.g. 150',
                          suffixText: 'tokens',
                          enabled: !_priceLocked,
                          helperText: _priceLocked
                              ? 'Price can\'t be changed while you have active orders'
                              : null,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
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
                        if (!_priceLocked)
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _priceController,
                            builder: (_, value, _) {
                              final tokens =
                                  int.tryParse(value.text) ?? 0;
                              if (tokens <= 0) {
                                return const SizedBox.shrink();
                              }
                              final zar = tokens / 100;
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  '≈ R${zar.toStringAsFixed(2)} ZAR',
                                  style: const TextStyle(
                                    color: AppColors.buyTextTertiary,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: AppSpacing.md),

                        // Description
                        _buildTextField(
                          controller: _descriptionController,
                          label: 'Description',
                          hint: 'Describe what you\'re offering...',
                          maxLines: 4,
                          maxLength: 500,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Description is required'
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Location
                        _buildTextField(
                          controller: _locationController,
                          label: 'Location (optional)',
                          hint: 'e.g. Khayelitsha, Cape Town',
                          prefixIcon: Icons.location_on_outlined,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  ),
                ),
              ),

              // Save button
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        color: AppColors.buyDivider, width: 0.5),
                  ),
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buyMarketplaceAccent,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.buyMarketplaceAccent
                                .withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMd),
                        ),
                        elevation: 0,
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─── Form Helpers ──────────────────────────────────────────────────

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? suffixText,
    String? helperText,
    IconData? prefixIcon,
    int? maxLength,
    int maxLines = 1,
    bool enabled = true,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: TextStyle(
        color: enabled
            ? AppColors.buyTextPrimary
            : AppColors.buyTextTertiary,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixText: suffixText,
        helperText: helperText,
        helperStyle: const TextStyle(
          color: AppColors.buyTextTertiary,
          fontSize: 11,
        ),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
        filled: true,
        fillColor: enabled ? Colors.white : AppColors.buyChipBg,
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
        labelStyle: const TextStyle(
          color: AppColors.buyTextSecondary,
          fontSize: 14,
        ),
        hintStyle: const TextStyle(
          color: AppColors.buyTextTertiary,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildLockedField({
    required String label,
    required String value,
    String? helperText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.buyTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.buyChipBg,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
                color: AppColors.buyCardBorder, width: 0.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.buyTextTertiary,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.lock_outline,
                  size: 14, color: AppColors.buyTextTertiary),
            ],
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: const TextStyle(
              color: AppColors.buyTextTertiary,
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }

  String _categoryDisplayName(MarketplaceCategory category) {
    return category.displayName;
  }

  // ─── Image Editor ──────────────────────────────────────────────────

  Widget _buildImageEditor() {
    final totalImages = _existingImageUrls.length + _newImages.length;

    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Existing remote images
          ..._existingImageUrls.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    child: CachedNetworkImage(
                      imageUrl: entry.value,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => setState(() =>
                          _existingImageUrls.removeAt(entry.key)),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.buyError,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          // Newly selected local images
          ..._newImages.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    child: Image.file(
                      entry.value,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => setState(
                          () => _newImages.removeAt(entry.key)),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.buyError,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          // Add button
          if (totalImages < _maxImages)
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.buyCardBorder, width: 0.5),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusSm),
                  color: Colors.white,
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
                      '$totalImages/$_maxImages',
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
    );
  }

  Future<void> _pickImage() async {
    final totalImages =
        _existingImageUrls.length + _newImages.length;
    if (totalImages >= _maxImages) return;

    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (picked == null) return;

    setState(() => _newImages.add(File(picked.path)));
  }

  // ─── Save ──────────────────────────────────────────────────────────

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final priceTokens = int.tryParse(_priceController.text.trim());
    if (priceTokens == null || priceTokens <= 0) {
      setState(() => _isSaving = false);
      return;
    }

    context.read<MarketplaceBloc>().add(
      MarketplaceEvent.updateListing(
        listingId: widget.listingId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        priceTokens: priceTokens,
        imageUrls: _existingImageUrls,
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
      ),
    );
  }
}
