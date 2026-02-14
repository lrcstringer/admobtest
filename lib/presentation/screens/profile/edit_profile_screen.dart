import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../core/security/step_up_auth_service.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _cityController;
  String? _selectedGender;
  String? _selectedProvince;
  DateTime? _dateOfBirth;
  bool _isLoading = false;

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
    _usernameController = TextEditingController(text: user?.profile?.username);
    _cityController = TextEditingController(text: user?.profile?.city);
    _selectedGender = user?.profile?.gender;
    _selectedProvince = user?.profile?.province;
    _dateOfBirth = user?.profile?.dateOfBirth;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar section
              Center(
                child: Stack(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final user = state.user;
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary,
                          backgroundImage: user?.profile?.avatarUrl != null
                              ? NetworkImage(user!.profile!.avatarUrl!)
                              : null,
                          child: user?.profile?.avatarUrl == null
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
              AppSpacing.verticalXl,

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

              // Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.alternate_email),
                  helperText: '3-20 characters, no spaces',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  if (value.length < 3 || value.length > 20) {
                    return 'Username must be 3-20 characters';
                  }
                  if (value.contains(' ')) {
                    return 'Username cannot contain spaces';
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
        displayName: '${_firstNameController.text} ${_lastNameController.text}',
        username: _usernameController.text,
        gender: _selectedGender,
        dateOfBirth: _dateOfBirth,
        province: _selectedProvince,
        city: _cityController.text.isNotEmpty ? _cityController.text : null,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
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
