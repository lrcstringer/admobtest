import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_colors.dart';

/// Result from the media picker.
class MediaPickerResult {
  final File file;
  final String mediaType; // 'image', 'voice', or MIME type for documents
  final String? caption;

  const MediaPickerResult({
    required this.file,
    required this.mediaType,
    this.caption,
  });
}

/// Allowed document extensions for the file picker.
const _documentExtensions = [
  'pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'csv', 'zip',
];

/// Media selection widget for attaching images, documents, or starting voice
/// recording in message input.
///
/// Shows as a bottom sheet with camera, gallery, document, and voice options.
class MediaPickerWidget extends StatelessWidget {
  final ValueChanged<MediaPickerResult> onMediaSelected;
  final VoidCallback? onVoiceRequested;
  final VoidCallback? onVideoRequested;

  const MediaPickerWidget({
    super.key,
    required this.onMediaSelected,
    this.onVoiceRequested,
    this.onVideoRequested,
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

  Future<void> _pickDocument(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _documentExtensions,
      allowMultiple: false,
    );
    if (result != null &&
        result.files.isNotEmpty &&
        result.files.first.path != null &&
        context.mounted) {
      Navigator.pop(context);
      final file = File(result.files.first.path!);
      onMediaSelected(MediaPickerResult(
        file: file,
        mediaType: 'document',
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
              'Attach',
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
                _MediaOption(
                  icon: Icons.description,
                  label: 'Document',
                  color: AppColors.accent,
                  onTap: () => _pickDocument(context),
                ),
                if (onVideoRequested != null)
                  _MediaOption(
                    icon: Icons.videocam,
                    label: 'Video',
                    color: AppColors.purple,
                    onTap: () {
                      Navigator.pop(context);
                      onVideoRequested!();
                    },
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
  VoidCallback? onVideoRequested,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => MediaPickerWidget(
      onMediaSelected: onMediaSelected,
      onVoiceRequested: onVoiceRequested,
      onVideoRequested: onVideoRequested,
    ),
  );
}
