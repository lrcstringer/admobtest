import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/onboarding/onboarding_widgets.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _allowAccess = true;
  bool _runInBackground = true;
  bool _notifications = true;
  bool _isLoading = false;

  Future<void> _onContinue() async {
    setState(() => _isLoading = true);

    // TODO: Request actual permissions based on toggle states
    // For now, just complete onboarding

    final authBloc = context.read<AuthBloc>();
    authBloc.add(const AuthEvent.completeOnboarding());

    // Navigate to profile setup for username/display name
    context.go('/onboarding/profile');
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final userName = authState.user?.profile?.displayName ??
        authState.user?.profile?.username ??
        'User';
    final avatarUrl = authState.user?.profile?.avatarUrl;

    return OnboardingScaffold(
      currentPage: 3,
      totalPages: 5,
      showLogo: false,
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          children: [
            AppSpacing.verticalLg,
            // Profile picture
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                image: avatarUrl != null
                    ? DecorationImage(
                        image: NetworkImage(avatarUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: avatarUrl == null
                  ? Center(
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                    )
                  : null,
            ),
            AppSpacing.verticalMd,
            // Username
            Text(
              userName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalLg,
            // Settings heading
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalXl,
            // Permission toggles
            _buildPermissionToggle(
              title: 'Allow Access',
              description:
                  'To help us give you a great Chat experience, please allow iMali to access your contacts and media on your phone.',
              value: _allowAccess,
              onChanged: (value) => setState(() => _allowAccess = value),
            ),
            AppSpacing.verticalLg,
            _buildPermissionToggle(
              title: 'Run in the Background',
              description:
                  'iMali will operate in the background on your phone with unconstricted battery usage.',
              value: _runInBackground,
              onChanged: (value) => setState(() => _runInBackground = value),
            ),
            AppSpacing.verticalLg,
            _buildPermissionToggle(
              title: 'Notifications',
              description:
                  'This will allow us to update you when you have new earning offers.',
              value: _notifications,
              onChanged: (value) => setState(() => _notifications = value),
            ),
            const Spacer(),
            // Continue button
            AppButton(
              text: 'Continue',
              isLoading: _isLoading,
              onPressed: _onContinue,
            ),
            AppSpacing.verticalMd,
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionToggle({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimaryDark,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              AppSpacing.verticalXs,
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        ),
        AppSpacing.horizontalMd,
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.textOnPrimary,
          activeTrackColor: AppColors.switchActive,
          inactiveThumbColor: AppColors.switchInactive,
          inactiveTrackColor: AppColors.switchTrackInactive,
        ),
      ],
    );
  }
}
