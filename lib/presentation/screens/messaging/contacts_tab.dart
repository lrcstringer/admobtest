import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/brand_account.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/contact_suggestion.dart';
import '../../../domain/value_objects/user_search_result.dart';
import '../../blocs/community/community_bloc.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Contacts tab showing accepted contacts, contact requests,
/// joined communities, and brand accounts placeholder.
class ContactsTab extends StatefulWidget {
  const ContactsTab({super.key});

  @override
  State<ContactsTab> createState() => _ContactsTabState();
}

enum _SearchFilter { all, contacts, communities, brands, people }

class _ContactsTabState extends State<ContactsTab> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  _SearchFilter _activeFilter = _SearchFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state.actionError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.actionError!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, contactState) {
        return Column(
          children: [
            // Search bar
            _buildSearchBar(context),
            // Content
            Expanded(
              child: _isSearching
                  ? _buildSearchResults(context, contactState)
                  : _buildContactsList(context, contactState),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search contacts...',
          prefixIcon:
              const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _isSearching = false);
                    context
                        .read<ContactBloc>()
                        .add(const ContactEvent.clearSearch());
                  },
                )
              : null,
          filled: true,
          fillColor: AppColors.chatSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: (query) {
          setState(() {
            _isSearching = query.isNotEmpty;
            _activeFilter = _SearchFilter.all;
          });
          if (query.isNotEmpty) {
            context
                .read<ContactBloc>()
                .add(ContactEvent.unifiedSearch(query));
          } else {
            context
                .read<ContactBloc>()
                .add(const ContactEvent.clearSearch());
          }
        },
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, ContactState state) {
    if (state.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    // Get community matches locally
    final commState = context.read<CommunityBloc>().state;
    final queryLower = _searchController.text.toLowerCase();
    final communityMatches = commState.activeCommunities
        .where((c) => c.name.toLowerCase().contains(queryLower))
        .toList();

    final hasContacts = state.searchResults.isNotEmpty;
    final hasCommunities = communityMatches.isNotEmpty;
    final hasBrands = state.brandSearchResults.isNotEmpty;
    final hasPeople = state.globalSearchResults.isNotEmpty;
    final hasAny = hasContacts || hasCommunities || hasBrands || hasPeople;

    if (!hasAny) {
      return Center(
        child: Text(
          'No results found',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      );
    }

    return Column(
      children: [
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              _buildFilterChip('All', _SearchFilter.all),
              if (hasContacts)
                _buildFilterChip('Contacts', _SearchFilter.contacts),
              if (hasCommunities)
                _buildFilterChip('Communities', _SearchFilter.communities),
              if (hasBrands)
                _buildFilterChip('Brands', _SearchFilter.brands),
              if (hasPeople)
                _buildFilterChip('People', _SearchFilter.people),
            ],
          ),
        ),

        // Results
        Expanded(
          child: ListView(
            children: [
              // Contacts section
              if (hasContacts &&
                  (_activeFilter == _SearchFilter.all ||
                      _activeFilter == _SearchFilter.contacts)) ...[
                _buildSectionHeader(context, 'Contacts'),
                ...state.searchResults
                    .map((c) => _buildContactTile(context, c)),
              ],

              // Communities section
              if (hasCommunities &&
                  (_activeFilter == _SearchFilter.all ||
                      _activeFilter == _SearchFilter.communities)) ...[
                _buildSectionHeader(context, 'Communities'),
                ...communityMatches.map(
                  (comm) => ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            AppColors.secondary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.group,
                          color: AppColors.secondary),
                    ),
                    title: Text(
                      comm.name,
                      style:
                          const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${comm.memberCount} members',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    onTap: () =>
                        context.push('/chat/community/${comm.id}'),
                  ),
                ),
              ],

              // Brands section
              if (hasBrands &&
                  (_activeFilter == _SearchFilter.all ||
                      _activeFilter == _SearchFilter.brands)) ...[
                _buildSectionHeader(context, 'Brands'),
                ...state.brandSearchResults.map(
                  (brand) => _buildBrandSearchTile(context, brand),
                ),
              ],

              // Global users section
              if (hasPeople &&
                  (_activeFilter == _SearchFilter.all ||
                      _activeFilter == _SearchFilter.people)) ...[
                _buildSectionHeader(context, 'People on iMaliChat'),
                ...state.globalSearchResults.map(
                  (user) => _buildGlobalUserTile(context, user),
                ),
              ],

              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, _SearchFilter filter) {
    final isActive = _activeFilter == filter;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isActive,
        onSelected: (_) => setState(() => _activeFilter = filter),
        selectedColor: AppColors.primary.withValues(alpha: 0.15),
        labelStyle: TextStyle(
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          fontSize: 13,
        ),
        backgroundColor: AppColors.chatSurface,
        side: BorderSide.none,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget _buildBrandSearchTile(BuildContext context, BrandAccount brand) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.storefront, color: AppColors.secondary),
      ),
      title: Text(
        brand.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        brand.description ?? '${brand.followerCount} followers',
        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
      trailing: brand.isFollowed
          ? const Chip(label: Text('Following'))
          : FilledButton(
              onPressed: () => context
                  .read<ContactBloc>()
                  .add(ContactEvent.followBrand(brand.id)),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Follow'),
            ),
    );
  }

  Widget _buildGlobalUserTile(
      BuildContext context, UserSearchResult user) {
    return ListTile(
      leading: _buildUserAvatar(
          user.displayName, user.avatarUrl, user.avatarColor),
      title: Text(
        user.displayName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: user.username != null
          ? Text(
              '@${user.username}',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: FilledButton(
        onPressed: () => context
            .read<ContactBloc>()
            .add(ContactEvent.sendContactRequest(user.userId)),
        style: FilledButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text('Add'),
      ),
    );
  }

  Widget _buildUserAvatar(
      String displayName, String? avatarUrl, String? avatarColor) {
    const double size = 48;
    const double radius = 6;

    Color color = AppColors.primary;
    if (avatarColor != null && avatarColor.isNotEmpty) {
      try {
        color =
            Color(int.parse(avatarColor.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }

    final initials = _getUserInitials(displayName);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  String _getUserInitials(String name) {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }

  Widget _buildContactsList(
    BuildContext context,
    ContactState contactState,
  ) {
    if (contactState.status == ContactLoadingStatus.loading &&
        contactState.contacts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        // People You May Know suggestions carousel
        if (contactState.suggestions.isNotEmpty)
          _buildSuggestionsCarousel(context, contactState.suggestions),

        // New Friends / Contact Requests row
        if (contactState.pendingRequestCount > 0)
          _buildNewFriendsRow(context, contactState.pendingRequestCount),

        // My Contacts section
        if (contactState.contacts.isNotEmpty) ...[
          _buildSectionHeader(context, 'My Contacts'),
          ..._buildAlphabeticalContacts(context, contactState.contacts),
        ],

        // Brand Accounts section
        if (contactState.followedBrands.isNotEmpty) ...[
          _buildSectionHeader(context, 'Brand Accounts'),
          ...contactState.followedBrands.map(
            (brand) => ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.storefront,
                    color: AppColors.secondary),
              ),
              title: Text(
                brand.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                brand.description ?? '${brand.followerCount} followers',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              onTap: () {
                // TODO: Open brand conversation (Phase 4+)
              },
            ),
          ),
        ],

        // Empty state
        if (contactState.contacts.isEmpty &&
            contactState.pendingRequestCount == 0)
          _buildEmptyState(context),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSuggestionsCarousel(
    BuildContext context,
    List<ContactSuggestion> suggestions,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'People You May Know'),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return _buildSuggestionCard(context, suggestion);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionCard(
    BuildContext context,
    ContactSuggestion suggestion,
  ) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        elevation: 0,
        color: AppColors.chatSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dismiss button
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => context.read<ContactBloc>().add(
                        ContactEvent.dismissSuggestion(suggestion.userId),
                      ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: AppColors.textHint,
                  ),
                ),
              ),
              // Avatar
              _buildUserAvatar(
                suggestion.displayName,
                suggestion.avatarUrl,
                suggestion.avatarColor,
              ),
              const SizedBox(height: 8),
              // Name
              Text(
                suggestion.displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              // Reason
              Text(
                suggestion.reason,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Add button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.read<ContactBloc>().add(
                        ContactEvent.sendContactRequest(suggestion.userId),
                      ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Add', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewFriendsRow(BuildContext context, int count) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.person_add, color: AppColors.primary),
      ),
      title: const Text(
        'New Friends',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '$count pending',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '$count',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
      onTap: () => context.push('/chat/contact-requests'),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  List<Widget> _buildAlphabeticalContacts(
    BuildContext context,
    List<Contact> contacts,
  ) {
    // Sort by effective display name
    final sorted = List<Contact>.from(contacts)
      ..sort((a, b) => a.effectiveDisplayName
          .toLowerCase()
          .compareTo(b.effectiveDisplayName.toLowerCase()));

    final widgets = <Widget>[];
    String? lastLetter;

    for (final contact in sorted) {
      final firstLetter =
          contact.effectiveDisplayName[0].toUpperCase();
      if (firstLetter != lastLetter) {
        lastLetter = firstLetter;
        widgets.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              firstLetter,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );
      }
      widgets.add(_buildContactTile(context, contact));
    }

    return widgets;
  }

  Widget _buildContactTile(BuildContext context, Contact contact) {
    return ListTile(
      leading: _buildAvatar(contact),
      title: Text(
        contact.effectiveDisplayName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: contact.username != null
          ? Text(
              '@${contact.username}',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: contact.isFavorite
          ? Icon(Icons.star, color: AppColors.warning, size: 20)
          : null,
      onTap: () => _openChat(context, contact),
      onLongPress: () => _showContactOptions(context, contact),
    );
  }

  Widget _buildAvatar(Contact contact) {
    const double size = 48;
    const double radius = 6;

    final initialsWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _avatarColor(contact.avatarColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        contact.initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );

    if (contact.avatarUrl != null && contact.avatarUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: contact.avatarUrl!,
        imageBuilder: (_, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, __) => initialsWidget,
        errorWidget: (_, __, ___) => initialsWidget,
      );
    }

    return initialsWidget;
  }

  Color _avatarColor(String? colorStr) {
    if (colorStr != null && colorStr.isNotEmpty) {
      try {
        return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    return AppColors.primary;
  }

  void _openChat(BuildContext context, Contact contact) {
    // Create or open a P2P conversation with this contact
    context.read<ConversationBloc>().add(
          ConversationEvent.getOrCreateConversation(contact.contactUserId),
        );
    // The bloc listener will navigate to the conversation
  }

  void _showContactOptions(BuildContext context, Contact contact) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(
                contact.isFavorite ? Icons.star_outline : Icons.star,
                color: AppColors.warning,
              ),
              title: Text(
                contact.isFavorite
                    ? 'Remove from Favorites'
                    : 'Add to Favorites',
              ),
              onTap: () {
                Navigator.pop(ctx);
                context.read<ContactBloc>().add(
                      ContactEvent.toggleFavorite(
                        contactId: contact.id,
                        isFavorite: !contact.isFavorite,
                      ),
                    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_remove_outlined),
              title: const Text('Remove Contact'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmRemoveContact(context, contact);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppColors.error),
              title: const Text('Block'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmBlockContact(context, contact);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _confirmRemoveContact(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Contact?'),
        content: Text(
          'Remove "${contact.effectiveDisplayName}" from your contacts?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<ContactBloc>()
                  .add(ContactEvent.removeContact(contact.id));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _confirmBlockContact(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Block Contact?'),
        content: Text(
          'Block "${contact.effectiveDisplayName}"? '
          'They will not be able to message you.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<ContactBloc>()
                  .add(ContactEvent.blockContact(contact.id));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSpacing.verticalXl,
          Icon(Icons.contacts_outlined,
              size: 80, color: AppColors.textHint),
          AppSpacing.verticalLg,
          Text(
            'No contacts yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          AppSpacing.verticalSm,
          Text(
            'Search for users or import your phone contacts to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
