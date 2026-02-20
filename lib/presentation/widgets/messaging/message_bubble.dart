import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/enums/message_status.dart';
import '../../../domain/enums/message_type.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// WeChat-style message bubble with square avatars and speech triangles.
///
/// Handles text, token send/request, image, voice, and system messages.
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final String currentUserId;

  /// Optional avatar URL override (from conversation participant info).
  /// Falls back to [message.senderAvatarUrl] if null.
  final String? avatarUrl;

  /// Whether to show the sender name above the bubble (community messages).
  final bool showSenderName;

  /// Called when user taps a pending token request "Pay" or "Decline".
  final ValueChanged<bool>? onTokenRequestAction;

  /// Called when user long-presses the bubble (reactions, reply, etc.).
  final VoidCallback? onLongPress;

  /// Called when user taps the reply context.
  final VoidCallback? onReplyTap;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.currentUserId,
    this.avatarUrl,
    this.showSenderName = false,
    this.onTokenRequestAction,
    this.onLongPress,
    this.onReplyTap,
  });

  String? get _effectiveAvatarUrl => avatarUrl ?? message.senderAvatarUrl;

  @override
  Widget build(BuildContext context) {
    if (message.isSystem) return _buildSystemMessage(context);
    if (message.isTokenTransfer) return _buildTokenCard(context);

    final bubbleColor =
        isMe ? AppColors.chatBubbleSent : AppColors.chatBubbleReceived;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Left avatar (received messages)
              if (!isMe) ...[
                _buildSquareAvatar(),
                const SizedBox(width: 4),
              ],
              // Bubble with triangle
              Flexible(
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (showSenderName && !isMe)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          message.senderName,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    if (message.replyTo != null) _buildReplyContext(context),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left triangle (received)
                        if (!isMe)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomPaint(
                              size: const Size(6, 10),
                              painter:
                                  _TrianglePainter(isMe: false, color: bubbleColor),
                            ),
                          ),
                        // Bubble content
                        Flexible(child: _buildBubbleContent(context, bubbleColor)),
                        // Right triangle (sent)
                        if (isMe)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomPaint(
                              size: const Size(6, 10),
                              painter:
                                  _TrianglePainter(isMe: true, color: bubbleColor),
                            ),
                          ),
                      ],
                    ),
                    if (message.totalReactions > 0) _buildReactionsBar(context),
                  ],
                ),
              ),
              // Right avatar (sent messages)
              if (isMe) ...[
                const SizedBox(width: 4),
                _buildSquareAvatar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquareAvatar() {
    const double size = 36;
    const double radius = 4;

    if (_effectiveAvatarUrl != null) {
      return CachedNetworkImage(
        imageUrl: _effectiveAvatarUrl!,
        imageBuilder: (_, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, __) => _buildInitialsSquare(size, radius),
        errorWidget: (_, __, ___) => _buildInitialsSquare(size, radius),
      );
    }
    return _buildInitialsSquare(size, radius);
  }

  Widget _buildInitialsSquare(double size, double radius) {
    final name = message.senderName;
    String initials;
    if (name.isEmpty) {
      initials = '??';
    } else {
      final words = name.split(' ');
      if (words.length >= 2) {
        initials = '${words[0][0]}${words[1][0]}'.toUpperCase();
      } else {
        initials = name.substring(0, name.length.clamp(0, 2)).toUpperCase();
      }
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBubbleContent(BuildContext context, Color bubbleColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.hasMedia) _buildMedia(context),
          if (_isDecryptionFailed)
            _buildDecryptionFailed(context)
          else if (message.isEncrypted &&
              (message.textContent == null || message.textContent!.isEmpty))
            _buildEncryptedSentIndicator(context)
          else if (message.textContent?.isNotEmpty == true)
            Text(
              message.textContent!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.chatBubbleText,
                  ),
            ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (message.isEncrypted) ...[
                Icon(
                  Icons.lock,
                  size: 10,
                  color: AppColors.chatBubbleTimestamp,
                ),
                const SizedBox(width: 2),
              ],
              Text(
                _formatTime(message.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.chatBubbleTimestamp,
                      fontSize: 10,
                    ),
              ),
              if (isMe) ...[
                const SizedBox(width: 4),
                _buildStatusIcon(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReplyContext(BuildContext context) {
    return GestureDetector(
      onTap: onReplyTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: (isMe ? AppColors.chatBubbleSent : AppColors.chatBubbleReceived)
              .withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(4),
          border: Border(
            left: BorderSide(color: AppColors.accent, width: 3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.replyTo!.senderName,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              message.replyTo!.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.chatBubbleTimestamp,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia(BuildContext context) {
    if (message.type == MessageType.image) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ClipRRect(
          borderRadius: AppSpacing.borderRadiusSm,
          child: Image.network(
            message.media!.thumbnailUrl ?? message.media!.url,
            width: 220,
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 220,
              height: 100,
              color: AppColors.surface,
              child: const Icon(Icons.broken_image, size: 40),
            ),
          ),
        ),
      );
    }

    if (message.type == MessageType.voice) {
      final duration = message.media?.duration ?? 0;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_circle_filled,
              color: AppColors.chatBubbleText,
              size: 32,
            ),
            const SizedBox(width: 8),
            Text(
              '${(duration ~/ 60).toString().padLeft(2, '0')}:${(duration % 60).toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.chatBubbleText,
                  ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color color = AppColors.chatBubbleTimestamp;

    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
      case MessageStatus.sent:
        icon = Icons.done;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = AppColors.error;
      case MessageStatus.paid:
        icon = Icons.check_circle;
        color = const Color(0xFF006400); // Dark green on green bubble
      case MessageStatus.declined:
        icon = Icons.cancel_outlined;
        color = AppColors.error;
    }

    return Icon(icon, size: 14, color: color);
  }

  Widget _buildReactionsBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: message.reactions.entries
            .where((e) => e.value.isNotEmpty)
            .map((entry) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    '${entry.key} ${entry.value.length}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildTokenCard(BuildContext context) {
    final isSend = message.type == MessageType.tokenSend;
    final isRequest = message.type == MessageType.tokenRequest;
    final canAction = isRequest &&
        message.recipientId == currentUserId &&
        message.status == MessageStatus.sending; // pending

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: isSend
              ? AppColors.success.withValues(alpha: 0.5)
              : AppColors.accent.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSend
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSend ? Icons.send : Icons.call_received,
                  color: isSend ? AppColors.success : AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSend
                          ? (isMe ? 'You sent' : 'Sent to you')
                          : (isMe ? 'You requested' : 'Request from'),
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                    ),
                    Text(
                      '${message.tokenAmount} Tokens',
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isSend
                                    ? AppColors.success
                                    : AppColors.accent,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (message.textContent?.isNotEmpty == true) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Text(
                message.textContent!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ],
          if (canAction && onTokenRequestAction != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onTokenRequestAction!(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onTokenRequestAction!(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                    ),
                    child: const Text('Pay'),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          Text(
            _formatTime(message.createdAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.textContent ?? '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ),
    );
  }

  bool get _isDecryptionFailed =>
      message.textContent == '[Cannot decrypt]' ||
      message.textContent == '[Waiting for encryption key...]';

  Widget _buildDecryptionFailed(BuildContext context) {
    final isWaiting =
        message.textContent == '[Waiting for encryption key...]';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock_outline,
          size: 16,
          color: AppColors.chatBubbleTimestamp,
        ),
        const SizedBox(width: 6),
        Text(
          isWaiting
              ? 'Waiting for encryption key...'
              : 'Message cannot be decrypted',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.chatBubbleTimestamp,
                fontStyle: FontStyle.italic,
              ),
        ),
      ],
    );
  }

  Widget _buildEncryptedSentIndicator(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock,
          size: 16,
          color: AppColors.chatBubbleTimestamp,
        ),
        const SizedBox(width: 6),
        Text(
          'Encrypted message',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.chatBubbleTimestamp,
                fontStyle: FontStyle.italic,
              ),
        ),
      ],
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

/// Paints a small triangle "speech notch" pointing toward the avatar.
class _TrianglePainter extends CustomPainter {
  final bool isMe;
  final Color color;

  _TrianglePainter({required this.isMe, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isMe) {
      // Triangle pointing right → toward right-side avatar
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height * 0.5);
      path.lineTo(0, size.height);
    } else {
      // Triangle pointing left ← toward left-side avatar
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height * 0.5);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
