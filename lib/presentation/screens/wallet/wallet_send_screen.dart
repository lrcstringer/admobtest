import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/value_objects/user_search_result.dart';
import '../../blocs/user_search/user_search_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';

class WalletSendScreen extends StatefulWidget {
  final String? subAccountId;

  const WalletSendScreen({super.key, this.subAccountId});

  @override
  State<WalletSendScreen> createState() => _WalletSendScreenState();
}

class _WalletSendScreenState extends State<WalletSendScreen> {
  final TextEditingController _searchController = TextEditingController();

  /// Returns the accountTypeId to filter contacts by, if the sub-account
  /// has p2pRestrictToSameAccountType enabled.
  String? get _filterAccountTypeId {
    if (widget.subAccountId == null) return null;
    final walletState = context.read<WalletBloc>().state;
    final sa = walletState.subAccounts
        .where((s) => s.id == widget.subAccountId)
        .firstOrNull;
    if (sa == null || !sa.p2pRestrictToSameAccountType) return null;
    return sa.accountTypeId;
  }

  @override
  void initState() {
    super.initState();
    context.read<UserSearchBloc>().add(const UserSearchEvent.clearSearch());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IMaliAppBar(title: 'Send To'),
      body: TabBackground(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.themed(context).tabGradient,
        ),
        overlayAsset: null,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  context.read<UserSearchBloc>().add(
                        UserSearchEvent.searchUsers(
                          query,
                          accountTypeId: _filterAccountTypeId,
                        ),
                      );
                },
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  hintStyle: TextStyle(color: AppColors.textHint),
                  prefixIcon:
                      Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),

            // Results
            Expanded(
              child: BlocBuilder<UserSearchBloc, UserSearchState>(
                builder: (context, state) {
                  if (state.isSearching) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.searchResults.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return ListView.builder(
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) {
                      return _buildContactTile(
                          context, state.searchResults[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final hasQuery = _searchController.text.length >= 2;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasQuery ? Icons.person_off : Icons.person_search,
              size: 64,
              color: AppColors.textHint,
            ),
            AppSpacing.verticalLg,
            Text(
              hasQuery ? 'No users found' : 'Search for a contact',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              hasQuery
                  ? 'Try a different name'
                  : 'Type at least 2 characters to search',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, UserSearchResult contact) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withValues(alpha: 0.15),
        backgroundImage:
            contact.avatarUrl != null ? NetworkImage(contact.avatarUrl!) : null,
        child: contact.avatarUrl == null
            ? Text(
                contact.displayName.isNotEmpty
                    ? contact.displayName[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      title: Text(
        contact.displayName,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: contact.username != null
          ? Text(
              '@${contact.username}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textTertiary,
      ),
      onTap: () {
        context.go(
          '/wallet/send/amount',
          extra: {
            'recipientUserId': contact.userId,
            'recipientName': contact.displayName,
            'subAccountId': widget.subAccountId,
          },
        );
      },
    );
  }
}
