import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

/// Form screen to create a new community-organized group buy (Hlangana deal).
class CreateGroupBuyScreen extends StatefulWidget {
  const CreateGroupBuyScreen({super.key});

  @override
  State<CreateGroupBuyScreen> createState() => _CreateGroupBuyScreenState();
}

class _CreateGroupBuyScreenState extends State<CreateGroupBuyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _minParticipantsController = TextEditingController(text: '2');
  final _maxParticipantsController = TextEditingController();

  DateTime? _deadline;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    _minParticipantsController.dispose();
    _maxParticipantsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBuyBloc, GroupBuyState>(
      listenWhen: (prev, curr) =>
          prev.createSuccessId != curr.createSuccessId ||
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        if (state.createSuccessId != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hlangana deal created!'),
              backgroundColor: AppColors.success,
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
              backgroundColor: AppColors.error,
            ),
          );
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Hlangana Deal'),
            backgroundColor: AppColors.surface,
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
                      color: AppColors.secondary.withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.groups,
                            color: AppColors.secondary, size: 20),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Pool funds together with your community to unlock bulk deals!',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Title
                  _buildLabel('Deal Title'),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextField(
                    controller: _titleController,
                    hint: 'e.g. Bulk Rice 25kg - Khayelitsha',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Title is required' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Description
                  _buildLabel('Description'),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextField(
                    controller: _descriptionController,
                    hint: 'What are we buying together?',
                    maxLines: 3,
                    validator: (v) => v == null || v.isEmpty
                        ? 'Description is required'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Target amount
                  _buildLabel('Target Amount (tokens)'),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTextField(
                    controller: _targetAmountController,
                    hint: 'e.g. 5000',
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Amount is required';
                      final n = int.tryParse(v);
                      if (n == null || n <= 0) return 'Enter a valid amount';
                      return null;
                    },
                  ),
                  if (_targetAmountController.text.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      '= R${((int.tryParse(_targetAmountController.text) ?? 0) / 100).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.textHint,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),

                  // Deadline
                  _buildLabel('Deadline'),
                  const SizedBox(height: AppSpacing.xs),
                  GestureDetector(
                    onTap: _pickDeadline,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        _deadline != null
                            ? DateFormat('dd MMM yyyy, HH:mm')
                                .format(_deadline!)
                            : 'Tap to pick deadline',
                        style: TextStyle(
                          color: _deadline != null
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Participant limits
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Min Participants'),
                            const SizedBox(height: AppSpacing.xs),
                            _buildTextField(
                              controller: _minParticipantsController,
                              hint: '2',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Max Participants'),
                            const SizedBox(height: AppSpacing.xs),
                            _buildTextField(
                              controller: _maxParticipantsController,
                              hint: 'Unlimited',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Create button
                  AppButton(
                    text: 'Create Deal',
                    isLoading: state.isCreating,
                    loadingText: 'Creating...',
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
        color: AppColors.textPrimary,
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
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textHint),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      onChanged: (_) {
        if (controller == _targetAmountController) setState(() {});
      },
    );
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
    );
    if (time == null || !mounted) return;

    setState(() {
      _deadline = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick a deadline'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    final targetAmount = int.parse(_targetAmountController.text);
    final minParticipants =
        int.tryParse(_minParticipantsController.text) ?? 2;
    final maxParticipants =
        int.tryParse(_maxParticipantsController.text);

    context.read<GroupBuyBloc>().add(
          GroupBuyEvent.createGroupBuy(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            targetAmount: targetAmount,
            deadline: _deadline!,
            minParticipants: minParticipants,
            maxParticipants: maxParticipants,
          ),
        );
  }
}
