import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Digital fulfilment — Voucher display screen (Spec §9.8).
///
/// Shows voucher code in a green-bordered card with copy button,
/// instructions, expiry warning, and screenshot reminder.
class GroupBuyVoucherScreen extends StatefulWidget {
  final String groupBuyId;

  const GroupBuyVoucherScreen({
    super.key,
    required this.groupBuyId,
  });

  @override
  State<GroupBuyVoucherScreen> createState() =>
      _GroupBuyVoucherScreenState();
}

class _GroupBuyVoucherScreenState extends State<GroupBuyVoucherScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GroupBuyBloc>()
        .add(GroupBuyEvent.loadGroupBuy(widget.groupBuyId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        backgroundColor: AppColors.buyCard,
        foregroundColor: AppColors.buyTextPrimary,
        elevation: 0,
        title: const Text(
          'Your Voucher',
          style: TextStyle(
            color: AppColors.buyTextPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: BlocBuilder<GroupBuyBloc, GroupBuyState>(
        builder: (context, state) {
          final groupBuy = state.selectedGroupBuy;
          if (groupBuy == null) {
            return const Center(
              child: CircularProgressIndicator(
                  color: AppColors.buyGroupBuyAccent),
            );
          }

          // Find this user's contribution to get the voucher code
          final uid = context.read<AuthBloc>().state.user?.id;
          final contribution = uid != null
              ? state.contributions
                  .where((c) => c.userId == uid)
                  .firstOrNull
              : null;

          final voucherCode =
              contribution?.voucherCode ?? 'Voucher pending...';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Voucher card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.buyCard,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(
                        color: AppColors.buyGroupBuyAccent, width: 2),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.card_giftcard,
                              size: 20,
                              color: AppColors.buyGroupBuyAccent),
                          const SizedBox(width: 8),
                          const Text(
                            'Your voucher code',
                            style: TextStyle(
                              color: AppColors.buyGroupBuyAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Code
                      Text(
                        voucherCode,
                        style: const TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                          letterSpacing: 3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Copy button
                      OutlinedButton.icon(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: voucherCode));
                          HapticFeedback.lightImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Copied!'),
                              backgroundColor:
                                  AppColors.buyGroupBuyAccent,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(Icons.copy,
                            size: 16,
                            color: AppColors.buyGroupBuyAccent),
                        label: const Text('Copy code'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.buyGroupBuyAccent,
                          side: const BorderSide(
                            color: AppColors.buyGroupBuyAccent,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSm),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Instructions
                      if (groupBuy.fulfilmentInstructions != null &&
                          groupBuy
                              .fulfilmentInstructions!.isNotEmpty) ...[
                        Text(
                          groupBuy.fulfilmentInstructions!,
                          style: const TextStyle(
                            color: AppColors.buyTextSecondary,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                      ],

                      // Screenshot reminder
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined,
                              size: 14,
                              color: AppColors.buyTextTertiary),
                          const SizedBox(width: 4),
                          const Text(
                            'Take a screenshot of your code',
                            style: TextStyle(
                              color: AppColors.buyTextTertiary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Expiry warning
                if (groupBuy.collectionDeadline != null) ...[
                  const SizedBox(height: 12),
                  _buildExpiryWarning(groupBuy.collectionDeadline!),
                ],

                const SizedBox(height: 24),

                // Deal title reference
                Text(
                  groupBuy.title,
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpiryWarning(DateTime expiry) {
    final daysLeft = expiry.difference(DateTime.now()).inDays;
    final isUrgent = daysLeft < 7;
    final dateStr = DateFormat('dd MMM yyyy').format(expiry);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isUrgent
            ? AppColors.buyWarning.withValues(alpha: 0.1)
            : AppColors.buyChipBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 14,
            color: isUrgent
                ? AppColors.buyWarning
                : AppColors.buyTextTertiary,
          ),
          const SizedBox(width: 6),
          Text(
            'Use by $dateStr',
            style: TextStyle(
              color: isUrgent
                  ? AppColors.buyWarning
                  : AppColors.buyTextSecondary,
              fontSize: 12,
              fontWeight: isUrgent ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
