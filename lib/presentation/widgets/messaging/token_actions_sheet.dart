import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/value_objects/user_search_result.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/user_search/user_search_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Unified bottom sheet for sending or requesting tokens.
///
/// When [conversationId] and [recipientId] are provided, the contact is
/// pre-filled (used from inside a conversation). When omitted, a search
/// field lets the user pick any iMaliChat user (used from the Wallet screen).
class TokenActionsSheet extends StatefulWidget {
  final String? conversationId;
  final String? recipientId;
  final String? recipientName;

  const TokenActionsSheet({
    super.key,
    this.conversationId,
    this.recipientId,
    this.recipientName,
  });

  @override
  State<TokenActionsSheet> createState() => _TokenActionsSheetState();
}

class _TokenActionsSheetState extends State<TokenActionsSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _searchController = TextEditingController();
  bool _isSending = true;
  bool _isSubmitting = false;

  // Contact picker state (only used in standalone mode)
  _SelectedContact? _selectedContact;

  bool get _isStandalone => widget.conversationId == null;

  @override
  void initState() {
    super.initState();
    if (_isStandalone) {
      context.read<UserSearchBloc>().add(const UserSearchEvent.clearSearch());
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _selectContact(UserSearchResult result) {
    setState(() {
      _selectedContact = _SelectedContact(
        userId: result.userId,
        displayName: result.displayName,
      );
      _searchController.clear();
    });
    context.read<UserSearchBloc>().add(const UserSearchEvent.clearSearch());
  }

  void _clearContact() {
    setState(() => _selectedContact = null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConversationBloc, ConversationState>(
      listenWhen: (prev, curr) =>
          prev.isSending && !curr.isSending && _isSubmitting,
      listener: (context, state) {
        setState(() => _isSubmitting = false);
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
          context
              .read<ConversationBloc>()
              .add(const ConversationEvent.clearError());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(_isSending ? 'Tokens sent!' : 'Token request sent!'),
            ),
          );
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Send / Request toggle
            Row(
              children: [
                Expanded(
                  child: _buildToggle(context, 'Send', Icons.send, true),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildToggle(
                      context, 'Request', Icons.call_received, false),
                ),
              ],
            ),
            AppSpacing.verticalLg,

            // Contact picker (standalone mode only)
            if (_isStandalone) ...[
              if (_selectedContact != null)
                _buildSelectedContactChip()
              else ...[
                _buildContactSearchField(),
                BlocBuilder<UserSearchBloc, UserSearchState>(
                  builder: (context, searchState) {
                    if (searchState.isSearching) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    }
                    if (searchState.searchResults.isNotEmpty) {
                      return _buildSearchResultsList(
                          searchState.searchResults);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
              AppSpacing.verticalMd,
            ],

            // Amount
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (Tokens)',
                prefixIcon: const Icon(Icons.monetization_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
              ),
            ),
            AppSpacing.verticalMd,

            // Note
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Add a note (optional)',
                prefixIcon: const Icon(Icons.note_outlined),
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
              ),
            ),
            AppSpacing.verticalLg,

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isSending ? AppColors.success : AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        _isSending
                            ? 'Send Instant Tokens'
                            : 'Request Instant Tokens',
                      ),
              ),
            ),
            AppSpacing.verticalMd,
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildToggle(
    BuildContext context,
    String label,
    IconData icon,
    bool isSendMode,
  ) {
    final isSelected = _isSending == isSendMode;
    return InkWell(
      onTap: () => setState(() => _isSending = isSendMode),
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.chatSurface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.chatSurface,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (query) {
        context
            .read<UserSearchBloc>()
            .add(UserSearchEvent.searchUsers(query));
      },
      decoration: InputDecoration(
        labelText: 'To (search by name)',
        prefixIcon: const Icon(Icons.person_search_outlined),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
      ),
    );
  }

  Widget _buildSelectedContactChip() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.person, size: 20, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _selectedContact!.displayName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          GestureDetector(
            onTap: _clearContact,
            child: Icon(Icons.close, size: 18, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsList(List<UserSearchResult> results) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 160),
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              backgroundImage: result.avatarUrl != null
                  ? NetworkImage(result.avatarUrl!)
                  : null,
              child: result.avatarUrl == null
                  ? Text(
                      result.displayName.isNotEmpty
                          ? result.displayName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    )
                  : null,
            ),
            title: Text(
              result.displayName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            onTap: () => _selectContact(result),
          );
        },
      ),
    );
  }

  void _submit() {
    // Resolve recipient
    final recipientId =
        _isStandalone ? _selectedContact?.userId : widget.recipientId;

    if (_isStandalone && recipientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a contact')),
      );
      return;
    }

    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final note = _noteController.text.trim();

    setState(() => _isSubmitting = true);

    if (_isStandalone) {
      // Standalone mode: need to get/create a conversation first, then send
      context.read<ConversationBloc>().add(
            ConversationEvent.sendTokensToUser(
              recipientId: recipientId!,
              amount: amount,
              isSend: _isSending,
              message: note.isEmpty ? null : note,
            ),
          );
    } else {
      // In-conversation mode: send directly
      if (_isSending) {
        context.read<ConversationBloc>().add(
              ConversationEvent.sendTokens(
                conversationId: widget.conversationId!,
                recipientId: recipientId!,
                amount: amount,
                message: note.isEmpty ? null : note,
              ),
            );
      } else {
        context.read<ConversationBloc>().add(
              ConversationEvent.requestTokens(
                conversationId: widget.conversationId!,
                recipientId: recipientId!,
                amount: amount,
                message: note.isEmpty ? null : note,
              ),
            );
      }
    }
  }
}

class _SelectedContact {
  final String userId;
  final String displayName;

  const _SelectedContact({
    required this.userId,
    required this.displayName,
  });
}
