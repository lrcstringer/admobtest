import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Placeholder Save screen — will be replaced with full implementation.
class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Save'),
      body: WaveBackground(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.75,
            child: Image.asset(
              'assets/images/dragons.jpg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
