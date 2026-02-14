import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class HowToEarnScreen extends StatelessWidget {
  const HowToEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'How it works'),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: WaveBackground(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 96),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Intro ----
            Text(
              'iMaliChat is a money app that pays you for your attention.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSpacing.verticalMd,
            Text(
              'You earn tokens by watching short ads and answering tiny surveys \u2013 then you can:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            _buildBullet(context, 'build up a wallet balance'),
            _buildBullet(context, 'climb daily and weekly leaderboards'),
            _buildBullet(context, 'send and request value with friends'),
            _buildBullet(context, 'spend on things like airtime'),
            AppSpacing.verticalMd,
            Container(
              width: double.infinity,
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                ),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Text(
                'No gambling, no guessing. Just fair rewards for time you already spend on your phone.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
              ),
            ),

            // ---- Section 1 ----
            const SizedBox(height: 48),
            _buildSectionHeader(context, '1', 'Earn tokens from short ads & surveys'),
            AppSpacing.verticalMd,
            Text(
              'Most of what you do in iMaliChat happens in the Earn area. There you\u2019ll see earn messages from different brands.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalMd,
            _buildCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How it works:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  _buildOrderedItem(context, 'Tap an earn message to open it.'),
                  _buildOrderedItem(context, 'Watch/read the content (images have a countdown, videos play fully).'),
                  _buildOrderedItem(context, 'Answer the quick survey question(s).'),
                  AppSpacing.verticalSm,
                  const Divider(color: AppColors.border, height: 1),
                  AppSpacing.verticalSm,
                  Text(
                    'Every time you complete that flow, you earn tokens. Tokens are your in-app money.',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),

            // ---- Section 2 ----
            const SizedBox(height: 48),
            _buildSectionHeader(context, '2', 'Scores, streaks & leaderboards'),
            AppSpacing.verticalMd,
            Text(
              'Each time you earn, two things happen:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            _buildIconInfoCard(
              context,
              icon: Icons.account_balance_wallet,
              iconColor: AppColors.primary,
              title: 'You get tokens',
              subtitle: 'Guaranteed value you keep in your wallet.',
            ),
            AppSpacing.verticalSm,
            _buildIconInfoCard(
              context,
              icon: Icons.emoji_events,
              iconColor: AppColors.secondary,
              title: 'You get score',
              subtitle: 'Used for ranking against other users.',
            ),
            AppSpacing.verticalMd,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border(
                  left: BorderSide(
                    color: AppColors.secondary,
                    width: 2,
                  ),
                ),
              ),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  children: [
                    TextSpan(
                      text: 'Pro tip: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const TextSpan(
                      text: 'If you come back regularly, you build a streak. Streaks boost your score, helping you climb the leaderboard faster.',
                    ),
                  ],
                ),
              ),
            ),

            // ---- Section 3 ----
            const SizedBox(height: 48),
            _buildSectionHeader(context, '3', 'Daily & weekly pots (bonus rewards)'),
            AppSpacing.verticalMd,
            Text(
              'On top of your normal tokens, iMaliChat has two extra bonus pots: a Daily Pot and a Weekly Pot.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'A small slice of the value from each completed ad + survey goes into these pots. At the end of each period, the top users on the leaderboard share the pot.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalMd,
            Container(
              width: double.infinity,
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.1),
                    AppColors.orange.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                ),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In the Pots section you can see:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  _buildSparkleItem(context, 'How big the pots are'),
                  _buildSparkleItem(context, 'How much time is left'),
                  _buildSparkleItem(context, 'Your current rank and score'),
                ],
              ),
            ),

            // ---- Section 4 ----
            const SizedBox(height: 48),
            _buildSectionHeader(context, '4', 'Your wallet & history'),
            AppSpacing.verticalMd,
            Text(
              'All tokens you earn, win, or spend flow through your wallet. Inside the wallet you\u2019ll see your balance and a full transaction history.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'If you ever wonder \u201cWhere did that come from?\u201d or \u201cWhere did it go?\u201d, the wallet history is your answer.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),

            // ---- Section 5 ----
            const SizedBox(height: 48),
            _buildSectionHeader(context, '5', 'Money Chat: move value between people'),
            AppSpacing.verticalMd,
            Text(
              'Money Chat lets you use your balance with people you trust. Send tokens to friends or request from them.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalMd,
            _buildCard(
              context,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chat_bubble_outline, size: 24, color: Colors.white),
                  ),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: Text(
                      'Every send or request shows up as a chat-style entry in your Money Chat thread, so everything stays transparent.',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // ---- Section 6 ----
            const SizedBox(height: 48),
            _buildSectionHeader(context, '6', 'Invite friends & earn together'),
            AppSpacing.verticalMd,
            Text(
              'When you invite someone from inside iMaliChat, we link their phone number to your account (first-touch wins).',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalMd,
            Container(
              width: double.infinity,
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.purple.withValues(alpha: 0.1),
                  ],
                ),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.card_giftcard, size: 20, color: AppColors.primary),
                      AppSpacing.horizontalSm,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Starter Bonuses',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'When they join, both you and your friend get a token bonus.',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSm,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.people, size: 20, color: AppColors.primary),
                      AppSpacing.horizontalSm,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assist Score',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Over time, your assist score grows as they continue to earn.',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.verticalSm,
            Text(
              'The idea is to reward real, active referrals, not spammy invites.',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),

            // ---- Section 7 ----
            const SizedBox(height: 48),
            _buildSectionHeader(context, '7', 'Spending your tokens'),
            AppSpacing.verticalMd,
            Text(
              'As your tokens grow, you\u2019ll be able to use them inside the app \u2013 starting with airtime purchases. Over time, more ways to spend will be added.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalMd,
            _buildCard(
              context,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.smartphone, size: 24, color: Colors.white),
                  ),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: Text(
                      'Every spend shows in your wallet history so you always know how your value is being used.',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }

  Widget _buildBullet(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          AppSpacing.horizontalSm,
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String number, String title) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
          ),
        ),
        AppSpacing.horizontalSm,
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              AppColors.secondaryGradient[0].withValues(alpha: 0.06),
              AppColors.card,
            ),
            AppColors.card,
          ],
        ),
        border: Border.all(color: AppColors.border),
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: child,
    );
  }

  Widget _buildOrderedItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u2022',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          AppSpacing.horizontalSm,
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconInfoCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              iconColor.withValues(alpha: 0.06),
              AppColors.card,
            ),
            AppColors.card,
          ],
        ),
        border: Border.all(color: AppColors.border),
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          AppSpacing.horizontalSm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkleItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, size: 10, color: AppColors.secondary),
          AppSpacing.horizontalXs,
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
