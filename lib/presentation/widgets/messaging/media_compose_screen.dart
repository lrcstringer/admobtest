import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../theme/app_colors.dart';

/// Full-screen compose screen shown after picking media, allowing the user
/// to preview the attachment and optionally add a caption before sending.
///
/// Mimics WhatsApp behaviour: media + caption are sent as a single message
/// and rendered in one bubble on the receiver side.
class MediaComposeScreen extends StatefulWidget {
  final File mediaFile;
  final String mediaType;
  final File? thumbnailFile;
  final int? durationSeconds;

  /// Called when the user taps send.  [caption] is null if the user left
  /// the caption field empty.
  final ValueChanged<String?> onSend;

  const MediaComposeScreen({
    super.key,
    required this.mediaFile,
    required this.mediaType,
    this.thumbnailFile,
    this.durationSeconds,
    required this.onSend,
  });

  @override
  State<MediaComposeScreen> createState() => _MediaComposeScreenState();
}

class _MediaComposeScreenState extends State<MediaComposeScreen> {
  final _captionController = TextEditingController();
  bool _sent = false;

  bool get _isImage =>
      widget.mediaType == 'image' || widget.mediaType.startsWith('image/');

  bool get _isVideo => widget.mediaType.startsWith('video/');

  bool get _isAudio => widget.mediaType.startsWith('audio/');

  bool get _isDocument => !_isImage && !_isVideo && !_isAudio;

  String get _fileName => p.basename(widget.mediaFile.path);

  String get _fileExtension =>
      p.extension(widget.mediaFile.path).replaceFirst('.', '').toUpperCase();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_sent) return;
    _sent = true;

    final caption = _captionController.text.trim();
    widget.onSend(caption.isEmpty ? null : caption);
    Navigator.of(context).pop();
  }

  // ── Preview builders ──────────────────────────────────────────────────

  Widget _buildImagePreview() {
    return Expanded(
      child: Center(
        child: Image.file(
          widget.mediaFile,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildVideoPreview() {
    if (widget.thumbnailFile != null) {
      return Expanded(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.file(widget.thumbnailFile!, fit: BoxFit.contain),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.play_arrow, color: Colors.white, size: 40),
              ),
              if (widget.durationSeconds != null)
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _formatDuration(widget.durationSeconds!),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // No thumbnail available — show placeholder
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.videocam, color: AppColors.purple, size: 40),
            ),
            if (widget.durationSeconds != null) ...[
              const SizedBox(height: 8),
              Text(
                _formatDuration(widget.durationSeconds!),
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAudioPreview() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.mic, color: AppColors.primary, size: 40),
            ),
            if (widget.durationSeconds != null) ...[
              const SizedBox(height: 12),
              Text(
                _formatDuration(widget.durationSeconds!),
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 16),
              ),
            ],
            const SizedBox(height: 8),
            const Text(
              'Voice Note',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentPreview() {
    final iconColor = _documentIconColor;
    final fileSize = widget.mediaFile.lengthSync();

    return Expanded(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.chatSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.chatBubbleTimestamp.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.description, color: iconColor, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                _fileName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '$_fileExtension · ${_formatFileSize(fileSize)}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color get _documentIconColor {
    final ext = p.extension(widget.mediaFile.path).replaceFirst('.', '').toLowerCase();
    switch (ext) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return Colors.green;
      case 'ppt':
      case 'pptx':
        return Colors.orange;
      default:
        return AppColors.textSecondary;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────

  static String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: AppBar(
        backgroundColor: AppColors.chatBackground,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _isImage
              ? 'Photo'
              : _isVideo
                  ? 'Video'
                  : _isAudio
                      ? 'Voice Note'
                      : 'Document',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Media preview
          if (_isImage) _buildImagePreview(),
          if (_isVideo) _buildVideoPreview(),
          if (_isAudio) _buildAudioPreview(),
          if (_isDocument) _buildDocumentPreview(),

          // Caption input + send button
          Container(
            color: AppColors.chatSurface,
            padding: EdgeInsets.only(
              left: 12,
              right: 8,
              top: 8,
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _captionController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    maxLines: 4,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Add a caption...',
                      hintStyle:
                          const TextStyle(color: AppColors.textHint),
                      filled: true,
                      fillColor: AppColors.chatInputField,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: FloatingActionButton(
                    onPressed: _handleSend,
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    child:
                        const Icon(Icons.send, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
