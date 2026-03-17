import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/purchase.dart';
import '../../blocs/purchase/purchase_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

class BuySuccessScreen extends StatelessWidget {
  const BuySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        final purchase = state.lastPurchase;

        if (purchase == null) {
          return Scaffold(
            backgroundColor: AppColors.buyBackground,
            appBar: IMaliAppBar(
              title: 'Purchase Successful',
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.buyTextPrimary,
            ),
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.buySuccess,
                      size: 80,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Purchase Complete',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Back to Buy',
                      onPressed: () => context.go('/buy'),
                      isFullWidth: false,
                    ),
                  ],
                ),
              ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.buyBackground,
          appBar: IMaliAppBar(
            title: 'Purchase Successful',
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.buyTextPrimary,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Success icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.buySuccess.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.buySuccess,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'Purchase Successful!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your ${purchase.categoryDisplayName.toLowerCase()} purchase has been completed.',
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Purchase details card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          'Product',
                          purchase.productName,
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          'Provider',
                          purchase.providerName,
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          'Recipient',
                          purchase.recipientNumber ?? '-',
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          'Amount',
                          purchase.formattedZarAmount,
                          valueStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.buyMarketplaceAccent,
                          ),
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          'Tokens Used',
                          '${purchase.tokenAmount} tokens',
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          'Paid from',
                          _resolveWalletName(context, purchase.subAccountId),
                        ),
                        if (purchase.reference != null) ...[
                          const Divider(height: 24),
                          _buildDetailRow(
                            'Reference',
                            purchase.reference!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Voucher details (if applicable)
                if (purchase.voucherCode != null) ...[
                  const SizedBox(height: 24),
                  _buildVoucherCard(context, purchase),
                ],

                const SizedBox(height: 32),

                // Action buttons
                AppButton(
                  text: 'Done',
                  onPressed: () => context.go('/buy'),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<PurchaseBloc>().add(
                            const PurchaseEvent.resetSelection(),
                          );
                      context.go('/buy');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Make Another Purchase',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.buyTextSecondary,
            fontSize: 14,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: valueStyle ??
                const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildVoucherCard(BuildContext context, Purchase purchase) {
    return Card(
      color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getVoucherIcon(purchase.category),
                  color: AppColors.buyMarketplaceAccent,
                ),
                const SizedBox(width: 8),
                Text(
                  _getVoucherTitle(purchase.category),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Voucher code
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    purchase.voucherCode!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (purchase.voucherPin != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'PIN: ${purchase.voucherPin}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        color: AppColors.buyTextTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Copy button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  final textToCopy = purchase.voucherPin != null
                      ? '${purchase.voucherCode}\nPIN: ${purchase.voucherPin}'
                      : purchase.voucherCode!;
                  Clipboard.setData(ClipboardData(text: textToCopy));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy to Clipboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveWalletName(BuildContext context, String walletId) {
    if (walletId.isEmpty) return 'Main Wallet';
    final subAccounts = context.read<WalletBloc>().state.subAccounts;
    final match = subAccounts.where((sa) => sa.id == walletId).firstOrNull;
    return match?.name ?? 'Main Wallet';
  }

  IconData _getVoucherIcon(PurchaseCategory category) {
    switch (category) {
      case PurchaseCategory.electricity:
        return Icons.bolt;
      case PurchaseCategory.voucher:
        return Icons.card_giftcard;
      default:
        return Icons.receipt;
    }
  }

  String _getVoucherTitle(PurchaseCategory category) {
    switch (category) {
      case PurchaseCategory.electricity:
        return 'Electricity Token';
      case PurchaseCategory.voucher:
        return 'Voucher Code';
      default:
        return 'Your Code';
    }
  }
}
