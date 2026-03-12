import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/enums/marketplace_category.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing'),
        backgroundColor: AppColors.surface,
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
          if (state.isLoading) {
            return _buildShimmer();
          }

          final listing = state.selectedListing;
          if (listing == null) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Listing not found',
                style: const TextStyle(color: AppColors.textSecondary),
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
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          listing.category.displayName,
                            style: const TextStyle(
                              color: AppColors.primary,
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
                          color: AppColors.textPrimary,
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

                      // Description
                      Text(
                        listing.description,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
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

                      // Location
                      if (listing.location != null &&
                          listing.location!.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              listing.location!,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
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
              color: AppColors.surface,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Contact Seller',
                      variant: AppButtonVariant.secondary,
                      onPressed: _onContactSeller,
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    if (images.isEmpty) {
      return AspectRatio(
        aspectRatio: 1.2,
        child: Container(
          color: AppColors.surfaceElevated,
          child: const Icon(
            Icons.storefront_outlined,
            color: AppColors.textHint,
            size: 64,
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.2,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (_, index) => CachedNetworkImage(
          imageUrl: images[index],
          fit: BoxFit.cover,
          placeholder: (_, __) => Shimmer.fromColors(
            baseColor: AppColors.surface,
            highlightColor: AppColors.surfaceElevated,
            child: Container(color: AppColors.surface),
          ),
          errorWidget: (_, __, ___) => Container(
            color: AppColors.surfaceElevated,
            child: const Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.textHint,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderCard(dynamic listing) {
    return GestureDetector(
      onTap: () => context.push(
        '/buy/marketplace/provider/${listing.providerId}',
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.surface,
              backgroundImage: listing.providerPhotoUrl != null
                  ? CachedNetworkImageProvider(listing.providerPhotoUrl!)
                  : null,
              child: listing.providerPhotoUrl == null
                  ? Text(
                      listing.providerName.isNotEmpty
                          ? listing.providerName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
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
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  TrustBadge(
                    score: (listing.providerTrustScore as num?)?.toDouble() ??
                        0.0,
                    isVerified: listing.providerIsVerified == true,
                    size: TrustBadgeSize.small,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.surface,
      highlightColor: AppColors.surfaceElevated,
      child: Column(
        children: [
          Container(height: 300, color: AppColors.surface),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 24, width: 200, color: AppColors.surface),
                const SizedBox(height: 12),
                Container(height: 16, width: 100, color: AppColors.surface),
                const SizedBox(height: 16),
                Container(height: 60, color: AppColors.surface),
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
      backgroundColor: AppColors.surfaceElevated,
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
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.primary,
              ),
              title: const Text(
                'Share to Chat',
                style: TextStyle(color: AppColors.textPrimary),
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
                color: AppColors.textSecondary,
              ),
              title: const Text(
                'Copy Link',
                style: TextStyle(color: AppColors.textPrimary),
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
                    backgroundColor: AppColors.success,
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
    // TODO: E2EE chat integration (Phase 3.7)
  }

  void _onBuy(String listingId) {
    // Navigate to wallet selection for purchase
    context.push('/buy/marketplace/orders', extra: {'listingId': listingId});
  }
}
