import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/brand_account.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Screen showing all available brands with follow/unfollow functionality.
class BrandAccountsScreen extends StatefulWidget {
  const BrandAccountsScreen({super.key});

  @override
  State<BrandAccountsScreen> createState() => _BrandAccountsScreenState();
}

class _BrandAccountsScreenState extends State<BrandAccountsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ContactBloc>()
        .add(const ContactEvent.loadAvailableBrands());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: const IMaliAppBar(
        title: 'Brand Accounts',
        backgroundColor: AppColors.chatAppBar,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.actionError!),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoadingBrands && state.availableBrands.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.availableBrands.isEmpty) {
            return _buildEmptyState();
          }

          // Split into followed and other
          final followed =
              state.availableBrands.where((b) => b.isFollowed).toList();
          final other =
              state.availableBrands.where((b) => !b.isFollowed).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              if (followed.isNotEmpty) ...[
                _buildSectionHeader('Following', count: followed.length),
                ...followed.map((b) => _buildBrandTile(context, b)),
              ],
              if (other.isNotEmpty) ...[
                _buildSectionHeader('Discover Brands', count: other.length),
                ...other.map((b) => _buildBrandTile(context, b)),
              ],
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.storefront_outlined,
                size: 64, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(
              'No brands available',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Brand accounts will appear here once they are set up.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {int? count}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
          ),
          if (count != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBrandTile(BuildContext context, BrandAccount brand) {
    return ListTile(
      leading: _buildBrandAvatar(brand),
      title: Text(
        brand.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        brand.description ?? '${brand.followerCount} followers',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: brand.isFollowed
          ? OutlinedButton(
              onPressed: () {
                context
                    .read<ContactBloc>()
                    .add(ContactEvent.unfollowBrand(brand.id));
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Following'),
            )
          : FilledButton(
              onPressed: () {
                context
                    .read<ContactBloc>()
                    .add(ContactEvent.followBrand(brand.id));
              },
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Follow'),
            ),
    );
  }

  Widget _buildBrandAvatar(BrandAccount brand) {
    const double size = 48;
    const double radius = 6;

    Color color = AppColors.secondary;
    if (brand.avatarColor != null && brand.avatarColor!.isNotEmpty) {
      try {
        color = Color(
            int.parse(brand.avatarColor!.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: brand.logoUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.network(
                brand.logoUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.storefront,
                  color: color,
                  size: 24,
                ),
              ),
            )
          : Icon(Icons.storefront, color: color, size: 24),
    );
  }
}
