import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../../core/di/injection.dart';
import '../../../data/datasources/remote/media_upload_datasource.dart';
import '../../../domain/entities/message.dart';
import '../../theme/app_colors.dart';

/// Inline video message player for the message bubble.
///
/// Shows an encrypted thumbnail as poster with a play button overlay.
/// On tap, downloads + decrypts the video and plays it inline.
class VideoMessagePlayer extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VideoMessagePlayer({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  State<VideoMessagePlayer> createState() => _VideoMessagePlayerState();
}

class _VideoMessagePlayerState extends State<VideoMessagePlayer> {
  Uint8List? _thumbnailBytes;
  bool _isLoadingThumb = true;
  bool _isLoadingVideo = false;
  bool _isPlaying = false;
  bool _hasError = false; // Fix #13: track error state for retry
  VideoPlayerController? _videoController;
  File? _tempVideoFile;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    // Fix #9: Delete temp file synchronously in dispose (fire-and-forget)
    _tempVideoFile?.delete().ignore();
    super.dispose();
  }

  Future<void> _loadThumbnail() async {
    final media = widget.message.media;
    if (media == null) return;

    try {
      final thumbUrl = media.thumbnailUrl ?? media.url;
      final thumbKey = media.thumbKey ?? media.mediaKey;

      // Fix #5: Check for empty URL
      if (thumbUrl.isEmpty) {
        if (mounted) setState(() => _isLoadingThumb = false);
        return;
      }

      if (thumbKey != null && thumbKey.isNotEmpty) {
        final datasource = getIt<MediaUploadDatasource>();
        final bytes = await datasource.downloadAndDecrypt(
          url: thumbUrl,
          mediaKeyBase64: thumbKey,
        );
        if (mounted) setState(() { _thumbnailBytes = bytes; _isLoadingThumb = false; });
      } else {
        if (mounted) setState(() => _isLoadingThumb = false);
      }
    } catch (e) {
      // Fix #14: Log thumbnail download errors
      debugPrint('VideoMessagePlayer: thumbnail load failed: $e');
      if (mounted) setState(() => _isLoadingThumb = false);
    }
  }

  Future<void> _playVideo() async {
    if (_isLoadingVideo) return;

    final media = widget.message.media;
    // Fix #2: Null-safe check instead of force-unwrap
    if (media == null || media.mediaKey == null || media.mediaKey!.isEmpty) {
      debugPrint('VideoMessagePlayer: missing media or mediaKey');
      if (mounted) setState(() => _hasError = true);
      return;
    }

    setState(() {
      _isLoadingVideo = true;
      _hasError = false;
    });

    try {
      final datasource = getIt<MediaUploadDatasource>();

      // Download and decrypt
      final bytes = await datasource.downloadAndDecrypt(
        url: media.url,
        mediaKeyBase64: media.mediaKey!,
      );

      // Fix #16: Guard async writes with mounted check
      if (!mounted) return;

      // Write to temp file
      final dir = await getTemporaryDirectory();
      final tempFile = File('${dir.path}/video_${widget.message.id}.mp4');
      await tempFile.writeAsBytes(bytes);

      // Fix #16: Re-check mounted after async write
      if (!mounted) {
        tempFile.delete().ignore();
        return;
      }

      _tempVideoFile = tempFile;

      // Initialize player
      _videoController = VideoPlayerController.file(tempFile)
        ..setLooping(true);
      await _videoController!.initialize();
      await _videoController!.play();

      if (mounted) {
        setState(() {
          _isPlaying = true;
          _isLoadingVideo = false;
        });
      }
    } catch (e) {
      // Fix #14: Log video playback errors
      debugPrint('VideoMessagePlayer: playVideo failed: $e');
      if (mounted) {
        setState(() {
          _isLoadingVideo = false;
          _hasError = true;
        });
      }
    }
  }

  void _togglePlayPause() {
    final controller = _videoController;
    if (controller == null) return;

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString();
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.message.media;
    final duration = media?.duration ?? 0;

    return GestureDetector(
      // Fix #13: On error, tap retries the video download
      onTap: _hasError
          ? _playVideo
          : (_isPlaying ? _togglePlayPause : _playVideo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Video or thumbnail
              if (_isPlaying && _videoController != null)
                FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: _videoController!.value.size.width,
                    height: _videoController!.value.size.height,
                    child: VideoPlayer(_videoController!),
                  ),
                )
              else if (_thumbnailBytes != null)
                Image.memory(_thumbnailBytes!, fit: BoxFit.cover)
              else if (_isLoadingThumb)
                Container(
                  color: AppColors.chatSurface,
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else
                Container(
                  color: AppColors.chatSurface,
                  child: const Icon(Icons.videocam, size: 40, color: AppColors.textHint),
                ),

              // Play button / loading / error overlay (when not playing)
              if (!_isPlaying)
                Center(
                  child: _isLoadingVideo
                      // Fix #15: Show "Downloading..." text during video download
                      ? const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(height: 8),
                            Text(
                              'Downloading…',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          // Fix #13: Show error icon with retry hint
                          child: Icon(
                            _hasError ? Icons.refresh : Icons.play_arrow,
                            color: _hasError ? AppColors.error : Colors.white,
                            size: 32,
                          ),
                        ),
                ),

              // Pause indicator (when playing but paused)
              if (_isPlaying &&
                  _videoController != null &&
                  !_videoController!.value.isPlaying)
                Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),

              // Duration label (bottom-right)
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.videocam, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(duration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
