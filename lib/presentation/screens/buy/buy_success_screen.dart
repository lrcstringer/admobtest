import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../theme/app_colors.dart';

class BuySuccessScreen extends StatelessWidget {
  const BuySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Purchase Successful'),
      body: Center(
        child: Text(
          'Purchase Successful\nComing Soon',
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
