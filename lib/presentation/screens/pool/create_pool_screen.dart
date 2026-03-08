import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../domain/enums/gift_style.dart';
import '../../../domain/enums/pool_mode.dart';
import '../../blocs/token_pool/token_pool_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gift/gift_style_picker.dart';

/// Screen for creating a new Collection Room (Group Sasaza or Group Save).
///
/// Each entry point locks the mode — no mode selector is shown.
class CreatePoolScreen extends StatefulWidget {
  final PoolMode initialMode;
  final String? recipientId;
  final String? recipientName;
  final String? communityId;

  const CreatePoolScreen({
    super.key,
    required this.initialMode,
    this.recipientId,
    this.recipientName,
    this.communityId,
  });

  @override
  State<CreatePoolScreen> createState() => _CreatePoolScreenState();
}

class _CreatePoolScreenState extends State<CreatePoolScreen> {
  late final PoolMode _mode;
  GiftStyle _style = GiftStyle.celebration;
  final _titleController = TextEditingController();
  final _purposeController = TextEditingController();
  final _messageController = TextEditingController();
  final _recipientController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _recipientId;
  final List<Map<String, String>> _invitees = []; // [{id, name}]

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    // Pre-fetch Play Integrity token in background while user fills form.
    getIt<PlayIntegrityService>().warmUp();
    // Clear stale activePool so the BlocListener doesn't
    // immediately fire from a previous pool's state.
    context.read<TokenPoolBloc>().add(const TokenPoolEvent.reset());
    if (widget.recipientId != null && widget.recipientId!.isNotEmpty) {
      _recipientId = widget.recipientId;
      _recipientController.text = widget.recipientName ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _purposeController.dispose();
    _messageController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_mode == PoolMode.sasaza &&
        (_recipientId == null || _recipientId!.isEmpty)) {
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
          purpose: _purposeController.text.trim(),
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
          title: Text(
            _mode == PoolMode.sasaza ? 'Create Group Sasaza' : 'Group Save',
          ),
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

              // Style picker (sasaza only)
              if (_mode == PoolMode.sasaza) ...[
                Text('Style', style: theme.textTheme.titleSmall),
                AppSpacing.verticalSm,
                GiftStylePicker(
                  selected: _style,
                  onChanged: (s) => setState(() => _style = s),
                ),
                AppSpacing.verticalMd,
              ],

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

              // Purpose (save mode only)
              if (_mode == PoolMode.save) ...[
                TextFormField(
                  controller: _purposeController,
                  decoration: InputDecoration(
                    labelText: 'Purpose',
                    hintText: 'What is the savings goal?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLength: 200,
                  maxLines: 2,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Purpose is required'
                      : null,
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
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _mode == PoolMode.sasaza
                                      ? 'Creating Sasaza...'
                                      : 'Creating Group Save...',
                                ),
                              ],
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
      var skippedRecipient = false;
      setState(() {
        for (final contact in result) {
          if (contact['id'] == _recipientId) {
            skippedRecipient = true;
            continue;
          }
          // Avoid duplicates
          if (!_invitees.any((i) => i['id'] == contact['id'])) {
            _invitees.add(contact);
          }
        }
      });
      if (skippedRecipient && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The recipient cannot also be an invitee'),
          ),
        );
      }
    }
  }
}

