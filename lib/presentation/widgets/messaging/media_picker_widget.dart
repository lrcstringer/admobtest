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

/// Media selection widget for attaching images and documents.
///
/// Shows as a bottom sheet with camera, gallery, and document options.
class MediaPickerWidget extends StatelessWidget {
  final ValueChanged<MediaPickerResult> onMediaSelected;

  const MediaPickerWidget({
    super.key,
    required this.onMediaSelected,
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
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 16,
              runSpacing: 16,
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
  final IconData? icon;
  final String? imageAsset;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MediaOption({
    this.icon,
    this.imageAsset,
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
            child: imageAsset != null
                ? ClipOval(
                    child: Image.asset(
                      imageAsset!,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(icon, color: color, size: 28),
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

/// Shows the media picker (Camera, Gallery, Document) as a bottom sheet.
void showMediaPicker(
  BuildContext context, {
  required ValueChanged<MediaPickerResult> onMediaSelected,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => MediaPickerWidget(
      onMediaSelected: onMediaSelected,
    ),
  );
}

/// Action picker widget for notes, calls, gifts, and tokens.
///
/// Shows as a bottom sheet from the + button in the message input bar.
/// Layout: top row = notes (async), bottom row = calls (live) + actions.
class ActionPickerWidget extends StatelessWidget {
  final VoidCallback? onVoiceNoteRequested;
  final VoidCallback? onVideoNoteRequested;
  final VoidCallback? onVoiceCallRequested;
  final VoidCallback? onVideoCallRequested;
  final VoidCallback? onGiftRequested;
  final VoidCallback? onGroupGiftRequested;
  final VoidCallback? onTokenAction;

  const ActionPickerWidget({
    super.key,
    this.onVoiceNoteRequested,
    this.onVideoNoteRequested,
    this.onVoiceCallRequested,
    this.onVideoCallRequested,
    this.onGiftRequested,
    this.onGroupGiftRequested,
    this.onTokenAction,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              'More',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 16,
              runSpacing: 16,
              children: [
                // Row 1: Voice Note, Video Note, Send Instant Tokens, Sasaza
                if (onVoiceNoteRequested != null)
                  _MediaOption(
                    icon: Icons.mic,
                    label: 'Voice Note',
                    color: AppColors.primary,
                    onTap: () {
                      Navigator.pop(context);
                      onVoiceNoteRequested!();
                    },
                  ),
                if (onVideoNoteRequested != null)
                  _MediaOption(
                    icon: Icons.videocam,
                    label: 'Video Note',
                    color: AppColors.purple,
                    onTap: () {
                      Navigator.pop(context);
                      onVideoNoteRequested!();
                    },
                  ),
                if (onTokenAction != null)
                  _MediaOption(
                    icon: Icons.attach_money,
                    label: 'Send Instant\nTokens',
                    color: AppColors.accent,
                    onTap: () {
                      Navigator.pop(context);
                      onTokenAction!();
                    },
                  ),
                if (onGiftRequested != null)
                  _MediaOption(
                    imageAsset: 'assets/images/sasaza.png',
                    label: 'Sasaza',
                    color: AppColors.gold,
                    onTap: () {
                      Navigator.pop(context);
                      onGiftRequested!();
                    },
                  ),
                if (onGroupGiftRequested != null)
                  _MediaOption(
                    icon: Icons.card_giftcard,
                    label: 'Group\nSasaza',
                    color: AppColors.secondary,
                    onTap: () {
                      Navigator.pop(context);
                      onGroupGiftRequested!();
                    },
                  ),
                // Row 2: Voice Call, Video Call
                if (onVoiceCallRequested != null)
                  _MediaOption(
                    icon: Icons.phone,
                    label: 'Voice Call',
                    color: AppColors.success,
                    onTap: () {
                      Navigator.pop(context);
                      onVoiceCallRequested!();
                    },
                  ),
                if (onVideoCallRequested != null)
                  _MediaOption(
                    icon: Icons.video_call,
                    label: 'Video Call',
                    color: AppColors.secondary,
                    onTap: () {
                      Navigator.pop(context);
                      onVideoCallRequested!();
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

/// Shows the action picker as a bottom sheet.
void showActionPicker(
  BuildContext context, {
  VoidCallback? onVoiceNoteRequested,
  VoidCallback? onVideoNoteRequested,
  VoidCallback? onVoiceCallRequested,
  VoidCallback? onVideoCallRequested,
  VoidCallback? onGiftRequested,
  VoidCallback? onGroupGiftRequested,
  VoidCallback? onTokenAction,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => ActionPickerWidget(
      onVoiceNoteRequested: onVoiceNoteRequested,
      onVideoNoteRequested: onVideoNoteRequested,
      onVoiceCallRequested: onVoiceCallRequested,
      onVideoCallRequested: onVideoCallRequested,
      onGiftRequested: onGiftRequested,
      onGroupGiftRequested: onGroupGiftRequested,
      onTokenAction: onTokenAction,
    ),
  );
}
