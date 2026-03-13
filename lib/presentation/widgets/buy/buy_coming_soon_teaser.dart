import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../common/brand_card.dart';

/// Teaser card for layers not yet enabled (Featured, Marketplace).
class BuyComingSoonTeaser extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final BrandGradient gradient;

  const BuyComingSoonTeaser({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.gradient = BrandGradient.cyanBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: BrandCard(
        gradient: gradient,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.buyCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.secondary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buyTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.buyTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.buyWarning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'SOON',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.buyWarning,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
