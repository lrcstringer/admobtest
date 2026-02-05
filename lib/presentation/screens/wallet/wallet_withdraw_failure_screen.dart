import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class WalletWithdrawFailureScreen extends StatelessWidget {
  final String? error;

  const WalletWithdrawFailureScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Withdrawal Failed'),
      body: WaveBackground(
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 64,
                ),
              ),
              AppSpacing.verticalXl,
              Text(
                'Withdrawal Failed',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              AppSpacing.verticalMd,
              Text(
                error ?? 'Something went wrong. Please try again.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalXxl,
              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeightLg,
                child: ElevatedButton(
                  onPressed: () => context.go('/wallet'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: const Text(
                    'Back to Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              AppSpacing.verticalMd,
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
