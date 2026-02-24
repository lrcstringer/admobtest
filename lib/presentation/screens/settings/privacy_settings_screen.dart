import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/privacy_settings.dart';
import '../../../domain/enums/privacy_enums.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Privacy settings screen allowing users to control who can find them,
/// see their profile, and message them.
class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Privacy'),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final privacy =
              state.user?.profile?.privacySettings ?? const PrivacySettings();

          return ListView(
            children: [
              // Discoverability
              _buildSectionHeader(context, 'Who Can Find Me'),
              _buildDropdownTile<Discoverability>(
                context,
                icon: Icons.search,
                title: 'Search visibility',
                subtitle: 'Who can find you via search',
                value: privacy.discoverability,
                items: const {
                  Discoverability.everyone: 'Everyone',
                  Discoverability.contactsOnly: 'Contacts only',
                  Discoverability.nobody: 'Nobody',
                },
                onChanged: (v) => _update(context, 'discoverability', v.name),
              ),

              const Divider(height: 1),

              // Personal info
              _buildSectionHeader(context, 'Personal Info'),
              _buildDropdownTile<PhoneNumberVisibility>(
                context,
                icon: Icons.phone,
                title: 'Phone number',
                subtitle: 'Who can see your phone number',
                value: privacy.phoneNumberVisibility,
                items: const {
                  PhoneNumberVisibility.contactsOnly: 'Contacts only',
                  PhoneNumberVisibility.nobody: 'Nobody',
                },
                onChanged: (v) =>
                    _update(context, 'phoneNumberVisibility', v.name),
              ),
              _buildDropdownTile<ProfilePhotoVisibility>(
                context,
                icon: Icons.photo_camera_outlined,
                title: 'Profile photo',
                subtitle: 'Who can see your profile photo',
                value: privacy.profilePhotoVisibility,
                items: const {
                  ProfilePhotoVisibility.everyone: 'Everyone',
                  ProfilePhotoVisibility.contactsOnly: 'Contacts only',
                },
                onChanged: (v) =>
                    _update(context, 'profilePhotoVisibility', v.name),
              ),
              _buildDropdownTile<LastSeenVisibility>(
                context,
                icon: Icons.access_time,
                title: 'Last seen',
                subtitle: 'Who can see when you were last active',
                value: privacy.lastSeenVisibility,
                items: const {
                  LastSeenVisibility.everyone: 'Everyone',
                  LastSeenVisibility.contactsOnly: 'Contacts only',
                  LastSeenVisibility.nobody: 'Nobody',
                },
                onChanged: (v) =>
                    _update(context, 'lastSeenVisibility', v.name),
              ),

              const Divider(height: 1),

              // Messaging
              _buildSectionHeader(context, 'Messaging'),
              _buildSwitchTile(
                context,
                icon: Icons.done_all,
                title: 'Read receipts',
                subtitle: 'Show when you\'ve read messages',
                value: privacy.readReceipts,
                onChanged: (v) => _update(context, 'readReceipts', v),
              ),
              _buildDropdownTile<GroupAddPermission>(
                context,
                icon: Icons.group_add_outlined,
                title: 'Group invitations',
                subtitle: 'Who can add you to groups & communities',
                value: privacy.groupAddPermission,
                items: const {
                  GroupAddPermission.everyone: 'Everyone',
                  GroupAddPermission.contactsOnly: 'Contacts only',
                },
                onChanged: (v) =>
                    _update(context, 'groupAddPermission', v.name),
              ),
              _buildDropdownTile<BrandMessaging>(
                context,
                icon: Icons.storefront_outlined,
                title: 'Brand messages',
                subtitle: 'Whether brands can message you',
                value: privacy.brandMessaging,
                items: const {
                  BrandMessaging.allowAll: 'Allow all',
                  BrandMessaging.optedInOnly: 'Followed brands only',
                  BrandMessaging.none: 'None',
                },
                onChanged: (v) => _update(context, 'brandMessaging', v.name),
              ),

              const Divider(height: 1),

              // Blocked users
              _buildSectionHeader(context, 'Blocked Users'),
              ListTile(
                leading: const Icon(Icons.block, color: AppColors.error),
                title: const Text('Blocked users'),
                subtitle: const Text('Manage blocked users'),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppColors.textSecondary,
                ),
                onTap: () {
                  // TODO: Navigate to blocked users screen (Phase 2)
                },
              ),

              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  void _update(BuildContext context, String key, dynamic value) {
    context.read<ProfileBloc>().add(
          ProfileEvent.updatePrivacySetting(key: key, value: value),
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

  Widget _buildDropdownTile<T>(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required T value,
    required Map<T, String> items,
    required ValueChanged<T> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<T>(
        value: value,
        underline: const SizedBox.shrink(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
            ),
        items: items.entries
            .map(
              (e) => DropdownMenuItem<T>(value: e.key, child: Text(e.value)),
            )
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      activeTrackColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}
