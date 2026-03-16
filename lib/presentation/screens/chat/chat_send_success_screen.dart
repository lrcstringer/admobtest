import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';
import '../../theme/app_colors.dart';

class ChatSendSuccessScreen extends StatelessWidget {
  const ChatSendSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Send Successful'),
      body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.chatGradient,
        ),
        overlayAsset: null,
        child: const Center(
          child: Text(
            'Send Successful\nComing Soon',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
