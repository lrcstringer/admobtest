import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../theme/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Forgot Password'),
      body: Center(
        child: Text(
          'Forgot Password\nComing Soon',
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
