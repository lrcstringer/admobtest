import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';

/// Chooser screen that lets the user pick between One-to-One Sasaza
/// (personal gift) and Group Together to Sasaza (group pool).
///
/// Reached from the action strip on the Chats tab or the "+" action
/// picker inside a conversation. When opened without a recipient
/// (from the Chats tab), the One-to-One flow prompts for a contact first.
class SasazaChooserScreen extends StatelessWidget {
  final String? recipientId;
  final String? recipientName;
  final String? conversationId;

  const SasazaChooserScreen({
    super.key,
    this.recipientId,
    this.recipientName,
    this.conversationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Sasaza'),
      body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
        overlayAsset: null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              _SasazaOptionCard(
                imageAsset: 'assets/images/sasaza.png',
                title: 'One-to-One Sasaza',
                subtitle: 'Send a personal gift to someone special',
                gradientColors: AppColors.goldGradient,
                onTap: () {
                  if (recipientId != null &&
                      recipientId!.isNotEmpty &&
                      conversationId != null) {
                    // Launched from inside a conversation — pre-fill recipient
                    context.push(
                      '/chat/conversation/$conversationId/send-gift',
                      extra: {
                        'recipientId': recipientId,
                        'recipientName': recipientName ?? '',
                      },
                    );
                  } else {
                    // Standalone — gift composer has its own recipient picker
                    context.push(
                      '/chat/send-gift',
                      extra: {
                        'recipientId': recipientId,
                        'recipientName': recipientName,
                      },
                    );
                  }
                },
              ),
              AppSpacing.verticalLg,
              _SasazaOptionCard(
                imageAsset: 'assets/images/sasaza.png',
                title: 'Group Together to Sasaza',
                subtitle: 'Pool together with friends for a group gift',
                gradientColors: AppColors.primaryGradient,
                onTap: () {
                  context.push(
                    '/chat/create-pool',
                    extra: {
                      'recipientId': recipientId,
                      'recipientName': recipientName,
                      'mode': 'sasaza',
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SasazaOptionCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _SasazaOptionCard({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.alphaBlend(
                gradientColors[0].withValues(alpha: 0.08),
                AppColors.surface,
              ),
              Color.alphaBlend(
                gradientColors[1].withValues(alpha: 0.04),
                AppColors.surface,
              ),
            ],
          ),
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageAsset,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: gradientColors.first,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
