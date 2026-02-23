import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Search bar for finding messages within a conversation.
///
/// Includes a debounced text field, result count, and close button.
class MessageSearchBar extends StatefulWidget {
  final int resultCount;
  final ValueChanged<String> onSearch;
  final VoidCallback onClose;

  const MessageSearchBar({
    super.key,
    required this.resultCount,
    required this.onSearch,
    required this.onClose,
  });

  @override
  State<MessageSearchBar> createState() => _MessageSearchBarState();
}

class _MessageSearchBarState extends State<MessageSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (value.trim().isNotEmpty) {
        widget.onSearch(value.trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _onChanged,
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                isDense: true,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (_controller.text.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              '${widget.resultCount} found',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: widget.onClose,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }
}
