import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Help & Support'),
      body: ListView(
        children: [
          // Quick help section
          _buildSectionHeader(context, 'Quick Help'),
          _buildFaqItem(
            context,
            question: 'How do I earn tokens?',
            answer:
                'You can earn tokens by watching ads, completing surveys, and referring friends. Head to the Earn tab to get started!',
          ),
          _buildFaqItem(
            context,
            question: 'How much is a token worth?',
            answer:
                '1 token = R0.01 ZAR. So 100 tokens = R1.00, and 1000 tokens = R10.00.',
          ),
          _buildFaqItem(
            context,
            question: 'How do I cash out?',
            answer:
                'Go to Wallet > Cash Out. You need a minimum of 5000 tokens (R50) to cash out. Cashouts are processed via bank transfer.',
          ),
          _buildFaqItem(
            context,
            question: 'What are Pots?',
            answer:
                'Pots are daily and weekly prize pools. Every time you earn tokens, you get entries into the pot draw. Winners are selected randomly!',
          ),
          _buildFaqItem(
            context,
            question: 'How do referrals work?',
            answer:
                'Share your referral code with friends. When they sign up and earn their first tokens, you both get bonus tokens!',
          ),
          const Divider(height: 1),

          // Contact section
          _buildSectionHeader(context, 'Contact Us'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.email_outlined, color: AppColors.primary),
            ),
            title: const Text('Email Support'),
            subtitle: const Text('support@imali.co.za'),
            onTap: () => _launchEmail(),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat_outlined, color: Colors.green),
            ),
            title: const Text('WhatsApp'),
            subtitle: const Text('+27 12 345 6789'),
            onTap: () => _launchWhatsApp(),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.help_outline, color: Colors.blue),
            ),
            title: const Text('Help Center'),
            subtitle: const Text('Browse articles and guides'),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () => _launchUrl('https://help.imali.co.za'),
          ),
          const Divider(height: 1),

          // Feedback
          _buildSectionHeader(context, 'Feedback'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star_outline, color: Colors.orange),
            ),
            title: const Text('Rate the App'),
            subtitle: const Text('Love iMali? Give us 5 stars!'),
            onTap: () => _launchAppStore(),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.feedback_outlined, color: Colors.purple),
            ),
            title: const Text('Send Feedback'),
            subtitle: const Text('Help us improve iMali'),
            onTap: () => _showFeedbackDialog(context),
          ),

          AppSpacing.verticalXl,

          // Response time note
          Padding(
            padding: AppSpacing.pagePadding,
            child: Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: AppColors.info, size: 20),
                  AppSpacing.horizontalSm,
                  Expanded(
                    child: Text(
                      'Our support team typically responds within 24 hours on business days.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.verticalXl,
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  Widget _buildFaqItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontSize: 15),
      ),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Text(
          answer,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Future<void> _launchEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@imali.co.za',
      queryParameters: {'subject': 'iMali Support Request'},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchWhatsApp() async {
    final uri = Uri.parse('https://wa.me/27123456789');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchAppStore() async {
    // This would link to the actual app store listing
    final uri = Uri.parse('https://play.google.com/store/apps/details?id=com.imali.app');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('We\'d love to hear from you! What would you like to share?'),
            AppSpacing.verticalMd,
            TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Type your feedback here...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you for your feedback!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
