import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/marketplace_category.dart';
import '../../blocs/provider_registration/provider_registration_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

/// 3-step provider registration flow.
/// Step 0: Name + Bio + Photo
/// Step 1: Category + Services description
/// Step 2: Confirm & submit
class ProviderRegistrationScreen extends StatelessWidget {
  const ProviderRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ProviderRegistrationBloc>(),
      child: const _ProviderRegistrationBody(),
    );
  }
}

class _ProviderRegistrationBody extends StatelessWidget {
  const _ProviderRegistrationBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Seller'),
        backgroundColor: AppColors.surface,
      ),
      body: BlocConsumer<ProviderRegistrationBloc, ProviderRegistrationState>(
        listener: (context, state) {
          if (state.isComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? 'Registration submitted'),
                backgroundColor: AppColors.success,
              ),
            );
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
              // Step indicator
              _buildStepIndicator(state.currentStep),

              // Step content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: _buildStep(context, state),
                ),
              ),

              // Navigation buttons
              _buildButtons(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepIndicator(int currentStep) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = index <= currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStep(BuildContext context, ProviderRegistrationState state) {
    switch (state.currentStep) {
      case 0:
        return _StepNameBio(state: state);
      case 1:
        return _StepCategoryServices(state: state);
      case 2:
        return _StepConfirm(state: state);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildButtons(
      BuildContext context, ProviderRegistrationState state) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (state.currentStep > 0)
              Expanded(
                child: AppButton(
                  text: 'Back',
                  variant: AppButtonVariant.outline,
                  onPressed: () => context
                      .read<ProviderRegistrationBloc>()
                      .add(const ProviderRegistrationEvent.previousStep()),
                ),
              ),
            if (state.currentStep > 0) const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                text: state.currentStep == 2 ? 'Submit' : 'Next',
                variant: AppButtonVariant.primary,
                isLoading: state.isSubmitting,
                onPressed: () {
                  final bloc = context.read<ProviderRegistrationBloc>();
                  if (state.currentStep == 2) {
                    bloc.add(const ProviderRegistrationEvent.submit());
                  } else {
                    bloc.add(const ProviderRegistrationEvent.nextStep());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepNameBio extends StatelessWidget {
  final ProviderRegistrationState state;

  const _StepNameBio({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tell us about yourself',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'This info appears on your seller profile',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          onChanged: (v) => context
              .read<ProviderRegistrationBloc>()
              .add(ProviderRegistrationEvent.updateName(v)),
          decoration: const InputDecoration(
            labelText: 'Display Name',
            hintText: 'e.g. Mama Thandi\'s Kitchen',
          ),
          controller: TextEditingController(text: state.displayName)
            ..selection = TextSelection.collapsed(
                offset: state.displayName.length),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          onChanged: (v) => context
              .read<ProviderRegistrationBloc>()
              .add(ProviderRegistrationEvent.updateBio(v)),
          maxLines: 3,
          maxLength: 200,
          decoration: const InputDecoration(
            labelText: 'Short Bio',
            hintText: 'Tell buyers what you do...',
          ),
          controller: TextEditingController(text: state.bio)
            ..selection =
                TextSelection.collapsed(offset: state.bio.length),
        ),
      ],
    );
  }
}

class _StepCategoryServices extends StatelessWidget {
  final ProviderRegistrationState state;

  const _StepCategoryServices({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What do you offer?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
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
          children: MarketplaceCategory.values.map((cat) {
            final isSelected = state.selectedCategory == cat;
            return ChoiceChip(
              label: Text('${cat.emoji} ${cat.displayName}'),
              selected: isSelected,
              onSelected: (_) => context
                  .read<ProviderRegistrationBloc>()
                  .add(ProviderRegistrationEvent.updateCategory(cat)),
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              backgroundColor: AppColors.surfaceElevated,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          onChanged: (v) => context
              .read<ProviderRegistrationBloc>()
              .add(ProviderRegistrationEvent.updateServices(v)),
          maxLines: 4,
          maxLength: 500,
          decoration: const InputDecoration(
            labelText: 'Describe your services',
            hintText: 'What do you sell or offer?',
          ),
          controller:
              TextEditingController(text: state.servicesDescription)
                ..selection = TextSelection.collapsed(
                    offset: state.servicesDescription.length),
        ),
      ],
    );
  }
}

class _StepConfirm extends StatelessWidget {
  final ProviderRegistrationState state;

  const _StepConfirm({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirm your details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildRow('Name', state.displayName),
        _buildRow('Bio', state.bio),
        _buildRow(
          'Category',
          state.selectedCategory?.displayName ?? 'Not selected',
        ),
        _buildRow('Services', state.servicesDescription),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.secondary, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Your registration will be reviewed by an admin. '
                  'You\'ll be notified once approved.',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value.isEmpty ? '—' : value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
