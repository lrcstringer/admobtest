import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// POPIA consent modal bottom sheet for the reward program.
/// Must be accepted before the user can access reward features.
class RewardConsentDialog extends StatefulWidget {
  /// Called with `true` when the user accepts consent.
  final ValueChanged<bool>? onConsentGiven;

  const RewardConsentDialog({super.key, this.onConsentGiven});

  /// Show the consent dialog as a modal bottom sheet.
  /// Returns `true` if consent was given, `false` otherwise.
  static Future<bool> show(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const RewardConsentDialog(),
    );
    return result ?? false;
  }

  @override
  State<RewardConsentDialog> createState() => _RewardConsentDialogState();
}

class _RewardConsentDialogState extends State<RewardConsentDialog> {
  bool _accepted = false;
  bool _isSubmitting = false;

  Future<void> _submitConsent() async {
    setState(() => _isSubmitting = true);
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('updateRewardConsent')
          .call({'consent': true});

      if (!mounted) return;
      widget.onConsentGiven?.call(true);
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save consent: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              AppSpacing.verticalLg,

              // Icon and title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.card_giftcard,
                      color: AppColors.accent,
                      size: 24,
                    ),
                  ),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: Text(
                      'Reward Program Consent',
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalLg,

              // Explanation text
              Text(
                'iMali partners with brand sponsors to offer you non-token rewards '
                'such as voucher codes, discount codes, QR codes, and freebies when '
                'you complete earn activities.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
              ),
              AppSpacing.verticalMd,
              Text(
                'In accordance with the Protection of Personal Information Act (POPIA), '
                'we require your consent before enrolling you in the reward program. '
                'Your personal information will only be shared with sponsors as necessary '
                'to deliver your rewards.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                      height: 1.5,
                    ),
              ),
              AppSpacing.verticalLg,

              // Consent checkbox
              InkWell(
                onTap: () => setState(() => _accepted = !_accepted),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _accepted,
                        onChanged: (v) =>
                            setState(() => _accepted = v ?? false),
                        activeColor: AppColors.primary,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                    height: 1.5,
                                  ),
                              children: [
                                const TextSpan(
                                  text:
                                      'I consent to receiving non-token rewards from '
                                      'brand sponsors and agree to the ',
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push('/privacy-policy');
                                    },
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.verticalLg,

              // Accept button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _accepted && !_isSubmitting ? _submitConsent : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Accept',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              AppSpacing.verticalSm,

              // Decline / Close
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Not Now',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
              AppSpacing.verticalSm,
            ],
          ),
        ),
      ),
    );
  }
}
