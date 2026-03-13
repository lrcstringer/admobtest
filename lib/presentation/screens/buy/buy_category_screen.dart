import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/purchase.dart';
import '../../../domain/entities/service_provider.dart';
import '../../blocs/purchase/purchase_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/buy/buy_qr_scanner.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// VAS Category drill-down: Provider grid → Product list → Recipient input.
class BuyCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String? categoryName;
  final String? categoryEmoji;

  const BuyCategoryScreen({
    super.key,
    required this.categoryId,
    this.categoryName,
    this.categoryEmoji,
  });

  @override
  State<BuyCategoryScreen> createState() => _BuyCategoryScreenState();
}

class _BuyCategoryScreenState extends State<BuyCategoryScreen> {
  final _recipientController = TextEditingController();
  final _searchController = TextEditingController();
  Timer? _searchDebounce;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final purchaseCategory = _mapToPurchaseCategory(widget.categoryId);
    if (purchaseCategory != null) {
      context
          .read<PurchaseBloc>()
          .add(PurchaseEvent.loadProvidersByCategory(purchaseCategory));
    } else {
      context.read<PurchaseBloc>().add(const PurchaseEvent.loadProviders());
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _searchController.dispose();
    _searchDebounce?.cancel();
    _searchDebounce = null;
    super.dispose();
  }

