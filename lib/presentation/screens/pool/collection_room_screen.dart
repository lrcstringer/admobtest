import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/token_pool.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/token_pool/token_pool_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/messaging/message_bubble.dart';
import '../../widgets/messaging/message_input_bar.dart';
import '../../widgets/pool/contribute_sheet.dart';
import '../../widgets/pool/pool_progress_card.dart';
import '../../widgets/pool/withdrawal_request_sheet.dart';
import 'pool_distribute_sheet.dart';

/// Main screen for a Collection Room (pool conversation).
/// Shows pool progress card + chat messages.
class CollectionRoomScreen extends StatefulWidget {
  final String poolId;

  const CollectionRoomScreen({super.key, required this.poolId});

  @override
  State<CollectionRoomScreen> createState() => _CollectionRoomScreenState();
}

class _CollectionRoomScreenState extends State<CollectionRoomScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start watching the pool
    context
        .read<TokenPoolBloc>()
        .add(TokenPoolEvent.watchPool(widget.poolId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String get _currentUserId =>
      context.read<AuthBloc>().state.user?.id ?? '';

  void _showContributeSheet(TokenPool pool) {
    // Hardcoded balance — wire to WalletBloc when wallet integration is complete
    const availableBalance = 10000;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ContributeSheet(
        pool: pool,
        availableBalance: availableBalance,
        onContribute: (amount, anonymous) {
          context.read<TokenPoolBloc>().add(TokenPoolEvent.contribute(
                poolId: pool.id,
                amount: amount,
                anonymous: anonymous,
              ));
        },
      ),
    );
  }

  void _showDistributeSheet(TokenPool pool) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => PoolDistributeSheet(
        pool: pool,
        onDistribute: (payouts, keepOpen) {
          context.read<TokenPoolBloc>().add(TokenPoolEvent.distributePool(
                poolId: pool.id,
                payouts: payouts,
                keepOpen: keepOpen,
              ));
        },
      ),
    );
  }

  void _showWithdrawalSheet(TokenPool pool) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => WithdrawalRequestSheet(
        pool: pool,
        currentUserId: _currentUserId,
        onWithdraw: (amount) {
          context.read<TokenPoolBloc>().add(TokenPoolEvent.requestWithdrawal(
                poolId: pool.id,
                amount: amount,
              ));
        },
      ),
    );
  }

  void _confirmSendGift(TokenPool pool) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Send Group Sasaza?'),
        content: Text(
          'Send ${pool.totalAmount} tokens to ${pool.recipientName}? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<TokenPoolBloc>()
                  .add(TokenPoolEvent.sendGroupGift(pool.id));
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _confirmCancel(TokenPool pool) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Collection?'),
        content: Text(
          pool.hasContributions
              ? 'All ${pool.totalAmount} tokens will be refunded to contributors.'
              : 'This collection room will be closed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<TokenPoolBloc>()
                  .add(TokenPoolEvent.cancelPool(pool.id));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Cancel Collection'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TokenPoolBloc, TokenPoolState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
          context
              .read<TokenPoolBloc>()
              .add(const TokenPoolEvent.clearError());
        }
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.success,
            ),
          );
          context
              .read<TokenPoolBloc>()
              .add(const TokenPoolEvent.clearError());
        }
      },
      builder: (context, poolState) {
        final pool = poolState.activePool;

        return Scaffold(
          appBar: AppBar(
            title: Text(pool?.title ?? 'Collection Room'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            actions: [
              if (pool != null &&
                  pool.isOrganizer(_currentUserId) &&
                  pool.isCollecting)
                PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'cancel') _confirmCancel(pool);
                  },
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 'cancel',
                      child: Row(
                        children: [
                          Icon(Icons.cancel, color: AppColors.error, size: 20),
                          SizedBox(width: 8),
                          Text('Cancel Collection'),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          body: pool == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    // Pool progress card
                    PoolProgressCard(
                      pool: pool,
                      currentUserId: _currentUserId,
                      onContribute: () => _showContributeSheet(pool),
                      onSend: () => _confirmSendGift(pool),
                      onDistribute: () => _showDistributeSheet(pool),
                      onCancel: () => _confirmCancel(pool),
                      onRequestWithdrawal: () => _showWithdrawalSheet(pool),
                    ),

                    // Messages list (from conversation)
                    Expanded(
                      child: _buildMessageList(pool),
                    ),

                    // Text input (for chat coordination, only when collecting)
                    if (pool.isCollecting)
                      _buildMessageInput(pool.conversationId),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildMessageList(TokenPool pool) {
    // Use ConversationBloc to load messages for the collection room's conversation
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, convState) {
        final messages = convState.messages;

        if (messages.isEmpty) {
          return Center(
            child: Text(
              'Chat about the collection here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
          );
        }

        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return MessageBubble(
              message: message,
              isMe: message.senderId == _currentUserId,
              currentUserId: _currentUserId,
            );
          },
        );
      },
    );
  }

  void _sendMessage(BuildContext context, String conversationId) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<ConversationBloc>().add(
          ConversationEvent.sendTextMessage(
            conversationId: conversationId,
            text: text,
          ),
        );
    _messageController.clear();
  }

  Widget _buildMessageInput(String conversationId) {
    return MessageInputBar(
      controller: _messageController,
      isSending: false,
      onSend: () => _sendMessage(context, conversationId),
    );
  }
}
