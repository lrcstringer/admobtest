import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/community_member.dart';
import '../../../domain/enums/member_role.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/tab_background.dart';

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
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
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
          body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
        overlayAsset: AppColors.waveOverlay,
            // 8.2 Show empty state instead of infinite spinner when not loading
            child: members.isEmpty &&
                    state.operationStatus == CommunityOperationStatus.processing
                ? const Center(child: CircularProgressIndicator())
                : members.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.group_outlined,
                                size: 64, color: AppColors.textHint),
                            AppSpacing.verticalMd,
                            Text('No members found',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                      )
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
    final isInvited = member.isInvited;

    return Opacity(
      opacity: isInvited ? 0.6 : 1.0,
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _roleColor(member.role).withValues(alpha: 0.2),
            backgroundImage:
                member.avatarUrl != null && !isInvited
                    ? NetworkImage(member.avatarUrl!)
                    : null,
            child: member.avatarUrl == null || isInvited
                ? Icon(
                    isInvited ? Icons.mail_outline : Icons.person,
                    color: isInvited
                        ? AppColors.warning
                        : _roleColor(member.role),
                    size: 20,
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
              if (isInvited)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Pending',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                  ),
                ),
            ],
          ),
          subtitle: Text(
            isInvited
                ? '${member.roleDisplayName} · Invitation sent'
                : member.roleDisplayName,
          ),
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
