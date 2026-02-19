import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/community.dart';
import '../../../domain/enums/community_type.dart';
import '../../../domain/repositories/community_repository.dart';
import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Screen for creating a new community (regular or stokvel).
///
/// Adapts its form fields based on the selected community type.
class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  CommunityType _selectedType = CommunityType.regular;
  String _contributionCycle = 'monthly';
  int _contributionAmount = 1000; // 10 ZAR default
  int _approvalThreshold = 5000; // 50 ZAR default
  bool _allowMemberWithdrawals = false;
  int _penaltyPercentage = 5;
  bool _enableFinancials = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state.operationStatus == CommunityOperationStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage ?? 'Community created!'),
              backgroundColor: AppColors.success,
            ),
          );
          context.go('/chat');
        } else if (state.operationStatus == CommunityOperationStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Failed to create community'),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        }
      },
      builder: (context, state) {
        final isLoading =
            state.operationStatus == CommunityOperationStatus.processing;

        return Scaffold(
          appBar: AppBar(title: const Text('Create Community')),
          body: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Type Selector ──
                  Text(
                    'Community Type',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  _buildTypeSelector(context),
                  AppSpacing.verticalLg,

                  // ── Basic Info ──
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Community Name',
                      hintText: 'Enter a name for your community',
                      prefixIcon: const Icon(Icons.group),
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                    ),
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a community name';
                      }
                      if (value.trim().length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  AppSpacing.verticalMd,
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description (optional)',
                      hintText: 'What is this community about?',
                      prefixIcon: const Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                    ),
                    maxLength: 200,
                    maxLines: 3,
                  ),
                  AppSpacing.verticalLg,

                  // ── Financials Toggle (regular only) ──
                  if (_selectedType == CommunityType.regular) ...[
                    SwitchListTile(
                      title: const Text('Enable Financials'),
                      subtitle: const Text(
                          'Allow contributions and withdrawals'),
                      value: _enableFinancials,
                      onChanged: (v) => setState(() => _enableFinancials = v),
                      activeThumbColor: AppColors.primary,
                    ),
                    AppSpacing.verticalMd,
                  ],

                  // ── Stokvel Settings ──
                  if (_selectedType == CommunityType.stokvel ||
                      (_selectedType == CommunityType.regular &&
                          _enableFinancials)) ...[
                    _buildFinancialSettings(context),
                    AppSpacing.verticalLg,
                  ],

                  // ── Submit Button ──
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _createCommunity,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Create Community',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ),
                  AppSpacing.verticalLg,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeSelector(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TypeCard(
            label: 'Regular',
            icon: Icons.group,
            description: 'Chat group with optional finances',
            isSelected: _selectedType == CommunityType.regular,
            color: AppColors.primary,
            onTap: () => setState(() {
              _selectedType = CommunityType.regular;
              _enableFinancials = false;
            }),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TypeCard(
            label: 'Stokvel',
            icon: Icons.savings,
            description: 'Savings group with payout cycles',
            isSelected: _selectedType == CommunityType.stokvel,
            color: AppColors.success,
            onTap: () => setState(() {
              _selectedType = CommunityType.stokvel;
              _enableFinancials = true;
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedType == CommunityType.stokvel
              ? 'Stokvel Settings'
              : 'Financial Settings',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        AppSpacing.verticalSm,

        // Contribution Cycle
        DropdownButtonFormField<String>(
          initialValue: _contributionCycle,
          decoration: InputDecoration(
            labelText: 'Contribution Cycle',
            prefixIcon: const Icon(Icons.calendar_month),
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'none', child: Text('No schedule')),
            DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
            DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
          ],
          onChanged: (v) {
            if (v != null) setState(() => _contributionCycle = v);
          },
        ),
        AppSpacing.verticalMd,

        // Contribution Amount
        TextFormField(
          initialValue: (_contributionAmount / 100).toStringAsFixed(2),
          decoration: InputDecoration(
            labelText: 'Contribution Amount (ZAR)',
            prefixText: 'R ',
            prefixIcon: const Icon(Icons.attach_money),
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (v) {
            final amount = double.tryParse(v);
            if (amount != null) {
              _contributionAmount = (amount * 100).round();
            }
          },
        ),
        AppSpacing.verticalMd,

        // Approval Threshold
        TextFormField(
          initialValue: (_approvalThreshold / 100).toStringAsFixed(2),
          decoration: InputDecoration(
            labelText: 'Require Approval Above (ZAR)',
            prefixText: 'R ',
            prefixIcon: const Icon(Icons.verified_user),
            helperText: 'Transactions above this require admin approval',
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (v) {
            final amount = double.tryParse(v);
            if (amount != null) {
              _approvalThreshold = (amount * 100).round();
            }
          },
        ),
        AppSpacing.verticalMd,

        // Allow Withdrawals
        SwitchListTile(
          title: const Text('Allow Member Withdrawals'),
          subtitle: const Text('Members can withdraw their own contributions'),
          value: _allowMemberWithdrawals,
          onChanged: (v) => setState(() => _allowMemberWithdrawals = v),
          activeThumbColor: AppColors.primary,
        ),

        // Penalty (stokvel only)
        if (_selectedType == CommunityType.stokvel) ...[
          AppSpacing.verticalMd,
          TextFormField(
            initialValue: _penaltyPercentage.toString(),
            decoration: InputDecoration(
              labelText: 'Late Penalty (%)',
              prefixIcon: const Icon(Icons.warning_amber),
              suffixText: '%',
              border: OutlineInputBorder(
                borderRadius: AppSpacing.borderRadiusMd,
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (v) {
              final pct = int.tryParse(v);
              if (pct != null) _penaltyPercentage = pct;
            },
          ),
        ],
      ],
    );
  }

  void _createCommunity() {
    if (!_formKey.currentState!.validate()) return;

    final isStokvel = _selectedType == CommunityType.stokvel;

    final settings = CommunitySettings(
      enableFinancials: isStokvel || _enableFinancials,
      requireApprovalAbove: _approvalThreshold,
      allowMemberWithdrawals: _allowMemberWithdrawals,
      contributionCycle:
          (isStokvel || _enableFinancials) ? _contributionCycle : 'none',
      contributionAmount:
          (isStokvel || _enableFinancials) ? _contributionAmount : 0,
      penaltyPercentage: isStokvel ? _penaltyPercentage : 0,
    );

    final params = CreateCommunityParams(
      type: _selectedType,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      settings: settings,
    );

    context
        .read<CommunityBloc>()
        .add(CommunityEvent.createCommunity(params: params));
  }
}

// =============================================================================
// TYPE CARD
// =============================================================================

class _TypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String description;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TypeCard({
    required this.label,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected ? color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: isSelected ? color : AppColors.textHint),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected ? color : AppColors.textSecondary,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
