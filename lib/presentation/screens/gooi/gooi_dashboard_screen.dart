import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/gooi_group_status.dart';
import '../../../domain/enums/gooi_member_status.dart';
import '../../blocs/gooi/gooi_dashboard_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gooi/countdown_strip.dart';
import '../../widgets/gooi/member_contribution_grid.dart';
import '../../widgets/gooi/my_status_card.dart';
import '../../widgets/gooi/pot_meter_arc.dart';
import '../../widgets/gooi/reserve_fund_card.dart';
import '../../widgets/gooi/roster_scroll.dart';

class GooiDashboardScreen extends StatefulWidget {
  final String groupId;
  const GooiDashboardScreen({super.key, required this.groupId});

  @override
  State<GooiDashboardScreen> createState() => _GooiDashboardScreenState();
}

class _GooiDashboardScreenState extends State<GooiDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GooiDashboardBloc>().add(GooiDashboardEvent.loadGroup(widget.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GooiDashboardBloc, GooiDashboardState>(
      listener: (context, state) {
        if (state.actionSuccess != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.actionSuccess!)),
          );
        }
        if (state.actionError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.actionError!), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isInitiator = state.group?.initiatorUserId == state.currentUserId;

        return Scaffold(
          backgroundColor: AppColors.chatBackground,
          appBar: AppBar(
            backgroundColor: AppColors.chatBackground,
            title: Text(state.group?.name ?? 'Gooi-Gooi'),
            actions: [
              if (state.group != null)
                PopupMenuButton<String>(
                  onSelected: (action) => _handleMenuAction(context, action, state),
                  itemBuilder: (_) => [
                    if (isInitiator)
                      const PopupMenuItem(value: 'delegate', child: Text('Delegate Trigger')),
                    const PopupMenuItem(value: 'auto', child: Text('Auto-Contribute')),
                    const PopupMenuItem(value: 'history', child: Text('History')),
                    const PopupMenuItem(value: 'withdraw', child: Text('Request Withdrawal')),
                    if (isInitiator && state.group!.status == GooiGroupStatus.completed)
                      const PopupMenuItem(value: 'writeoff', child: Text('Write Off Bad Debt')),
                    const PopupMenuItem(value: 'dissolve', child: Text('Dissolve Group')),
                  ],
                ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.errorMessage != null
                  ? Center(child: Text(state.errorMessage!))
                  : RefreshIndicator(
                      onRefresh: () async {
                        context.read<GooiDashboardBloc>().add(const GooiDashboardEvent.refreshGroup());
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          children: [
                            // Zone A: Pot Meter
                            if (state.currentCycle != null)
                              PotMeterArc(
                                totalExpected: state.currentCycle!.totalExpected,
                                totalCollected: state.currentCycle!.totalCollected,
                                memberCount: state.members.length,
                                contributions: state.contributions,
                              ),
                            const SizedBox(height: AppSpacing.md),

                            // Zone B: Member Contribution Grid
                            MemberContributionGrid(
                              members: state.members,
                              contributions: state.contributions,
                              currentCycle: state.currentCycle,
                            ),
                            const SizedBox(height: AppSpacing.md),

                            // Zone C: Countdown
                            if (state.currentCycle != null)
                              CountdownStrip(
                                dueDate: state.currentCycle!.dueDate,
                                graceCloseDate: state.currentCycle!.graceCloseDate,
                                cycleStatus: state.currentCycle!.status,
                              ),
                            const SizedBox(height: AppSpacing.md),

                            // Zone D: My Status
                            MyStatusCard(
                              group: state.group,
                              currentCycle: state.currentCycle,
                              members: state.members,
                              contributions: state.contributions,
                              currentUserId: state.currentUserId,
                              isActionInProgress: state.isActionInProgress,
                              onContribute: (subAccountId) {
                                context.read<GooiDashboardBloc>().add(
                                      GooiDashboardEvent.contribute(subAccountId: subAccountId),
                                    );
                              },
                              onTriggerPayout: () {
                                context.read<GooiDashboardBloc>().add(
                                      const GooiDashboardEvent.triggerPayout(),
                                    );
                              },
                            ),
                            const SizedBox(height: AppSpacing.md),

                            // Reserve Fund display
                            if (state.group != null)
                              ReserveFundCard(
                                group: state.group!,
                                cycles: state.cycles,
                              ),
                            const SizedBox(height: AppSpacing.md),

                            // Default members warning (Initiator only)
                            if (isInitiator) _buildDefaultersSection(context, state),

                            // Zone E: Roster
                            RosterScroll(
                              members: state.members,
                              cycles: state.cycles,
                              payouts: state.payouts,
                              group: state.group,
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  Widget _buildDefaultersSection(BuildContext context, GooiDashboardState state) {
    final defaulters = state.members.where((m) => m.status == GooiMemberStatus.suspended || m.missedCycles > 0).toList();
    if (defaulters.isEmpty) return const SizedBox.shrink();

    return Card(
      color: Colors.red.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Members Needing Attention',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.red),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...defaulters.map((m) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.red.withValues(alpha: 0.15),
                    child: const Icon(Icons.warning, color: Colors.red, size: 16),
                  ),
                  title: Text(m.displayName),
                  subtitle: Text(
                    m.status == GooiMemberStatus.suspended
                        ? 'Suspended (${m.missedCycles} missed)'
                        : '${m.missedCycles} missed cycle(s)${m.hasDebt ? " · R${(m.outstandingDebt / 100).toStringAsFixed(0)} debt" : ""}',
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (action) {
                      context.read<GooiDashboardBloc>().add(
                            GooiDashboardEvent.applyPenalty(
                              targetUserId: m.userId,
                              action: action,
                            ),
                          );
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'warn', child: Text('Warn')),
                      const PopupMenuItem(value: 'suspend', child: Text('Suspend')),
                      const PopupMenuItem(value: 'remove', child: Text('Remove')),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action, GooiDashboardState state) {
    switch (action) {
      case 'delegate':
        context.push('/chat/gooi/${widget.groupId}/delegate');
      case 'auto':
        final currentMember = state.members.where((m) => m.userId == state.currentUserId).firstOrNull;
        final isEnabled = currentMember?.autoContribute ?? false;
        context.read<GooiDashboardBloc>().add(
              GooiDashboardEvent.toggleAutoContribute(enabled: !isEnabled),
            );
      case 'history':
        context.push('/chat/gooi/${widget.groupId}/history');
      case 'withdraw':
        _showWithdrawalDialog(context);
      case 'writeoff':
        _showWriteOffDialog(context);
      case 'dissolve':
        _showDissolveDialog(context, state);
    }
  }

  void _showWithdrawalDialog(BuildContext context) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Request Withdrawal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Withdrawing requires 80% group approval. Your refund will be calculated based on contributions minus payouts received.',
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<GooiDashboardBloc>().add(
                    GooiDashboardEvent.requestWithdrawal(
                      reason: reasonController.text.isEmpty ? null : reasonController.text,
                    ),
                  );
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.gold),
            child: const Text('Submit Request'),
          ),
        ],
      ),
    );
  }

  void _showWriteOffDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Write Off Bad Debt'),
        content: const Text(
          'This will zero out any negative reserve balance caused by unrecoverable member debts. '
          'This action is logged in the audit trail and visible to all members.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<GooiDashboardBloc>().add(
                    const GooiDashboardEvent.writeOffBadDebt(),
                  );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Write Off'),
          ),
        ],
      ),
    );
  }

  void _showDissolveDialog(BuildContext context, GooiDashboardState state) {
    final isPreActive = state.group?.status == GooiGroupStatus.forming;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Dissolve Group'),
        content: Text(
          isPreActive
              ? 'This will permanently dissolve the group. All pending invitations will be cancelled.'
              : 'This will dissolve the group. Refunds will be calculated:\n\n'
                  '- Members who have NOT received a payout: proportional refund\n'
                  '- Members who already received a payout: no refund\n\n'
                  'This requires unanimous consent from all active members.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<GooiDashboardBloc>().add(
                    const GooiDashboardEvent.dissolveGroup(),
                  );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Dissolve'),
          ),
        ],
      ),
    );
  }
}
