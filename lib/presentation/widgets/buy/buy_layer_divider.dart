import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// 1px divider line with 16px vertical padding between Buy tab layers.
class BuyLayerDivider extends StatelessWidget {
  const BuyLayerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        width: double.infinity,
        color: AppColors.buyDivider,
      ),
    );
  }
}
