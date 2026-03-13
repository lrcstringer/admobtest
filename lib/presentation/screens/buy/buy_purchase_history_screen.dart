import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/purchase.dart';
import '../../blocs/purchase/purchase_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Full-page VAS purchase history screen.
class BuyPurchaseHistoryScreen extends StatefulWidget {
  const BuyPurchaseHistoryScreen({super.key});

  @override
  State<BuyPurchaseHistoryScreen> createState() =>
      _BuyPurchaseHistoryScreenState();
}

class _BuyPurchaseHistoryScreenState extends State<BuyPurchaseHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<PurchaseBloc>()
        .add(const PurchaseEvent.loadHistory(limit: 50));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Purchase History'),
      body: WaveBackground(
        child: BlocBuilder<PurchaseBloc, PurchaseState>(
          builder: (context, state) {
            if (state.isLoadingHistory) {
              return _buildShimmer();
            }

            if (state.history.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_outlined,
                        size: 48,
                        color: AppColors.textTertiary.withValues(alpha: 0.5)),
                    const SizedBox(height: 12),
                    const Text(
                      'No purchases yet',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your purchase history will appear here',
                      style: TextStyle(
                          color: AppColors.textTertiary, fontSize: 13),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                final bloc = context.read<PurchaseBloc>();
                bloc.add(const PurchaseEvent.loadHistory(limit: 50));
                await bloc.stream
                    .firstWhere((s) => !s.isLoadingHistory)
                    .timeout(
                      const Duration(seconds: 10),
                      onTimeout: () => bloc.state,
                    );
              },
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.history.length,
                itemBuilder: (context, index) {
                  return _buildHistoryCard(state.history[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Purchase purchase) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getStatusColor(purchase.status).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getCategoryIcon(purchase.category),
              color: _getStatusColor(purchase.status),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  purchase.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${purchase.recipientNumber ?? ''} \u00b7 ${purchase.statusDisplayName}',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                purchase.formattedZarAmount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.tokenGold,
                ),
              ),
              Text(
                _formatDate(purchase.createdAt),
                style: const TextStyle(
                    color: AppColors.textTertiary, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (_, _) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(PurchaseCategory category) {
    switch (category) {
      case PurchaseCategory.airtime:
        return Icons.phone_android;
      case PurchaseCategory.data:
        return Icons.wifi;
      case PurchaseCategory.electricity:
        return Icons.bolt;
      case PurchaseCategory.voucher:
        return Icons.card_giftcard;
      case PurchaseCategory.marketplace:
        return Icons.storefront;
      case PurchaseCategory.school:
        return Icons.school;
      case PurchaseCategory.municipal:
        return Icons.account_balance;
      case PurchaseCategory.insurance:
        return Icons.shield;
      case PurchaseCategory.funeral:
        return Icons.favorite_border;
      case PurchaseCategory.stokvel:
        return Icons.people;
      case PurchaseCategory.gaming:
        return Icons.sports_esports;
      case PurchaseCategory.other:
        return Icons.shopping_bag;
    }
  }

  Color _getStatusColor(PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.completed:
        return AppColors.success;
      case PurchaseStatus.pending:
      case PurchaseStatus.processing:
        return AppColors.warning;
      case PurchaseStatus.failed:
        return AppColors.error;
      case PurchaseStatus.refunded:
        return AppColors.secondary;
    }
  }

  static final DateFormat _dateFmt = DateFormat('dd/MM/yyyy');

  String _formatDate(DateTime date) {
    return _dateFmt.format(date);
  }
}
