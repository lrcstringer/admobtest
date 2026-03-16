import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Community Group Buy creation screen (Spec §9.11).
///
/// 3-step form: Image → Deal Details → Preview & Publish.
/// Physical deals only for community-organized. Max 30 participants.
class CommunityGroupBuyCreateScreen extends StatefulWidget {
  const CommunityGroupBuyCreateScreen({super.key});

  @override
  State<CommunityGroupBuyCreateScreen> createState() =>
      _CommunityGroupBuyCreateScreenState();
}

const _categories = [
  'Food & Groceries',
  'Clothing & Fashion',
  'Home & Household',
  'Electronics',
  'Services',
  'Other',
];

class _CommunityGroupBuyCreateScreenState
    extends State<CommunityGroupBuyCreateScreen> {
  int _step = 0; // 0=image, 1=details, 2=preview
  bool _showSuccess = false;

  // Step 1: Image
  String? _imagePath;

  // Step 2: Details
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _originalPriceController = TextEditingController();
  final _minParticipantsController =
      TextEditingController(text: '3');
  final _maxParticipantsController =
      TextEditingController(text: '10');
  final _deliveryFeeController = TextEditingController();
  final _addressControllers = <TextEditingController>[
    TextEditingController(),
  ];
  String? _selectedCategory;
  DateTime? _deadline;
  String _fulfilmentMethod = 'collection'; // collection or delivery

  // Step 3: Preview
  bool _autoJoin = true;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _originalPriceController.dispose();
    _minParticipantsController.dispose();
    _maxParticipantsController.dispose();
    _deliveryFeeController.dispose();
    for (final c in _addressControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showSuccess) return _buildSuccessScreen();

    return BlocListener<GroupBuyBloc, GroupBuyState>(
      listenWhen: (prev, curr) =>
          prev.successId != curr.successId ||
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        if (state.successId != null) {
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
          setState(() => _showSuccess = true);
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
      child: Scaffold(
        backgroundColor: AppColors.buyBackground,
        appBar: AppBar(
          backgroundColor: AppColors.buyCard,
          foregroundColor: AppColors.buyTextPrimary,
          title: Text(
            _stepTitle,
          ),
        ),
        body: Column(
          children: [
            // Step indicator
            _buildStepIndicator(),
            const Divider(height: 0.5, color: AppColors.buyDivider),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: _buildStepContent(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  String get _stepTitle {
    switch (_step) {
      case 0:
        return 'Add a Photo';
      case 1:
        return 'Deal Details';
      case 2:
        return 'Preview & Publish';
      default:
        return 'Create Group Buy';
    }
  }

  // ── Step Indicator ──

  Widget _buildStepIndicator() {
    return Container(
      color: AppColors.buyCard,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: List.generate(3, (i) {
          final isActive = i <= _step;
          final isDone = i < _step;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.buyGroupBuyAccent
                        : AppColors.buyChipBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: isDone
                      ? const Icon(Icons.check,
                          size: 14, color: Colors.white)
                      : Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: isActive
                                ? Colors.white
                                : AppColors.buyTextTertiary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                if (i < 2)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 4),
                      color: i < _step
                          ? AppColors.buyGroupBuyAccent
                          : AppColors.buyCardBorder,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ── Step Content ──

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return _buildStep1Image();
      case 1:
        return _buildStep2Details();
      case 2:
        return _buildStep3Preview();
      default:
        return const SizedBox.shrink();
    }
  }

  // ── Step 1: Image ──

  Widget _buildStep1Image() {
    return Column(
      children: [
        // Info banner
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.buyGroupBuyAccent
                .withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: const Border(
              left: BorderSide(
                  color: AppColors.buyGroupBuyAccent, width: 3),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.people,
                  size: 20, color: AppColors.buyGroupBuyAccent),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spotted a deal? Get a group together and save!',
                      style: TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'All contributions are held in escrow and auto-refunded if the target isn\'t met.',
                      style: TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Image picker
        GestureDetector(
          onTap: _pickImage,
          child: _imagePath != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd),
                      child: Image.file(
                        File(_imagePath!),
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          height: 220,
                          color: AppColors.buyShimmerBase,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _imagePath = null),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close,
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.buyChipBg,
                    borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMd),
                    border: Border.all(
                        color: AppColors.buyCardBorder),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined,
                          size: 40,
                          color: AppColors.buyTextTertiary),
                      const SizedBox(height: 10),
                      const Text(
                        'Take a photo of the product, store, or flyer',
                        style: TextStyle(
                          color: AppColors.buyTextTertiary,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Required',
                        style: TextStyle(
                          color: AppColors.buyError,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.buyCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined,
                  color: AppColors.buyGroupBuyAccent),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined,
                  color: AppColors.buyGroupBuyAccent),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 70,
    );
    if (picked != null) {
      setState(() => _imagePath = picked.path);
    }
  }

  // ── Step 2: Deal Details ──

  Widget _buildStep2Details() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Title
          _label('What\'s the deal?'),
          const SizedBox(height: 6),
          _textField(
            controller: _titleController,
            hint: 'e.g. Bulk rice bags at Makro',
            validator: (v) => (v?.trim().length ?? 0) < 5
                ? 'Title must be at least 5 characters'
                : null,
          ),
          const SizedBox(height: 14),

          // 2. Description
          _label('Description'),
          const SizedBox(height: 6),
          _textField(
            controller: _descriptionController,
            hint: 'Describe the deal, what people will get...',
            maxLines: 3,
            validator: (v) => (v?.trim().length ?? 0) < 20
                ? 'Description must be at least 20 characters'
                : null,
          ),
          const SizedBox(height: 14),

          // 3. Category
          _label('Category'),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _categories.map((cat) {
              final selected = _selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: selected,
                onSelected: (_) =>
                    setState(() => _selectedCategory = cat),
                selectedColor: AppColors.buyGroupBuyAccent
                    .withValues(alpha: 0.15),
                backgroundColor: AppColors.buyChipBg,
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: selected
                      ? AppColors.buyGroupBuyAccent
                      : AppColors.buyTextSecondary,
                ),
                side: BorderSide(
                  color: selected
                      ? AppColors.buyGroupBuyAccent
                      : AppColors.buyCardBorder,
                  width: 0.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          // 4. Price per person
          _label('Price per person (tokens)'),
          const SizedBox(height: 6),
          _textField(
            controller: _priceController,
            hint: 'e.g. 500',
            keyboardType: TextInputType.number,
            validator: (v) {
              final n = int.tryParse(v ?? '');
              return n == null || n <= 0
                  ? 'Enter a valid price'
                  : null;
            },
          ),
          if (_priceController.text.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              '= R${((int.tryParse(_priceController.text) ?? 0) / 100).toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 11,
              ),
            ),
          ],
          const SizedBox(height: 14),

          // 5. Original price (optional)
          _label('Original price (optional, for savings display)'),
          const SizedBox(height: 6),
          _textField(
            controller: _originalPriceController,
            hint: 'e.g. 800',
            keyboardType: TextInputType.number,
          ),
          if (_originalPriceController.text.isNotEmpty &&
              _priceController.text.isNotEmpty) ...[
            const SizedBox(height: 4),
            Builder(builder: (ctx) {
              final orig =
                  int.tryParse(_originalPriceController.text) ?? 0;
              final price =
                  int.tryParse(_priceController.text) ?? 0;
              if (orig > price) {
                final pct =
                    (((orig - price) / orig) * 100).round();
                return Text(
                  'Save $pct%',
                  style: const TextStyle(
                    color: AppColors.buyGroupBuyAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
          const SizedBox(height: 14),

          // 6-7. Min / Max participants
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Min participants'),
                    const SizedBox(height: 6),
                    _textField(
                      controller: _minParticipantsController,
                      hint: '3',
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        final n = int.tryParse(v ?? '');
                        return n == null || n < 3
                            ? 'Min 3'
                            : null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Max participants'),
                    const SizedBox(height: 6),
                    _textField(
                      controller: _maxParticipantsController,
                      hint: '10',
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        final n = int.tryParse(v ?? '');
                        final min = int.tryParse(
                                _minParticipantsController.text) ??
                            3;
                        if (n == null || n < min) {
                          return '≥ min';
                        }
                        if (n > 30) return 'Max 30';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 8. Deadline
          _label('Deadline'),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: _pickDeadline,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.buyChipBg,
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusSm),
                border: Border.all(color: AppColors.buyCardBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _deadline != null
                          ? DateFormat('dd MMM yyyy')
                              .format(_deadline!)
                          : 'Select deadline (3-30 days from now)',
                      style: TextStyle(
                        color: _deadline != null
                            ? AppColors.buyTextPrimary
                            : AppColors.buyTextTertiary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(Icons.calendar_today,
                      size: 18,
                      color: AppColors.buyTextTertiary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // 9. Fulfilment method
          _label('Fulfilment method'),
          const SizedBox(height: 6),
          Row(
            children: [
              _methodChip('Collection', 'collection'),
              const SizedBox(width: 8),
              _methodChip('Delivery', 'delivery'),
            ],
          ),
          const SizedBox(height: 14),

          // 10. Collection addresses (if collection)
          if (_fulfilmentMethod == 'collection') ...[
            _label('Collection address(es)'),
            const SizedBox(height: 6),
            ..._addressControllers.asMap().entries.map((entry) {
              final idx = entry.key;
              final ctrl = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: _textField(
                        controller: ctrl,
                        hint: 'Address ${idx + 1}',
                        validator: idx == 0
                            ? (v) => (v?.trim().isEmpty ?? true)
                                ? 'At least one address required'
                                : null
                            : null,
                      ),
                    ),
                    if (idx > 0)
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            size: 20, color: AppColors.buyError),
                        onPressed: () {
                          _addressControllers[idx].dispose();
                          setState(() =>
                              _addressControllers.removeAt(idx));
                        },
                      ),
                  ],
                ),
              );
            }),
            if (_addressControllers.length < 3)
              TextButton.icon(
                onPressed: () {
                  setState(() => _addressControllers
                      .add(TextEditingController()));
                },
                icon: Icon(Icons.add,
                    size: 16,
                    color: AppColors.buyGroupBuyAccent),
                label: const Text(
                  'Add another address',
                  style: TextStyle(
                    color: AppColors.buyGroupBuyAccent,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 14),
          ],

          // 11. Delivery fee (if delivery)
          if (_fulfilmentMethod == 'delivery') ...[
            _label('Delivery fee (tokens, optional)'),
            const SizedBox(height: 6),
            _textField(
              controller: _deliveryFeeController,
              hint: 'e.g. 50',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 7)),
      firstDate: now.add(const Duration(days: 3)),
      lastDate: now.add(const Duration(days: 30)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.buyGroupBuyAccent,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _deadline = picked);
    }
  }

  Widget _methodChip(String label, String value) {
    final selected = _fulfilmentMethod == value;
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            setState(() => _fulfilmentMethod = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.buyGroupBuyAccent
                    .withValues(alpha: 0.12)
                : AppColors.buyChipBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? AppColors.buyGroupBuyAccent
                  : AppColors.buyCardBorder,
              width: 0.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? AppColors.buyGroupBuyAccent
                  : AppColors.buyTextSecondary,
              fontSize: 13,
              fontWeight:
                  selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  // ── Step 3: Preview ──

  Widget _buildStep3Preview() {
    final price = int.tryParse(_priceController.text) ?? 0;
    final zarPrice = (price / 100).toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preview',
          style: TextStyle(
            color: AppColors.buyTextPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Preview card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.buyCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
                color: AppColors.buyCardBorder, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _titleController.text,
                style: const TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'R$zarPrice · $price tokens per person',
                style: const TextStyle(
                  color: AppColors.buyGroupBuyAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _descriptionController.text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.people_outline,
                      size: 14,
                      color: AppColors.buyTextTertiary),
                  const SizedBox(width: 4),
                  Text(
                    '${_minParticipantsController.text}-${_maxParticipantsController.text} participants',
                    style: const TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (_deadline != null) ...[
                    Icon(Icons.timer_outlined,
                        size: 14,
                        color: AppColors.buyTextTertiary),
                    const SizedBox(width: 4),
                    Text(
                      'Ends ${DateFormat('dd MMM').format(_deadline!)}',
                      style: const TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
              if (_selectedCategory != null) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.buyChipBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _selectedCategory!,
                    style: const TextStyle(
                      color: AppColors.buyTextSecondary,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Auto-join toggle
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.buyCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
                color: AppColors.buyCardBorder, width: 0.5),
          ),
          child: SwitchListTile.adaptive(
            value: _autoJoin,
            onChanged: (v) => setState(() => _autoJoin = v),
            title: const Text(
              'I want to be first to join',
              style: TextStyle(
                color: AppColors.buyTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            activeTrackColor: AppColors.buyGroupBuyAccent,
          ),
        ),
        const SizedBox(height: 12),

        // Trust reminder
        Row(
          children: [
            Icon(Icons.shield_outlined,
                size: 16, color: AppColors.buyGroupBuyAccent),
            const SizedBox(width: 6),
            const Expanded(
              child: Text(
                'All contributions are held in escrow and automatically refunded if the target isn\'t met.',
                style: TextStyle(
                  color: AppColors.buyTextTertiary,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Bottom bar ──

  Widget _buildBottomBar() {
    return BlocBuilder<GroupBuyBloc, GroupBuyState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(16, 10, 16,
              MediaQuery.of(context).padding.bottom + 10),
          decoration: const BoxDecoration(
            color: AppColors.buyCard,
            border: Border(
              top: BorderSide(
                  color: AppColors.buyCardBorder, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              if (_step > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => _step--),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.buyTextSecondary,
                      side: const BorderSide(
                          color: AppColors.buyCardBorder),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd),
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                ),
              if (_step > 0) const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: state.isCreating
                      ? null
                      : _onNext,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.buyGroupBuyAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd),
                    ),
                  ),
                  child: state.isCreating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          _step == 2
                              ? 'Publish deal'
                              : 'Next',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onNext() {
    switch (_step) {
      case 0:
        if (_imagePath == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please add a photo of the deal'),
              backgroundColor: AppColors.buyError,
            ),
          );
          return;
        }
        setState(() => _step = 1);
      case 1:
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
        if (_deadline == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a deadline'),
              backgroundColor: AppColors.buyError,
            ),
          );
          return;
        }
        setState(() => _step = 2);
      case 2:
        _onPublish();
    }
  }

  Future<void> _onPublish() async {
    HapticFeedback.mediumImpact();

    final pricePerPerson = int.tryParse(_priceController.text) ?? 0;
    final maxParticipants =
        int.tryParse(_maxParticipantsController.text) ?? 1;
    final targetAmount = pricePerPerson * maxParticipants;

    String? imageUrl;
    if (_imagePath != null) {
      try {
        final userId =
            FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';
        final ref = FirebaseStorage.instance.ref(
            'groupBuys/${userId}_${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(File(_imagePath!));
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image upload failed: $e'),
              backgroundColor: AppColors.buyError,
            ),
          );
        }
        return;
      }
    }

    if (!mounted) return;

    context.read<GroupBuyBloc>().add(
          GroupBuyEvent.createGroupBuy(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            targetAmount: targetAmount,
            deadline: _deadline!,
            minParticipants:
                int.tryParse(_minParticipantsController.text) ?? 3,
            maxParticipants: maxParticipants,
            imageUrl: imageUrl,
            pricePerPerson: pricePerPerson,
          ),
        );
  }

  // ── Success screen ──

  Widget _buildSuccessScreen() {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.buyGroupBuyAccent
                      .withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 40,
                  color: AppColors.buyGroupBuyAccent,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Deal published!',
                style: TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your group buy is now live. Share it with friends to fill up faster!',
                style: TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.buyGroupBuyAccent,
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd),
                    ),
                  ),
                  child: const Text(
                    'Browse deals',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
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

  // ── Common helpers ──

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.buyTextPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _textField({
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
      style: const TextStyle(
          color: AppColors.buyTextPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            const TextStyle(color: AppColors.buyTextTertiary),
        filled: true,
        fillColor: AppColors.buyChipBg,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSpacing.radiusSm),
          borderSide:
              const BorderSide(color: AppColors.buyCardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSpacing.radiusSm),
          borderSide:
              const BorderSide(color: AppColors.buyCardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(
              color: AppColors.buyGroupBuyAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSpacing.radiusSm),
          borderSide:
              const BorderSide(color: AppColors.buyError),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      onChanged: (_) {
        if (controller == _priceController ||
            controller == _originalPriceController) {
          setState(() {});
        }
      },
    );
  }
}
