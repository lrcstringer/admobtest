import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Consistent bottom sheet wrapper for all messaging-related sheets.
///
/// Provides uniform drag handle, border radius, background color,
/// and safe area padding across all modals in the Chat tab.
/// Shows a fade gradient at the bottom when content is scrollable.
class IMaliBottomSheet extends StatefulWidget {
  final List<Widget> children;

  /// Optional title shown below the drag handle.
  final String? title;

  /// Whether to add bottom safe area padding.
  final bool useSafeArea;

  const IMaliBottomSheet({
    super.key,
    required this.children,
    this.title,
    this.useSafeArea = true,
  });

  @override
  State<IMaliBottomSheet> createState() => _IMaliBottomSheetState();
}

class _IMaliBottomSheetState extends State<IMaliBottomSheet> {
  final _scrollController = ScrollController();
  bool _showScrollIndicator = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _checkOverflow() {
    if (!_scrollController.hasClients) return;
    final canScroll =
        _scrollController.position.maxScrollExtent > 0;
    if (canScroll != _showScrollIndicator) {
      setState(() => _showScrollIndicator = canScroll);
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final atBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 8;
    final shouldShow = !atBottom &&
        _scrollController.position.maxScrollExtent > 0;
    if (shouldShow != _showScrollIndicator) {
      setState(() => _showScrollIndicator = shouldShow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        bottom: widget.useSafeArea,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  widget.title!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            Flexible(
              child: Stack(
                children: [
                  ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: widget.children,
                  ),
                  if (_showScrollIndicator)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: IgnorePointer(
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.surfaceElevated.withValues(alpha: 0),
                                AppColors.surfaceElevated,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textHint,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// Shows a standard messaging bottom sheet with consistent styling.
Future<T?> showIMaliBottomSheet<T>({
  required BuildContext context,
  required List<Widget> children,
  String? title,
  bool isScrollControlled = false,
  bool useSafeArea = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    builder: (_) => IMaliBottomSheet(
      title: title,
      useSafeArea: useSafeArea,
      children: children,
    ),
  );
}
