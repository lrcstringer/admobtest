import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/purchase.dart';
import '../../../domain/entities/service_provider.dart';
import '../../blocs/purchase/purchase_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';

class BuyServicesScreen extends StatefulWidget {
  const BuyServicesScreen({super.key});

  @override
  State<BuyServicesScreen> createState() => _BuyServicesScreenState();
}

class _BuyServicesScreenState extends State<BuyServicesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PurchaseBloc>().add(const PurchaseEvent.loadProviders());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchaseBloc, PurchaseState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<PurchaseBloc>().add(const PurchaseEvent.clearError());
        }
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.success,
            ),
          );
          context.read<PurchaseBloc>().add(const PurchaseEvent.clearSuccess());
          // Refresh wallet balance after purchase
          context.read<WalletBloc>().add(const WalletEvent.loadWallet());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_getAppBarTitle(state)),
            leading: state.selectedProvider != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context
                          .read<PurchaseBloc>()
                          .add(const PurchaseEvent.resetSelection());
                    },
                  )
                : null,
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () => _showHistorySheet(context),
              ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  String _getAppBarTitle(PurchaseState state) {
    if (state.selectedProvider != null) {
      return state.selectedProvider!.name;
    }
    return 'Buy Services';
  }

  Widget _buildBody(BuildContext context, PurchaseState state) {
    if (state.selectedProvider != null) {
      return _buildProductsView(context, state);
    }
    return _buildProvidersView(context, state);
  }

  Widget _buildProvidersView(BuildContext context, PurchaseState state) {
    return Column(
      children: [
        // Category filter
        _buildCategoryFilter(context, state),

        // Providers list
        Expanded(
          child: state.isLoadingProviders
              ? const Center(child: CircularProgressIndicator())
              : state.providers.isEmpty
                  ? _buildEmptyState()
                  : _buildProvidersList(context, state),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(BuildContext context, PurchaseState state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildCategoryChip(
            context,
            label: 'All',
            isSelected: state.selectedCategory == null,
            onTap: () {
              context
                  .read<PurchaseBloc>()
                  .add(const PurchaseEvent.selectCategory(null));
            },
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            context,
            label: 'Airtime',
            icon: Icons.phone_android,
            isSelected: state.selectedCategory == PurchaseCategory.airtime,
            onTap: () {
              context
                  .read<PurchaseBloc>()
                  .add(const PurchaseEvent.selectCategory(PurchaseCategory.airtime));
            },
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            context,
            label: 'Data',
            icon: Icons.wifi,
            isSelected: state.selectedCategory == PurchaseCategory.data,
            onTap: () {
              context
                  .read<PurchaseBloc>()
                  .add(const PurchaseEvent.selectCategory(PurchaseCategory.data));
            },
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            context,
            label: 'Electricity',
            icon: Icons.bolt,
            isSelected: state.selectedCategory == PurchaseCategory.electricity,
            onTap: () {
              context
                  .read<PurchaseBloc>()
                  .add(const PurchaseEvent.selectCategory(PurchaseCategory.electricity));
            },
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            context,
            label: 'Vouchers',
            icon: Icons.card_giftcard,
            isSelected: state.selectedCategory == PurchaseCategory.voucher,
            onTap: () {
              context
                  .read<PurchaseBloc>()
                  .add(const PurchaseEvent.selectCategory(PurchaseCategory.voucher));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context, {
    required String label,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildProvidersList(BuildContext context, PurchaseState state) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.providers.length,
      itemBuilder: (context, index) {
        final provider = state.providers[index];
        return _buildProviderCard(context, provider);
      },
    );
  }

  Widget _buildProviderCard(BuildContext context, ServiceProvider provider) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context
              .read<PurchaseBloc>()
              .add(PurchaseEvent.selectProvider(provider));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (provider.logoUrl != null)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(provider.logoUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getCategoryColor(provider.category),
                ),
                child: Center(
                  child: Text(
                    provider.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              provider.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(PurchaseCategory category) {
    switch (category) {
      case PurchaseCategory.airtime:
        return Colors.blue;
      case PurchaseCategory.data:
        return Colors.purple;
      case PurchaseCategory.electricity:
        return Colors.orange;
      case PurchaseCategory.voucher:
        return Colors.green;
      case PurchaseCategory.other:
        return Colors.grey;
    }
  }

  Widget _buildProductsView(BuildContext context, PurchaseState state) {
    return Column(
      children: [
        // Recipient input
        _buildRecipientInput(context, state),

        // Products list
        Expanded(
          child: state.isLoadingProducts
              ? const Center(child: CircularProgressIndicator())
              : state.products.isEmpty
                  ? _buildEmptyState(message: 'No products available')
                  : _buildProductsList(context, state),
        ),
      ],
    );
  }

  Widget _buildRecipientInput(BuildContext context, PurchaseState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getRecipientLabel(state.selectedProvider?.category),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: _getRecipientHint(state.selectedProvider?.category),
                    suffixIcon: state.isValidating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : state.isRecipientValid == true
                            ? const Icon(Icons.check_circle, color: AppColors.success)
                            : state.isRecipientValid == false
                                ? const Icon(Icons.error, color: AppColors.error)
                                : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    context
                        .read<PurchaseBloc>()
                        .add(PurchaseEvent.setRecipientNumber(value));
                  },
                  onSubmitted: (_) {
                    context
                        .read<PurchaseBloc>()
                        .add(const PurchaseEvent.validateRecipient());
                  },
                ),
              ),
              if (state.recentRecipients.isNotEmpty) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: () => _showRecentRecipientsSheet(context, state),
                  tooltip: 'Recent recipients',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getRecipientLabel(PurchaseCategory? category) {
    switch (category) {
      case PurchaseCategory.electricity:
        return 'Meter Number';
      case PurchaseCategory.airtime:
      case PurchaseCategory.data:
        return 'Phone Number';
      default:
        return 'Recipient';
    }
  }

  String _getRecipientHint(PurchaseCategory? category) {
    switch (category) {
      case PurchaseCategory.electricity:
        return 'Enter meter number';
      case PurchaseCategory.airtime:
      case PurchaseCategory.data:
        return 'Enter phone number (e.g. 0812345678)';
      default:
        return 'Enter recipient';
    }
  }

  Widget _buildProductsList(BuildContext context, PurchaseState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final product = state.products[index];
        final isSelected = state.selectedProduct?.id == product.id;
        return _buildProductCard(context, product, isSelected, state);
      },
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ServiceProduct product,
    bool isSelected,
    PurchaseState state,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? const BorderSide(color: AppColors.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          context.read<PurchaseBloc>().add(PurchaseEvent.selectProduct(product));
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    if (product.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        product.description!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                    if (product.validity != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Valid for ${product.validity}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.formattedPrice,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${product.priceTokens} tokens',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              if (isSelected) ...[
                const SizedBox(width: 12),
                const Icon(Icons.check_circle, color: AppColors.primary),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({String message = 'No providers available'}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showRecentRecipientsSheet(BuildContext context, PurchaseState state) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Recipients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...state.recentRecipients.map((recipient) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(recipient),
                  onTap: () {
                    context
                        .read<PurchaseBloc>()
                        .add(PurchaseEvent.selectRecentRecipient(recipient));
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showHistorySheet(BuildContext context) {
    context.read<PurchaseBloc>().add(const PurchaseEvent.loadHistory(limit: 20));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return BlocBuilder<PurchaseBloc, PurchaseState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Purchase History',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.isLoadingHistory
                          ? const Center(child: CircularProgressIndicator())
                          : state.history.isEmpty
                              ? const Center(
                                  child: Text('No purchase history'),
                                )
                              : ListView.builder(
                                  controller: scrollController,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  itemCount: state.history.length,
                                  itemBuilder: (context, index) {
                                    final purchase = state.history[index];
                                    return _buildHistoryItem(purchase);
                                  },
                                ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildHistoryItem(Purchase purchase) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(purchase.status).withValues(alpha: 0.1),
          child: Icon(
            _getCategoryIcon(purchase.category),
            color: _getStatusColor(purchase.status),
          ),
        ),
        title: Text(purchase.productName),
        subtitle: Text(
          '${purchase.recipientNumber ?? ''} • ${purchase.statusDisplayName}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              purchase.formattedZarAmount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatDate(purchase.createdAt),
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
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
        return Colors.orange;
      case PurchaseStatus.failed:
        return AppColors.error;
      case PurchaseStatus.refunded:
        return Colors.blue;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Floating purchase button
class PurchaseFloatingButton extends StatelessWidget {
  const PurchaseFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        if (state.selectedProduct == null ||
            state.recipientNumber == null ||
            state.recipientNumber!.isEmpty) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton.extended(
          onPressed: state.isPurchasing
              ? null
              : () {
                  context
                      .read<PurchaseBloc>()
                      .add(const PurchaseEvent.makePurchase());
                },
          icon: state.isPurchasing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.shopping_cart),
          label: Text(
            state.isPurchasing
                ? 'Processing...'
                : 'Buy for ${state.selectedProduct!.priceTokens} tokens',
          ),
          backgroundColor: AppColors.primary,
        );
      },
    );
  }
}
