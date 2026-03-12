import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_colors.dart';

/// One-time contextual tooltip overlay (Spec §8.21).
///
/// Shows a tooltip pointing to a UI element. Max 4 across marketplace.
/// Persisted in SharedPreferences as `shown_tooltip_{id}`.
///
/// Usage:
/// ```dart
/// ContextualTooltip.showIfNeeded(
///   context: context,
///   id: 'heart_save',
///   message: 'Tap the heart to save items for later',
///   targetKey: _heartKey,
/// );
/// ```
class ContextualTooltip {
  ContextualTooltip._();

  static const _prefix = 'shown_tooltip_';

  /// Show the tooltip if it hasn't been shown before.
  static Future<void> showIfNeeded({
    required BuildContext context,
    required String id,
    required String message,
    required GlobalKey targetKey,
    ArrowDirection arrowDirection = ArrowDirection.down,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_prefix$id';
    if (prefs.getBool(key) == true) return;

    final renderBox =
        targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !context.mounted) return;

    final overlay = Overlay.of(context);
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TooltipOverlay(
        message: message,
        targetPosition: position,
        targetSize: size,
        arrowDirection: arrowDirection,
        onDismiss: () {
          entry.remove();
          prefs.setBool(key, true);
        },
      ),
    );

    overlay.insert(entry);
  }

  /// Reset a specific tooltip so it shows again (for testing).
  static Future<void> reset(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$id');
  }

  /// Reset all tooltips.
  static Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith(_prefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}

enum ArrowDirection { up, down, left, right }

class _TooltipOverlay extends StatelessWidget {
  final String message;
  final Offset targetPosition;
  final Size targetSize;
  final ArrowDirection arrowDirection;
  final VoidCallback onDismiss;

  const _TooltipOverlay({
    required this.message,
    required this.targetPosition,
    required this.targetSize,
    required this.arrowDirection,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate tooltip position based on arrow direction
    double top;
    double left;

    switch (arrowDirection) {
      case ArrowDirection.up:
        top = targetPosition.dy + targetSize.height + 8;
        left = (targetPosition.dx + targetSize.width / 2) - 100;
      case ArrowDirection.down:
        top = targetPosition.dy - 60;
        left = (targetPosition.dx + targetSize.width / 2) - 100;
      case ArrowDirection.left:
        top = targetPosition.dy + targetSize.height / 2 - 24;
        left = targetPosition.dx + targetSize.width + 8;
      case ArrowDirection.right:
        top = targetPosition.dy + targetSize.height / 2 - 24;
        left = targetPosition.dx - 208;
    }

    // Clamp to screen bounds
    left = left.clamp(12.0, screenWidth - 212.0);

    return GestureDetector(
      onTap: onDismiss,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          // Semi-transparent backdrop
          Positioned.fill(
            child: Container(color: Colors.transparent),
          ),
          // Tooltip bubble
          Positioned(
            top: top,
            left: left,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.buyTextPrimary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.buyShadow,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
