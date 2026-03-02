import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Dark charcoal background with a subtle doodle pattern for conversation screens.
///
/// Uses a tiling PNG image of scattered chat-themed icons at low contrast.
/// The image repeats seamlessly across the entire screen.
class ChatBackground extends StatelessWidget {
  const ChatBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.chatBackground),
      child: Opacity(
        opacity: 0.2,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chat_doodle_bg.png'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}
