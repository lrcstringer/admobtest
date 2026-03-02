import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../theme/app_colors.dart';

/// Result returned when a voice recording completes.
class VoiceRecordingResult {
  final File file;
  final int durationSeconds;

  const VoiceRecordingResult({required this.file, required this.durationSeconds});
}

/// Full-screen voice message recorder with animated microphone,
/// progress ring, and review/send flow.
///
/// Matches the [VideoMessageRecorder] UI for visual consistency.
class VoiceRecorderWidget extends StatefulWidget {
  final ValueChanged<VoiceRecordingResult> onRecordingComplete;
  final VoidCallback onCancel;

  const VoiceRecorderWidget({
    super.key,
    required this.onRecordingComplete,
    required this.onCancel,
  });

  @override
  State<VoiceRecorderWidget> createState() => _VoiceRecorderWidgetState();
}

enum _RecorderPhase { initializing, ready, recording, review }

class _VoiceRecorderWidgetState extends State<VoiceRecorderWidget>
    with TickerProviderStateMixin {
  static const _maxSeconds = 300; // 5 minutes
  static const _maxFileBytes = 5 * 1024 * 1024;
  static const _warningSeconds = 250; // 4:10
  static const _criticalSeconds = 290; // 4:50

  // Recording
  final AudioRecorder _recorder = AudioRecorder();
  Timer? _timer;
  int _elapsedSeconds = 0;
  String? _filePath;
  _RecorderPhase _phase = _RecorderPhase.initializing;
  String? _errorMessage;

  // Review
  AudioPlayer? _reviewPlayer;
  StreamSubscription? _reviewStateSub;
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
    _checkPermission();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _pulseController.dispose();
    _recorder.dispose();
    _reviewStateSub?.cancel();
    _reviewPlayer?.dispose();
    super.dispose();
  }

  // ===========================================================================
  // PERMISSION
  // ===========================================================================

  Future<void> _checkPermission() async {
    try {
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        widget.onCancel();
        return;
      }
      if (mounted) setState(() => _phase = _RecorderPhase.ready);
    } catch (e) {
      if (mounted) setState(() => _errorMessage = 'Microphone error: $e');
    }
  }

  // ===========================================================================
  // RECORDING
  // ===========================================================================

  Future<void> _startRecording() async {
    if (_phase != _RecorderPhase.ready) return;
    setState(() => _phase = _RecorderPhase.recording);
    try {
      final tempDir = await getTemporaryDirectory();
      _filePath =
          '${tempDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: _filePath!,
      );
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

    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Could not start recording: $e';
          _phase = _RecorderPhase.ready;
        });
      }
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    _pulseController.stop();
    _progressController.stop();

    try {
      HapticFeedback.lightImpact();
      final path = await _recorder.stop();

      if (path == null || path.isEmpty) {
        setState(() {
          _errorMessage = 'Recording failed';
          _phase = _RecorderPhase.ready;
        });
        return;
      }

      final file = File(path);
      if (!file.existsSync()) {
        setState(() {
          _errorMessage = 'Recording file not found';
          _phase = _RecorderPhase.ready;
        });
        return;
      }

      if (_elapsedSeconds < 1) {
        await file.delete();
        setState(() => _phase = _RecorderPhase.ready);
        return;
      }

      final fileSize = await file.length();
      if (fileSize > _maxFileBytes) {
        await file.delete();
        setState(() {
          _errorMessage =
              'Recording too large (${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB). '
              'Try a shorter recording.';
          _phase = _RecorderPhase.ready;
        });
        return;
      }

      // Set up review player (don't auto-play — let user decide)
      _reviewPlayer = AudioPlayer();
      await _reviewPlayer!.setFilePath(path);
      await _reviewPlayer!.setLoopMode(LoopMode.off);

      _reviewStateSub?.cancel();
      _reviewStateSub = _reviewPlayer!.playerStateStream.listen((state) {
        if (!mounted) return;
        setState(() => _isReviewPlaying = state.playing);
      });

      if (mounted) setState(() => _phase = _RecorderPhase.review);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Recording failed: $e';
          _phase = _RecorderPhase.ready;
        });
      }
    }
  }

  // ===========================================================================
  // ACTIONS
  // ===========================================================================

  void _retake() {
    _reviewStateSub?.cancel();
    _reviewStateSub = null;
    _reviewPlayer?.dispose();
    _reviewPlayer = null;
    _isReviewPlaying = false;

    if (_filePath != null) {
      File(_filePath!).delete().ignore();
    }
    _filePath = null;
    _elapsedSeconds = 0;
    _progressController.reset();
    _errorMessage = null;
    setState(() => _phase = _RecorderPhase.ready);
  }

  void _send() {
    if (_filePath == null) return;

    final file = File(_filePath!);
    if (!file.existsSync()) return;

    _reviewStateSub?.cancel();
    _reviewStateSub = null;
    _reviewPlayer?.stop();
    _reviewPlayer?.dispose();
    _reviewPlayer = null;

    widget.onRecordingComplete(VoiceRecordingResult(
      file: file,
      durationSeconds: _elapsedSeconds,
    ));

    // Prevent cleanup in dispose — file is now owned by caller
    _filePath = null;
  }

  Future<void> _cancel() async {
    _timer?.cancel();
    try {
      await _recorder.stop();
    } catch (_) {}

    _reviewStateSub?.cancel();
    _reviewStateSub = null;
    _reviewPlayer?.dispose();
    _reviewPlayer = null;

    if (_filePath != null) {
      File(_filePath!).delete().ignore();
    }

    widget.onCancel();
  }

  void _toggleReviewPlayback() {
    final player = _reviewPlayer;
    if (player == null) return;

    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
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
    return '$m:$s / 5:00';
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
            onPressed: _cancel,
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
          ),
          Text(
            'Voice Note',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: 48), // spacer to balance layout
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final previewSize = screenWidth * 0.5;

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

    if (_phase == _RecorderPhase.review) {
      return SizedBox(
        width: previewSize,
        height: previewSize,
        child: Center(
          child: GestureDetector(
            onTap: _toggleReviewPlayback,
            child: Container(
              width: previewSize,
              height: previewSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withValues(alpha: 0.08),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.5),
                  width: 3,
                ),
              ),
              child: Icon(
                _isReviewPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 64,
              ),
            ),
          ),
        ),
      );
    }

    // Ready or recording — rounded square mic area with progress ring
    final ringSize = previewSize + 12; // extra for ring stroke
    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Progress ring tracing the rounded-rect edges (only while recording)
          if (_phase == _RecorderPhase.recording)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _progressController,
                builder: (_, __) => CustomPaint(
                  painter: _RoundedRectProgressPainter(
                    progress: _progressController.value,
                    color: _progressColor,
                    strokeWidth: 6,
                    borderRadius: 18,
                  ),
                ),
              ),
            ),
          // Microphone rounded square
          Container(
            width: previewSize,
            height: previewSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withValues(alpha: 0.08),
              border: Border.all(
                color: _phase == _RecorderPhase.recording
                    ? _progressColor.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.mic,
              color: Colors.white,
              size: 80,
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
            _ActionButton(
              onTap: _retake,
              icon: Icons.refresh,
              label: 'Retake',
              color: Colors.white,
              filled: false,
            ),
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

    if (_phase == _RecorderPhase.initializing) {
      return const SizedBox(height: 80);
    }

    // Ready or recording — show record/stop button
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
// ROUNDED-RECT PROGRESS PAINTER — traces the box edges from top-center clockwise
// =============================================================================

class _RoundedRectProgressPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0
  final Color color;
  final double strokeWidth;
  final double borderRadius;

  _RoundedRectProgressPainter({
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
      ..color = Colors.white.withValues(alpha: 0.12)
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

    // Draw the progress arc
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
  bool shouldRepaint(covariant _RoundedRectProgressPainter oldDelegate) =>
      progress != oldDelegate.progress || color != oldDelegate.color;
}
