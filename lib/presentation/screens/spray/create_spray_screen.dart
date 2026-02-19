import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/spray_occasion.dart';
import '../../blocs/community/community_bloc.dart';
import '../../blocs/token_spray/token_spray_bloc.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Screen for creating a new token spray celebration in a community.
/// Reached via /chat/community/:id/create-spray
class CreateSprayScreen extends StatefulWidget {
  final String communityId;

  const CreateSprayScreen({super.key, required this.communityId});

  @override
  State<CreateSprayScreen> createState() => _CreateSprayScreenState();
}

class _CreateSprayScreenState extends State<CreateSprayScreen> {
  final _messageController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SprayOccasion _selectedOccasion = SprayOccasion.custom;
  String? _selectedRecipientId;
  bool _hasTarget = false;

  static const _occasions = [
    (SprayOccasion.birthday, 'Birthday', Icons.cake),
    (SprayOccasion.newJob, 'New Job', Icons.work),
    (SprayOccasion.graduation, 'Graduation', Icons.school),
    (SprayOccasion.newBaby, 'New Baby', Icons.child_care),
    (SprayOccasion.wedding, 'Wedding', Icons.favorite),
    (SprayOccasion.achievement, 'Achievement', Icons.emoji_events),
    (SprayOccasion.custom, 'Other', Icons.celebration),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }

  void _onCreate() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRecipientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a recipient')),
      );
      return;
    }

    final targetAmount = _hasTarget
        ? int.tryParse(_targetAmountController.text.trim())
        : null;

    context.read<TokenSprayBloc>().add(TokenSprayEvent.createSpray(
      recipientId: _selectedRecipientId!,
      occasion: _selectedOccasion,
      message: _messageController.text.trim(),
      targetAmount: targetAmount,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Start Token Spray'),
      body: WaveBackground(
        child: BlocConsumer<TokenSprayBloc, TokenSprayState>(
        listener: (context, state) {
          if (state.activeSpray != null && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Token spray started!')),
            );
            context.pop();
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
            context.read<TokenSprayBloc>().add(const TokenSprayEvent.clearError());
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                // Recipient selector
                Text(
                  'Who are you celebrating?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildRecipientSelector(context),
                const SizedBox(height: AppSpacing.lg),

                // Occasion picker
                Text(
                  'What\'s the occasion?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _occasions.map((item) {
                    final (occasion, label, icon) = item;
                    final isSelected = _selectedOccasion == occasion;
                    return ChoiceChip(
                      avatar: Icon(icon, size: 18),
                      label: Text(label),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedOccasion = occasion),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Message
                Text(
                  'Celebration message',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: _messageController,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    hintText: 'Write a celebration message...',
                    prefixIcon: Icon(Icons.message),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please write a message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                // Optional target
                SwitchListTile(
                  title: const Text('Set a target amount'),
                  subtitle: const Text('Optional goal for contributions'),
                  value: _hasTarget,
                  onChanged: (v) => setState(() => _hasTarget = v),
                ),
                if (_hasTarget) ...[
                  const SizedBox(height: AppSpacing.sm),
                  TextFormField(
                    controller: _targetAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Target amount (tokens)',
                      prefixIcon: Icon(Icons.toll),
                    ),
                    validator: (value) {
                      if (!_hasTarget) return null;
                      final amount = int.tryParse(value ?? '');
                      if (amount == null || amount < 10) {
                        return 'Minimum target is 10 tokens';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),

                // Create button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: state.isLoading ? null : _onCreate,
                    icon: state.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.celebration),
                    label: Text(state.isLoading ? 'Creating...' : 'Start Spray'),
                  ),
                ),
              ],
            ),
          );
        },
        ),
      ),
    );
  }

  Widget _buildRecipientSelector(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, communityState) {
        final members = communityState.selectedCommunityMembers
            .where((m) => m.isActive)
            .toList();

        if (members.isEmpty) {
          return const Text('No members available');
        }

        return DropdownButtonFormField<String>(
          initialValue: _selectedRecipientId,
          decoration: const InputDecoration(
            hintText: 'Select a member',
            prefixIcon: Icon(Icons.person),
          ),
          items: members.map((member) {
            return DropdownMenuItem(
              value: member.userId,
              child: Text(member.displayName),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedRecipientId = value;
            });
          },
          validator: (value) {
            if (value == null) return 'Please select a recipient';
            return null;
          },
        );
      },
    );
  }
}
