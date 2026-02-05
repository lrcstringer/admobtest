import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';
import '../../theme/app_colors.dart';

class ChatBonusNetworkScreen extends StatelessWidget {
  const ChatBonusNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Bonus Network'),
      body: const WaveBackground(
        child: Center(
          child: Text(
            'Bonus Network\nComing Soon',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
