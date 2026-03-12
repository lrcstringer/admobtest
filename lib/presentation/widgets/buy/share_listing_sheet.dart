import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/entities/marketplace_listing.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Share listing bottom sheet (Spec §14.1).
///
/// Options: WhatsApp, iMali Chat, Copy Link.
class ShareListingSheet extends StatelessWidget {
  final MarketplaceListing listing;
  final VoidCallback? onShareWhatsApp;
  final VoidCallback? onShareChat;
  final String? deepLinkUrl;

  const ShareListingSheet({
    super.key,
    required this.listing,
    this.onShareWhatsApp,
    this.onShareChat,
    this.deepLinkUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 8, 20, MediaQuery.of(context).padding.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.buyDivider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Share listing',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            listing.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.buyTextTertiary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),

          // Share options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ShareOption(
                icon: Icons.chat_bubble_rounded,
                label: 'WhatsApp',
                color: const Color(0xFF25D366),
                onTap: () {
                  Navigator.pop(context);
                  onShareWhatsApp?.call();
                },
              ),
              _ShareOption(
                icon: Icons.forum_rounded,
                label: 'iMali Chat',
                color: AppColors.buyMarketplaceAccent,
                onTap: () {
                  Navigator.pop(context);
                  onShareChat?.call();
                },
              ),
              _ShareOption(
                icon: Icons.link_rounded,
                label: 'Copy Link',
                color: AppColors.buyTextSecondary,
                onTap: () {
                  final url = deepLinkUrl ?? 'https://imali.app/listing/${listing.id}';
                  Clipboard.setData(ClipboardData(text: url));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Link copied'),
                      backgroundColor: AppColors.buyTextPrimary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
