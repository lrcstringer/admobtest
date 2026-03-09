import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Full-width 8px divider band between Buy tab layers.
class BuyLayerDivider extends StatelessWidget {
  const BuyLayerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: double.infinity,
      color: AppColors.divider,
    );
  }
}
