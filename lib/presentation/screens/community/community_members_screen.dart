import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/community_member.dart';
import '../../../domain/enums/member_role.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Full members list with admin actions (role change, remove).
class CommunityMembersScreen extends StatelessWidget {
  final String communityId;

  const CommunityMembersScreen({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state.operationStatus == CommunityOperationStatus.success &&
            state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.success,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        } else if (state.operationStatus == CommunityOperationStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Operation failed'),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        }
      },
      builder: (context, state) {
        final community = state.selectedCommunity;
        final members = state.selectedCommunityMembers;
        final isAdmin = community?.isAdmin(currentUserId) ?? false;

        return Scaffold(
          appBar: AppBar(
            title: Text('Members (${members.length})'),
            actions: [
              if (isAdmin)
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () =>
                      context.push('/chat/community/$communityId/invite'),
                ),
            ],
          ),
          body: members.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: AppSpacing.pagePadding,
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return _MemberCard(
                      member: member,
                      currentUserId: currentUserId,
                      isCurrentUserAdmin: isAdmin,
                      communityId: communityId,
                    );
                  },
                ),
        );
      },
    );
  }
}

// =============================================================================
// MEMBER CARD
// =============================================================================

class _MemberCard extends StatelessWidget {
  final CommunityMember member;
  final String currentUserId;
  final bool isCurrentUserAdmin;
  final String communityId;

  const _MemberCard({
    required this.member,
    required this.currentUserId,
    required this.isCurrentUserAdmin,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = member.userId == currentUserId;
    final canManage = isCurrentUserAdmin && !member.isOwner && !isMe;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _roleColor(member.role).withValues(alpha: 0.2),
          backgroundImage: member.avatarUrl != null
              ? NetworkImage(member.avatarUrl!)
              : null,
          child: member.avatarUrl == null
              ? Text(
                  member.displayName.isNotEmpty
                      ? member.displayName[0].toUpperCase()
                      : '?',
                  style: TextStyle(color: _roleColor(member.role)),
                )
              : null,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                isMe ? '${member.displayName} (You)' : member.displayName,
              ),
            ),
          ],
        ),
        subtitle: Text(member.roleDisplayName),
        trailing: canManage
            ? PopupMenuButton<String>(
                onSelected: (action) =>
                    _handleAction(context, action, member),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'role',
                    child: Text('Change Role'),
                  ),
                  const PopupMenuItem(
                    value: 'remove',
                    child: Text('Remove Member'),
                  ),
                ],
              )
            : member.contributionBalance > 0
                ? Text(
                    'R${(member.contributionBalance / 100).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                : null,
      ),
    );
  }

  void _handleAction(
    BuildContext context,
    String action,
    CommunityMember member,
  ) {
    switch (action) {
      case 'role':
        _showRoleDialog(context, member);
      case 'remove':
        _confirmRemove(context, member);
    }
  }

  void _showRoleDialog(BuildContext context, CommunityMember member) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text('Change role for ${member.displayName}'),
        children: [
          for (final role in [
            MemberRole.admin,
            MemberRole.treasurer,
            MemberRole.member,
            MemberRole.viewer,
          ])
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(ctx);
                context.read<CommunityBloc>().add(
                      CommunityEvent.updateMemberRole(
                        communityId: communityId,
                        memberId: member.userId,
                        role: role,
                      ),
                    );
              },
              child: Row(
                children: [
                  Icon(
                    role == member.role
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: _roleColor(role),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(_roleDisplayName(role)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _confirmRemove(BuildContext context, CommunityMember member) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Member?'),
        content:
            Text('Remove ${member.displayName} from this community?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CommunityBloc>().add(
                    CommunityEvent.removeMember(
                      communityId: communityId,
                      memberId: member.userId,
                    ),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  Color _roleColor(MemberRole role) {
    switch (role) {
      case MemberRole.owner:
        return AppColors.primary;
      case MemberRole.admin:
        return AppColors.secondary;
      case MemberRole.treasurer:
        return AppColors.success;
      case MemberRole.member:
        return AppColors.textSecondary;
      case MemberRole.viewer:
        return AppColors.textHint;
    }
  }

  String _roleDisplayName(MemberRole role) {
    switch (role) {
      case MemberRole.owner:
        return 'Owner';
      case MemberRole.admin:
        return 'Admin';
      case MemberRole.treasurer:
        return 'Treasurer';
      case MemberRole.member:
        return 'Member';
      case MemberRole.viewer:
        return 'Viewer';
    }
  }
}
