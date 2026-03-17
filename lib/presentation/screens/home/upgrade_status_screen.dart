import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';
import '../../theme/app_colors.dart';

class UpgradeStatusScreen extends StatelessWidget {
  const UpgradeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IMaliAppBar(title: 'Upgrade Status'),
      body: TabBackground(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.themed(context).tabGradient,
        ),
        overlayAsset: null,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: const Center(
            child: Text(
              'Upgrade Status\nComing Soon',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
