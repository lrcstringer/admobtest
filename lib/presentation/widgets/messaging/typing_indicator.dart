import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Animated "is typing..." indicator with bouncing dots.
///
/// Includes a 300ms appearance delay to filter out noise from rapid
/// typing state flips (user types one char then stops). The indicator
/// only appears after typing has been continuous for 300ms.
class TypingIndicator extends StatefulWidget {
  /// Display names of users who are typing.
  final List<String> typingNames;

  const TypingIndicator({super.key, required this.typingNames});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  /// Whether the indicator is actually visible (after delay).
  bool _isVisible = false;

  /// Timer for the 300ms appearance delay.
  Timer? _showTimer;

  @override
  void initState() {
    super.initState();
    _scheduleVisibility();
    _initAnimations();
  }

  void _scheduleVisibility() {
    _showTimer?.cancel();
    if (widget.typingNames.isNotEmpty) {
      // Delay showing by 300ms to filter out noise
      _showTimer = Timer(const Duration(milliseconds: 300), () {
        if (mounted) setState(() => _isVisible = true);
      });
    } else {
      // Hide immediately when typing stops
      _isVisible = false;
    }
  }

  @override
  void didUpdateWidget(covariant TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.typingNames.length != widget.typingNames.length ||
        oldWidget.typingNames.toString() != widget.typingNames.toString()) {
      _scheduleVisibility();
    }
  }

  void _initAnimations() {
    _controllers = List.generate(3, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      )..repeat(reverse: true);
    });

    // Stagger the animations
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) _controllers[i].forward();
      });
    }

    _animations = _controllers.map((c) {
      return Tween<double>(begin: 0, end: -6).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  void dispose() {
    _showTimer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  String get _label {
    if (widget.typingNames.isEmpty) return '';
    if (widget.typingNames.length == 1) {
      return '${widget.typingNames.first} is typing';
    }
    return '${widget.typingNames.join(", ")} are typing';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.typingNames.isEmpty || !_isVisible) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(width: 4),
          ..._animations.map((animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, animation.value),
                  child: child,
                );
              },
              child: Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
