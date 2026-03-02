import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/user_search/user_search_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Screen for searching and selecting a user to start a new P2P conversation.
///
/// When [returnContact] is true, tapping a user pops with
/// `{'id': userId, 'name': displayName}` instead of navigating to a
/// conversation. When [multiSelect] is true, users are accumulated into a
/// list and a "Done" button pops with `List<Map<String, String>>`.
class ContactPickerScreen extends StatefulWidget {
  /// If true, pop with contact data instead of creating a conversation.
  final bool returnContact;

  /// If true (implies [returnContact]), allow selecting multiple contacts.
  final bool multiSelect;

  const ContactPickerScreen({
    super.key,
    this.returnContact = false,
    this.multiSelect = false,
  });

  @override
  State<ContactPickerScreen> createState() => _ContactPickerScreenState();
}

class _ContactPickerScreenState extends State<ContactPickerScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _awaitingConversation = false;

  /// Selected contacts for multi-select mode.
  final List<Map<String, String>> _selected = [];

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.length >= 2) {
        context
            .read<UserSearchBloc>()
            .add(UserSearchEvent.searchUsers(query));
      } else {
        context.read<UserSearchBloc>().add(const UserSearchEvent.clearSearch());
      }
    });
  }

  void _onUserSelected(String userId, String displayName) {
    // Single-select return mode: pop immediately with contact data
    if (widget.returnContact && !widget.multiSelect) {
      context.pop<Map<String, String>>({'id': userId, 'name': displayName});
      return;
    }

    // Multi-select mode: toggle selection
    if (widget.multiSelect) {
      setState(() {
        final idx = _selected.indexWhere((c) => c['id'] == userId);
        if (idx >= 0) {
          _selected.removeAt(idx);
        } else {
          _selected.add({'id': userId, 'name': displayName});
        }
      });
      return;
    }

    // Default: create/navigate to conversation
    _awaitingConversation = true;
    context
        .read<ConversationBloc>()
        .add(ConversationEvent.getOrCreateConversation(userId));
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.multiSelect
        ? 'Select Contacts${_selected.isNotEmpty ? ' (${_selected.length})' : ''}'
        : widget.returnContact
            ? 'Select Contact'
            : 'New Chat';

    return Scaffold(
      appBar: IMaliAppBar(
        title: title,
      ),
      body: WaveBackground(
        child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search by name',
                hintStyle: const TextStyle(color: AppColors.textHint),
                prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.textHint),
                        onPressed: () {
                          _searchController.clear();
                          context
                              .read<UserSearchBloc>()
                              .add(const UserSearchEvent.clearSearch());
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.chatSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                setState(() {}); // Update clear button visibility
                _onSearchChanged(query);
              },
            ),
          ),
          if (widget.multiSelect && _selected.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () =>
                      context.pop<List<Map<String, String>>>(_selected),
                  icon: const Icon(Icons.check, size: 20),
                  label: Text('Done (${_selected.length} selected)'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: BlocListener<ConversationBloc, ConversationState>(
              listenWhen: (prev, curr) =>
                  _awaitingConversation &&
                  prev.selectedConversation != curr.selectedConversation &&
                  curr.selectedConversation != null,
              listener: (context, state) {
                _awaitingConversation = false;
                // Navigate to the new/existing conversation
                final conv = state.selectedConversation!;
                context.go('/chat/conversation/${conv.id}');
              },
              child: BlocBuilder<UserSearchBloc, UserSearchState>(
              builder: (context, state) {
                if (state.isSearching) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (_searchController.text.length < 2) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for a user by name',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  );
                }

                if (state.searchResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_off,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No users found',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = state.searchResults[index];
                    return ListTile(
                      leading: _buildAvatar(context, user.displayName,
                          user.avatarUrl, user.avatarColor),
                      title: Text(user.displayName),
                      subtitle: user.username != null
                          ? Text(
                              '@${user.username}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            )
                          : null,
                      trailing: widget.multiSelect &&
                              _selected.any((c) => c['id'] == user.userId)
                          ? const Icon(Icons.check_circle,
                              color: AppColors.primary)
                          : null,
                      onTap: () =>
                          _onUserSelected(user.userId, user.displayName),
                    );
                  },
                );
              },
            ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    String displayName,
    String? avatarUrl,
    String? avatarColor,
  ) {
    final bgColor = avatarColor != null
        ? Color(int.parse(avatarColor.replaceFirst('#', '0xFF')))
        : AppColors.primary.withValues(alpha: 0.2);

    final initialsWidget = CircleAvatar(
      radius: 24,
      backgroundColor: bgColor,
      child: Text(
        _initials(displayName),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );

    if (avatarUrl != null) {
      return CachedNetworkImage(
        imageUrl: avatarUrl,
        imageBuilder: (_, imageProvider) => CircleAvatar(
          radius: 24,
          backgroundImage: imageProvider,
        ),
        placeholder: (_, __) => initialsWidget,
        errorWidget: (_, __, ___) => initialsWidget,
      );
    }

    return initialsWidget;
  }

  String _initials(String name) {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }
}
