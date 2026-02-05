import 'package:flutter/material.dart';

/// A decorative wave background that places the wave image behind the child content.
///
/// Wraps the [child] in a [Stack] with the wave image positioned at the top.
/// Content sits on top of the wave for a layered visual effect.
class WaveBackground extends StatelessWidget {
  final Widget child;

  const WaveBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/wave_feather_fixed_r7.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        child,
      ],
    );
  }
}
