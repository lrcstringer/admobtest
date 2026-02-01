import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// iMali logo widget for onboarding and splash screens
/// Uses mascot assets from assets/logo-assets/
class ZawadiLogo extends StatelessWidget {
  final double size;
  final bool showTagline;
  final bool useBubbles;

  const ZawadiLogo({
    super.key,
    this.size = 120,
    this.showTagline = true,
    this.useBubbles = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageHeight = size * 1.5;

    // Choose mascot asset based on size and variant
    final assetPath = useBubbles
        ? _getBubblesAsset(imageHeight)
        : _getMascotAsset(imageHeight);

    return Image.asset(
      assetPath,
      height: imageHeight,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder(context);
      },
    );
  }

  /// Select appropriate mascot asset based on display size
  String _getMascotAsset(double displayHeight) {
    if (displayHeight <= 48) return 'assets/logo-assets/mascot-32.png';
    if (displayHeight <= 96) return 'assets/logo-assets/mascot-64.png';
    if (displayHeight <= 192) return 'assets/logo-assets/mascot-128.png';
    if (displayHeight <= 384) return 'assets/logo-assets/mascot-256.png';
    return 'assets/logo-assets/mascot-512.png';
  }

  /// Select appropriate mascot-bubbles asset based on display size
  String _getBubblesAsset(double displayHeight) {
    return 'assets/icons/iMaliCrown4.png';
  }

  /// Fallback placeholder if the asset fails to load
  Widget _buildPlaceholder(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.25),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: AppColors.logoGradient,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.face,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'iMALI',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: size * 0.2,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        if (showTagline) ...[
          const SizedBox(height: 4),
          Text(
            'the cashback chat app',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: size * 0.1,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
        ],
      ],
    );
  }
}
