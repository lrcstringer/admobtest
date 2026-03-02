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
import '../../widgets/messaging/media_compose_screen.dart';
import '../../widgets/messaging/media_picker_widget.dart';
import '../../widgets/messaging/message_input_bar.dart';
import '../../widgets/messaging/reaction_picker.dart';
import '../../widgets/messaging/video_message_recorder.dart';
import '../../widgets/messaging/voice_recorder_widget.dart';

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
      // 8.11 Listen for error/success feedback from CommunityBloc
      child: BlocConsumer<CommunityBloc, CommunityState>(
        listener: (context, commState) {
          if (commState.operationStatus == CommunityOperationStatus.failure &&
              commState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(commState.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, commState) {
          final community = commState.selectedCommunity;
          final showFinances = community?.hasFinancials ?? false;
          final isAdmin = community?.isAdmin(currentUserId) ?? false;

          return DefaultTabController(
            length: showFinances ? 3 : 2,
            child: Builder(
              builder: (context) {
                return AnimatedBuilder(
                  animation: DefaultTabController.of(context),
                  builder: (context, _) {
                    final currentTab =
                        DefaultTabController.of(context).index;

                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        title: Text(community?.name ?? 'Community'),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => context.push(
                                '/chat/community/${widget.communityId}/settings'),
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
                            _MembersTab(
                              members: commState.selectedCommunityMembers,
                              isLoading: commState.operationStatus ==
                                  CommunityOperationStatus.processing,
                              communityId: widget.communityId,
                              isAdmin: isAdmin,
                            ),
                            if (showFinances)
                              _FinancesTab(
                                community: community,
                                transactions:
                                    commState.selectedCommunityTransactions,
                                communityId: widget.communityId,
                                currentUserId: currentUserId,
                              ),
                          ],
                        ),
                      ),
                      floatingActionButton: currentTab == 1 && isAdmin
                          ? FloatingActionButton.extended(
                              onPressed: () => context.push(
                                  '/chat/community/${widget.communityId}/invite'),
                              icon: const Icon(Icons.person_add),
                              label: const Text('Invite'),
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          );
        },
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
              onMediaAttachment: () => _showMediaPicker(context),
              onAttachment: () => _showActionPicker(context),
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

  void _showMediaPicker(BuildContext context) {
    final bloc = context.read<CommunityMessagingBloc>();
    showMediaPicker(
      context,
      onMediaSelected: (result) {
        // 8.1 Use showGeneralDialog instead of Navigator.push for fullscreen overlay
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black,
          pageBuilder: (ctx, _, __) => MediaComposeScreen(
            mediaFile: result.file,
            mediaType: result.mediaType,
            onSend: (caption) {
              bloc.add(
                CommunityMessagingEvent.sendMediaMessage(
                  mediaFile: result.file,
                  mediaType: result.mediaType,
                  caption: caption,
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showActionPicker(BuildContext context) {
    showActionPicker(
      context,
      onVoiceNoteRequested: () => _openVoiceRecorder(context),
      onVideoNoteRequested: () => _openVideoRecorder(context),
      onGroupGiftRequested: () {
        context.push(
          '/chat/create-pool',
          extra: {'communityId': communityId},
        );
      },
    );
  }

  void _openVoiceRecorder(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      pageBuilder: (ctx, _, __) => VoiceRecorderWidget(
        onRecordingComplete: (result) {
          Navigator.of(ctx).pop();
          context.read<CommunityMessagingBloc>().add(
                CommunityMessagingEvent.sendMediaMessage(
                  mediaFile: result.file,
                  mediaType: 'audio/m4a',
                  durationSeconds: result.durationSeconds,
                ),
              );
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void _openVideoRecorder(BuildContext context) {
    final bloc = context.read<CommunityMessagingBloc>();
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      pageBuilder: (ctx, _, __) => VideoMessageRecorder(
        onRecordingComplete: (result) {
          Navigator.of(ctx).pop();
          // 8.1 Use showGeneralDialog instead of Navigator.push for fullscreen overlay
          showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black,
            pageBuilder: (ctx2, _, __) => MediaComposeScreen(
              mediaFile: result.videoFile,
              mediaType: 'video/mp4',
              thumbnailFile: result.thumbnailFile,
              durationSeconds: result.durationSeconds,
              onSend: (caption) {
                bloc.add(
                  CommunityMessagingEvent.sendMediaMessage(
                    mediaFile: result.videoFile,
                    mediaType: 'video/mp4',
                    durationSeconds: result.durationSeconds,
                    thumbnailFile: result.thumbnailFile,
                    caption: caption,
                  ),
                );
              },
            ),
          );
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }
}

// =============================================================================
// MEMBERS TAB
// =============================================================================

class _MembersTab extends StatelessWidget {
  final List<CommunityMember> members;
  final bool isLoading;
  final String communityId;
  final bool isAdmin;

  const _MembersTab({
    required this.members,
    this.isLoading = false,
    required this.communityId,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty && isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (members.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group_outlined, size: 64, color: AppColors.textHint),
            AppSpacing.verticalMd,
            Text(
              'No members yet',
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
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        final isInvited = member.isInvited;
        return Opacity(
          opacity: isInvited ? 0.6 : 1.0,
          child: Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    _roleColor(member.role).withValues(alpha: 0.2),
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
                  Expanded(child: Text(member.displayName)),
                  if (isInvited)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Pending',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
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
              // 8.16 Null-safe access to memberCount
              '${community?.memberCount ?? 0} members',
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
    // 8.16 Null-safe access — community is already guarded by caller
    if (community == null) return const SizedBox.shrink();
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
