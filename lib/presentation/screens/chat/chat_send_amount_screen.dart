import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';
import '../../theme/app_colors.dart';

class ChatSendAmountScreen extends StatelessWidget {
  const ChatSendAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Send Amount'),
      body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.chatGradient,
        ),
        overlayAsset: AppColors.waveOverlay,
        child: const Center(
          child: Text(
            'Send Amount\nComing Soon',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
