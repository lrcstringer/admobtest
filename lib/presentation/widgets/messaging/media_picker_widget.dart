import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_colors.dart';

/// Result from the media picker.
class MediaPickerResult {
  final File file;
  final String mediaType; // 'image' or 'voice'
  final String? caption;

  const MediaPickerResult({
    required this.file,
    required this.mediaType,
    this.caption,
  });
}

/// Media selection widget for attaching images or starting voice recording
/// in message input.
///
/// Shows as a bottom sheet with camera, gallery, and voice options.
class MediaPickerWidget extends StatelessWidget {
  final ValueChanged<MediaPickerResult> onMediaSelected;
  final VoidCallback? onVoiceRequested;

  const MediaPickerWidget({
    super.key,
    required this.onMediaSelected,
    this.onVoiceRequested,
  });

  Future<void> _pickFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null && context.mounted) {
      Navigator.pop(context);
      onMediaSelected(MediaPickerResult(
        file: File(image.path),
        mediaType: 'image',
      ));
    }
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null && context.mounted) {
      Navigator.pop(context);
      onMediaSelected(MediaPickerResult(
        file: File(image.path),
        mediaType: 'image',
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Send Media',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MediaOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  color: AppColors.secondary,
                  onTap: () => _pickFromCamera(context),
                ),
                _MediaOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  color: AppColors.success,
                  onTap: () => _pickFromGallery(context),
                ),
                if (onVoiceRequested != null)
                  _MediaOption(
                    icon: Icons.mic,
                    label: 'Voice',
                    color: AppColors.primary,
                    onTap: () {
                      Navigator.pop(context);
                      onVoiceRequested!();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MediaOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MediaOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

/// Shows the media picker as a bottom sheet.
///
/// Returns a [MediaPickerResult] or null if dismissed.
void showMediaPicker(
  BuildContext context, {
  required ValueChanged<MediaPickerResult> onMediaSelected,
  VoidCallback? onVoiceRequested,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => MediaPickerWidget(
      onMediaSelected: onMediaSelected,
      onVoiceRequested: onVoiceRequested,
    ),
  );
}
