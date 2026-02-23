import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../theme/app_colors.dart';

/// Result returned when a voice recording completes.
class VoiceRecordingResult {
  final File file;
  final int durationSeconds;

  const VoiceRecordingResult({required this.file, required this.durationSeconds});
}

/// Tap-to-toggle voice recorder widget (WeChat style).
///
/// Shows a pulsing red dot, elapsed timer, cancel and send buttons.
/// Auto-stops at 5 minutes. Rejects files > 5 MB.
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

class _VoiceRecorderWidgetState extends State<VoiceRecorderWidget>
    with SingleTickerProviderStateMixin {
  static const _maxDuration = Duration(minutes: 5);
  static const _maxFileBytes = 5 * 1024 * 1024; // 5 MB

  final AudioRecorder _recorder = AudioRecorder();
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRecording = false;
  String? _filePath;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _startRecording();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      widget.onCancel();
      return;
    }

    final tempDir = await getTemporaryDirectory();
    _filePath =
        '${tempDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: _filePath!,
    );

    setState(() => _isRecording = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsedSeconds++);
      if (_elapsedSeconds >= _maxDuration.inSeconds) {
        _sendRecording();
      }
    });
  }

  Future<void> _sendRecording() async {
    if (!_isRecording) return;
    _timer?.cancel();

    final path = await _recorder.stop();
    setState(() => _isRecording = false);

    if (path == null || path.isEmpty) {
      widget.onCancel();
      return;
    }

    final file = File(path);
    if (!file.existsSync()) {
      widget.onCancel();
      return;
    }

    final fileSize = await file.length();
    if (fileSize > _maxFileBytes) {
      await file.delete();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording too large (max 5 MB)')),
        );
      }
      widget.onCancel();
      return;
    }

    if (_elapsedSeconds < 1) {
      await file.delete();
      widget.onCancel();
      return;
    }

    widget.onRecordingComplete(VoiceRecordingResult(
      file: file,
      durationSeconds: _elapsedSeconds,
    ));
  }

  Future<void> _cancelRecording() async {
    _timer?.cancel();
    if (_isRecording) {
      await _recorder.stop();
    }
    setState(() => _isRecording = false);

    if (_filePath != null) {
      try {
        await File(_filePath!).delete();
      } catch (_) {}
    }
    widget.onCancel();
  }

  String get _formattedTime {
    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: [
          // Cancel button
          IconButton(
            onPressed: _cancelRecording,
            icon: const Icon(Icons.close),
            color: AppColors.error,
          ),
          const SizedBox(width: 8),
          // Pulsing red dot
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.error
                      .withValues(alpha: 0.4 + _pulseController.value * 0.6),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          // Timer
          Text(
            _formattedTime,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
          ),
          const Spacer(),
          // Send button
          IconButton.filled(
            onPressed: _sendRecording,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
