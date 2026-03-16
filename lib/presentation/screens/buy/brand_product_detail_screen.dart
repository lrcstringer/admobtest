import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/brand_product.dart';
import '../../theme/app_colors.dart';

class BrandProductDetailScreen extends StatelessWidget {
  final String productId;
  final String storefrontId;
  final BrandProduct? product;

  const BrandProductDetailScreen({
    super.key,
    required this.productId,
    required this.storefrontId,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        backgroundColor: AppColors.buyBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.buyTextPrimary),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: Text(
            'Product not found',
            style: TextStyle(color: AppColors.buyTextSecondary),
          ),
        ),
      );
    }

    final p = product!;

    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      body: CustomScrollView(
        slivers: [
          // Hero image
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppColors.buyCard,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 18,
                child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: p.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: p.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                          Container(color: AppColors.surfaceElevated),
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.surfaceElevated,
                        child: const Icon(Icons.image_outlined,
                            size: 64, color: AppColors.textTertiary),
                      ),
                    )
                  : Container(
                      color: AppColors.surfaceElevated,
                      child: const Icon(Icons.shopping_bag_outlined,
                          size: 64, color: AppColors.textTertiary),
                    ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Price row
                  Row(
                    children: [
                      const Icon(Icons.toll, size: 20, color: AppColors.gold),
                      const SizedBox(width: 6),
                      Text(
                        '${p.priceTokens} tokens',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'R${p.priceZar.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Stock status
                  if (!p.isInStock)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Out of stock',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  if (p.category != null && p.category!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        p.category!,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],

                  // Description
                  if (p.description != null &&
                      p.description!.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MarkdownBody(
                      data: p.description!,
                      selectable: true,
                      onTapLink: (_, href, _) {
                        if (href != null) {
                          launchUrl(Uri.parse(href),
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        h1: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        h2: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        h3: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        strong: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        a: const TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                        listBullet: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],

                  // Fulfilment info
                  const SizedBox(height: 20),
                  _buildFulfilmentSection(p),

                  const SizedBox(height: 32),

                  // CTA button
                  if (p.isInStock) _buildCtaButton(context, p),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFulfilmentSection(BrandProduct p) {
    final items = <_InfoRow>[];

    switch (p.fulfilmentType) {
      case FulfilmentType.catalog:
        items.add(const _InfoRow(
            Icons.storefront, 'Type', 'Catalog — enquire to purchase'));
        if (p.contactMethod != null && p.contactMethod!.isNotEmpty) {
          items.add(_InfoRow(Icons.chat_outlined, 'Contact', p.contactMethod!));
        }
      case FulfilmentType.digital:
        items.add(const _InfoRow(
            Icons.cloud_download_outlined, 'Type', 'Digital delivery'));
        if (p.voucherInstructions != null &&
            p.voucherInstructions!.isNotEmpty) {
          items.add(_InfoRow(
              Icons.info_outline, 'Redemption', p.voucherInstructions!));
        }
      case FulfilmentType.physical:
        items.add(const _InfoRow(
            Icons.local_shipping_outlined, 'Type', 'Physical product'));
        if (p.collectionAddress != null &&
            p.collectionAddress!.isNotEmpty) {
          items.add(_InfoRow(
              Icons.place_outlined, 'Collection', p.collectionAddress!));
        }
        if (p.deliveryInfo != null && p.deliveryInfo!.isNotEmpty) {
          items.add(
              _InfoRow(Icons.schedule_outlined, 'Delivery', p.deliveryInfo!));
        }
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Details',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(item.icon,
                              size: 18, color: AppColors.textSecondary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.label,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textTertiary,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(height: 2),
                                Text(item.value,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textPrimary,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCtaButton(BuildContext context, BrandProduct p) {
    String label;
    IconData icon;

    switch (p.fulfilmentType) {
      case FulfilmentType.catalog:
        label = 'Enquire Now';
        icon = Icons.chat_outlined;
      case FulfilmentType.digital:
        label = 'Buy Now';
        icon = Icons.shopping_cart_outlined;
      case FulfilmentType.physical:
        label = 'Buy Now';
        icon = Icons.shopping_cart_outlined;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 20),
        label: Text(label,
            style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          if (p.contactMethod != null && p.contactMethod!.isNotEmpty) {
            final uri = Uri.tryParse(p.contactMethod!);
            if (uri != null) {
              launchUrl(uri, mode: LaunchMode.externalApplication);
              return;
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Coming soon')),
          );
        },
      ),
    );
  }
}

class _InfoRow {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);
}
