import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';
import '../../theme/app_colors.dart';

class BonusNetworkScreen extends StatelessWidget {
  const BonusNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'The Bonus Network'),
      body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.homeGradient,
        ),
        overlayAsset: AppColors.waveOverlay,
        child: const Center(
          child: Text(
            'The Bonus Network\nComing Soon',
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
