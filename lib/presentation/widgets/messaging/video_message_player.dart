import 'dart:io';
import 'dart:typed_data';

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
    _tempVideoFile?.delete().ignore();
    super.dispose();
  }

  Future<void> _loadThumbnail() async {
    final media = widget.message.media;
    if (media == null) return;

    try {
      final thumbUrl = media.thumbnailUrl ?? media.url;
      final thumbKey = media.thumbKey ?? media.mediaKey;

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
    } catch (_) {
      if (mounted) setState(() => _isLoadingThumb = false);
    }
  }

  Future<void> _playVideo() async {
    if (_isLoadingVideo) return;
    setState(() => _isLoadingVideo = true);

    try {
      final media = widget.message.media!;
      final datasource = getIt<MediaUploadDatasource>();

      // Download and decrypt
      final bytes = await datasource.downloadAndDecrypt(
        url: media.url,
        mediaKeyBase64: media.mediaKey!,
      );

      // Write to temp file
      final dir = await getTemporaryDirectory();
      _tempVideoFile = File('${dir.path}/video_${widget.message.id}.mp4');
      await _tempVideoFile!.writeAsBytes(bytes);

      // Initialize player
      _videoController = VideoPlayerController.file(_tempVideoFile!)
        ..setLooping(true);
      await _videoController!.initialize();
      await _videoController!.play();

      if (mounted) {
        setState(() {
          _isPlaying = true;
          _isLoadingVideo = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingVideo = false);
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
      onTap: _isPlaying ? _togglePlayPause : _playVideo,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 220,
          height: 220,
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

              // Play button overlay (when not playing)
              if (!_isPlaying)
                Center(
                  child: _isLoadingVideo
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
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
