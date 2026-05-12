import 'package:flutter/material.dart';

import 'presentation/screens/play_ad/play_ad_screen.dart';
import 'presentation/theme/app_theme.dart';

class PlayAdApp extends StatelessWidget {
  const PlayAdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMali',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const PlayAdScreen(),
    );
  }
}
