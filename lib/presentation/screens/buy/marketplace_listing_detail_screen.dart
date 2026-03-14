import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/enums/delivery_method.dart';
import '../../../domain/enums/marketplace_category.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../blocs/order/order_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/buy/payment_protection_explainer.dart';
import '../../widgets/buy/trust_badge.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/token_display.dart';

/// Detail screen for a single marketplace listing.
/// Shows image carousel, price, provider card, and action buttons.
class MarketplaceListingDetailScreen extends StatefulWidget {
  final String listingId;

  const MarketplaceListingDetailScreen({
    super.key,
    required this.listingId,
  });

  @override
  State<MarketplaceListingDetailScreen> createState() =>
      _MarketplaceListingDetailScreenState();
}

class _MarketplaceListingDetailScreenState
    extends State<MarketplaceListingDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<MarketplaceBloc>()
        .add(MarketplaceEvent.selectListing(widget.listingId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listenWhen: (prev, curr) =>
          prev.isProcessing && !curr.isProcessing,
      listener: (context, state) {
        if (state.successMessage != null) {
          context.push('/buy/marketplace/orders');
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.buyBackground,
        appBar: AppBar(
          title: const Text('Listing'),
          backgroundColor: AppColors.background,
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: _onShare,
            ),
            IconButton(
              icon: const Icon(Icons.flag_outlined),
              onPressed: () => context.push(
                '/buy/marketplace/report/listing/${widget.listingId}',
              ),
            ),
          ],
        ),
        body: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        builder: (context, state) {
          if (state.isLoadingDetail) {
            return _buildShimmer();
          }

          final listing = state.selectedListing;
          if (listing == null) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Listing not found',
                style: const TextStyle(color: AppColors.buyTextSecondary),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image carousel
                _buildImageCarousel(listing.images),

                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          listing.category.displayName,
                            style: const TextStyle(
                              color: AppColors.buyMarketplaceAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(height: AppSpacing.sm),

                      // Title
                      Text(
                        listing.title,
                        style: const TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Price
                      TokenDisplay(
                        amount: listing.priceTokens,
                        style: TokenDisplayStyle.large,
                        showZar: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Favourite & renewal counts
                      if (listing.favouriteCount > 0 ||
                          listing.renewalCount > 0)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: Row(
                            children: [
                              if (listing.favouriteCount > 0) ...[
                                const Icon(Icons.favorite_border,
                                    size: 14,
                                    color: AppColors.buyTextSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  '${listing.favouriteCount} saves',
                                  style: const TextStyle(
                                    color: AppColors.buyTextSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                              if (listing.favouriteCount > 0 &&
                                  listing.renewalCount > 0)
                                const SizedBox(width: 12),
                              if (listing.renewalCount > 0) ...[
                                const Icon(Icons.autorenew,
                                    size: 14,
                                    color: AppColors.buyTextSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  '${listing.renewalCount} renewals',
                                  style: const TextStyle(
                                    color: AppColors.buyTextSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                      // Description
                      Text(
                        listing.description,
                        style: const TextStyle(
                          color: AppColors.buyTextSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Payment protection explainer
                      const PaymentProtectionExplainer(),

                      const SizedBox(height: AppSpacing.lg),

                      // Provider card
                      _buildProviderCard(listing),

                      const SizedBox(height: AppSpacing.lg),

                      // Delivery method
                      Row(
                        children: [
                          const Icon(
                            Icons.local_shipping_outlined,
                            color: AppColors.buyTextSecondary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            listing.deliveryMethod.displayName,
                            style: const TextStyle(
                              color: AppColors.buyTextSecondary,
                              fontSize: 13,
                            ),
                          ),
                          if (listing.deliveryFee != null &&
                              listing.deliveryFee! > 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              '(${listing.deliveryFee} tokens)',
                              style: const TextStyle(
                                color: AppColors.buyTextTertiary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Location
                      if (listing.location != null &&
                          listing.location!.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.buyTextSecondary,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              listing.location!,
                              style: const TextStyle(
                                color: AppColors.buyTextSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        builder: (context, state) {
          if (state.selectedListing == null) return const SizedBox.shrink();
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: const BoxDecoration(
              color: AppColors.buyCard,
              border: Border(
                top: BorderSide(color: AppColors.buyCardBorder, width: 0.5),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Contact Seller',
                          variant: AppButtonVariant.secondary,
                          onPressed: _onContactSeller,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Make Offer',
                          variant: AppButtonVariant.secondary,
                          onPressed: () {
                            final listing = state.selectedListing!;
                            context.push(
                              '/buy/marketplace/make-offer',
                              extra: {
                                'listingId': listing.id,
                                'listingPriceTokens': listing.priceTokens,
                                'listingTitle': listing.title,
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: AppButton(
                          text: 'Buy Now',
                          variant: AppButtonVariant.primary,
                          onPressed: () => _onBuy(state.selectedListing!.id),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      ),
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    if (images.isEmpty) {
      return AspectRatio(
        aspectRatio: 1.8,
        child: Container(
          color: AppColors.buyCard,
          child: const Icon(
            Icons.storefront_outlined,
            color: AppColors.buyTextTertiary,
            size: 64,
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 2.4,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (_, index) => CachedNetworkImage(
          imageUrl: images[index],
          fit: BoxFit.cover,
          placeholder: (_, _) => Shimmer.fromColors(
            baseColor: AppColors.buyCard,
            highlightColor: AppColors.buyCard,
            child: Container(color: AppColors.buyCard),
          ),
          errorWidget: (_, _, _) => Container(
            color: AppColors.buyCard,
            child: const Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.buyTextTertiary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderCard(MarketplaceListing listing) {
    return GestureDetector(
      onTap: () => context.push(
        '/buy/marketplace/provider/${listing.providerId}',
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.buyCard,
              backgroundImage: listing.providerPhotoUrl != null
                  ? CachedNetworkImageProvider(listing.providerPhotoUrl!)
                  : null,
              child: listing.providerPhotoUrl == null
                  ? Text(
                      listing.providerName.isNotEmpty
                          ? listing.providerName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.providerName,
                    style: const TextStyle(
                      color: AppColors.buyTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      TrustBadge(
                        score: (listing.providerTrustScore as num?)?.toDouble() ??
                            0.0,
                        isVerified: listing.providerIsVerified == true,
                        size: TrustBadgeSize.small,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        listing.providerCompletedOrders == 1
                            ? '1 sale'
                            : '${listing.providerCompletedOrders} sales',
                        style: const TextStyle(
                          color: AppColors.buyTextTertiary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.buyTextSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.buyCard,
      highlightColor: AppColors.buyCard,
      child: Column(
        children: [
          Container(height: 300, color: AppColors.buyCard),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 24, width: 200, color: AppColors.buyCard),
                const SizedBox(height: 12),
                Container(height: 16, width: 100, color: AppColors.buyCard),
                const SizedBox(height: 16),
                Container(height: 60, color: AppColors.buyCard),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onShare() {
    final listing = context.read<MarketplaceBloc>().state.selectedListing;
    if (listing == null) return;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.buyCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.buyCardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.buyMarketplaceAccent,
              ),
              title: const Text(
                'Share to Chat',
                style: TextStyle(color: AppColors.buyTextPrimary),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                context.push(
                  '/share/marketplace/${listing.id}',
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.copy,
                color: AppColors.buyTextSecondary,
              ),
              title: const Text(
                'Copy Link',
                style: TextStyle(color: AppColors.buyTextPrimary),
              ),
              onTap: () {
                Navigator.of(ctx).pop();
                Clipboard.setData(
                  ClipboardData(
                    text:
                        'https://imalichat.app/buy/marketplace/${listing.id}',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link copied!'),
                    backgroundColor: AppColors.buySuccess,
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }

  void _onContactSeller() {
    final listing = context.read<MarketplaceBloc>().state.selectedListing;
    if (listing == null) return;
    context.push(
      '/chat/conversation/${listing.providerId}',
      extra: {
        'recipientName': listing.providerName,
        'context': 'marketplace_listing',
        'listingId': listing.id,
      },
    );
  }

  void _onBuy(String listingId) {
    final listing = context.read<MarketplaceBloc>().state.selectedListing;
    if (listing == null) return;

    final priceZar = listing.priceZar.toStringAsFixed(2);

    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.buyCard,
        title: const Text(
          'Confirm Purchase',
          style: TextStyle(color: AppColors.buyTextPrimary),
        ),
        content: Text(
          'Buy "${listing.title}" for R$priceZar (${listing.priceTokens} tokens)?',
          style: const TextStyle(color: AppColors.buyTextSecondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Buy Now'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && mounted) {
        context.read<OrderBloc>().add(
              OrderEvent.buyItem(
                listingId: listingId,
                walletId: 'primary',
              ),
            );
      }
    });
  }
}
