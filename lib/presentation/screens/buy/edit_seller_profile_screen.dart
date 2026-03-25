import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

/// Edit seller profile: bio, contact preferences, and de-registration.
class EditSellerProfileScreen extends StatefulWidget {
  const EditSellerProfileScreen({super.key});

  @override
  State<EditSellerProfileScreen> createState() =>
      _EditSellerProfileScreenState();
}

class _EditSellerProfileScreenState extends State<EditSellerProfileScreen> {
  final _bioController = TextEditingController();
  late bool _chatContact;
  late bool _phoneContact;
  bool _initialised = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialised) {
      final provider =
          context.read<MarketplaceBloc>().state.currentSellerProfile;
      if (provider != null) {
        _bioController.text = provider.bio ?? '';
        _chatContact = provider.contactPreferences['chat'] ?? true;
        _phoneContact = provider.contactPreferences['phone'] ?? false;
      } else {
        _chatContact = true;
        _phoneContact = false;
      }
      _initialised = true;
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.buyTextPrimary,
      ),
      body: BlocConsumer<MarketplaceBloc, MarketplaceState>(
        listenWhen: (prev, curr) =>
            (prev.isUpdatingProfile && !curr.isUpdatingProfile) ||
            (prev.isDeregistering && !curr.isDeregistering),
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.buyError,
              ),
            );
            context
                .read<MarketplaceBloc>()
                .add(const MarketplaceEvent.clearMessages());
          } else if (!state.isUpdatingProfile && !state.isDeregistering) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated'),
                backgroundColor: AppColors.buySuccess,
              ),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          final provider = state.currentSellerProfile;
          if (provider == null) {
            return const Center(
              child: Text(
                'No seller profile found',
                style: TextStyle(color: AppColors.buyTextSecondary),
              ),
            );
          }

          final isDeregistering = provider.isDeregistering;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bio
                      const Text(
                        'About you',
                        style: TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: _bioController,
                        maxLines: 3,
                        maxLength: 200,
                        style: const TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Tell buyers about yourself and what you offer...',
                          hintStyle: const TextStyle(
                            color: AppColors.buyTextTertiary,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColors.buyCard,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                            borderSide: const BorderSide(
                              color: AppColors.buyCardBorder,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                            borderSide: const BorderSide(
                              color: AppColors.buyCardBorder,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

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
                                style: TextStyle(
                                    color: AppColors.buyTextPrimary),
                              ),
                              value: _chatContact,
                              onChanged: (v) =>
                                  setState(() => _chatContact = v),
                              activeTrackColor:
                                  AppColors.buyMarketplaceAccent,
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.buyCardBorder,
                            ),
                            SwitchListTile(
                              title: const Text(
                                'Phone',
                                style: TextStyle(
                                    color: AppColors.buyTextPrimary),
                              ),
                              subtitle: Text(
                                _phoneContact
                                    ? 'Your phone number will be visible'
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
                              activeTrackColor:
                                  AppColors.buyMarketplaceAccent,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // De-registration section
                      const Divider(color: AppColors.buyDivider),
                      const SizedBox(height: AppSpacing.md),
                      const Text(
                        'Stop Selling',
                        style: TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      if (isDeregistering) ...[
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color:
                                AppColors.buyWarning.withValues(alpha: 0.08),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(
                              color: AppColors.buyWarning
                                  .withValues(alpha: 0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.timer_outlined,
                                      size: 18,
                                      color: AppColors.buyWarning),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${provider.daysUntilDeregistration} days remaining',
                                    style: const TextStyle(
                                      color: AppColors.buyWarning,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Your seller account is being de-registered. '
                                'Your listings are paused. You can cancel '
                                'within the cooling-off period.',
                                style: TextStyle(
                                  color: AppColors.buyTextSecondary,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              AppButton(
                                text: 'Cancel De-registration',
                                variant: AppButtonVariant.outline,
                                isLoading: state.isDeregistering,
                                onPressed: () {
                                  context.read<MarketplaceBloc>().add(
                                        const MarketplaceEvent
                                            .cancelDeregistration(),
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        const Text(
                          'If you no longer want to sell, you can de-register. '
                          'There is a 7-day cooling-off period during which '
                          'you can change your mind.',
                          style: TextStyle(
                            color: AppColors.buyTextSecondary,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                          text: 'De-register as Seller',
                          variant: AppButtonVariant.outline,
                          onPressed: () => _confirmDeregistration(context),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Save button
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
                  child: AppButton(
                    text: 'Save Changes',
                    variant: AppButtonVariant.primary,
                    isLoading: state.isUpdatingProfile,
                    onPressed: _onSave,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onSave() {
    context.read<MarketplaceBloc>().add(
          MarketplaceEvent.updateSellerProfile(
            bio: _bioController.text.trim(),
            contactPreferences: {
              'chat': _chatContact,
              'phone': _phoneContact,
            },
          ),
        );
  }

  Future<void> _confirmDeregistration(BuildContext context) async {
    final bloc = context.read<MarketplaceBloc>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.buyCard,
        title: const Text(
          'Stop Selling?',
          style: TextStyle(color: AppColors.buyTextPrimary),
        ),
        content: const Text(
          'Your listings will be paused immediately. After 7 days, '
          'your seller account and all listings will be permanently removed.\n\n'
          'You can cancel within the 7-day cooling-off period.',
          style: TextStyle(
            color: AppColors.buyTextSecondary,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep Selling'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.buyError,
            ),
            child: const Text('De-register'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!mounted) return;
    bloc.add(const MarketplaceEvent.deregisterSeller());
  }
}
