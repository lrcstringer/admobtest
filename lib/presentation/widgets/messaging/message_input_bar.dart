import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Reusable message input bar for both conversations and community chat.
///
/// When text is empty and [onVoiceRecord] is non-null, the send button
/// becomes a mic button. Tapping it triggers voice recording mode.
class MessageInputBar extends StatefulWidget {
  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;
  final VoidCallback? onAttachment;
  final VoidCallback? onTokenAction;

  /// Called when the user taps the mic icon to start recording.
  final VoidCallback? onVoiceRecord;

  /// Called when typing state changes (for typing indicators).
  final ValueChanged<bool>? onTypingChanged;

  const MessageInputBar({
    super.key,
    required this.controller,
    required this.isSending,
    required this.onSend,
    this.onAttachment,
    this.onTokenAction,
    this.onVoiceRecord,
    this.onTypingChanged,
  });

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.trim().isNotEmpty;
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant MessageInputBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      widget.controller.addListener(_onTextChanged);
      _hasText = widget.controller.text.trim().isNotEmpty;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
    // Notify parent about typing state changes
    widget.onTypingChanged?.call(hasText);
  }

  bool get _showMic => !_hasText && widget.onVoiceRecord != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: [
          if (widget.onTokenAction != null)
            IconButton(
              icon: const Icon(Icons.attach_money),
              color: AppColors.primary,
              onPressed: widget.onTokenAction,
            ),
          if (widget.onAttachment != null)
            IconButton(
              icon: const Icon(Icons.attach_file),
              color: AppColors.textSecondary,
              onPressed: widget.onAttachment,
            ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          _showMic
              ? IconButton.filled(
                  onPressed: widget.onVoiceRecord,
                  icon: const Icon(Icons.mic),
                )
              : IconButton.filled(
                  onPressed: widget.isSending ? null : widget.onSend,
                  icon: widget.isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textOnPrimary,
                          ),
                        )
                      : const Icon(Icons.send),
                ),
        ],
      ),
    );
  }
}
