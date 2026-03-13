import 'package:flutter/material.dart';

import '../../../domain/entities/conversation.dart';
import '../../theme/app_colors.dart';
import 'imali_avatar.dart';

/// Modal bottom sheet for picking a conversation to forward a message to.
class ForwardConversationPicker extends StatelessWidget {
  final List<Conversation> conversations;
  final String currentUserId;
  final ValueChanged<String> onConversationSelected;

  const ForwardConversationPicker({
    super.key,
    required this.conversations,
    required this.currentUserId,
    required this.onConversationSelected,
  });

  /// Shows the picker as a modal bottom sheet and returns the selected conversation ID.
  static Future<String?> show({
    required BuildContext context,
    required List<Conversation> conversations,
    required String currentUserId,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) => ForwardConversationPicker(
          conversations: conversations,
          currentUserId: currentUserId,
          onConversationSelected: (id) => Navigator.of(ctx).pop(id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.textHint,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Forward to...',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const Divider(height: 1),
        // Conversation list
        Expanded(
          child: conversations.isEmpty
              ? Center(
                  child: Text(
                    'No conversations',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                )
              : ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final conv = conversations[index];
                    return _buildConversationTile(context, conv);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildConversationTile(BuildContext context, Conversation conv) {
    // Get the other participant's info for display
    final otherParticipantId = conv.participantIds
        .firstWhere((id) => id != currentUserId, orElse: () => '');
    final participant = conv.participants[otherParticipantId];
    final displayName = participant?.displayName ?? 'Unknown';
    final avatarUrl = participant?.avatarUrl;

    return ListTile(
      leading: IMaliAvatar(
        imageUrl: avatarUrl,
        displayName: displayName,
      ),
      title: Text(displayName),
      subtitle: conv.lastMessageText != null
          ? Text(
              conv.lastMessageText!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
          : null,
      onTap: () => onConversationSelected(conv.id),
    );
  }
}