  PurchaseCategory? _mapToPurchaseCategory(String categoryId) {
    // categoryId matches the purchaseCategoryMapping field from BuyCategory
    for (final cat in PurchaseCategory.values) {
      if (cat.name == categoryId) return cat;
    }
    return null;
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
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: state.selectedProvider == null,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              context
                  .read<PurchaseBloc>()
                  .add(const PurchaseEvent.resetSelection());
            }
          },
          child: Scaffold(
            appBar: IMaliAppBar(
              title: _getTitle(state),
            ),
            body: WaveBackground(child: _buildBody(context, state)),
            floatingActionButton: _buildFab(context, state),
          ),
        );
      },
    );
  }

  String _getTitle(PurchaseState state) {
    if (state.selectedProvider != null) {
      return state.selectedProvider!.name;
    }
    if (widget.categoryName != null) {
      final emoji = widget.categoryEmoji ?? '';
      return '$emoji ${widget.categoryName!}'.trim();
    }
    return 'Select Provider';
  }

  Widget _buildBody(BuildContext context, PurchaseState state) {
    if (state.selectedProvider != null) {
      return _buildProductsView(context, state);
    }
    return _buildProvidersView(context, state);
  }

  // ── Providers View ──

  Widget _buildProvidersView(BuildContext context, PurchaseState state) {
    if (state.isLoadingProviders) {
      return _buildProviderShimmer();
    }

    if (state.providers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store_outlined, size: 48,
                color: AppColors.textTertiary.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            const Text('No providers available',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 12),
            AppButton(
              text: 'Retry',
              onPressed: () {
                final bloc = context.read<PurchaseBloc>();
                final purchaseCategory =
                    _mapToPurchaseCategory(widget.categoryId);
                if (purchaseCategory != null) {
                  bloc.add(PurchaseEvent.loadProvidersByCategory(
                      purchaseCategory));
                } else {
                  bloc.add(const PurchaseEvent.loadProviders());
                }
              },
              variant: AppButtonVariant.outline,
              size: AppButtonSize.small,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
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
    return GestureDetector(
      onTap: () {
        context
            .read<PurchaseBloc>()
            .add(PurchaseEvent.selectProvider(provider));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (provider.logoUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: provider.logoUrl!,
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain,
                  placeholder: (_, __) => _buildProviderInitials(provider),
                  errorWidget: (_, __, ___) =>
                      _buildProviderInitials(provider),
                ),
              )
            else
              _buildProviderInitials(provider),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                provider.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderInitials(ServiceProvider provider) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.15),
      ),
      child: Center(
        child: Text(
          provider.initials,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProviderShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // ── Products View ──

  Widget _buildProductsView(BuildContext context, PurchaseState state) {
    // Filter products by search query
    final filteredProducts = _searchQuery.isEmpty
        ? state.products
        : state.products
            .where((p) =>
                p.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Column(
      children: [
        _buildRecipientInput(context, state),

        // Product search field with debounce
        if (state.products.length > 5)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: const TextStyle(color: AppColors.textHint),
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.textHint, size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            color: AppColors.textHint, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                _searchDebounce?.cancel();
                _searchDebounce = Timer(
                  const Duration(milliseconds: 300),
                  () {
                    if (mounted) setState(() => _searchQuery = value.trim());
                  },
                );
              },
            ),
          ),

        Expanded(
          child: state.isLoadingProducts
              ? _buildProductShimmer()
              : filteredProducts.isEmpty
                  ? Center(
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'No products available'
                            : 'No products match "$_searchQuery"',
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 14),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        final isSelected =
                            state.selectedProduct?.id == product.id;
                        return _buildProductCard(
                            context, product, isSelected);
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildRecipientInput(BuildContext context, PurchaseState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        border: Border(
          bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getRecipientLabel(state.selectedProvider?.category),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _recipientController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: _getRecipientHint(
                        state.selectedProvider?.category),
                    hintStyle:
                        const TextStyle(color: AppColors.textHint),
                    suffixIcon: _buildRecipientSuffix(state),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: AppColors.border.withValues(alpha: 0.5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: AppColors.border.withValues(alpha: 0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.primary),
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
              // QR scan button for meter numbers
              if (state.selectedProvider?.category ==
                  PurchaseCategory.electricity) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner,
                      color: AppColors.secondary),
                  onPressed: () => _openQrScanner(context),
                  tooltip: 'Scan meter barcode',
                ),
              ],
            ],
          ),
          // Recent recipients chips
          if (state.recentRecipients.isNotEmpty) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.recentRecipients.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final number = state.recentRecipients[index];
                  return ActionChip(
                    label: Text(
                      number,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                        color: AppColors.border.withValues(alpha: 0.5)),
                    onPressed: () {
                      _recipientController.text = number;
                      context.read<PurchaseBloc>().add(
                            PurchaseEvent.selectRecentRecipient(number),
                          );
                    },
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _buildRecipientSuffix(PurchaseState state) {
    if (state.isValidating) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
              strokeWidth: 2, color: AppColors.secondary),
        ),
      );
    }
    if (state.isRecipientValid == true) {
      return const Icon(Icons.check_circle, color: AppColors.success);
    }
    if (state.isRecipientValid == false) {
      return const Icon(Icons.error, color: AppColors.error);
    }
    return null;
  }

  Future<void> _openQrScanner(BuildContext context) async {
    final bloc = context.read<PurchaseBloc>();
    final scanned = await BuyQrScanner.show(context);
    if (scanned != null && mounted) {
      _recipientController.text = scanned;
      bloc.add(PurchaseEvent.setRecipientNumber(scanned));
    }
  }

  Widget _buildProductCard(
    BuildContext context,
    ServiceProduct product,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          context
              .read<PurchaseBloc>()
              .add(PurchaseEvent.selectProduct(product));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border.withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
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
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (product.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        product.description!,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    if (product.validity != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Valid for ${product.validity}',
                        style: const TextStyle(
                          color: AppColors.textTertiary,
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: product.isActive
                          ? AppColors.tokenGold
                          : AppColors.textTertiary,
                    ),
                  ),
                  Text(
                    '${product.priceTokens} tokens',
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                  if (!product.isActive) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Out of stock',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildProductShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
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

  Widget? _buildFab(BuildContext context, PurchaseState state) {
    if (state.selectedProduct == null ||
        state.recipientNumber == null ||
        state.recipientNumber!.isEmpty ||
        state.isRecipientValid != true) {
      return null;
    }

    return FloatingActionButton.extended(
      onPressed: state.isPurchasing
          ? null
          : () => context.push('/buy/wallet-selection'),
      icon: state.isPurchasing
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            )
          : const Icon(Icons.shopping_cart),
      label: Text(
        state.isPurchasing
            ? 'Processing...'
            : 'Buy for ${state.selectedProduct!.priceTokens} tokens',
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
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
}
