import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/onboarding/onboarding_widgets.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({super.key});

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isLoading = false;
  int _selectedSource = 1; // 0 = gallery, 1 = camera, 2 = remove

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _onSourceSelected(int index) {
    setState(() => _selectedSource = index);

    switch (index) {
      case 0:
        _pickImage(ImageSource.gallery);
        break;
      case 1:
        _pickImage(ImageSource.camera);
        break;
      case 2:
        // Remove selected image
        setState(() => _selectedImage = null);
        break;
    }
  }

  Future<void> _onContinue() async {
    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) return;

    if (_selectedImage == null) {
      context.go('/onboarding/permissions');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Upload image to Firebase Storage
      final userId = authState.user!.id;
      final ref = FirebaseStorage.instance
          .ref()
          .child('avatars')
          .child('$userId.jpg');

      await ref.putFile(
        _selectedImage!,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final downloadUrl = await ref.getDownloadURL();

      // Save avatar URL to user profile
      final userRepo = getIt<UserRepository>();
      final result = await userRepo.updateProfile(
        userId: userId,
        avatarUrl: downloadUrl,
      );

      if (!mounted) return;

      result.fold(
        (failure) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.displayMessage),
              backgroundColor: Colors.red,
            ),
          );
        },
        (_) {
          context.go('/onboarding/permissions');
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _onSkip() {
    context.go('/onboarding/permissions');
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final userName = authState.user?.profile?.displayName ??
        authState.user?.profile?.username ??
        'User';

    return OnboardingScaffold(
      currentPage: 2,
      totalPages: 5,
      showLogo: false,
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          children: [
            AppSpacing.verticalXl,
            // Profile picture placeholder or selected image
            GestureDetector(
              onTap: () => _onSourceSelected(_selectedSource),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: _selectedImage != null
                      ? Colors.transparent
                      : AppColors.accent,
                  borderRadius: BorderRadius.circular(24),
                  image: _selectedImage != null
                      ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _selectedImage == null
                    ? CustomPaint(
                        painter: DashedBorderPainter(
                          color: AppColors.secondary,
                          strokeWidth: 2,
                          gap: 8,
                          borderRadius: 24,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 48,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                      )
                    : null,
              ),
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
            AppSpacing.verticalXl,
            // Source selection icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSourceButton(
                  index: 0,
                  icon: Icons.photo_library_outlined,
                  isSelected: _selectedSource == 0,
                ),
                AppSpacing.horizontalMd,
                _buildSourceButton(
                  index: 1,
                  icon: Icons.camera_alt,
                  isSelected: _selectedSource == 1,
                ),
                AppSpacing.horizontalMd,
                _buildSourceButton(
                  index: 2,
                  icon: _selectedImage != null
                      ? Icons.delete_outline
                      : Icons.image_outlined,
                  isSelected: _selectedSource == 2,
                ),
              ],
            ),
            AppSpacing.verticalXxl,
            // Heading
            Text(
              'Your profile picture',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalMd,
            // Description
            Text(
              'Use your camera or select a\nphoto from your phone to use as\nyour profile picture.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
            ),
            AppSpacing.verticalLg,
            // Skip text
            GestureDetector(
              onTap: _onSkip,
              child: Text(
                'You can skip this step!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
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

  Widget _buildSourceButton({
    required int index,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _onSourceSelected(index),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }
}

/// Custom painter for dashed border
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2,
    this.gap = 5,
    this.borderRadius = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );
    path.addRRect(rrect);

    // Create dashed path
    final dashPath = Path();
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0;
      bool draw = true;

      while (distance < metric.length) {
        final length = draw ? gap * 2 : gap;
        if (draw) {
          dashPath.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      gap != oldDelegate.gap ||
      borderRadius != oldDelegate.borderRadius;
}
