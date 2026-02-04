import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/group.dart';
import '../../../domain/entities/group_member.dart';
import '../../../domain/entities/group_transaction.dart';
import '../../blocs/group/group_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GroupDetailScreen extends StatefulWidget {
  final String groupId;

  const GroupDetailScreen({super.key, required this.groupId});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<GroupBloc>().add(GroupEvent.loadGroupDetails(groupId: widget.groupId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    context.read<GroupBloc>().add(const GroupEvent.clearSelectedGroup());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBloc, GroupState>(
      listener: (context, state) {
        if (state.operationStatus == GroupOperationStatus.success &&
            state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.success,
            ),
          );
          context.read<GroupBloc>().add(const GroupEvent.clearError());
        } else if (state.operationStatus == GroupOperationStatus.failure &&
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
        final group = state.selectedGroup;
        final isLoading = state.operationStatus == GroupOperationStatus.processing;

        if (group == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Group')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(group.name),
            actions: [
              if (state.hasPendingApprovals)
                Badge(
                  label: Text('${state.selectedGroupApprovals.length}'),
                  child: IconButton(
                    icon: const Icon(Icons.approval),
                    onPressed: () => context.go('/groups/${widget.groupId}/approvals'),
                  ),
                ),
              PopupMenuButton<String>(
                onSelected: (value) => _handleMenuAction(context, value, group),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'invite',
                    child: ListTile(
                      leading: Icon(Icons.person_add),
                      title: Text('Invite Member'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'leave',
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app, color: Colors.red),
                      title: Text('Leave Group', style: TextStyle(color: Colors.red)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Members'),
                Tab(text: 'Transactions'),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(context, state, group),
                  _buildMembersTab(context, state),
                  _buildTransactionsTab(context, state),
                ],
              ),
              if (isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: AppSpacing.pagePadding,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/groups/${widget.groupId}/withdraw'),
                      icon: const Icon(Icons.arrow_upward),
                      label: const Text('Withdraw'),
                    ),
                  ),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.go('/groups/${widget.groupId}/contribute'),
                      icon: const Icon(Icons.add),
                      label: const Text('Contribute'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverviewTab(BuildContext context, GroupState state, Group group) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance card
          Container(
            width: double.infinity,
            padding: AppSpacing.cardPaddingLarge,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getGradientColors(group.type),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppSpacing.borderRadiusLg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: Text(
                        group.typeDisplayName,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    const Spacer(),
                    if (group.status != GroupStatus.active)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: AppSpacing.borderRadiusSm,
                        ),
                        child: Text(
                          group.statusDisplayName,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                  ],
                ),
                AppSpacing.verticalLg,
                Text(
                  'Group Balance',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                ),
                AppSpacing.verticalXs,
                Text(
                  'R${(group.totalBalance / 100).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                AppSpacing.verticalSm,
                Text(
                  '${group.totalBalance} tokens',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalLg,

          // Group info
          Text(
            'About',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          AppSpacing.verticalSm,
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  AppSpacing.verticalMd,
                  Row(
                    children: [
                      _buildInfoChip(
                        context,
                        icon: Icons.people,
                        label: '${group.memberCount} members',
                      ),
                      AppSpacing.horizontalMd,
                      _buildInfoChip(
                        context,
                        icon: Icons.calendar_today,
                        label: 'Created ${_formatDate(group.createdAt)}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Stokvel-specific info
          if (group.isStokvel && group.stokvelSettings != null) ...[
            AppSpacing.verticalLg,
            Text(
              'Contribution Schedule',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSpacing.verticalSm,
            Card(
              child: ListTile(
                leading: Icon(Icons.repeat, color: AppColors.primary),
                title: Text(
                  '${group.settings.contributionCycle.name.toUpperCase()} contribution',
                ),
                subtitle: Text(
                  'R${(group.settings.contributionAmount / 100).toStringAsFixed(2)} per cycle',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMembersTab(BuildContext context, GroupState state) {
    final members = state.selectedGroupMembers;

    if (members.isEmpty) {
      return const Center(child: Text('No members yet'));
    }

    return ListView.builder(
      padding: AppSpacing.pagePadding,
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return _buildMemberCard(context, member);
      },
    );
  }

  Widget _buildMemberCard(BuildContext context, GroupMember member) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRoleColor(member.role).withValues(alpha: 0.2),
          backgroundImage: member.avatarUrl != null
              ? NetworkImage(member.avatarUrl!)
              : null,
          child: member.avatarUrl == null
              ? Text(
                  member.displayName.isNotEmpty
                      ? member.displayName[0].toUpperCase()
                      : '?',
                  style: TextStyle(color: _getRoleColor(member.role)),
                )
              : null,
        ),
        title: Text(member.displayName),
        subtitle: Text(member.role.name.toUpperCase()),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getRoleColor(member.role).withValues(alpha: 0.1),
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          child: Text(
            'R${(member.contributionBalance / 100).toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _getRoleColor(member.role),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsTab(BuildContext context, GroupState state) {
    final transactions = state.selectedGroupTransactions;

    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppColors.textTertiary,
            ),
            AppSpacing.verticalMd,
            Text(
              'No transactions yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: AppSpacing.pagePadding,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return _buildTransactionCard(context, tx);
      },
    );
  }

  Widget _buildTransactionCard(BuildContext context, GroupTransaction tx) {
    final isPositive = tx.type == GroupTransactionType.contribution ||
        tx.type == GroupTransactionType.transferIn;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isPositive
              ? AppColors.success.withValues(alpha: 0.1)
              : AppColors.error.withValues(alpha: 0.1),
          child: Icon(
            isPositive ? Icons.add : Icons.remove,
            color: isPositive ? AppColors.success : AppColors.error,
          ),
        ),
        title: Text(tx.description),
        subtitle: Text(_formatDate(tx.createdAt)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isPositive ? '+' : '-'}R${(tx.amount / 100).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isPositive ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (tx.status != GroupTransactionStatus.completed)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Text(
                  tx.status.name,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.warning,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, {required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  void _handleMenuAction(BuildContext context, String action, Group group) {
    switch (action) {
      case 'invite':
        context.go('/groups/${widget.groupId}/invite');
        break;
      case 'settings':
        context.go('/groups/${widget.groupId}/settings');
        break;
      case 'leave':
        _showLeaveConfirmation(context, group);
        break;
    }
  }

  void _showLeaveConfirmation(BuildContext context, Group group) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave Group?'),
        content: Text('Are you sure you want to leave "${group.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<GroupBloc>().add(
                    GroupEvent.leaveGroup(groupId: widget.groupId),
                  );
              context.go('/groups');
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  List<Color> _getGradientColors(GroupType type) {
    switch (type) {
      case GroupType.stokvel:
        return AppColors.logoGradient;
      case GroupType.family:
        return [AppColors.success, AppColors.success.withValues(alpha: 0.7)];
      case GroupType.organization:
        return [AppColors.secondary, AppColors.secondary.withValues(alpha: 0.7)];
      case GroupType.club:
        return [AppColors.tertiary, AppColors.tertiary.withValues(alpha: 0.7)];
    }
  }

  Color _getRoleColor(GroupRole role) {
    switch (role) {
      case GroupRole.owner:
        return AppColors.primary;
      case GroupRole.admin:
        return AppColors.secondary;
      case GroupRole.treasurer:
        return AppColors.success;
      case GroupRole.member:
        return AppColors.textSecondary;
      case GroupRole.viewer:
        return AppColors.textTertiary;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
