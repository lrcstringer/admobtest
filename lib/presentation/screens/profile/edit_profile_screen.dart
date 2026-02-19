import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../core/security/step_up_auth_service.dart';
import '../../../data/datasources/remote/media_upload_datasource.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _displayNameController;
  late final TextEditingController _cityController;
  String? _selectedGender;
  String? _selectedProvince;
  DateTime? _dateOfBirth;
  bool _isLoading = false;
  bool _isUploadingAvatar = false;
  String? _pendingAvatarUrl;

  final List<String> _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];
  final List<String> _provinces = [
    'Eastern Cape',
    'Free State',
    'Gauteng',
    'KwaZulu-Natal',
    'Limpopo',
    'Mpumalanga',
    'North West',
    'Northern Cape',
    'Western Cape',
  ];

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthBloc>().state.user;
    _firstNameController = TextEditingController(text: user?.profile?.firstName);
    _lastNameController = TextEditingController(text: user?.profile?.lastName);
    _displayNameController = TextEditingController(text: user?.displayName ?? '');
    _cityController = TextEditingController(text: user?.profile?.city);
    _selectedGender = user?.profile?.gender;
    _selectedProvince = user?.profile?.province;
    _dateOfBirth = user?.profile?.dateOfBirth;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _displayNameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Edit Profile'),
      body: WaveBackground(
        child: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar section
              Center(
                child: GestureDetector(
                  onTap: _pickAndUploadAvatar,
                  child: Stack(
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final user = state.user;
                          final avatarUrl = _pendingAvatarUrl ?? user?.profile?.avatarUrl;
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.primary,
                            backgroundImage: avatarUrl != null
                                ? NetworkImage(avatarUrl)
                                : null,
                            child: _isUploadingAvatar
                                ? const CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2)
                                : avatarUrl == null
                                    ? Text(
                                        user?.initials ?? 'U',
                                        style: const TextStyle(
                                          fontSize: 32,
                                          color: Colors.white,
                                        ),
                                      )
                                    : null,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.verticalXl,

              // Display Name
              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a display name';
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMd,

              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMd,

              // Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMd,

              // Gender
              DropdownButtonFormField<String>(
                // ignore: deprecated_member_use
                value: _genders.map((g) => g.toLowerCase()).contains(_selectedGender)
                    ? _selectedGender
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.wc),
                ),
                items: _genders
                    .map((gender) => DropdownMenuItem(
                          value: gender.toLowerCase(),
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedGender = value);
                },
              ),
              AppSpacing.verticalMd,

              // Date of Birth
              InkWell(
                onTap: _selectDateOfBirth,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _dateOfBirth != null
                        ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
                        : 'Select date',
                    style: TextStyle(
                      color: _dateOfBirth != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              AppSpacing.verticalMd,

              // Province
              DropdownButtonFormField<String>(
                // ignore: deprecated_member_use
                value: _provinces.contains(_selectedProvince) ? _selectedProvince : null,
                decoration: const InputDecoration(
                  labelText: 'Province',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                items: _provinces
                    .map((province) => DropdownMenuItem(
                          value: province,
                          child: Text(province),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedProvince = value);
                },
              ),
              AppSpacing.verticalMd,

              // City
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City/Town (Optional)',
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              AppSpacing.verticalXl,

              // Save Button
              AppButton(
                text: 'Save Changes',
                onPressed: _saveProfile,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(now.year - 18),
      firstDate: DateTime(1920),
      lastDate: DateTime(now.year - 13), // Minimum age 13
    );
    if (picked != null) {
      setState(() => _dateOfBirth = picked);
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return;

    final user = context.read<AuthBloc>().state.user;
    if (user == null) return;

    setState(() => _isUploadingAvatar = true);

    try {
      final file = File(picked.path);

      final datasource = getIt<MediaUploadDatasource>();
      final url = await datasource.uploadAvatar(
        imageFile: file,
        userId: user.id,
      );

      if (mounted) {
        setState(() {
          _pendingAvatarUrl = url;
          _isUploadingAvatar = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploadingAvatar = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload avatar: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    // Step-up auth guard for profile changes
    final stepUpService = getIt<StepUpAuthService>();
    final stepUpResult = stepUpService.evaluateRequired(
      actionType: 'profile_change',
    );

    if (stepUpResult == StepUpResult.biometricVerified) {
      final biometricResult = await stepUpService.performBiometricStepUp();
      if (biometricResult == StepUpResult.cancelled ||
          biometricResult == StepUpResult.failed) {
        return;
      }
      if (biometricResult == StepUpResult.otpRequired) {
        if (!mounted) return;
        final otpPassed = await _navigateToStepUpOtp();
        if (otpPassed != true) return;
      }
    } else if (stepUpResult == StepUpResult.otpRequired) {
      final otpPassed = await _navigateToStepUpOtp();
      if (otpPassed != true) return;
    }

    if (!mounted) return;
    setState(() => _isLoading = true);

    final user = context.read<AuthBloc>().state.user;
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final userRepository = getIt<UserRepository>();
      final result = await userRepository.updateProfile(
        userId: user.id,
        displayName: _displayNameController.text.trim(),
        avatarUrl: _pendingAvatarUrl,
        gender: _selectedGender,
        dateOfBirth: _dateOfBirth,
        province: _selectedProvince,
        city: _cityController.text.isNotEmpty ? _cityController.text : null,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      );

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.displayMessage),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        (updatedUser) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: AppColors.success,
              ),
            );
            // Refresh auth state to get updated user
            context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
            context.pop();
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool?> _navigateToStepUpOtp() {
    final phoneNumber =
        context.read<AuthBloc>().state.user?.phoneNumber ?? '';
    return context.push<bool>(
      '/auth/step-up-otp',
      extra: {
        'phoneNumber': phoneNumber,
        'reason': 'Profile changes require identity verification.',
      },
    );
  }
}
