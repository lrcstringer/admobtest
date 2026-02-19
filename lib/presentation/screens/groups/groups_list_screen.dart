import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/group.dart';
import '../../blocs/group/group_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

@Deprecated('Use MessagingScreen instead (communities in unified inbox). Will be removed in a future cleanup PR.')
class GroupsListScreen extends StatefulWidget {
  const GroupsListScreen({super.key});

  @override
  State<GroupsListScreen> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends State<GroupsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(const GroupEvent.loadUserGroups());
    context.read<GroupBloc>().add(const GroupEvent.loadPendingInvitations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(
        title: 'My Groups',
        extraActions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/groups/create'),
          ),
        ],
      ),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state.operationStatus == GroupOperationStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<GroupBloc>().add(const GroupEvent.clearError());
          }
        },
        builder: (context, state) {
          if (state.status == GroupLoadingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == GroupLoadingStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  AppSpacing.verticalMd,
                  Text(
                    state.errorMessage ?? 'Failed to load groups',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.verticalMd,
                  AppButton(
                    text: 'Retry',
                    onPressed: () {
                      context.read<GroupBloc>().add(const GroupEvent.loadUserGroups());
                    },
                    isFullWidth: false,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<GroupBloc>().add(const GroupEvent.loadUserGroups());
              context.read<GroupBloc>().add(const GroupEvent.loadPendingInvitations());
            },
            child: CustomScrollView(
              slivers: [
                // Pending invitations section
                if (state.pendingInvitations.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: AppSpacing.pagePadding.copyWith(bottom: 0),
                      child: Text(
                        'Pending Invitations',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: AppSpacing.pagePadding.copyWith(top: AppSpacing.sm),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildInvitationCard(
                          context,
                          state.pendingInvitations[index],
                        ),
                        childCount: state.pendingInvitations.length,
                      ),
                    ),
                  ),
                ],

                // My groups section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSpacing.pagePadding.copyWith(bottom: 0),
                    child: Text(
                      'My Groups',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),

                if (state.groups.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group_outlined,
                            size: 80,
                            color: AppColors.textTertiary,
                          ),
                          AppSpacing.verticalMd,
                          Text(
                            'No groups yet',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          AppSpacing.verticalSm,
                          Text(
                            'Create or join a group to get started',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                          ),
                          AppSpacing.verticalLg,
                          AppButton(
                            text: 'Create Group',
                            onPressed: () => context.go('/groups/create'),
                            icon: Icons.add,
                            isFullWidth: false,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: AppSpacing.pagePadding.copyWith(top: AppSpacing.sm),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildGroupCard(
                          context,
                          state.groups[index],
                        ),
                        childCount: state.groups.length,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/groups/create'),
        icon: const Icon(Icons.add),
        label: const Text('Create'),
      ),
    );
  }

  Widget _buildInvitationCard(BuildContext context, dynamic invitation) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      color: AppColors.primary.withValues(alpha: 0.1),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.mail, color: Colors.white),
        ),
        title: Text('Group Invitation'),
        subtitle: Text('You\'ve been invited as ${invitation.role.name}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: AppColors.success),
              onPressed: () {
                context.read<GroupBloc>().add(
                      GroupEvent.acceptInvitation(groupId: invitation.groupId),
                    );
              },
            ),
            IconButton(
              icon: Icon(Icons.close, color: AppColors.error),
              onPressed: () {
                context.read<GroupBloc>().add(
                      GroupEvent.declineInvitation(groupId: invitation.groupId),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, Group group) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      color: Color.alphaBlend(
        AppColors.primaryGradient[0].withValues(alpha: 0.04),
        AppColors.surface,
      ),
      child: InkWell(
        onTap: () => context.go('/groups/${group.id}'),
        borderRadius: AppSpacing.borderRadiusMd,
        child: Padding(
          padding: AppSpacing.cardPadding,
          child: Row(
            children: [
              // Group avatar
              CircleAvatar(
                radius: 28,
                backgroundColor: _getGroupTypeColor(group.type).withValues(alpha: 0.2),
                backgroundImage: group.avatarUrl != null
                    ? NetworkImage(group.avatarUrl!)
                    : null,
                child: group.avatarUrl == null
                    ? Icon(
                        _getGroupTypeIcon(group.type),
                        color: _getGroupTypeColor(group.type),
                        size: 28,
                      )
                    : null,
              ),
              AppSpacing.horizontalMd,

              // Group info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            group.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getGroupTypeColor(group.type).withValues(alpha: 0.1),
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: Text(
                            group.typeDisplayName,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: _getGroupTypeColor(group.type),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalXs,
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${group.memberCount} members',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                        AppSpacing.horizontalMd,
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'R${(group.totalBalance / 100).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.chevron_right,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getGroupTypeColor(GroupType type) {
    switch (type) {
      case GroupType.stokvel:
        return AppColors.primary;
      case GroupType.family:
        return AppColors.success;
      case GroupType.organization:
        return AppColors.secondary;
      case GroupType.club:
        return AppColors.tertiary;
    }
  }

  IconData _getGroupTypeIcon(GroupType type) {
    switch (type) {
      case GroupType.stokvel:
        return Icons.savings;
      case GroupType.family:
        return Icons.family_restroom;
      case GroupType.organization:
        return Icons.business;
      case GroupType.club:
        return Icons.groups;
    }
  }
}
