import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.30;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.themed(context).tabGradient,
          ),
        ),
        child: Stack(
          children: [

            // Main content
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    // Compact header: mascot + iMaliChat + tagline
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: mascotSize,
                      height: mascotSize,
                      child: Image.asset(
                        'assets/icons/iMaliCrown4.png',
                        width: mascotSize,
                        height: mascotSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/icons/ImaliFacewithText.png',
                            width: mascotSize,
                            height: mascotSize,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'iMali',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'Chat',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Earn. Chat. Buy.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    // Title
                    Text(
                      'Privacy Policy',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: 16),

                    // Scrollable privacy content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'iMaliChat ("we", "us", or "our") operates the '
                          'iMaliChat mobile application (the "App"). This '
                          'Privacy Policy explains how we collect, use, '
                          'disclose, and safeguard your information when you '
                          'use our App. By using the App you agree to the '
                          'collection and use of information in accordance '
                          'with this policy.\n\n'
                          '1. Information We Collect\n\n'
                          'Personal information you provide:\n'
                          '\u2022 Phone number \u2013 used for account creation, '
                          'OTP verification, and login.\n'
                          '\u2022 Display name, username, and profile photo \u2013 '
                          'shown to other users within the App.\n'
                          '\u2022 Date of birth, gender, province, and city \u2013 '
                          'used to personalise your experience and for '
                          'audience targeting of earn opportunities.\n'
                          '\u2022 Languages and interests \u2013 used to match you '
                          'with relevant earn opportunities.\n\n'
                          'Information collected automatically:\n'
                          '\u2022 Device information \u2013 device model, OS version, '
                          'platform, and hardware-backed key status, used '
                          'for security and device binding.\n'
                          '\u2022 FCM tokens \u2013 Firebase Cloud Messaging tokens '
                          'for push notifications.\n'
                          '\u2022 Usage data \u2013 login timestamps, engagement '
                          'activity, and in-app actions for analytics and '
                          'fraud prevention.\n'
                          '\u2022 Advertising ID \u2013 collected by Google AdMob to '
                          'serve ads within the App.\n\n'
                          '2. Device Permissions\n\n'
                          '\u2022 Camera \u2013 to take profile photos and capture '
                          'media for chat messages. You can deny or revoke '
                          'this permission at any time in your device '
                          'settings.\n'
                          '\u2022 Contacts \u2013 to help you find friends already '
                          'using iMaliChat. Contact data is not uploaded to '
                          'our servers; matching is done locally on your '
                          'device.\n'
                          '\u2022 Biometrics (fingerprint / face) \u2013 for secure '
                          'app unlock and session authentication. Biometric '
                          'data never leaves your device.\n'
                          '\u2022 Internet & network state \u2013 required for the '
                          'App to function.\n\n'
                          '3. How We Use Your Information\n\n'
                          '\u2022 To create and manage your account.\n'
                          '\u2022 To verify your identity via OTP and '
                          'device-based authentication.\n'
                          '\u2022 To provide and personalise earn opportunities '
                          '(token rewards).\n'
                          '\u2022 To process token transactions and maintain '
                          'your wallet balance.\n'
                          '\u2022 To send push notifications about login '
                          'requests, security alerts, and engagement '
                          'updates.\n'
                          '\u2022 To display advertisements via Google AdMob.\n'
                          '\u2022 To detect and prevent fraud, abuse, and '
                          'security threats.\n'
                          '\u2022 To comply with legal obligations.\n\n'
                          '4. Token Economy & Financial Data\n\n'
                          'The App uses a token-based reward system. We '
                          'maintain a double-entry ledger of all token '
                          'transactions (earnings, transfers, and pot '
                          'contributions). Transaction records include '
                          'amounts, timestamps, and participant identifiers. '
                          'Token balances are stored on our servers and are '
                          'not transferable outside the App except as '
                          'described in our Terms of Service.\n\n'
                          '5. Data Sharing & Disclosure\n\n'
                          'We do not sell your personal information. We may '
                          'share data with:\n'
                          '\u2022 Firebase / Google Cloud \u2013 for authentication, '
                          'database hosting, cloud functions, analytics, and '
                          'push notifications.\n'
                          '\u2022 Google AdMob \u2013 for serving advertisements. '
                          'AdMob may collect device and advertising '
                          'identifiers.\n'
                          '\u2022 MyMobileAPI \u2013 our SMS gateway provider, which '
                          'receives your phone number solely to deliver OTP '
                          'verification codes.\n'
                          '\u2022 Brand partners \u2013 anonymised or aggregated '
                          'engagement metrics only. Your personal details '
                          'are never shared with advertisers.\n'
                          '\u2022 Law enforcement \u2013 when required by law or to '
                          'protect the safety of our users.\n\n'
                          '6. Data Security\n\n'
                          'We implement industry-standard security measures '
                          'including:\n'
                          '\u2022 Hardware-backed cryptographic device binding '
                          '(ECDSA key pairs).\n'
                          '\u2022 Biometric session locks.\n'
                          '\u2022 Runtime Application Self-Protection (RASP).\n'
                          '\u2022 Encrypted HTTPS communication.\n'
                          '\u2022 Server-side rate limiting and risk event '
                          'monitoring.\n\n'
                          'While we strive to protect your data, no method '
                          'of electronic transmission or storage is 100% '
                          'secure.\n\n'
                          '7. Data Retention\n\n'
                          'We retain your account data for as long as your '
                          'account is active. If you delete your account, we '
                          'will remove your personal information from our '
                          'active databases within 30 days. Some data may be '
                          'retained in anonymised form for analytics or as '
                          'required by law.\n\n'
                          '8. Your Rights\n\n'
                          'Under the Protection of Personal Information Act '
                          '(POPIA) and other applicable laws, you have the '
                          'right to:\n'
                          '\u2022 Access the personal information we hold about '
                          'you.\n'
                          '\u2022 Request correction of inaccurate information.\n'
                          '\u2022 Request deletion of your account and '
                          'associated data.\n'
                          '\u2022 Object to the processing of your personal '
                          'information.\n'
                          '\u2022 Withdraw consent at any time.\n\n'
                          'To exercise any of these rights, contact us at '
                          'privacy@imalichat.com.\n\n'
                          '9. Children\'s Privacy\n\n'
                          'The App is not intended for children under the '
                          'age of 18. We do not knowingly collect personal '
                          'information from children. If we become aware '
                          'that a child under 18 has provided us with '
                          'personal data, we will take steps to delete such '
                          'information.\n\n'
                          '10. Third-Party Links\n\n'
                          'The App may contain links to third-party websites '
                          'or services. We are not responsible for the '
                          'privacy practices of these third parties.\n\n'
                          '11. Changes to This Policy\n\n'
                          'We may update this Privacy Policy from time to '
                          'time. We will notify you of material changes via '
                          'in-app notification or push notification.\n\n'
                          '12. Contact Us\n\n'
                          'If you have questions or concerns about this '
                          'Privacy Policy, please contact us:\n\n'
                          'iMaliChat\n'
                          'Email: privacy@imalichat.com\n'
                          'South Africa\n\n'
                          'Last updated: February 2026',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),

                    // Back button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 32),
                      child: AppButton(
                        text: 'Back',
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/auth/age-consent');
                          }
                        },
                        size: AppButtonSize.large,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
