import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class WalletSendScreen extends StatefulWidget {
  final String? subAccountId;

  const WalletSendScreen({super.key, this.subAccountId});

  @override
  State<WalletSendScreen> createState() => _WalletSendScreenState();
}

class _WalletSendScreenState extends State<WalletSendScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<_ContactResult> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      final queryLower = query.toLowerCase();

      // Search by display name (prefix match)
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('displayNameLower', isGreaterThanOrEqualTo: queryLower)
          .where('displayNameLower', isLessThanOrEqualTo: '$queryLower\uf8ff')
          .limit(20)
          .get();

      final results = <_ContactResult>[];
      for (final doc in snapshot.docs) {
        if (doc.id == currentUserId) continue;
        final data = doc.data();
        results.add(_ContactResult(
          userId: doc.id,
          displayName: data['displayName'] as String? ?? 'Unknown',
          phoneNumber: data['phoneNumber'] as String? ?? '',
          avatarUrl: data['avatarUrl'] as String?,
        ));
      }

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (_) {
      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Send To'),
      body: WaveBackground(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _searchUsers,
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  hintStyle: TextStyle(color: AppColors.textHint),
                  prefixIcon:
                      Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide(color: AppColors.border),
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
              child: _isSearching
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                      ? _buildEmptyState(context)
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return _buildContactTile(
                                context, _searchResults[index]);
                          },
                        ),
            ),
          ],
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

  Widget _buildContactTile(BuildContext context, _ContactResult contact) {
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
      subtitle: Text(
        _maskPhone(contact.phoneNumber),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
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

  String _maskPhone(String phone) {
    if (phone.length < 6) return phone;
    return '${phone.substring(0, 3)}****${phone.substring(phone.length - 3)}';
  }
}

class _ContactResult {
  final String userId;
  final String displayName;
  final String phoneNumber;
  final String? avatarUrl;

  const _ContactResult({
    required this.userId,
    required this.displayName,
    required this.phoneNumber,
    this.avatarUrl,
  });
}
