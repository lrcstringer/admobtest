import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
/// Single-screen seller registration.
/// Auto-populates name/photo from user profile.
/// T&Cs checkbox + contact preferences, one "Start Selling" button.
class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});

  @override
  State<SellerRegistrationScreen> createState() =>
      _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  bool _acceptedTerms = false;
  bool _chatContact = true;
  bool _phoneContact = false;

  static const String _termsText = '''
iMaliChat Marketplace — Seller Terms

By registering as a seller you agree to the following:

1. Honesty
   List only items or services you can genuinely provide. Do not mislead buyers about quality, condition, or availability.

2. Fair pricing
   Prices are in iMaliChat tokens. Set fair prices — the community will hold you accountable through ratings and vouches.

3. Delivery
   Deliver items or complete services within 7 days of a confirmed order. If you cannot deliver, cancel the order so the buyer is refunded.

4. Communication
   Respond to buyer messages promptly. Ignoring buyers damages trust and may lead to account suspension.

5. No prohibited items
   Do not list illegal goods, weapons, drugs, stolen property, counterfeit items, or anything that violates South African law.

6. Account responsibility
   You are responsible for all activity under your seller account. Do not share your account credentials.

7. Disputes
   If a buyer raises a dispute, cooperate in good faith. iMaliChat may mediate and make a final decision on refunds.

8. Suspension & removal
   iMaliChat may suspend or permanently remove your seller account if you violate these terms, receive excessive complaints, or engage in fraud.

9. De-registration
   You may stop selling at any time. There is a 7-day cooling-off period during which you can change your mind. After 7 days, your listings are removed.

These terms may be updated. Continued use of the marketplace means you accept any changes. Questions? Contact support in the app.''';

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    final displayName = user?.displayName ?? 'Seller';
    final avatarUrl = user?.profile?.avatarUrl;

    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        title: const Text('Become a Seller'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.buyTextPrimary,
      ),
      body: BlocConsumer<MarketplaceBloc, MarketplaceState>(
        listenWhen: (prev, curr) =>
            prev.isRegistering && !curr.isRegistering,
        listener: (context, state) {
          if (state.registrationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You are now a seller!'),
                backgroundColor: AppColors.buySuccess,
              ),
            );
            context
                .read<MarketplaceBloc>()
                .add(const MarketplaceEvent.clearMessages());
            context.go('/buy/marketplace/create-listing');
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.buyError,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile preview
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.transparent,
                              backgroundImage: avatarUrl != null
                                  ? NetworkImage(avatarUrl)
                                  : null,
                              child: avatarUrl == null
                                  ? Text(
                                      displayName.isNotEmpty
                                          ? displayName[0].toUpperCase()
                                          : '?',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.buyTextPrimary,
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              displayName,
                              style: const TextStyle(
                                color: AppColors.buyTextPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'This is how buyers will see you',
                              style: TextStyle(
                                color: AppColors.buyTextSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Contact preferences
                      const Text(
                        'How can buyers contact you?',
                        style: TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.buyCard,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                            color: AppColors.buyCardBorder,
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            SwitchListTile(
                              title: const Text(
                                'iMaliChat message',
                                style:
                                    TextStyle(color: AppColors.buyTextPrimary),
                              ),
                              subtitle: const Text(
                                'Buyers can message you in the app',
                                style: TextStyle(
                                  color: AppColors.buyTextSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              value: _chatContact,
                              onChanged: (v) =>
                                  setState(() => _chatContact = v),
                              activeTrackColor: AppColors.buyMarketplaceAccent,
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.buyCardBorder,
                            ),
                            SwitchListTile(
                              title: const Text(
                                'Phone',
                                style:
                                    TextStyle(color: AppColors.buyTextPrimary),
                              ),
                              subtitle: Text(
                                _phoneContact
                                    ? 'Your phone number will be visible to buyers'
                                    : 'Your phone number stays private',
                                style: TextStyle(
                                  color: _phoneContact
                                      ? AppColors.buyWarning
                                      : AppColors.buyTextSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              value: _phoneContact,
                              onChanged: (v) =>
                                  setState(() => _phoneContact = v),
                              activeTrackColor: AppColors.buyMarketplaceAccent,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // T&Cs
                      const Text(
                        'Marketplace Terms',
                        style: TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        height: 200,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.buyCard,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                            color: AppColors.buyCardBorder,
                            width: 0.5,
                          ),
                        ),
                        child: const SingleChildScrollView(
                          child: Text(
                            _termsText,
                            style: TextStyle(
                              color: AppColors.buyTextSecondary,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      CheckboxListTile(
                        value: _acceptedTerms,
                        onChanged: (v) =>
                            setState(() => _acceptedTerms = v ?? false),
                        title: const Text(
                          'I agree to the iMaliChat Marketplace Terms',
                          style: TextStyle(
                            color: AppColors.buyTextPrimary,
                            fontSize: 13,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColors.buyMarketplaceAccent,
                      ),
                    ],
                  ),
                ),
              ),

              // Submit button
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: const BoxDecoration(
                  color: AppColors.buyCard,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.buyCardBorder,
                      width: 0.5,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: (_acceptedTerms && !state.isRegistering)
                          ? () => _onSubmit(displayName, avatarUrl)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buyMarketplaceAccent,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.buyMarketplaceAccent.withValues(alpha: 0.5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                      child: state.isRegistering
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Registering...',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Start Selling',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onSubmit(String displayName, String? avatarUrl) {
    context.read<MarketplaceBloc>().add(
          MarketplaceEvent.registerProvider(
            displayName: displayName,
            photoUrl: avatarUrl,
            contactPreferences: {
              'chat': _chatContact,
              'phone': _phoneContact,
            },
          ),
        );
  }
}
