import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Dark charcoal background for conversation screens.
///
/// Used on conversation list, conversation detail, and message requests screens
/// to give a professional, premium feel that makes chat content pop.
class ChatBackground extends StatelessWidget {
  const ChatBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: AppColors.chatBackground);
  }
}
