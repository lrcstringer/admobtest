import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _displayNameController = TextEditingController();
  final _usernameController = TextEditingController();
  String? _displayNameError;
  String? _usernameError;
  bool _isCheckingUsername = false;
  bool _isUsernameAvailable = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _displayNameController.text.length >= 2 &&
      _usernameController.text.length >= 3 &&
      _isUsernameAvailable &&
      !_isCheckingUsername;

  Future<void> _checkUsernameAvailability(String username) async {
    if (username.length < 3) {
      setState(() {
        _usernameError = 'Username must be at least 3 characters';
        _isUsernameAvailable = false;
      });
      return;
    }

    // Validate username format
    final validUsername = RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username);
    if (!validUsername) {
      setState(() {
        _usernameError = 'Only letters, numbers, and underscores allowed';
        _isUsernameAvailable = false;
      });
      return;
    }

    setState(() {
      _isCheckingUsername = true;
      _usernameError = null;
    });

    final userRepo = getIt<UserRepository>();
    final result = await userRepo.isUsernameAvailable(username);

    if (mounted) {
      result.fold(
        (failure) {
          setState(() {
            _usernameError = 'Unable to check username';
            _isCheckingUsername = false;
            _isUsernameAvailable = false;
          });
        },
        (available) {
          setState(() {
            _isCheckingUsername = false;
            _isUsernameAvailable = available;
            if (!available) {
              _usernameError = 'Username is already taken';
            }
          });
        },
      );
    }
  }

  Future<void> _onContinue() async {
    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) return;

    setState(() => _isLoading = true);

    final userRepo = getIt<UserRepository>();
    final result = await userRepo.updateProfile(
      userId: authState.user!.id,
      displayName: _displayNameController.text.trim(),
      username: _usernameController.text.trim().toLowerCase(),
    );

    if (mounted) {
      result.fold(
        (failure) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.displayMessage)),
          );
        },
        (user) {
          context.read<AuthBloc>().add(const AuthEvent.completeOnboarding());
          context.go('/home');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.verticalLg,
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalXl,
              Text(
                'What should we call you?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              AppSpacing.verticalMd,
              AppTextField(
                controller: _displayNameController,
                label: 'Display Name',
                hint: 'Enter your name',
                errorText: _displayNameError,
                onChanged: (value) {
                  setState(() {
                    if (value.length < 2) {
                      _displayNameError = 'Name must be at least 2 characters';
                    } else {
                      _displayNameError = null;
                    }
                  });
                },
              ),
              AppSpacing.verticalLg,
              AppTextField(
                controller: _usernameController,
                label: 'Username',
                hint: 'Choose a unique username',
                errorText: _usernameError,
                prefixIcon: Icons.alternate_email,
                suffixIcon: _isCheckingUsername
                    ? null
                    : _isUsernameAvailable && _usernameController.text.length >= 3
                        ? Icons.check_circle
                        : null,
                onChanged: (value) {
                  _checkUsernameAvailability(value);
                },
              ),
              if (_isCheckingUsername)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        ),
                      ),
                      AppSpacing.horizontalSm,
                      Text(
                        'Checking availability...',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              AppSpacing.verticalMd,
              Text(
                'Your username will be visible to other users and used for sending/receiving tokens.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const Spacer(),
              AppButton(
                text: 'Complete Setup',
                isLoading: _isLoading,
                onPressed: _canContinue ? _onContinue : null,
              ),
              AppSpacing.verticalLg,
            ],
          ),
        ),
      ),
    );
  }
}
