import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';
import '../../theme/app_colors.dart';

class WhatIsEMaliChatScreen extends StatelessWidget {
  const WhatIsEMaliChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'What is eMaliChat'),
      body: TabBackground(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.themed(context).tabGradient,
        ),
        overlayAsset: null,
        child: const Center(
          child: Text(
            'What is eMaliChat\nComing Soon',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
