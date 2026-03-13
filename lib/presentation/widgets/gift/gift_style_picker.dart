import 'package:flutter/material.dart';

import '../../../domain/enums/gift_style.dart';
import '../../theme/app_spacing.dart';
import 'gift_card_painters.dart';

/// Horizontal scroll picker for gift visual styles.
class GiftStylePicker extends StatelessWidget {
  final GiftStyle selected;
  final ValueChanged<GiftStyle> onChanged;

  const GiftStylePicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static final _styles = [
    (
      GiftStyle.celebration,
      'Celebration',
      Icons.celebration,
      [Icons.auto_awesome, Icons.star],
    ),
    (
      GiftStyle.birthday,
      'Birthday',
      Icons.cake,
      [Icons.celebration, Icons.star],
    ),
    (
      GiftStyle.love,
      'Love',
      Icons.favorite,
      [Icons.favorite_border, Icons.favorite],
    ),
    (
      GiftStyle.ndlovukazi,
      'Ndlovukazi',
      Icons.auto_awesome,
      [Icons.star, Icons.diamond],
    ),
    (
      GiftStyle.professional,
      'Professional',
      Icons.business_center,
      <IconData>[],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _styles.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final (style, label, mainIcon, accentIcons) = _styles[index];
          final isSelected = selected == style;
          final colors = GiftStyleColors.forStyle(style);

          return GestureDetector(
            onTap: () => onChanged(style),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 88,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? colors.iconColor : Colors.transparent,
                  width: 2.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colors.iconColor.withValues(alpha: 0.35),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]
                    : null,
              ),
              child: Stack(
                children: [
                  // Multi-color gradient background
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isSelected
                              ? colors.gradient
                              : colors.gradient
                                  .map((c) => c.withValues(alpha: 0.55))
                                  .toList(),
                        ),
                      ),
                    ),
                  ),

                  // Style-specific decorative paint layer
                  if (style != GiftStyle.professional)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: giftStylePainter(
                          style,
                          opacity: isSelected ? 0.85 : 0.5,
                        ),
                      ),
                    ),

                  // Accent icons (small, positioned around edges)
                  if (accentIcons.isNotEmpty) ...[
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(
                        accentIcons[0],
                        color: colors.accent1
                            .withValues(alpha: isSelected ? 0.85 : 0.5),
                        size: 12,
                      ),
                    ),
                    if (accentIcons.length > 1)
                      Positioned(
                        bottom: 28,
                        left: 6,
                        child: Icon(
                          accentIcons[1],
                          color: colors.accent2
                              .withValues(alpha: isSelected ? 0.75 : 0.45),
                          size: 10,
                        ),
                      ),
                  ],

                  // Main icon + label
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          mainIcon,
                          color: isSelected
                              ? colors.iconColor
                              : colors.iconColor.withValues(alpha: 0.6),
                          size: 34,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          label,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: isSelected
                                        ? colors.iconColor
                                        : colors.iconColor
                                            .withValues(alpha: 0.7),
                                    fontWeight:
                                        isSelected ? FontWeight.bold : null,
                                    fontSize: 10,
                                  ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
}
