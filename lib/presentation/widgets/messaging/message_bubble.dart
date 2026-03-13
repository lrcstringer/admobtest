import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/di/injection.dart';
import '../../../data/datasources/remote/media_upload_datasource.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/enums/message_status.dart';
import '../../../domain/enums/message_type.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../buy/shareable_buy_card.dart';
import '../gift/gift_bubble.dart';
import '../gift/gift_opening_dialog.dart';
import '../pool/group_gift_bubble.dart';
import '../pool/group_gift_opening_dialog.dart';
import '../spray/spray_bubble.dart';
import 'video_message_player.dart';
import 'voice_player_widget.dart';

/// WeChat-style message bubble with square avatars and speech triangles.
///
/// Supports swipe-to-reply, double-tap to react, and message clustering
/// (hide avatar/tail for consecutive same-sender messages).
class MessageBubble extends StatefulWidget {
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

  /// Called when user taps an image to view full-screen.
  final VoidCallback? onImageTap;

  /// Optional search query to highlight matching text.
  final String? highlightQuery;

  /// Display name of the other participant (for token request labels).
  final String? otherUserName;

  /// Called when user swipes to reply (swipe-to-reply gesture).
  final ValueChanged<Message>? onSwipeReply;

  /// Called when user double-taps to react (quick reaction).
  final ValueChanged<Message>? onDoubleTapReact;

  /// Whether to show the avatar (false when clustering consecutive messages).
  final bool showAvatar;

  /// Whether to show the speech triangle tail (false for middle messages in cluster).
  final bool showTail;

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
    this.onImageTap,
    this.highlightQuery,
    this.otherUserName,
    this.onSwipeReply,
    this.onDoubleTapReact,
    this.showAvatar = true,
    this.showTail = true,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  /// Swipe-to-reply drag offset.
  double _swipeOffset = 0;
  static const _swipeThreshold = 64.0;

  String? get _effectiveAvatarUrl {
    final url = widget.avatarUrl ?? widget.message.senderAvatarUrl;
    return (url != null && url.isNotEmpty) ? url : null;
  }

