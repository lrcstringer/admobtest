import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../theme/app_colors.dart';

/// Result returned when the user finishes recording a video message.
class VideoRecordingResult {
  final File videoFile;
  final File thumbnailFile;
  final int durationSeconds;

  const VideoRecordingResult({
    required this.videoFile,
    required this.thumbnailFile,
    required this.durationSeconds,
  });
}

/// Full-screen video message recorder with square camera preview,
/// animated progress ring, and review/send flow.
class VideoMessageRecorder extends StatefulWidget {
  final ValueChanged<VideoRecordingResult> onRecordingComplete;
  final VoidCallback onCancel;

  const VideoMessageRecorder({
    super.key,
    required this.onRecordingComplete,
    required this.onCancel,
  });

  @override
  State<VideoMessageRecorder> createState() => _VideoMessageRecorderState();
}

enum _RecorderPhase { initializing, preview, recording, processing, review }

class _VideoMessageRecorderState extends State<VideoMessageRecorder>
    with TickerProviderStateMixin {
  static const _maxSeconds = 60;
  static const _maxFileBytes = 5 * 1024 * 1024;
  static const _warningSeconds = 50;
  static const _criticalSeconds = 55;

  // Camera
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isFrontCamera = true;
  _RecorderPhase _phase = _RecorderPhase.initializing;

  // Recording
  Timer? _timer;
  int _elapsedSeconds = 0;

  // Processing / review
  File? _rawVideoFile;
  File? _compressedFile;
  File? _thumbnailFile;
  String? _errorMessage;
  VideoPlayerController? _reviewController;
  bool _isReviewPlaying = false;

  // Animations
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: _maxSeconds),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _initCamera();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _pulseController.dispose();
    _cameraController?.dispose();
    _reviewController?.removeListener(_onReviewPlayerUpdate);
    _reviewController?.dispose();
    // Clean up temp files if not sent
    _rawVideoFile?.delete().ignore();
    super.dispose();
  }

  // ===========================================================================
  // CAMERA
  // ===========================================================================

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() => _errorMessage = 'No cameras available');
        return;
      }
      await _setupCamera(_frontCamera ?? _cameras.first);
    } catch (e) {
      if (mounted) setState(() => _errorMessage = 'Camera error: $e');
    }
  }

  CameraDescription? get _frontCamera => _cameras.cast<CameraDescription?>().firstWhere(
        (c) => c!.lensDirection == CameraLensDirection.front,
        orElse: () => null,
      );

  CameraDescription? get _backCamera => _cameras.cast<CameraDescription?>().firstWhere(
        (c) => c!.lensDirection == CameraLensDirection.back,
        orElse: () => null,
      );

  Future<void> _setupCamera(CameraDescription camera) async {
    _cameraController?.dispose();
    final controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: true,
    );
    _cameraController = controller;

    try {
      await controller.initialize();
      if (mounted) setState(() => _phase = _RecorderPhase.preview);
    } catch (e) {
      if (mounted) setState(() => _errorMessage = 'Camera init failed: $e');
    }
  }

  Future<void> _flipCamera() async {
    if (_phase == _RecorderPhase.recording) return;
    final target = _isFrontCamera ? _backCamera : _frontCamera;
    if (target == null) return;
    _isFrontCamera = !_isFrontCamera;
    setState(() => _phase = _RecorderPhase.initializing);
    await _setupCamera(target);
  }

  // ===========================================================================
  // RECORDING
  // ===========================================================================

  Future<void> _startRecording() async {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) return;
    if (controller.value.isRecordingVideo) return;

    try {
      await controller.startVideoRecording();
      HapticFeedback.mediumImpact();

      _elapsedSeconds = 0;
      _progressController.forward(from: 0);
      _pulseController.repeat(reverse: true);

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() => _elapsedSeconds++);
        if (_elapsedSeconds >= _maxSeconds) {
          _stopRecording();
        }
      });

      setState(() => _phase = _RecorderPhase.recording);
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Could not start recording: $e');
      }
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    _pulseController.stop();
    _progressController.stop();

    final controller = _cameraController;
    if (controller == null || !controller.value.isRecordingVideo) return;

    try {
      HapticFeedback.lightImpact();
      final xFile = await controller.stopVideoRecording();
      _rawVideoFile = File(xFile.path);
      setState(() => _phase = _RecorderPhase.processing);
      await _compressVideo();
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Recording failed: $e';
          _phase = _RecorderPhase.preview;
        });
      }
    }
  }

  // ===========================================================================
  // COMPRESSION
  // ===========================================================================

  Future<void> _compressVideo() async {
    final rawFile = _rawVideoFile;
    if (rawFile == null) return;

    try {
      final dir = await getTemporaryDirectory();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final outputPath = '${dir.path}/vmsg_$ts.mp4';
      final thumbPath = '${dir.path}/vmsg_thumb_$ts.jpg';

      // Compress to 480×480 square, mpeg4 video (always available in min FFmpeg
      // build — libx264 is NOT included in ffmpeg_kit_flutter_new_min), 64k audio
      final compressCmd = '-i "${rawFile.path}" '
          '-vf "crop=min(iw\\,ih):min(iw\\,ih),scale=480:480" '
          '-c:v mpeg4 -b:v 600k '
          '-c:a aac -b:a 64k -movflags +faststart '
          '-y "$outputPath"';

      final session = await FFmpegKit.execute(compressCmd);
      final returnCode = await session.getReturnCode();
      if (!ReturnCode.isSuccess(returnCode)) {
        final logs = await session.getAllLogsAsString();
        debugPrint('VideoRecorder: FFmpeg compression failed: $logs');
        throw Exception('Compression failed');
      }

      final compressed = File(outputPath);
      final size = await compressed.length();
      if (size > _maxFileBytes) {
        await compressed.delete();
        throw Exception(
            'Video too large (${(size / (1024 * 1024)).toStringAsFixed(1)} MB). '
            'Try a shorter recording.');
      }

      // Generate thumbnail from first frame
      final thumbCmd = '-i "$outputPath" '
          '-ss 00:00:00.5 -vframes 1 '
          '-vf "scale=480:480" '
          '-y "$thumbPath"';
      await FFmpegKit.execute(thumbCmd);

      _compressedFile = compressed;
      _thumbnailFile = File(thumbPath);

      // Set up review player (don't auto-play — let user decide)
      _reviewController = VideoPlayerController.file(compressed)
        ..setLooping(false);
      await _reviewController!.initialize();

      _reviewController!.addListener(_onReviewPlayerUpdate);

      if (mounted) setState(() => _phase = _RecorderPhase.review);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _phase = _RecorderPhase.preview;
        });
      }
    }
  }

  // ===========================================================================
  // ACTIONS
  // ===========================================================================

  void _onReviewPlayerUpdate() {
    if (!mounted) return;
    final controller = _reviewController;
    if (controller == null) return;
    final playing = controller.value.isPlaying;
    if (playing != _isReviewPlaying) {
      setState(() => _isReviewPlaying = playing);
    }
  }

  void _toggleReviewPlayback() {
    final controller = _reviewController;
    if (controller == null) return;

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      // If playback finished, seek to start before playing again
      if (controller.value.position >= controller.value.duration) {
        controller.seekTo(Duration.zero);
      }
      controller.play();
    }
  }

  void _retake() {
    _reviewController?.removeListener(_onReviewPlayerUpdate);
    _reviewController?.dispose();
    _reviewController = null;
    _compressedFile?.delete().ignore();
    _thumbnailFile?.delete().ignore();
    _compressedFile = null;
    _thumbnailFile = null;
    _rawVideoFile?.delete().ignore();
    _rawVideoFile = null;
    _elapsedSeconds = 0;
    _progressController.reset();
    setState(() => _phase = _RecorderPhase.preview);
  }

  void _send() {
    if (_compressedFile == null || _thumbnailFile == null) return;

    _reviewController?.pause();
    _reviewController?.removeListener(_onReviewPlayerUpdate);
    _reviewController?.dispose();
    _reviewController = null;

    widget.onRecordingComplete(VideoRecordingResult(
      videoFile: _compressedFile!,
      thumbnailFile: _thumbnailFile!,
      durationSeconds: _elapsedSeconds,
    ));
    // Prevent cleanup in dispose — files are now owned by caller
    _compressedFile = null;
    _thumbnailFile = null;
    _rawVideoFile = null;
  }

  // ===========================================================================
  // UI HELPERS
  // ===========================================================================

  Color get _progressColor {
    if (_elapsedSeconds >= _criticalSeconds) return AppColors.error;
    if (_elapsedSeconds >= _warningSeconds) return AppColors.warning;
    return AppColors.success;
  }

  String get _timerText {
    final m = (_elapsedSeconds ~/ 60).toString();
    final s = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s / 1:00';
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Frosted glass background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withValues(alpha: 0.7)),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                const Spacer(),
                _buildCenterContent(),
                const SizedBox(height: 16),
                _buildTimerLabel(),
                const Spacer(),
                _buildBottomControls(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: widget.onCancel,
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
          ),
          Text(
            'Video Message',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (_phase == _RecorderPhase.preview ||
              _phase == _RecorderPhase.initializing)
            IconButton(
              onPressed: _flipCamera,
              icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 28),
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final previewSize = screenWidth * 0.78;

    if (_errorMessage != null) {
      return SizedBox(
        width: previewSize,
        height: previewSize,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: AppColors.error, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (_phase == _RecorderPhase.initializing) {
      return SizedBox(
        width: previewSize,
        height: previewSize,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    if (_phase == _RecorderPhase.processing) {
      return SizedBox(
        width: previewSize,
        height: previewSize,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 16),
              Text(
                'Compressing...',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_phase == _RecorderPhase.review && _reviewController != null) {
      return GestureDetector(
        onTap: _toggleReviewPlayback,
        child: SizedBox(
          width: previewSize,
          height: previewSize,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: VideoPlayer(_reviewController!),
                ),
                // Play/pause overlay
                if (!_isReviewPlaying)
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    // Preview or recording — show camera with progress ring
    return SizedBox(
      width: previewSize + 12, // extra for ring stroke
      height: previewSize + 12,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Progress ring (only visible while recording)
          if (_phase == _RecorderPhase.recording)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _progressController,
                builder: (_, __) => CustomPaint(
                  painter: _ProgressRingPainter(
                    progress: _progressController.value,
                    color: _progressColor,
                    strokeWidth: 6,
                    borderRadius: 18,
                  ),
                ),
              ),
            ),
          // Camera preview
          SizedBox(
            width: previewSize,
            height: previewSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _cameraController != null &&
                      _cameraController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: 1.0,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: _cameraController!.value.previewSize?.height ?? 480,
                          height: _cameraController!.value.previewSize?.width ?? 480,
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    )
                  : Container(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerLabel() {
    if (_phase != _RecorderPhase.recording && _phase != _RecorderPhase.review) {
      return const SizedBox(height: 20);
    }

    return Text(
      _phase == _RecorderPhase.review
          ? '${(_elapsedSeconds ~/ 60).toString()}:${(_elapsedSeconds % 60).toString().padLeft(2, '0')}'
          : _timerText,
      style: TextStyle(
        color: _phase == _RecorderPhase.recording ? _progressColor : Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  Widget _buildBottomControls() {
    if (_phase == _RecorderPhase.review) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Retake
            _ActionButton(
              onTap: _retake,
              icon: Icons.refresh,
              label: 'Retake',
              color: Colors.white,
              filled: false,
            ),
            // Send
            _ActionButton(
              onTap: _send,
              icon: Icons.send,
              label: 'Send',
              color: AppColors.success,
              filled: true,
            ),
          ],
        ),
      );
    }

    if (_phase == _RecorderPhase.processing ||
        _phase == _RecorderPhase.initializing) {
      return const SizedBox(height: 80);
    }

    // Preview or recording — show record/stop button
    final isRecording = _phase == _RecorderPhase.recording;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: isRecording ? _stopRecording : _startRecording,
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (_, child) => Transform.scale(
              scale: isRecording ? _pulseAnimation.value : 1.0,
              child: child,
            ),
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              padding: const EdgeInsets.all(4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: isRecording ? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: isRecording ? BorderRadius.circular(8) : null,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isRecording ? 'Tap to stop' : 'Tap to record',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// ACTION BUTTON (Retake / Send)
// =============================================================================

class _ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final Color color;
  final bool filled;

  const _ActionButton({
    required this.onTap,
    required this.icon,
    required this.label,
    required this.color,
    required this.filled,
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
              color: filled ? color : Colors.transparent,
              shape: BoxShape.circle,
              border: filled ? null : Border.all(color: color, width: 2),
            ),
            child: Icon(
              icon,
              color: filled ? Colors.white : color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// PROGRESS RING PAINTER — rounded-rect ring around the camera preview
// =============================================================================

class _ProgressRingPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0
  final Color color;
  final double strokeWidth;
  final double borderRadius;

  _ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Background track
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawRRect(rrect, bgPaint);

    if (progress <= 0) return;

    // Build path starting from top-center, going clockwise around the box
    final r = borderRadius;
    final l = rect.left;
    final t = rect.top;
    final ri = rect.right;
    final b = rect.bottom;
    final cx = rect.center.dx;

    final path = Path()
      ..moveTo(cx, t)
      ..lineTo(ri - r, t) // top edge → right
      ..arcToPoint(Offset(ri, t + r), radius: Radius.circular(r))
      ..lineTo(ri, b - r) // right edge ↓
      ..arcToPoint(Offset(ri - r, b), radius: Radius.circular(r))
      ..lineTo(l + r, b) // bottom edge ← left
      ..arcToPoint(Offset(l, b - r), radius: Radius.circular(r))
      ..lineTo(l, t + r) // left edge ↑
      ..arcToPoint(Offset(l + r, t), radius: Radius.circular(r))
      ..lineTo(cx, t); // top edge ← back to center

    final metric = path.computeMetrics().first;
    final progressPath = metric.extractPath(0, metric.length * progress);

    // Draw the progress arc along the box edges
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(progressPath, progressPaint);

    // Bright dot at leading edge
    final tangent = metric.getTangentForOffset(metric.length * progress);
    if (tangent != null) {
      canvas.drawCircle(
        tangent.position,
        strokeWidth * 1.2,
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      progress != oldDelegate.progress || color != oldDelegate.color;
}
