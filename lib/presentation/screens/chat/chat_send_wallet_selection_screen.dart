import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';
import '../../theme/app_colors.dart';

class ChatSendWalletSelectionScreen extends StatelessWidget {
  const ChatSendWalletSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Send - Select Wallet'),
      body: const WaveBackground(
        child: Center(
          child: Text(
            'Send - Select Wallet\nComing Soon',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
