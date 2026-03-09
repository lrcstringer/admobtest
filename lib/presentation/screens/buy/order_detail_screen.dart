import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        backgroundColor: AppColors.surface,
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
            // Reload order after action
            context
                .read<OrderBloc>()
                .add(OrderEvent.selectOrder(widget.orderId));
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
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final order = state.selectedOrder;
          if (order == null) {
            return const Center(
              child: Text(
                'Order not found',
                style: TextStyle(color: AppColors.textSecondary),
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
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
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
                                      color: AppColors.textHint,
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
                                      color: AppColors.textPrimary,
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

                      // Dispute info
                      if (order.status == OrderStatus.disputed &&
                          order.disputeReason != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded,
                                      color: AppColors.error, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Dispute',
                                    style: TextStyle(
                                      color: AppColors.error,
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
                                  color: AppColors.textSecondary,
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
                              color: AppColors.secondary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.chat_outlined,
                                    color: AppColors.secondary, size: 18),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'View conversation',
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: AppColors.secondary, size: 18),
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
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
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
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
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
        backgroundColor: AppColors.surfaceElevated,
        title: const Text(
          'Confirm Receipt?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'This releases payment to the seller. '
          'Make sure you received your item.',
          style: TextStyle(color: AppColors.textSecondary),
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
              style: TextStyle(color: AppColors.success),
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
        backgroundColor: AppColors.surfaceElevated,
        title: const Text(
          'Raise a Dispute',
          style: TextStyle(color: AppColors.textPrimary),
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
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}
