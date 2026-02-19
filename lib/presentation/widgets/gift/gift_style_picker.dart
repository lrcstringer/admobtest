import 'package:flutter/material.dart';

import '../../../domain/enums/gift_style.dart';
import '../../theme/app_spacing.dart';

/// Horizontal scroll picker for gift visual styles.
class GiftStylePicker extends StatelessWidget {
  final GiftStyle selected;
  final ValueChanged<GiftStyle> onChanged;

  const GiftStylePicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _styles = [
    (GiftStyle.celebration, 'Celebration', Icons.celebration, Colors.amber),
    (GiftStyle.birthday, 'Birthday', Icons.cake, Colors.pink),
    (GiftStyle.love, 'Love', Icons.favorite, Colors.red),
    (GiftStyle.ndlovukazi, 'Ndlovukazi', Icons.auto_awesome, Colors.purple),
    (GiftStyle.professional, 'Professional', Icons.business_center, Colors.blueGrey),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _styles.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final (style, label, icon, color) = _styles[index];
          final isSelected = selected == style;
          return GestureDetector(
            onTap: () => onChanged(style),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 80,
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.15)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? color : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 32),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSelected ? color : null,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
