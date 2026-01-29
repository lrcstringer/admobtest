import 'package:flutter/material.dart';

import '../../widgets/common/imali_app_bar.dart';
import '../../theme/app_colors.dart';

class ChatBonusNetworkInviteScreen extends StatelessWidget {
  const ChatBonusNetworkInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Invite to Bonus Network'),
      body: Center(
        child: Text(
          'Invite to Bonus Network\nComing Soon',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
      ),
    );
  }
}