  /// Wraps content with swipe-to-reply + double-tap-to-react gestures.
  Widget _wrapWithGestures({required Widget child}) {
    Widget result = child;

    // Double-tap to react
    if (widget.onDoubleTapReact != null) {
      result = GestureDetector(
        onDoubleTap: () => widget.onDoubleTapReact!(widget.message),
        child: result,
      );
    }

    // Swipe-to-reply (horizontal drag)
    if (widget.onSwipeReply != null) {
      result = GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            // Swipe right for received, left for sent
            final delta = widget.isMe ? -details.delta.dx : details.delta.dx;
            _swipeOffset = (_swipeOffset + delta).clamp(0.0, _swipeThreshold * 1.5);
          });
        },
        onHorizontalDragEnd: (_) {
          if (_swipeOffset >= _swipeThreshold) {
            widget.onSwipeReply!(widget.message);
          }
          setState(() => _swipeOffset = 0);
        },
        onHorizontalDragCancel: () {
          setState(() => _swipeOffset = 0);
        },
        child: Stack(
          children: [
            // Reply icon behind the bubble
            if (_swipeOffset > 8)
              Positioned.fill(
                child: Align(
                  alignment: widget.isMe
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Opacity(
                    opacity: (_swipeOffset / _swipeThreshold).clamp(0.0, 1.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.reply,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            // The bubble itself, translated
            Transform.translate(
              offset: Offset(
                widget.isMe ? -_swipeOffset : _swipeOffset,
                0,
              ),
              child: result,
            ),
          ],
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.message.deletedForEveryone) return _buildDeletedMessage(context);
    if (widget.message.isSystem) return _buildSystemMessage(context);
    if (widget.message.isGift && widget.message.gift != null) return _buildGiftBubble(context);
    if (widget.message.isGroupGift && widget.message.groupGift != null) return _buildGroupGiftBubble(context);
    if (widget.message.isSpray && widget.message.tokenSpray != null) return _buildSprayBubble(context);
    if (widget.message.isGooiGooiInvite) return _buildGooiInviteCard(context);
    if (widget.message.isMarketplaceShare || widget.message.isGroupBuyShare) return _buildShareableBuyCard(context);
    if (widget.message.isTokenTransfer) return _buildTokenCard(context);

    final bubbleColor =
        widget.isMe ? AppColors.chatBubbleSent : AppColors.chatBubbleReceived;

    // Clustered messages get tighter vertical spacing
    final verticalMargin = widget.showTail ? 4.0 : 1.0;

    final bubble = Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: verticalMargin),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Left avatar (received messages) — hidden for clustered mid-messages
              if (!widget.isMe) ...[
                if (widget.showAvatar)
                  _buildSquareAvatar()
                else
                  const SizedBox(width: 36), // placeholder to keep alignment
                const SizedBox(width: 4),
              ],
              // Bubble with triangle
              Flexible(
                child: Column(
                  crossAxisAlignment:
                      widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (widget.showSenderName && !widget.isMe)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          widget.message.senderName,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    if (widget.message.replyTo != null) _buildReplyContext(context),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left triangle (received) — only on tail messages
                        if (!widget.isMe && widget.showTail)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomPaint(
                              size: const Size(6, 10),
                              painter:
                                  _TrianglePainter(isMe: false, color: bubbleColor),
                            ),
                          )
                        else if (!widget.isMe)
                          const SizedBox(width: 6), // keep alignment without triangle
                        // Bubble content
                        Flexible(child: _buildBubbleContent(context, bubbleColor)),
                        // Right triangle (sent) — only on tail messages
                        if (widget.isMe && widget.showTail)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomPaint(
                              size: const Size(6, 10),
                              painter:
                                  _TrianglePainter(isMe: true, color: bubbleColor),
                            ),
                          )
                        else if (widget.isMe)
                          const SizedBox(width: 6),
                      ],
                    ),
                    if (widget.message.totalReactions > 0) _buildReactionsBar(context),
                  ],
                ),
              ),
              // Right avatar (sent messages) — hidden for clustered mid-messages
              if (widget.isMe) ...[
                const SizedBox(width: 4),
                if (widget.showAvatar)
                  _buildSquareAvatar()
                else
                  const SizedBox(width: 36),
              ],
            ],
          ),
        ),
      ),
    );

    return _wrapWithGestures(child: bubble);
  }

  Widget _buildSquareAvatar() {
    const double size = 36;
    const double radius = 4;

    if (_effectiveAvatarUrl != null) {
      return CachedNetworkImage(
        imageUrl: _effectiveAvatarUrl!,
        httpHeaders: const {'Connection': 'keep-alive'},
        fadeInDuration: const Duration(milliseconds: 150),
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
    final name = widget.message.senderName;
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

  Widget _buildDeletedMessage(BuildContext context) {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!widget.isMe) ...[
              _buildSquareAvatar(),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: (widget.isMe
                          ? AppColors.chatBubbleSent
                          : AppColors.chatBubbleReceived)
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.chatSurface,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.block, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 6),
                    Text(
                      widget.isMe
                          ? 'You deleted this message'
                          : 'This message was deleted',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textHint,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isMe) ...[
              const SizedBox(width: 4),
              _buildSquareAvatar(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBubbleContent(BuildContext context, Color bubbleColor) {
    final textColor = widget.isMe
        ? AppColors.chatBubbleText
        : AppColors.chatBubbleReceivedText;
    final metaColor = widget.isMe
        ? AppColors.chatBubbleTimestamp
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (widget.message.isForwarded)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shortcut, size: 12, color: metaColor),
                  const SizedBox(width: 4),
                  Text(
                    'Forwarded',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: metaColor,
                          fontStyle: FontStyle.italic,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
          if (widget.message.hasMedia) _buildMedia(context),
          if (_isSentByYouFallback)
            const SizedBox.shrink() // Handled by _SentByYouPlaceholder in media
          else if (_isDecryptionFailed)
            _buildDecryptionFailed(context)
          else if (_isJsonMediaPayload)
            const SizedBox.shrink() // Suppress leaked JSON media payload
          else if (widget.message.isEncrypted &&
              (widget.message.textContent == null || widget.message.textContent!.isEmpty))
            _buildEncryptedSentIndicator(context)
          else if (widget.message.textContent?.isNotEmpty == true) ...[
            _buildTextContent(context, textColor),
            if (_firstUrl != null) _buildLinkPreview(context, metaColor),
          ],
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.message.expiresAt != null) ...[
                Icon(
                  Icons.timer_outlined,
                  size: 10,
                  color: metaColor,
                ),
                const SizedBox(width: 2),
              ],
              if (widget.message.isEncrypted) ...[
                Icon(
                  Icons.lock,
                  size: 10,
                  color: metaColor,
                ),
                const SizedBox(width: 2),
              ],
              Text(
                _formatTime(widget.message.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: metaColor,
                      fontSize: 10,
                    ),
              ),
              if (widget.isMe) ...[
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
      onTap: widget.onReplyTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: (widget.isMe ? AppColors.chatBubbleSent : AppColors.chatBubbleReceived)
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
              widget.message.replyTo!.senderName,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              widget.message.replyTo!.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: widget.isMe
                        ? AppColors.chatBubbleTimestamp
                        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.6),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia(BuildContext context) {
    // Media expired or removed — show placeholder
    if (widget.message.type.isMedia && widget.message.media == null) {
      // Sender's own message after reinstall — show graceful type indicator
      // instead of the alarming "Media no longer available".
      if (_isSentByYouFallback) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _SentByYouPlaceholder(type: widget.message.type),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _MediaExpiredPlaceholder(type: widget.message.type, isMe: widget.isMe),
      );
    }

    if (widget.message.type == MessageType.image) {
      final media = widget.message.media!;
      final isEncrypted =
          media.thumbKey != null && media.thumbKey!.isNotEmpty;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: widget.onImageTap,
          child: Hero(
            tag: 'image_${widget.message.id}',
            child: ClipRRect(
              borderRadius: AppSpacing.borderRadiusSm,
              child: isEncrypted
                  ? _EncryptedImageThumbnail(
                      key: ValueKey('thumb_${widget.message.id}'),
                      url: media.thumbnailUrl ?? media.url,
                      mediaKeyBase64: media.thumbKey ?? media.mediaKey!,
                    )
                  : CachedNetworkImage(
                      imageUrl: media.thumbnailUrl ?? media.url,
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 200),
                      placeholder: (_, __) => Container(
                        width: 120,
                        height: 100,
                        color: AppColors.chatSurface.withValues(alpha: 0.5),
                        child: const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: 120,
                        height: 60,
                        color: AppColors.chatSurface,
                        child: const Icon(Icons.broken_image, size: 28),
                      ),
                    ),
            ),
          ),
        ),
      );
    }

    if (widget.message.type == MessageType.document) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _DocumentBubble(
          media: widget.message.media!,
          isMe: widget.isMe,
          messageId: widget.message.id,
        ),
      );
    }

    if (widget.message.type == MessageType.video) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: VideoMessagePlayer(message: widget.message, isMe: widget.isMe),
      );
    }

    if (widget.message.type == MessageType.voice) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: VoicePlayerWidget(message: widget.message, isMe: widget.isMe),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color color = AppColors.chatBubbleTimestamp;
    bool animateRead = false;

    // Read receipts: if readBy has entries, show blue double-check
    if (widget.message.readBy.isNotEmpty &&
        (widget.message.status == MessageStatus.sent ||
         widget.message.status == MessageStatus.delivered ||
         widget.message.status == MessageStatus.read)) {
      icon = Icons.done_all;
      color = Colors.blue;
      animateRead = true;
    } else {
      switch (widget.message.status) {
        case MessageStatus.sending:
          icon = Icons.access_time;
        case MessageStatus.sent:
        case MessageStatus.delivered:
          icon = Icons.done;
        case MessageStatus.read:
          icon = Icons.done_all;
          color = Colors.blue;
          animateRead = true;
        case MessageStatus.pending:
          icon = Icons.hourglass_empty;
          color = AppColors.accent;
        case MessageStatus.failed:
          icon = Icons.error_outline;
          color = AppColors.error;
        case MessageStatus.paid:
          icon = Icons.check_circle;
          color = const Color(0xFF006400); // Dark green on green bubble
        case MessageStatus.declined:
          icon = Icons.cancel_outlined;
          color = AppColors.error;
        case MessageStatus.expired:
          icon = Icons.timer_off;
          color = AppColors.textHint;
      }
    }

    final iconWidget = Icon(icon, size: 14, color: color);

    // Subtle scale-pop + color fade for read receipts
    if (animateRead) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.6, end: 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticOut,
        builder: (_, scale, child) => Transform.scale(
          scale: scale,
          child: child,
        ),
        child: iconWidget,
      );
    }

    return iconWidget;
  }

  Widget _buildReactionsBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.chatSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.chatSurface,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.message.reactions.entries
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

  Widget _buildGiftBubble(BuildContext context) {
    final gift = widget.message.gift!;
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isMe) ...[
                _buildSquareAvatar(),
                const SizedBox(width: 4),
              ],
              GiftBubble(
                giftId: gift.giftId,
                amount: gift.amount,
                message: gift.message,
                style: gift.style,
                status: gift.status,
                recipientId: gift.recipientId,
                recipientName: gift.recipientName,
                isMe: widget.isMe,
                currentUserId: widget.currentUserId,
                onOpen: () => showGiftOpeningDialog(
                  context,
                  gift: gift,
                  senderName: widget.message.senderName,
                ),
                onClaim: () => showGiftOpeningDialog(
                  context,
                  gift: gift,
                  senderName: widget.message.senderName,
                ),
              ),
              if (widget.isMe) ...[
                const SizedBox(width: 4),
                _buildSquareAvatar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupGiftBubble(BuildContext context) {
    final groupGift = widget.message.groupGift!;
    final isRecipient = !widget.isMe; // In recipient's P2P chat, received = recipient
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isMe) ...[
                _buildSquareAvatar(),
                const SizedBox(width: 4),
              ],
              GroupGiftBubble(
                data: groupGift,
                isMe: widget.isMe,
                isRecipient: isRecipient,
                onOpen: isRecipient
                    ? () => showDialog(
                          context: context,
                          useSafeArea: false,
                          builder: (_) =>
                              GroupGiftOpeningDialog(giftData: groupGift),
                        )
                    : null,
              ),
              if (widget.isMe) ...[
                const SizedBox(width: 4),
                _buildSquareAvatar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSprayBubble(BuildContext context) {
    final spray = widget.message.tokenSpray!;
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isMe) ...[
                _buildSquareAvatar(),
                const SizedBox(width: 4),
              ],
              SprayBubble(
                sprayId: spray.sprayId,
                recipientName: spray.recipientName,
                occasion: spray.occasion,
                currentTotal: spray.currentTotal,
                contributorCount: spray.contributorCount,
                targetAmount: spray.targetAmount,
                status: spray.status,
                expiresAt: spray.expiresAt,
                currentUserId: widget.currentUserId,
                recipientId: spray.recipientId,
              ),
              if (widget.isMe) ...[
                const SizedBox(width: 4),
                _buildSquareAvatar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGooiInviteCard(BuildContext context) {
    Map<String, dynamic> data = {};
    if (widget.message.textContent != null) {
      try {
        data = Map<String, dynamic>.from(
          json.decode(widget.message.textContent!) as Map,
        );
      } catch (_) {
        data = {'groupName': widget.message.textContent};
      }
    }

    final groupName = data['groupName'] as String? ?? 'Gooi-Gooi Group';
    final groupId = data['groupId'] as String?;
    final amount = data['contributionAmount'] as num?;
    final amountLabel = amount != null
        ? 'R${(amount / 100).toStringAsFixed(0)}/cycle'
        : '';

    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          constraints: const BoxConstraints(maxWidth: 280),
          decoration: BoxDecoration(
            color: AppColors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.group, color: AppColors.teal, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      groupName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.teal,
                          ),
                    ),
                  ),
                ],
              ),
              if (amountLabel.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(amountLabel, style: Theme.of(context).textTheme.bodySmall),
              ],
              const SizedBox(height: 8),
              Text(
                'You\'ve been invited to join a Gooi-Gooi savings group.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (groupId != null && !widget.isMe) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        // Navigation handled by parent via GoRouter
                      },
                      child: const Text('View'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareableBuyCard(BuildContext context) {
    // Parse structured data from textContent (JSON-encoded)
    Map<String, dynamic> data = {};
    if (widget.message.textContent != null) {
      try {
        data = Map<String, dynamic>.from(
          json.decode(widget.message.textContent!) as Map,
        );
      } catch (_) {
        // Fallback: treat textContent as title
        data = {'title': widget.message.textContent};
      }
    }

    final isGroupBuy = widget.message.isGroupBuyShare;
    final deepLink = data['deepLink'] as String?;

    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isMe) ...[
                _buildSquareAvatar(),
                const SizedBox(width: 4),
              ],
              ShareableBuyCard(
                title: data['title'] as String? ?? 'Listing',
                thumbnailUrl: data['thumbnailUrl'] as String?,
                priceLabel: data['price'] != null
                    ? '${data['price']} tokens'
                    : '',
                subtitle: isGroupBuy
                    ? data['spotsLeft'] as String?
                    : null,
                isGroupBuy: isGroupBuy,
                onTap: deepLink != null
                    ? () {
                        // Deep link navigation handled by parent screen
                      }
                    : null,
              ),
              if (widget.isMe) ...[
                const SizedBox(width: 4),
                _buildSquareAvatar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTokenCard(BuildContext context) {
    final isSend = widget.message.type == MessageType.tokenSend;
    final isRequest = widget.message.type == MessageType.tokenRequest;
    final isPaid = widget.message.status == MessageStatus.paid;
    final isDeclined = widget.message.status == MessageStatus.declined;
    final isExpired = widget.message.status == MessageStatus.expired;
    final canAction = isRequest &&
        widget.message.recipientId == widget.currentUserId &&
        widget.message.status == MessageStatus.pending;

    final name = widget.otherUserName ?? '';

    // Build label text with participant name and outcome status
    String label;
    if (isSend) {
      label = widget.isMe
          ? 'You sent'
          : name.isNotEmpty
              ? 'Sent to you by $name'
              : 'Sent to you';
    } else if (widget.isMe) {
      // Requester's view
      if (isPaid) {
        label = name.isNotEmpty
            ? 'Request to $name accepted'
            : 'Request accepted';
      } else if (isDeclined) {
        label = name.isNotEmpty
            ? 'Request to $name declined'
            : 'Request declined';
      } else if (isExpired) {
        label = name.isNotEmpty
            ? 'Request to $name expired'
            : 'Request expired';
      } else {
        label = name.isNotEmpty
            ? 'You requested from $name'
            : 'You requested';
      }
    } else {
      // Recipient's view
      if (isPaid) {
        label = name.isNotEmpty
            ? 'Request from $name accepted'
            : 'Request accepted';
      } else if (isDeclined) {
        label = name.isNotEmpty
            ? 'Request from $name declined'
            : 'Request declined';
      } else if (isExpired) {
        label = name.isNotEmpty
            ? 'Request from $name expired'
            : 'Request expired';
      } else {
        label = name.isNotEmpty ? 'Request from $name' : 'Request from';
      }
    }

    // Color reflects outcome: green for paid, red for declined, grey for expired, accent for pending
    final Color accentColor;
    if (isSend || isPaid) {
      accentColor = AppColors.success;
    } else if (isDeclined) {
      accentColor = AppColors.error;
    } else if (isExpired) {
      accentColor = AppColors.textHint;
    } else {
      accentColor = AppColors.accent;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.chatSurface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: accentColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Animated icon with scale-pop
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut,
                builder: (_, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSend ? Icons.send : Icons.call_received,
                    color: accentColor,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                    ),
                    // Animated token amount with count-up effect
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: (widget.message.tokenAmount ?? 0).toDouble()),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      builder: (_, value, _) => Text(
                        '${value.round()} Tokens',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: accentColor,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.message.textContent?.isNotEmpty == true) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.chatBackground,
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Text(
                widget.message.textContent!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ],
          if (canAction && widget.onTokenRequestAction != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => widget.onTokenRequestAction!(false),
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
                    onPressed: () => widget.onTokenRequestAction!(true),
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
            _formatTime(widget.message.createdAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemMessage(BuildContext context) {
    final isDisappearingEvent =
        widget.message.systemEventType == 'disappearing_messages_changed';
    final isCallEvent = widget.message.systemEventType == 'call_ended';

    // Call system message: show icon + formatted text
    if (isCallEvent) {
      return _buildCallSystemMessage(context);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.chatSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDisappearingEvent) ...[
                const Icon(Icons.timer_outlined,
                    size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  widget.message.textContent ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallSystemMessage(BuildContext context) {
    final data = widget.message.systemEventData ?? {};
    final callType = data['callType'] as String? ?? 'voice';
    final endReason = data['endReason'] as String? ?? 'normal';
    final durationSeconds = data['durationSeconds'] as int?;
    final isVideo = callType == 'video';

    // Determine icon and color based on end reason
    final IconData icon;
    final Color iconColor;
    final String text;

    switch (endReason) {
      case 'missed':
        icon = Icons.call_missed;
        iconColor = Colors.red;
        text = isVideo ? 'Missed video call' : 'Missed voice call';
      case 'declined':
        icon = isVideo ? Icons.videocam_off : Icons.call_end;
        iconColor = Colors.red;
        text = isVideo ? 'Video call declined' : 'Voice call declined';
      case 'cancelled':
        icon = isVideo ? Icons.videocam_off : Icons.call_end;
        iconColor = AppColors.textSecondary;
        text = isVideo ? 'Cancelled video call' : 'Cancelled voice call';
      case 'busy':
        icon = Icons.phone_disabled;
        iconColor = Colors.orange;
        text = 'Line busy';
      case 'reconnection_failed':
      case 'error':
        icon = Icons.call_end;
        iconColor = Colors.red;
        text = isVideo ? 'Video call failed' : 'Voice call failed';
      default:
        icon = isVideo ? Icons.videocam : Icons.call;
        iconColor = AppColors.accent;
        final durationText = durationSeconds != null && durationSeconds > 0
            ? _formatCallDuration(durationSeconds)
            : null;
        text = isVideo
            ? 'Video call${durationText != null ? ', $durationText' : ''}'
            : 'Voice call${durationText != null ? ', $durationText' : ''}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.chatSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCallDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Widget _buildTextContent(BuildContext context, Color textColor) {
    final text = widget.message.textContent!;
    if (widget.highlightQuery == null || widget.highlightQuery!.isEmpty) {
      return Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
      );
    }

    // Highlight matching segments
    final query = widget.highlightQuery!.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;
    final textLower = text.toLowerCase();

    while (start < text.length) {
      final idx = textLower.indexOf(query, start);
      if (idx == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (idx > start) {
        spans.add(TextSpan(text: text.substring(start, idx)));
      }
      spans.add(TextSpan(
        text: text.substring(idx, idx + query.length),
        style: TextStyle(
          backgroundColor: AppColors.accent.withValues(alpha: 0.3),
          fontWeight: FontWeight.bold,
        ),
      ));
      start = idx + query.length;
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
        children: spans,
      ),
    );
  }

  static final _urlRegex = RegExp(
    r'https?://[^\s<>"\)]+',
    caseSensitive: false,
  );

  /// First URL found in the message text, or null.
  String? get _firstUrl {
    final text = widget.message.textContent;
    if (text == null || text.isEmpty) return null;
    final match = _urlRegex.firstMatch(text);
    return match?.group(0);
  }

  Widget _buildLinkPreview(BuildContext context, Color metaColor) {
    final url = _firstUrl!;
    final uri = Uri.tryParse(url);
    final domain = uri?.host ?? url;

    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.isMe
              ? Colors.black.withValues(alpha: 0.08)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
          border: Border(
            left: BorderSide(color: AppColors.accent, width: 3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.link, size: 16, color: AppColors.accent),
            const SizedBox(width: 6),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    domain,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    url,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: metaColor,
                          fontSize: 11,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _isDecryptionFailed {
    final text = widget.message.textContent;
    return text == '[Cannot decrypt]' ||
        text == '[Waiting for encryption key...]' ||
        (text != null && text.startsWith('[Session expired'));
  }

  /// Detect leaked JSON media payloads in textContent (e.g. `{"media":{...}}`).
  /// These are E2EE decryption artefacts that should NOT be rendered as text.
  bool get _isJsonMediaPayload {
    final text = widget.message.textContent;
    return text != null && text.startsWith('{"media":');
  }

  /// Sender's own message whose plaintext was lost (e.g. after reinstall).
  /// The local E2EE cache is gone and the message can't be recovered.
  bool get _isSentByYouFallback =>
      widget.message.textContent == '[Sent by you]';

  Widget _buildDecryptionFailed(BuildContext context) {
    final text = widget.message.textContent ?? '';
    final isWaiting = text == '[Waiting for encryption key...]';
    final isSessionExpired = text.startsWith('[Session expired');
    final indicatorColor = widget.isMe
        ? AppColors.chatBubbleTimestamp
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.6);

    final String label;
    if (isWaiting) {
      label = 'Waiting for encryption key...';
    } else if (isSessionExpired) {
      label = 'Session expired — message unavailable';
    } else {
      label = 'Message cannot be decrypted';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock_outline,
          size: 16,
          color: indicatorColor,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: indicatorColor,
                fontStyle: FontStyle.italic,
              ),
        ),
      ],
    );
  }

  Widget _buildEncryptedSentIndicator(BuildContext context) {
    final indicatorColor = widget.isMe
        ? AppColors.chatBubbleTimestamp
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.6);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock,
          size: 16,
          color: indicatorColor,
        ),
        const SizedBox(width: 6),
        Text(
          'Encrypted message',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: indicatorColor,
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

/// Downloads and decrypts an AES-256-GCM encrypted image thumbnail
/// from Firebase Storage, then displays it with [Image.memory].
class _EncryptedImageThumbnail extends StatefulWidget {
  final String url;
  final String mediaKeyBase64;

  const _EncryptedImageThumbnail({
    super.key,
    required this.url,
    required this.mediaKeyBase64,
  });

  @override
  State<_EncryptedImageThumbnail> createState() =>
      _EncryptedImageThumbnailState();
}

class _EncryptedImageThumbnailState extends State<_EncryptedImageThumbnail> {
  /// Two-tier cache for decrypted image bytes:
  /// L1 = in-memory LRU (instant, lost on app restart)
  /// L2 = disk files in app cache dir (survives restarts, OS can reclaim)
  static const _maxMemEntries = 100;
  static final LinkedHashMap<String, Uint8List> _memCache = LinkedHashMap();
  static String? _diskCacheDir;

  Uint8List? _bytes;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(covariant _EncryptedImageThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url ||
        oldWidget.mediaKeyBase64 != widget.mediaKeyBase64) {
      _bytes = null;
      _isLoading = true;
      _hasError = false;
      _loadImage();
    }
  }

  /// SHA-1 hash of URL → hex string, used as disk cache filename.
  static String _cacheKey(String url) =>
      sha1.convert(utf8.encode(url)).toString();

  /// Lazily resolve and create the disk cache directory.
  static Future<String> _ensureDiskCacheDir() async {
    if (_diskCacheDir != null) return _diskCacheDir!;
    final cacheRoot = await getTemporaryDirectory();
    final dir = Directory('${cacheRoot.path}/encrypted_media');
    if (!dir.existsSync()) dir.createSync(recursive: true);
    _diskCacheDir = dir.path;
    return _diskCacheDir!;
  }

  Future<void> _loadImage() async {
    // L1: in-memory cache — instant
    final memHit = _memCache[widget.url];
    if (memHit != null) {
      _memCache.remove(widget.url);
      _memCache[widget.url] = memHit;
      if (mounted) setState(() { _bytes = memHit; _isLoading = false; });
      return;
    }

    // L2: disk cache — fast, no network/decrypt
    try {
      final dir = await _ensureDiskCacheDir();
      final file = File('$dir/${_cacheKey(widget.url)}');
      if (file.existsSync()) {
        final bytes = await file.readAsBytes();
        _promoteToMemCache(widget.url, bytes);
        if (mounted) setState(() { _bytes = bytes; _isLoading = false; });
        return;
      }
    } catch (_) {
      // Disk read failed — fall through to network
    }

    // L3: network download + decrypt
    try {
      final datasource = getIt<MediaUploadDatasource>();
      final bytes = await datasource.downloadAndDecrypt(
        url: widget.url,
        mediaKeyBase64: widget.mediaKeyBase64,
      );
      _promoteToMemCache(widget.url, bytes);
      // Write to disk cache (fire-and-forget)
      _writeDiskCache(widget.url, bytes);
      if (mounted) setState(() { _bytes = bytes; _isLoading = false; });
    } catch (e) {
      debugPrint('EncryptedImageThumbnail: load failed: $e');
      if (mounted) setState(() { _hasError = true; _isLoading = false; });
    }
  }

  static void _promoteToMemCache(String url, Uint8List bytes) {
    _memCache.remove(url);
    if (_memCache.length >= _maxMemEntries) {
      _memCache.remove(_memCache.keys.first);
    }
    _memCache[url] = bytes;
  }

  static Future<void> _writeDiskCache(String url, Uint8List bytes) async {
    try {
      final dir = await _ensureDiskCacheDir();
      await File('$dir/${_cacheKey(url)}').writeAsBytes(bytes, flush: true);
    } catch (_) {
      // Non-critical — image will just re-download next cold start
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        width: 120,
        height: 100,
        color: AppColors.chatSurface,
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_hasError || _bytes == null) {
      return Container(
        width: 120,
        height: 60,
        color: AppColors.chatSurface,
        child: const Icon(Icons.broken_image, size: 28),
      );
    }

    return Image.memory(
      _bytes!,
      width: 120,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}

/// Displays a document attachment with file icon, name, size, and
/// downloads + decrypts + opens the file on tap.
class _DocumentBubble extends StatefulWidget {
  final MessageMedia media;
  final bool isMe;
  final String messageId;

  const _DocumentBubble({
    required this.media,
    required this.isMe,
    required this.messageId,
  });

  @override
  State<_DocumentBubble> createState() => _DocumentBubbleState();
}

class _DocumentBubbleState extends State<_DocumentBubble> {
  bool _isDownloading = false;
  bool _isDownloaded = false;

  String get _extension {
    final name = widget.media.fileName;
    final dot = name.lastIndexOf('.');
    return dot != -1 ? name.substring(dot + 1).toLowerCase() : '';
  }

  IconData get _fileIcon {
    switch (_extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'zip':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color get _iconColor {
    switch (_extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return Colors.green;
      case 'ppt':
      case 'pptx':
        return Colors.orange;
      default:
        return AppColors.textSecondary;
    }
  }

  String get _formattedSize {
    final bytes = widget.media.fileSize;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  void initState() {
    super.initState();
    _checkIfDownloaded();
  }

  Future<File> _getPersistentFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final docDir = Directory('${dir.path}/iMaliChat/Documents');
    if (!docDir.existsSync()) {
      docDir.createSync(recursive: true);
    }
    return File('${docDir.path}/${widget.messageId}_${widget.media.fileName}');
  }

  Future<void> _checkIfDownloaded() async {
    try {
      final file = await _getPersistentFile();
      if (file.existsSync() && mounted) {
        setState(() => _isDownloaded = true);
      }
    } catch (_) {}
  }

  Future<void> _openDocument() async {
    if (_isDownloading) return;

    try {
      final media = widget.media;
      final isEncrypted = media.mediaKey != null && media.mediaKey!.isNotEmpty;

      if (media.url.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Document URL is missing')),
          );
        }
        return;
      }

      // Check if already downloaded
      final persistentFile = await _getPersistentFile();
      if (persistentFile.existsSync()) {
        final result = await OpenFilex.open(
          persistentFile.path,
          type: media.mimeType,
        );
        if (result.type != ResultType.done && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open document: ${result.message}')),
          );
        }
        return;
      }

      // Download required
      setState(() => _isDownloading = true);

      if (isEncrypted) {
        final datasource = getIt<MediaUploadDatasource>();
        final bytes = await datasource.downloadAndDecrypt(
          url: media.url,
          mediaKeyBase64: media.mediaKey!,
        );
        if (!mounted) return;
        await persistentFile.writeAsBytes(bytes);
        setState(() {
          _isDownloading = false;
          _isDownloaded = true;
        });
        final result = await OpenFilex.open(
          persistentFile.path,
          type: media.mimeType,
        );
        if (result.type != ResultType.done && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open document: ${result.message}')),
          );
        }
      } else {
        // Direct URL — open in browser/system viewer
        final uri = Uri.parse(media.url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open document')),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('DocumentBubble: _openDocument failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to download document')),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isMe
        ? AppColors.chatBubbleTimestamp.withValues(alpha: 0.3)
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.2);
    final metaColor = widget.isMe
        ? AppColors.chatBubbleTimestamp
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.6);

    return GestureDetector(
      onTap: _openDocument,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_fileIcon, color: _iconColor, size: 24),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.media.fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: widget.isMe
                              ? AppColors.chatBubbleText
                              : AppColors.chatBubbleReceivedText,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$_formattedSize · ${_extension.toUpperCase()}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: metaColor,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _isDownloading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    _isDownloaded
                        ? Icons.check_circle_outline
                        : Icons.download_rounded,
                    size: 20,
                    color: _isDownloaded ? AppColors.success : metaColor,
                  ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// MEDIA EXPIRED PLACEHOLDER
// =============================================================================

class _MediaExpiredPlaceholder extends StatelessWidget {
  final MessageType type;
  final bool isMe;

  const _MediaExpiredPlaceholder({required this.type, required this.isMe});

  IconData get _icon {
    switch (type) {
      case MessageType.image:
        return Icons.image_not_supported_outlined;
      case MessageType.video:
        return Icons.videocam_off_outlined;
      case MessageType.voice:
        return Icons.mic_off_outlined;
      case MessageType.document:
        return Icons.description_outlined;
      default:
        return Icons.block_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = isMe
        ? AppColors.chatBubbleTimestamp
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.6);

    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isMe
            ? Colors.black.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, color: textColor, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Media no longer available',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SENT BY YOU PLACEHOLDER (after reinstall, plaintext cache lost)
// =============================================================================

class _SentByYouPlaceholder extends StatelessWidget {
  final MessageType type;

  const _SentByYouPlaceholder({required this.type});

  IconData get _icon {
    switch (type) {
      case MessageType.image:
        return Icons.image_outlined;
      case MessageType.video:
        return Icons.videocam_outlined;
      case MessageType.voice:
        return Icons.mic_outlined;
      case MessageType.document:
        return Icons.description_outlined;
      default:
        return Icons.chat_bubble_outline;
    }
  }

  String get _label {
    switch (type) {
      case MessageType.image:
        return 'You sent a photo';
      case MessageType.video:
        return 'You sent a video';
      case MessageType.voice:
        return 'You sent a voice message';
      case MessageType.document:
        return 'You sent a document';
      default:
        return 'You sent a message';
    }
  }

  @override
  Widget build(BuildContext context) {
    const textColor = AppColors.chatBubbleTimestamp;

    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, color: textColor, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
