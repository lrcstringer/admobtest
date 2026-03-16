import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/purchase.dart';
import '../../blocs/purchase/purchase_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Full transaction history screen for the Buy tab.
///
/// Displays past VAS purchases with pull-to-refresh, empty state, and
/// paginated loading. Each row shows category icon, product name, date,
/// token amount, and a status badge.
class BuyTransactionsScreen extends StatefulWidget {
  const BuyTransactionsScreen({super.key});

  @override
  State<BuyTransactionsScreen> createState() => _BuyTransactionsScreenState();
}

class _BuyTransactionsScreenState extends State<BuyTransactionsScreen> {
  static const _pageSize = 50;
  final DateFormat _dateFmt = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    context
        .read<PurchaseBloc>()
        .add(const PurchaseEvent.loadHistory(limit: _pageSize));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: const IMaliAppBar(
        title: 'Buy Transactions',
        backgroundColor: AppColors.buyCard,
        foregroundColor: AppColors.buyTextPrimary,
      ),
      body: BlocBuilder<PurchaseBloc, PurchaseState>(
          builder: (context, state) {
            if (state.isLoadingHistory && state.history.isEmpty) {
              return _buildShimmer();
            }

            if (state.history.isEmpty) {
              return _buildEmptyState();
            }

            return RefreshIndicator(
              onRefresh: () async {
                final bloc = context.read<PurchaseBloc>();
                bloc.add(const PurchaseEvent.loadHistory(limit: _pageSize));
                await bloc.stream
                    .firstWhere((s) => !s.isLoadingHistory)
                    .timeout(
                      const Duration(seconds: 10),
                      onTimeout: () => bloc.state,
                    );
              },
              color: AppColors.buyMarketplaceAccent,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount:
                    state.history.length + (state.hasMoreHistory ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.history.length) {
                    return _buildLoadMore(state);
                  }
                  return _buildTransactionCard(state.history[index]);
                },
              ),
            );
          },
        ),
    );
  }

  Widget _buildTransactionCard(Purchase purchase) {
    final statusColor = _getStatusColor(purchase.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getCategoryIcon(purchase.category),
              color: statusColor,
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
                    color: AppColors.buyTextPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${purchase.recipientNumber ?? ''} \u00b7 ${purchase.statusDisplayName}',
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${purchase.tokenAmount} tokens',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.tokenGold,
                ),
              ),
              Text(
                _dateFmt.format(purchase.createdAt),
                style: const TextStyle(
                  color: AppColors.buyTextTertiary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              _buildStatusBadge(purchase.status, statusColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(PurchaseStatus status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.name[0].toUpperCase() + status.name.substring(1),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLoadMore(PurchaseState state) {
    if (state.isLoadingHistory) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: TextButton(
          onPressed: () {
            final lastDate = state.history.last.createdAt;
            context.read<PurchaseBloc>().add(
                  PurchaseEvent.loadHistory(
                    limit: _pageSize,
                    startAfter: lastDate,
                  ),
                );
          },
          child: const Text('Load more'),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 48,
              color: AppColors.buyTextTertiary.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          const Text(
            'No transactions yet',
            style: TextStyle(color: AppColors.buyTextSecondary, fontSize: 14),
          ),
          const SizedBox(height: 4),
          const Text(
            'Your purchase transactions will appear here',
            style: TextStyle(color: AppColors.buyTextTertiary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.buyShimmerBase,
      highlightColor: AppColors.buyShimmerHigh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (_, _) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.buyCard,
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
        return AppColors.buySuccess;
      case PurchaseStatus.pending:
      case PurchaseStatus.processing:
        return AppColors.buyWarning;
      case PurchaseStatus.failed:
        return AppColors.buyError;
      case PurchaseStatus.refunded:
        return AppColors.buyMarketplaceAccent;
    }
  }
}
