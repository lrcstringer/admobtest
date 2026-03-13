import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/marketplace_offer.dart';
import '../../../domain/enums/delivery_method.dart';
import '../../../domain/enums/offer_status.dart';
import '../../../domain/enums/order_status.dart';
import '../../blocs/order/order_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/buy/escrow_status_indicator.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/token_display.dart';

/// Full order detail with escrow timeline and action buttons.
class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(OrderEvent.selectOrder(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: AppColors.buyCard,
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          // Auto-load linked offer when order is selected
          if (state.selectedOrder?.offerId != null &&
              state.linkedOffer == null) {
            context.read<OrderBloc>().add(
                  OrderEvent.loadLinkedOffer(state.selectedOrder!.offerId!),
                );
          }
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.buySuccess,
              ),
            );
            context
                .read<OrderBloc>()
                .add(const OrderEvent.clearMessages());
            // Reload order after action
            context
                .read<OrderBloc>()
                .add(OrderEvent.selectOrder(widget.orderId));
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.buyError,
              ),
            );
            context
                .read<OrderBloc>()
                .add(const OrderEvent.clearMessages());
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final order = state.selectedOrder;
          if (order == null) {
            return const Center(
              child: Text(
                'Order not found',
                style: TextStyle(color: AppColors.buyTextSecondary),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Escrow status indicator
                      EscrowStatusIndicator(status: order.status),
                      const SizedBox(height: AppSpacing.lg),

                      // Listing info
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.buyCard,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.buyCard,
                                borderRadius: BorderRadius.circular(8),
                                image: order.thumbnailUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            order.thumbnailUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: order.thumbnailUrl == null
                                  ? const Icon(
                                      Icons.storefront_outlined,
                                      color: AppColors.buyTextTertiary,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.listingTitle,
                                    style: const TextStyle(
                                      color: AppColors.buyTextPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  TokenDisplay(
                                    amount: order.amount,
                                    showZar: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Parties and dates
                      _buildInfoRow('Buyer', order.buyerName),
                      _buildInfoRow('Seller', order.sellerName),
                      _buildInfoRow('Order ID', order.id),
                      _buildInfoRow(
                          'Created', _formatDate(order.createdAt)),
                      if (order.escrowedAt != null)
                        _buildInfoRow(
                            'Escrowed', _formatDate(order.escrowedAt!)),
                      if (order.fulfilledAt != null)
                        _buildInfoRow(
                            'Fulfilled', _formatDate(order.fulfilledAt!)),
                      if (order.completedAt != null)
                        _buildInfoRow(
                            'Completed', _formatDate(order.completedAt!)),
                      if (order.cancelledAt != null)
                        _buildInfoRow(
                            'Cancelled', _formatDate(order.cancelledAt!)),

                      // Delivery info
                      if (order.deliveryMethod != null)
                        _buildInfoRow(
                            'Delivery', order.deliveryMethod!.displayName),
                      if (order.deliveryFee != null &&
                          order.deliveryFee! > 0)
                        _buildInfoRow('Delivery Fee',
                            '${order.deliveryFee} tokens'),
                      if (order.deliveryDeadline != null)
                        _buildInfoRow('Delivery By',
                            _formatDate(order.deliveryDeadline!)),

                      // Offer/counter-offer history
                      if (state.linkedOffer != null)
                        _buildOfferHistory(state.linkedOffer!),

                      // Dispute info
                      if (order.status == OrderStatus.disputed &&
                          order.disputeReason != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.buyError.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded,
                                      color: AppColors.buyError, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Dispute',
                                    style: TextStyle(
                                      color: AppColors.buyError,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                order.disputeReason!,
                                style: const TextStyle(
                                  color: AppColors.buyTextSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Chat link
                      if (order.chatConversationId != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        GestureDetector(
                          onTap: () => context.push(
                            '/chat/${order.chatConversationId}',
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.buyMarketplaceAccent
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.chat_outlined,
                                    color: AppColors.buyMarketplaceAccent, size: 18),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'View conversation',
                                    style: TextStyle(
                                      color: AppColors.buyMarketplaceAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: AppColors.buyMarketplaceAccent, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Action buttons
              _buildActions(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.buyTextPrimary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, OrderState state) {
    final order = state.selectedOrder;
    if (order == null || order.isTerminal) return const SizedBox.shrink();

    final actions = <Widget>[];

    // Seller: mark as fulfilled
    if (order.canMarkFulfilled) {
      actions.add(Expanded(
        child: AppButton(
          text: 'Mark Fulfilled',
          variant: AppButtonVariant.primary,
          isLoading: state.isProcessing,
          onPressed: () => context
              .read<OrderBloc>()
              .add(OrderEvent.confirmFulfilment(order.id)),
        ),
      ));
    }

    // Buyer: confirm receipt
    if (order.canConfirmReceipt) {
      actions.add(Expanded(
        child: AppButton(
          text: 'Confirm Receipt',
          variant: AppButtonVariant.primary,
          isLoading: state.isProcessing,
          onPressed: () => _showConfirmReceiptDialog(order.id),
        ),
      ));
    }

    // Dispute
    if (order.canDispute) {
      if (actions.isNotEmpty) {
        actions.add(const SizedBox(width: AppSpacing.sm));
      }
      actions.add(Expanded(
        child: AppButton(
          text: 'Dispute',
          variant: AppButtonVariant.outline,
          onPressed: () => _showDisputeDialog(order.id),
        ),
      ));
    }

    // Cancel (only pending)
    if (order.status == OrderStatus.pending) {
      actions.add(Expanded(
        child: AppButton(
          text: 'Cancel',
          variant: AppButtonVariant.outline,
          isLoading: state.isProcessing,
          onPressed: () => context
              .read<OrderBloc>()
              .add(OrderEvent.cancelOrder(order.id)),
        ),
      ));
    }

    if (actions.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.buyCard,
        border: Border(
          top: BorderSide(color: AppColors.buyCardBorder, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Row(children: actions),
      ),
    );
  }

  void _showConfirmReceiptDialog(String orderId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.buyCard,
        title: const Text(
          'Confirm Receipt?',
          style: TextStyle(color: AppColors.buyTextPrimary),
        ),
        content: const Text(
          'This releases payment to the seller. '
          'Make sure you received your item.',
          style: TextStyle(color: AppColors.buyTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<OrderBloc>()
                  .add(OrderEvent.confirmReceipt(orderId));
            },
            child: const Text(
              'Confirm',
              style: TextStyle(color: AppColors.buySuccess),
            ),
          ),
        ],
      ),
    );
  }

  void _showDisputeDialog(String orderId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.buyCard,
        title: const Text(
          'Raise a Dispute',
          style: TextStyle(color: AppColors.buyTextPrimary),
        ),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Describe the issue...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              Navigator.pop(ctx);
              context.read<OrderBloc>().add(OrderEvent.disputeOrder(
                    orderId: orderId,
                    reason: controller.text.trim(),
                  ));
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: AppColors.buyError),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferHistory(MarketplaceOffer offer) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.handshake_outlined,
                    color: AppColors.buyMarketplaceAccent, size: 18),
                SizedBox(width: 8),
                Text(
                  'Offer History',
                  style: TextStyle(
                    color: AppColors.buyTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Step 1: Original listing price
            _OfferStep(
              label: 'Listing price',
              amount: offer.originalPrice,
              date: null,
              isFirst: true,
            ),
            // Step 2: Buyer's offer
            _OfferStep(
              label: 'Offer by ${offer.buyerName ?? 'Buyer'}',
              amount: offer.offerAmount,
              date: offer.createdAt,
              isFirst: false,
            ),
            // Step 3: Counter-offer (if any)
            if (offer.counterAmount != null)
              _OfferStep(
                label: 'Counter by ${offer.sellerName ?? 'Seller'}',
                amount: offer.counterAmount!,
                date: offer.respondedAt,
                isFirst: false,
              ),
            // Step 4: Final status
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: offer.status.isTerminal
                          ? AppColors.buySuccess
                          : AppColors.buyWarning,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Status: ${offer.status.name}',
                    style: TextStyle(
                      color: offer.status.isTerminal
                          ? AppColors.buySuccess
                          : AppColors.buyWarning,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (offer.message != null && offer.message!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '"${offer.message!}"',
                style: const TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _OfferStep extends StatelessWidget {
  final String label;
  final int amount;
  final DateTime? date;
  final bool isFirst;

  const _OfferStep({
    required this.label,
    required this.amount,
    required this.date,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final zarAmount = (amount / 100).toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isFirst
                      ? AppColors.buyTextSecondary
                      : AppColors.buyMarketplaceAccent,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 1,
                height: 20,
                color: AppColors.buyCardBorder,
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$amount tokens (R$zarAmount)',
                  style: const TextStyle(
                    color: AppColors.buyTextPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (date != null)
            Text(
              '${date!.day}/${date!.month}/${date!.year}',
              style: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }
}
