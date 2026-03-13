import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';

/// Reusable message input bar for both conversations and community chat.
///
/// Includes an inline emoji picker that toggles with the keyboard.
/// When text is empty, shows a Plus attachment button on the right.
/// When text is entered, switches to a Send button.
class MessageInputBar extends StatefulWidget {
  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;
  final VoidCallback? onAttachment;

  /// Called when typing state changes (for typing indicators).
  final ValueChanged<bool>? onTypingChanged;

  const MessageInputBar({
    super.key,
    required this.controller,
    required this.isSending,
    required this.onSend,
    this.onAttachment,
    this.onTypingChanged,
  });

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  bool _hasText = false;
  bool _showEmojiPicker = false;
  bool _showSentCheck = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.trim().isNotEmpty;
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
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
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
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

  void _onFocusChanged() {
    // When the keyboard opens (text field gains focus), hide emoji picker
    if (_focusNode.hasFocus && _showEmojiPicker) {
      setState(() => _showEmojiPicker = false);
    }
  }

  void _toggleEmojiPicker() {
    if (_showEmojiPicker) {
      // Switch from emoji picker → keyboard
      setState(() => _showEmojiPicker = false);
      _focusNode.requestFocus();
    } else {
      // Switch from keyboard → emoji picker
      _focusNode.unfocus();
      setState(() => _showEmojiPicker = true);
    }
  }

  void _onEmojiSelected(Category? category, Emoji emoji) {
    final controller = widget.controller;
    final text = controller.text;
    final selection = controller.selection;

    // Insert emoji at cursor position (or append if no valid selection)
    final int offset;
    if (selection.isValid && selection.baseOffset >= 0) {
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        emoji.emoji,
      );
      controller.text = newText;
      offset = selection.start + emoji.emoji.length;
    } else {
      controller.text = text + emoji.emoji;
      offset = controller.text.length;
    }

    controller.selection = TextSelection.collapsed(offset: offset);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 8,
            bottom: _showEmojiPicker
                ? 8
                : MediaQuery.of(context).padding.bottom + 8,
          ),
          decoration: const BoxDecoration(
            color: AppColors.chatInputBackground,
          ),
          child: Row(
            children: [
              // Emoji toggle button — always visible
              IconButton(
                icon: Icon(
                  _showEmojiPicker
                      ? Icons.keyboard_outlined
                      : Icons.emoji_emotions_outlined,
                ),
                color: AppColors.textSecondary,
                onPressed: _toggleEmojiPicker,
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.chatInputField,
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
              // Right button: morphs between Plus (attachment) and Send
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: _hasText
                    ? IconButton.filled(
                        key: const ValueKey('send'),
                        onPressed: widget.isSending
                            ? null
                            : () {
                                HapticFeedback.lightImpact();
                                setState(() => _showSentCheck = true);
                                widget.onSend();
                                Future.delayed(
                                    const Duration(milliseconds: 600), () {
                                  if (mounted) {
                                    setState(() => _showSentCheck = false);
                                  }
                                });
                              },
                        icon: widget.isSending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.textOnPrimary,
                                ),
                              )
                            : _showSentCheck
                                ? const Icon(Icons.check)
                                : const Icon(Icons.send),
                      )
                    : IconButton.filled(
                        key: const ValueKey('attach'),
                        onPressed: widget.onAttachment,
                        icon: const Icon(Icons.add),
                      ),
              ),
            ],
          ),
        ),
        if (_showEmojiPicker)
          SizedBox(
            height: 280,
            child: EmojiPicker(
              onEmojiSelected: _onEmojiSelected,
              onBackspacePressed: () {
                final controller = widget.controller;
                final text = controller.text;
                if (text.isNotEmpty) {
                  // Remove last character (handles multi-byte emoji)
                  final characters = text.characters;
                  controller.text =
                      characters.take(characters.length - 1).toString();
                  controller.selection = TextSelection.collapsed(
                    offset: controller.text.length,
                  );
                }
              },
              config: const Config(
                height: 280,
                emojiViewConfig: EmojiViewConfig(
                  columns: 8,
                  emojiSizeMax: 28,
                  backgroundColor: AppColors.chatInputBackground,
                ),
                categoryViewConfig: CategoryViewConfig(
                  backgroundColor: AppColors.chatInputBackground,
                  iconColorSelected: AppColors.primary,
                  indicatorColor: AppColors.primary,
                  iconColor: AppColors.textSecondary,
                ),
                searchViewConfig: SearchViewConfig(
                  backgroundColor: AppColors.chatInputBackground,
                  buttonIconColor: AppColors.textSecondary,
                ),
                bottomActionBarConfig: BottomActionBarConfig(
                  backgroundColor: AppColors.chatInputBackground,
                  buttonIconColor: AppColors.textSecondary,
                  buttonColor: AppColors.chatInputBackground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
