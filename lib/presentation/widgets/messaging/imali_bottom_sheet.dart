import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Consistent bottom sheet wrapper for all messaging-related sheets.
///
/// Provides uniform drag handle, border radius, background color,
/// and safe area padding across all modals in the Chat tab.
class IMaliBottomSheet extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        bottom: useSafeArea,
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
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ...children,
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
