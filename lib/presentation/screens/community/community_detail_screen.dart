import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/community.dart';
import '../../../domain/entities/community_member.dart';
import '../../../domain/entities/community_transaction.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/enums/member_role.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/community/community_bloc.dart';
import '../../blocs/community_messaging/community_messaging_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/wave_background.dart';
import '../../widgets/messaging/date_separator.dart';
import '../../widgets/messaging/message_bubble.dart';
import '../../widgets/messaging/message_input_bar.dart';
import '../../widgets/messaging/reaction_picker.dart';

/// Community detail screen with 3 tabs: Chat, Members, Finances.
///
/// Creates a scoped [CommunityMessagingBloc] for the chat tab.
class CommunityDetailScreen extends StatefulWidget {
  final String communityId;

  const CommunityDetailScreen({super.key, required this.communityId});

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  late final CommunityMessagingBloc _messagingBloc;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messagingBloc = GetIt.instance<CommunityMessagingBloc>(
      param1: widget.communityId,
    );
    _messagingBloc.add(const CommunityMessagingEvent.watchMessages());

    context
        .read<CommunityBloc>()
        .add(CommunityEvent.loadCommunityDetails(communityId: widget.communityId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messagingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    return BlocProvider<CommunityMessagingBloc>.value(
      value: _messagingBloc,
      child: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, commState) {
          final community = commState.selectedCommunity;
          final showFinances = community?.hasFinancials ?? false;

          return DefaultTabController(
            length: showFinances ? 3 : 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                title: Text(community?.name ?? 'Community'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () =>
                        context.push('/chat/community/${widget.communityId}/settings'),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (action) =>
                        _handleMenuAction(context, action, community),
                    itemBuilder: (context) => [
                      if (community?.isAdmin(currentUserId) ?? false)
                        const PopupMenuItem(
                          value: 'invite',
                          child: Text('Invite Member'),
                        ),
                      const PopupMenuItem(
                        value: 'members',
                        child: Text('All Members'),
                      ),
                      const PopupMenuItem(
                        value: 'leave',
                        child: Text('Leave Community'),
                      ),
                    ],
                  ),
                ],
                bottom: TabBar(
                  tabs: [
                    const Tab(text: 'Chat'),
                    const Tab(text: 'Members'),
                    if (showFinances) const Tab(text: 'Finances'),
                  ],
                ),
              ),
              body: WaveBackground(
                child: TabBarView(
                  children: [
                    _ChatTab(
                      communityId: widget.communityId,
                      messageController: _messageController,
                      currentUserId: currentUserId,
                    ),
                    _MembersTab(members: commState.selectedCommunityMembers),
                    if (showFinances)
                      _FinancesTab(
                        community: community,
                        transactions: commState.selectedCommunityTransactions,
                        communityId: widget.communityId,
                        currentUserId: currentUserId,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleMenuAction(
      BuildContext context, String action, Community? community) {
    switch (action) {
      case 'invite':
        context.push('/chat/community/${widget.communityId}/invite');
      case 'members':
        context.push('/chat/community/${widget.communityId}/members');
      case 'leave':
        if (community != null) _confirmLeave(context, community);
    }
  }

  void _confirmLeave(BuildContext context, Community community) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave Community?'),
        content: Text('Are you sure you want to leave "${community.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CommunityBloc>().add(
                    CommunityEvent.leaveCommunity(
                        communityId: widget.communityId),
                  );
              context.go('/chat');
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// CHAT TAB
// =============================================================================

class _ChatTab extends StatelessWidget {
  final String communityId;
  final TextEditingController messageController;
  final String currentUserId;

  const _ChatTab({
    required this.communityId,
    required this.messageController,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityMessagingBloc, CommunityMessagingState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(child: _buildMessages(context, state)),
            MessageInputBar(
              controller: messageController,
              isSending: state.isSending,
              onSend: () => _send(context),
              onAttachment: () => _showCommunityActions(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessages(BuildContext context, CommunityMessagingState state) {
    if (state.isLoading && state.messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.forum_outlined, size: 64, color: AppColors.textHint),
            AppSpacing.verticalMd,
            Text(
              'No messages yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    final messages = state.messages.reversed.toList();

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        if (!message.isVisibleTo(currentUserId)) {
          return const SizedBox.shrink();
        }

        final isMe = message.isSentBy(currentUserId);
        final showDate = index == messages.length - 1 ||
            !DateSeparator.isSameDay(
              messages[index].createdAt,
              messages[index + 1].createdAt,
            );

        return Column(
          children: [
            if (showDate) DateSeparator(date: message.createdAt),
            MessageBubble(
              message: message,
              isMe: isMe,
              currentUserId: currentUserId,
              showSenderName: true,
              onLongPress: () => _onLongPress(context, message),
            ),
          ],
        );
      },
    );
  }

  void _send(BuildContext context) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    context.read<CommunityMessagingBloc>().add(
          CommunityMessagingEvent.sendTextMessage(text: text),
        );
    messageController.clear();
  }

  void _onLongPress(BuildContext context, Message message) async {
    final bloc = context.read<CommunityMessagingBloc>();
    final emoji = await showReactionPicker(context);
    if (emoji != null) {
      if (message.hasReacted(currentUserId, emoji)) {
        bloc.add(CommunityMessagingEvent.removeReaction(
          messageId: message.id,
          emoji: emoji,
        ));
      } else {
        bloc.add(CommunityMessagingEvent.addReaction(
          messageId: message.id,
          emoji: emoji,
        ));
      }
    }
  }

  void _showCommunityActions(BuildContext context) {
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
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Send Gift'),
              subtitle: const Text('Send a wrapped gift to a member'),
              onTap: () {
                Navigator.pop(ctx);
                _showGiftMemberPicker(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.celebration),
              title: const Text('Start Token Spray'),
              subtitle: const Text('Celebrate a member together'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/chat/community/$communityId/create-spray');
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showGiftMemberPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => BlocBuilder<CommunityBloc, CommunityState>(
        builder: (blocContext, communityState) {
          final members = communityState.selectedCommunityMembers
              .where((m) => m.isActive && m.userId != currentUserId)
              .toList();

          return SafeArea(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Send Gift To',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                if (members.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('No other members available'),
                  )
                else
                  ...members.map((member) => ListTile(
                        title: Text(member.displayName),
                        onTap: () {
                          Navigator.pop(ctx);
                          context.push(
                            '/chat/community/$communityId/send-gift',
                            extra: {
                              'recipientId': member.userId,
                              'recipientName': member.displayName,
                            },
                          );
                        },
                      )),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

// =============================================================================
// MEMBERS TAB
// =============================================================================

class _MembersTab extends StatelessWidget {
  final List<CommunityMember> members;

  const _MembersTab({required this.members});

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: AppSpacing.pagePadding,
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
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
            title: Text(member.displayName),
            subtitle: Text(member.roleDisplayName),
            trailing: member.contributionBalance > 0
                ? Text(
                    'R${(member.contributionBalance / 100).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _roleColor(member.role),
                          fontWeight: FontWeight.w500,
                        ),
                  )
                : null,
          ),
        );
      },
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
}

// =============================================================================
// FINANCES TAB
// =============================================================================

class _FinancesTab extends StatelessWidget {
  final Community? community;
  final List<CommunityTransaction> transactions;
  final String communityId;
  final String currentUserId;

  const _FinancesTab({
    required this.community,
    required this.transactions,
    required this.communityId,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        children: [
          // Balance Card
          _buildBalanceCard(context),
          AppSpacing.verticalMd,

          // Action Buttons
          if (community != null) _buildActionButtons(context),
          AppSpacing.verticalLg,

          // Transactions
          Text(
            'Recent Transactions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          AppSpacing.verticalSm,
          if (transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(
                'No transactions yet',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            )
          else
            ...transactions.map((tx) => _buildTransactionCard(context, tx)),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.logoGradient,
        ),
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Column(
        children: [
          Text(
            'Community Balance',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                ),
          ),
          AppSpacing.verticalSm,
          Text(
            'R${community?.balanceZar.toStringAsFixed(2) ?? '0.00'}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (community?.isStokvel ?? false) ...[
            AppSpacing.verticalXs,
            Text(
              '${community!.memberCount} members',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                  ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final isAdmin = community!.isAdmin(currentUserId);

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () =>
                context.push('/chat/community/$communityId/contribute'),
            icon: const Icon(Icons.add),
            label: const Text('Contribute'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        if (community!.settings.allowMemberWithdrawals || isAdmin) ...[
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () =>
                  context.push('/chat/community/$communityId/withdraw'),
              icon: const Icon(Icons.remove),
              label: const Text('Withdraw'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTransactionCard(
      BuildContext context, CommunityTransaction tx) {
    final isPositive = tx.isInflow;

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
        title: Text(tx.description ?? tx.typeDisplayName),
        subtitle: Text(_formatDate(tx.createdAt)),
        trailing: Text(
          '${isPositive ? '+' : '-'}R${(tx.amount / 100).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isPositive ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';
}
