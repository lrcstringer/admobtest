import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../theme/app_colors.dart';

class EarnWalletConfirmScreen extends StatelessWidget {
  const EarnWalletConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Earn Wallet Confirm'),
      body: const Center(
        child: Text(
          'Earn Wallet Confirm\nComing Soon',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
