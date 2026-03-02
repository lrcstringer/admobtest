import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/gift_style.dart';
import '../../../domain/enums/pool_mode.dart';
import '../../blocs/token_pool/token_pool_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gift/gift_style_picker.dart';

/// Screen for creating a new Collection Room (Group Sasaza or Group Save).
class CreatePoolScreen extends StatefulWidget {
  final String? recipientId;
  final String? recipientName;
  final String? communityId;

  const CreatePoolScreen({
    super.key,
    this.recipientId,
    this.recipientName,
    this.communityId,
  });

  @override
  State<CreatePoolScreen> createState() => _CreatePoolScreenState();
}

class _CreatePoolScreenState extends State<CreatePoolScreen> {
  PoolMode _mode = PoolMode.sasaza;
  GiftStyle _style = GiftStyle.celebration;
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _recipientController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _recipientId;
  final List<Map<String, String>> _invitees = []; // [{id, name}]

  @override
  void initState() {
    super.initState();
    if (widget.recipientId != null) {
      _recipientId = widget.recipientId;
      _recipientController.text = widget.recipientName ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_mode == PoolMode.sasaza && _recipientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a recipient')),
      );
      return;
    }

    if (_invitees.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one invitee')),
      );
      return;
    }

    context.read<TokenPoolBloc>().add(TokenPoolEvent.createPool(
          mode: _mode,
          title: _titleController.text.trim(),
          message: _messageController.text.trim(),
          style: _style,
          recipientId: _mode == PoolMode.sasaza ? _recipientId : null,
          inviteeIds: _invitees.map((i) => i['id']!).toList(),
          communityId: widget.communityId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<TokenPoolBloc, TokenPoolState>(
      listener: (context, state) {
        if (state.activePool != null && !state.isCreating) {
          // Navigate to the collection room
          context.go('/chat/pool/${state.activePool!.id}');
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
          context.read<TokenPoolBloc>().add(const TokenPoolEvent.clearError());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Collection'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Mode selector
              _buildModeSelector(theme),
              AppSpacing.verticalLg,

              // Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: _mode == PoolMode.sasaza
                      ? "e.g., John's Birthday Gift"
                      : 'e.g., Holiday Fund',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLength: 100,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Title is required' : null,
              ),
              AppSpacing.verticalMd,

              // Style picker
              Text('Style', style: theme.textTheme.titleSmall),
              AppSpacing.verticalSm,
              GiftStylePicker(
                selected: _style,
                onChanged: (s) => setState(() => _style = s),
              ),
              AppSpacing.verticalMd,

              // Recipient (sasaza only)
              if (_mode == PoolMode.sasaza) ...[
                TextFormField(
                  controller: _recipientController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Recipient',
                    hintText: 'Select who will receive the gift',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: const Icon(Icons.person_search),
                  ),
                  onTap: () => _pickRecipient(context),
                ),
                AppSpacing.verticalMd,
              ],

              // Message
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message (optional)',
                  hintText: 'Add a personal message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLength: 200,
                maxLines: 2,
              ),
              AppSpacing.verticalMd,

              // Invitees
              _buildInviteeSection(theme),
              AppSpacing.verticalLg,

              // Create button
              BlocBuilder<TokenPoolBloc, TokenPoolState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isCreating ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state.isCreating
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _mode == PoolMode.sasaza
                                  ? 'Create Group Sasaza'
                                  : 'Create Group Save',
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeSelector(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _ModeCard(
            icon: Icons.card_giftcard,
            label: 'Group Sasaza',
            description: 'Gift for someone',
            isSelected: _mode == PoolMode.sasaza,
            color: AppColors.primary,
            onTap: () => setState(() => _mode = PoolMode.sasaza),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModeCard(
            icon: Icons.savings_outlined,
            label: 'Group Save',
            description: 'Save together',
            isSelected: _mode == PoolMode.save,
            color: AppColors.secondary,
            onTap: () => setState(() => _mode = PoolMode.save),
          ),
        ),
      ],
    );
  }

  Widget _buildInviteeSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Invitees', style: theme.textTheme.titleSmall),
            const Spacer(),
            TextButton.icon(
              onPressed: () => _pickInvitees(context),
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        if (_invitees.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'No invitees yet. Tap "Add" to invite people.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textHint,
              ),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _invitees.map((inv) {
              return Chip(
                label: Text(inv['name'] ?? 'Unknown'),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {
                  setState(() =>
                      _invitees.removeWhere((i) => i['id'] == inv['id']));
                },
              );
            }).toList(),
          ),
      ],
    );
  }

  Future<void> _pickRecipient(BuildContext context) async {
    // Navigate to contact picker and get result
    final result = await context.push<Map<String, String>>('/chat/pick-contact');
    if (result != null && mounted) {
      setState(() {
        _recipientId = result['id'];
        _recipientController.text = result['name'] ?? 'Unknown';
      });
    }
  }

  Future<void> _pickInvitees(BuildContext context) async {
    final result =
        await context.push<List<Map<String, String>>>('/chat/pick-contacts');
    if (result != null && mounted) {
      setState(() {
        for (final contact in result) {
          // Avoid duplicates and exclude recipient
          if (!_invitees.any((i) => i['id'] == contact['id']) &&
              contact['id'] != _recipientId) {
            _invitees.add(contact);
          }
        }
      });
    }
  }
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _ModeCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? color : AppColors.textHint.withValues(alpha: 0.3),
            width: isSelected ? 2.5 : 1,
          ),
          color: isSelected
              ? color.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: isSelected ? color : AppColors.textHint),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? color : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
