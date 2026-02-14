import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class WalletSendSuccessScreen extends StatelessWidget {
  final int? amount;
  final String? recipientName;

  const WalletSendSuccessScreen({
    super.key,
    this.amount,
    this.recipientName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Send Successful'),
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
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 64,
                ),
              ),
              AppSpacing.verticalXl,
              Text(
                'Transfer Sent!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              AppSpacing.verticalMd,
              if (amount != null && recipientName != null)
                Text(
                  '$amount tokens sent to $recipientName',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              if (amount != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '= R${(amount! * 0.01).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                  ),
                ),
              AppSpacing.verticalXxl,
              AppButton(
                text: 'Back to Wallet',
                onPressed: () => context.go('/wallet'),
                size: AppButtonSize.large,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
