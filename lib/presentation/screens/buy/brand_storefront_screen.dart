import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/brand_storefront.dart';
import '../../blocs/brand_storefront/brand_storefront_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/brand_card.dart';

class BrandStorefrontScreen extends StatelessWidget {
  final String storefrontId;

  const BrandStorefrontScreen({super.key, required this.storefrontId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<BrandStorefrontBloc>()
        ..add(BrandStorefrontEvent.loadStorefront(storefrontId)),
      child: const _BrandStorefrontBody(),
    );
  }
}

class _BrandStorefrontBody extends StatelessWidget {
  const _BrandStorefrontBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandStorefrontBloc, BrandStorefrontState>(
      builder: (context, state) {
        final storefront = state.storefront;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: Text(
              storefront?.brandName ?? 'Brand',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.background,
            elevation: 0,
          ),
          backgroundColor: AppColors.background,
          body: state.isLoading
              ? _buildLoading()
              : state.errorMessage != null
                  ? _buildError(context, state.errorMessage!)
                  : storefront != null
                      ? _buildStorefront(context, storefront)
                      : _buildError(context, 'Storefront not found'),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'Go Back',
              onPressed: () => context.pop(),
              variant: AppButtonVariant.outline,
              size: AppButtonSize.small,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorefront(BuildContext context, BrandStorefront storefront) {
    final visibleSections = storefront.sections
        .where((s) => s.isVisible)
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return CustomScrollView(
      slivers: [
        // Hero cover image
        if (storefront.coverImageUrl != null)
          SliverToBoxAdapter(
            child: _buildCoverImage(storefront),
          ),

        // Brand header with tagline
        SliverToBoxAdapter(
          child: _buildBrandHeader(storefront),
        ),

        // Dynamic sections
        ...visibleSections.map(
          (section) => SliverToBoxAdapter(
            child: _buildSection(context, section, storefront),
          ),
        ),

        // Bottom padding
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }

  Widget _buildCoverImage(BrandStorefront storefront) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: storefront.coverImageUrl!,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: AppColors.surfaceElevated),
        errorWidget: (_, __, ___) => Container(
          color: AppColors.surfaceElevated,
          child: const Icon(Icons.storefront, color: AppColors.textTertiary, size: 48),
        ),
      ),
    );
  }

  Widget _buildBrandHeader(BrandStorefront storefront) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (storefront.brandLogoUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: storefront.brandLogoUrl!,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storefront.brandName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (storefront.tagline != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    storefront.tagline!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    StorefrontSection section,
    BrandStorefront storefront,
  ) {
    switch (section.type) {
      case 'hero':
        return _StorefrontHeroSection(section: section);
      case 'quick_actions':
        return _StorefrontQuickActions(section: section);
      case 'product_grid':
        return _StorefrontProductGrid(section: section);
      case 'about':
        return _StorefrontAbout(section: section);
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── Section Widgets ───────────────────────────────────────────

class _StorefrontHeroSection extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontHeroSection({required this.section});

  @override
  Widget build(BuildContext context) {
    final imageUrl = section.data['imageUrl'] as String?;
    final title = section.data['title'] as String? ?? section.title ?? '';
    final subtitle = section.data['subtitle'] as String?;
    final ctaText = section.data['ctaText'] as String?;
    final ctaDeepLink = section.data['ctaDeepLink'] as String?;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: BrandCard(
        gradient: BrandGradient.goldOrange,
        tintOpacity: 0.10,
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              if (imageUrl != null)
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const SizedBox(height: 120),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    if (ctaText != null && ctaDeepLink != null) ...[
                      const SizedBox(height: 10),
                      AppButton(
                        text: ctaText,
                        onPressed: () => context.go(ctaDeepLink),
                        size: AppButtonSize.small,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StorefrontQuickActions extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontQuickActions({required this.section});

  @override
  Widget build(BuildContext context) {
    final actions = (section.data['actions'] as List<dynamic>?) ?? [];
    if (actions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.title != null && section.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                section.title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          Row(
            children: actions
                .take(4)
                .map((action) {
                  final a = action as Map<String, dynamic>;
                  return Expanded(
                    child: _buildActionButton(
                      context,
                      emoji: a['icon'] as String? ?? '📦',
                      label: a['label'] as String? ?? '',
                      deepLink: a['deepLink'] as String?,
                    ),
                  );
                })
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String emoji,
    required String label,
    String? deepLink,
  }) {
    return GestureDetector(
      onTap: deepLink != null ? () => context.go(deepLink) : null,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.5),
              ),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StorefrontProductGrid extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontProductGrid({required this.section});

  @override
  Widget build(BuildContext context) {
    final products = (section.data['products'] as List<dynamic>?) ?? [];
    if (products.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.title != null && section.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                section.title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index] as Map<String, dynamic>;
              return _buildProductCard(context, p);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    final name = product['name'] as String? ?? '';
    final price = (product['price'] as num?)?.toInt() ?? 0;
    final imageUrl = product['imageUrl'] as String?;
    final deepLink = product['deepLink'] as String?;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                width: double.infinity,
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: AppColors.surface),
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.surface,
                          child: const Icon(Icons.image,
                              color: AppColors.textTertiary),
                        ),
                      )
                    : Container(
                        color: AppColors.surface,
                        child: const Icon(Icons.shopping_bag,
                            color: AppColors.textTertiary),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.toll,
                            size: 14, color: AppColors.gold),
                        const SizedBox(width: 3),
                        Text(
                          '$price',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gold,
                          ),
                        ),
                      ],
                    ),
                    if (deepLink != null)
                      GestureDetector(
                        onTap: () => context.go(deepLink),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Buy',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textOnPrimary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StorefrontAbout extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontAbout({required this.section});

  @override
  Widget build(BuildContext context) {
    final description = section.data['description'] as String?;
    final address = section.data['address'] as String?;
    final phone = section.data['phone'] as String?;
    final hours = section.data['hours'] as String?;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: BrandCard(
        gradient: BrandGradient.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.title != null && section.title!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  section.title!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            if (description != null) ...[
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (address != null)
              _buildInfoRow(Icons.location_on, address),
            if (phone != null)
              _buildInfoRow(Icons.phone, phone),
            if (hours != null)
              _buildInfoRow(Icons.access_time, hours),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textTertiary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
