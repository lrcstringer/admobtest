import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';
import '../../theme/app_colors.dart';

class BuyWalletSelectionScreen extends StatelessWidget {
  const BuyWalletSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Select Wallet'),
      body: WaveBackground(
        child: Center(
          child: Text(
            'Select Wallet\nComing Soon',
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
