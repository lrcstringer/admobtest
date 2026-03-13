import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/buy_order.dart';
import '../../../domain/enums/order_status.dart';
import '../../blocs/order/order_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/token_display.dart';

/// Shows "My Purchases" and "My Sales" tabs with order cards.
class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<OrderBloc>().add(const OrderEvent.loadBuyerOrders());
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
    final bloc = context.read<OrderBloc>();
    if (_tabController.index == 0) {
      bloc.add(const OrderEvent.loadBuyerOrders());
    } else {
      bloc.add(const OrderEvent.loadSellerOrders());
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppColors.surface,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'My Purchases'),
            Tab(text: 'My Sales'),
          ],
        ),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            context
                .read<OrderBloc>()
                .add(const OrderEvent.clearMessages());
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context
                .read<OrderBloc>()
                .add(const OrderEvent.clearMessages());
          }
        },
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildOrderList(
                state.buyerOrders,
                state.isLoading,
                isBuyer: true,
              ),
              _buildOrderList(
                state.sellerOrders,
                state.isLoading,
                isBuyer: false,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderList(
    List<BuyOrder> orders,
    bool isLoading, {
    required bool isBuyer,
  }) {
    if (isLoading) return _buildShimmer();

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isBuyer
                  ? Icons.shopping_bag_outlined
                  : Icons.storefront_outlined,
              color: AppColors.textHint,
              size: 48,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              isBuyer ? 'No purchases yet' : 'No sales yet',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<OrderBloc>();
        if (isBuyer) {
          bloc.add(const OrderEvent.loadBuyerOrders());
        } else {
          bloc.add(const OrderEvent.loadSellerOrders());
        }
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (_, index) => _buildOrderCard(orders[index], isBuyer),
      ),
    );
  }

  Widget _buildOrderCard(BuyOrder order, bool isBuyer) {
    return GestureDetector(
      onTap: () => context.push('/buy/marketplace/orders/${order.id}'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                image: order.thumbnailUrl != null
                    ? DecorationImage(
                        image: NetworkImage(order.thumbnailUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: order.thumbnailUrl == null
                  ? const Icon(
                      Icons.storefront_outlined,
                      color: AppColors.textHint,
                      size: 20,
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.listingTitle,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isBuyer
                        ? 'from ${order.sellerName}'
                        : 'from ${order.buyerName}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Status + Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStatusChip(order.status),
                const SizedBox(height: 4),
                TokenAmountText(amount: order.amount),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    final Color color;
    switch (status) {
      case OrderStatus.pending:
        color = AppColors.textSecondary;
      case OrderStatus.escrowed:
        color = AppColors.secondary;
      case OrderStatus.fulfilled:
        color = AppColors.warning;
      case OrderStatus.completed:
        color = AppColors.success;
      case OrderStatus.disputed:
        color = AppColors.error;
      case OrderStatus.refunding:
        color = AppColors.warning;
      case OrderStatus.refunded:
        color = AppColors.secondary;
      case OrderStatus.cancelled:
        color = AppColors.textHint;
      case OrderStatus.failed:
        color = AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.surface,
      highlightColor: AppColors.surfaceElevated,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
