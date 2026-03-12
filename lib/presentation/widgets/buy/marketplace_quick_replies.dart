import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Contextual quick reply chips for marketplace chat (Spec §8.6).
///
/// Shows different chips for buyer vs seller role.
class MarketplaceQuickReplies extends StatelessWidget {
  final bool isSeller;
  final ValueChanged<String> onChipTapped;

  const MarketplaceQuickReplies({
    super.key,
    required this.isSeller,
    required this.onChipTapped,
  });

  static const _buyerChips = [
    'Is this still available?',
    'Can you deliver?',
    'Where are you located?',
    'What condition is it in?',
    "I'm interested!",
  ];

  static const _sellerChips = [
    'Yes, still available!',
    'I can deliver',
    'Collection only',
    'Let me check',
    'Thanks for your interest!',
  ];

  @override
  Widget build(BuildContext context) {
    final chips = isSeller ? _sellerChips : _buyerChips;

    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: chips.length,
        separatorBuilder: (_, _) => const SizedBox(width: 6),
        itemBuilder: (_, index) => GestureDetector(
          onTap: () => onChipTapped(chips[index]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.buyCardBorder,
                width: 0.5,
              ),
            ),
            child: Text(
              chips[index],
              style: const TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
