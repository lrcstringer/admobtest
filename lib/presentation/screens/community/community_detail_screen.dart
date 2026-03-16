import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
import '../../widgets/common/tab_background.dart';
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
  bool _communityWasSeen = false;

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
          // Detect community deletion — once we've seen the community
          // in the list, navigate back if it disappears (owner deleted it,
          // or we were removed).
          final stillPresent = commState.communities
              .any((c) => c.id == widget.communityId);
          if (stillPresent) _communityWasSeen = true;
          if (_communityWasSeen && !stillPresent) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This community has been deleted'),
                ),
              );
              context.go('/chat');
            }
            return;
          }

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
                      body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
        overlayAsset: null,
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
              onAttachment: () => _showActionPicker(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context
        .read<CommunityMessagingBloc>()
        .add(const CommunityMessagingEvent.loadMessages());
    // Give the stream a moment to deliver the fresh data
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Widget _buildMessages(BuildContext context, CommunityMessagingState state) {
    if (state.isLoading && state.messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.messages.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.forum_outlined,
                        size: 64, color: AppColors.textHint),
                    AppSpacing.verticalMd,
                    Text(
                      'No messages yet',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Messages are newest-first from the DB. With reverse:true, index 0
    // renders at the bottom — so newest messages appear at the bottom.
    final messages = state.messages;

    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: ListView.builder(
        reverse: true,
        physics: const AlwaysScrollableScrollPhysics(),
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

          // Look up member avatar from CommunityBloc state (same
          // pattern as P2P's conversation.participants[senderId].avatarUrl)
          final memberAvatar = context
              .read<CommunityBloc>()
              .state
              .getMemberByUserId(message.senderId)
              ?.avatarUrl;

          return Column(
            children: [
              if (showDate) DateSeparator(date: message.createdAt),
              MessageBubble(
                message: message,
                isMe: isMe,
                currentUserId: currentUserId,
                avatarUrl: memberAvatar,
                showSenderName: true,
                onLongPress: () => _onLongPress(context, message),
              ),
            ],
          );
        },
      ),
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

  void _openMediaCompose(BuildContext context, MediaPickerResult result) {
    final bloc = context.read<CommunityMessagingBloc>();
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      pageBuilder: (ctx, _, _) => MediaComposeScreen(
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
  }

  Future<void> _pickFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null && context.mounted) {
      _openMediaCompose(
        context,
        MediaPickerResult(file: File(image.path), mediaType: 'image'),
      );
    }
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null && context.mounted) {
      _openMediaCompose(
        context,
        MediaPickerResult(file: File(image.path), mediaType: 'image'),
      );
    }
  }

  Future<void> _pickDocument(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'csv',
        'zip',
      ],
      allowMultiple: false,
    );
    if (result != null &&
        result.files.isNotEmpty &&
        result.files.first.path != null &&
        context.mounted) {
      _openMediaCompose(
        context,
        MediaPickerResult(
          file: File(result.files.first.path!),
          mediaType: 'document',
        ),
      );
    }
  }

  void _showActionPicker(BuildContext context) {
    showActionPicker(
      context,
      onCameraRequested: () => _pickFromCamera(context),
      onGalleryRequested: () => _pickFromGallery(context),
      onDocumentRequested: () => _pickDocument(context),
      onVoiceNoteRequested: () => _openVoiceRecorder(context),
      onVideoNoteRequested: () => _openVideoRecorder(context),
      onSasazaRequested: () {
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
      pageBuilder: (ctx, _, _) => VoiceRecorderWidget(
        onRecordingComplete: (result) {
          Navigator.of(ctx).pop();
          showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black,
            pageBuilder: (ctx2, _, _) => MediaComposeScreen(
              mediaFile: result.file,
              mediaType: 'audio/m4a',
              durationSeconds: result.durationSeconds,
              onSend: (caption) {
                context.read<CommunityMessagingBloc>().add(
                      CommunityMessagingEvent.sendMediaMessage(
                        mediaFile: result.file,
                        mediaType: 'audio/m4a',
                        durationSeconds: result.durationSeconds,
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

  void _openVideoRecorder(BuildContext context) {
    final bloc = context.read<CommunityMessagingBloc>();
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      pageBuilder: (ctx, _, _) => VideoMessageRecorder(
        onRecordingComplete: (result) {
          Navigator.of(ctx).pop();
          // 8.1 Use showGeneralDialog instead of Navigator.push for fullscreen overlay
          showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black,
            pageBuilder: (ctx2, _, _) => MediaComposeScreen(
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

  Future<void> _onRefresh(BuildContext context) async {
    context.read<CommunityBloc>().add(
          CommunityEvent.loadCommunityDetails(communityId: communityId),
        );
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty && isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (members.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.group_outlined,
                        size: 64, color: AppColors.textHint),
                    AppSpacing.verticalMd,
                    Text(
                      'No members yet',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
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
