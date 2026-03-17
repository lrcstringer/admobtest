import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/di/injection.dart';
import '../../../core/services/audio_playback_service.dart';
import '../../../domain/entities/message.dart';
import '../../theme/app_colors.dart';

/// Inline voice message player styled to match [VideoMessagePlayer].
///
/// Shows a compact card with play/pause overlay, progress bar, and duration
/// chip — the same visual language used for video message bubbles.
class VoicePlayerWidget extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VoicePlayerWidget({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  State<VoicePlayerWidget> createState() => _VoicePlayerWidgetState();
}

class _VoicePlayerWidgetState extends State<VoicePlayerWidget> {
  final AudioPlaybackService _service = getIt<AudioPlaybackService>();
  late final StreamSubscription<PlayerState> _stateSub;
  late final StreamSubscription<Duration> _posSub;
  late final StreamSubscription<Duration?> _durSub;

  bool _isThisPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _hasError = false;
  double _speed = 1.0;
  late final StreamSubscription<double> _speedSub;

  bool get _isActive => _service.currentMessageId == widget.message.id;

  @override
  void initState() {
    super.initState();

    final metaDuration = widget.message.media?.duration ?? 0;
    _duration = Duration(seconds: metaDuration);

    _stateSub = _service.playerStateStream.listen((state) {
      if (!mounted) return;
      final active = _isActive;
      setState(() {
        _isThisPlaying = active && state.playing;
        if (active && state.processingState == ProcessingState.completed) {
          _isThisPlaying = false;
          _position = Duration.zero;
        }
        if (!active && (_isThisPlaying || _isLoading)) {
          _isThisPlaying = false;
          _isLoading = false;
          _position = Duration.zero;
        }
      });
    });

    _posSub = _service.positionStream.listen((pos) {
      if (!mounted || !_isActive) return;
      setState(() => _position = pos);
    });

    _durSub = _service.durationStream.listen((dur) {
      if (!mounted || !_isActive || dur == null) return;
      setState(() => _duration = dur);
    });

    _speedSub = _service.speedStream.listen((speed) {
      if (!mounted) return;
      setState(() => _speed = speed);
    });
  }

  @override
  void dispose() {
    _stateSub.cancel();
    _posSub.cancel();
    _durSub.cancel();
    _speedSub.cancel();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (_isLoading) return;

    if (_isThisPlaying) {
      await _service.pause();
      return;
    }

    final media = widget.message.media;
    if (media == null) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      await _service.playVoice(
        messageId: widget.message.id,
        url: media.url,
        mediaKeyBase64: media.mediaKey,
      );
    } catch (_) {
      if (mounted) setState(() => _hasError = true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Cycle playback speed: 1x → 1.5x → 2x → 1x.
  void _cycleSpeed() {
    final next = _speed >= 2.0 ? 1.0 : _speed >= 1.5 ? 2.0 : 1.5;
    _service.setSpeed(next);
  }

  String _speedLabel(double speed) {
    if (speed == 1.5) return '1.5x';
    if (speed == 2.0) return '2x';
    return '1x';
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(1, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final maxMs = _duration.inMilliseconds.toDouble();
    final posMs = _position.inMilliseconds.toDouble().clamp(0.0, maxMs);
    final progress = maxMs > 0 ? posMs / maxMs : 0.0;

    final bgColor = widget.isMe
        ? Colors.black.withValues(alpha: 0.15)
        : Colors.white.withValues(alpha: 0.08);

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Play/pause button (circular overlay matching video style)
                _buildPlayButton(),
                const SizedBox(width: 10),
                // Waveform-style bars + time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Waveform visualization
                      _buildWaveform(progress),
                      const SizedBox(height: 6),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 3,
                          backgroundColor: widget.isMe
                              ? AppColors.chatBubbleText.withValues(alpha: 0.2)
                              : AppColors.chatBubbleReceivedText
                                  .withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.isMe
                                ? AppColors.chatBubbleText
                                    .withValues(alpha: 0.8)
                                : AppColors.chatBubbleReceivedText
                                    .withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Duration chip + speed toggle (bottom row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Speed toggle — only visible during playback
                if (_isThisPlaying || _isActive)
                  GestureDetector(
                    onTap: _cycleSpeed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _speed != 1.0
                            ? AppColors.primary.withValues(alpha: 0.8)
                            : Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _speedLabel(_speed),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                // Duration chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.mic, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        _isThisPlaying || _isActive
                            ? _formatDuration(_position)
                            : _formatDuration(_duration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Transcription stub — tap to show "coming soon"
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Voice transcription coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.text_fields, size: 12,
                      color: widget.isMe
                          ? AppColors.chatBubbleText.withValues(alpha: 0.5)
                          : AppColors.chatBubbleReceivedText.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  Text(
                    'Transcribe',
                    style: TextStyle(
                      fontSize: 10,
                      color: widget.isMe
                          ? AppColors.chatBubbleText.withValues(alpha: 0.5)
                          : AppColors.chatBubbleReceivedText.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    if (_isLoading) {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
      child: Icon(
        _hasError
            ? Icons.error_outline
            : _isThisPlaying
                ? Icons.pause
                : Icons.play_arrow,
        color: _hasError ? AppColors.error : Colors.white,
        size: 24,
      ),
    );
  }

  /// Seekable waveform bars that animate with playback progress.
  /// Tap anywhere on the waveform to seek to that position.
  Widget _buildWaveform(double progress) {
    // Fixed waveform pattern (pseudo-random heights)
    const barHeights = [0.4, 0.7, 0.5, 0.9, 0.3, 0.8, 0.6, 1.0, 0.4, 0.7,
        0.5, 0.8, 0.3, 0.6, 0.9, 0.5, 0.7, 0.4, 0.8, 0.6];
    const maxHeight = 20.0;

    return GestureDetector(
      onTapDown: (details) => _seekFromTap(details.localPosition.dx),
      onHorizontalDragUpdate: (details) =>
          _seekFromTap(details.localPosition.dx),
      child: LayoutBuilder(
        builder: (context, constraints) {
          _waveformWidth = constraints.maxWidth;
          return SizedBox(
            height: maxHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(barHeights.length, (i) {
                final barProgress = i / barHeights.length;
                final isPlayed = barProgress < progress;
                final activeColor = widget.isMe
                    ? AppColors.chatBubbleText
                    : AppColors.chatBubbleReceivedText;
                final inactiveColor = widget.isMe
                    ? AppColors.chatBubbleText.withValues(alpha: 0.3)
                    : AppColors.chatBubbleReceivedText.withValues(alpha: 0.3);

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.5),
                    child: Container(
                      height: maxHeight * barHeights[i],
                      decoration: BoxDecoration(
                        color: isPlayed ? activeColor : inactiveColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  double _waveformWidth = 0;

  void _seekFromTap(double localX) {
    if (!_isActive || _duration.inMilliseconds == 0) return;
    final fraction = (localX / _waveformWidth).clamp(0.0, 1.0);
    final target = Duration(
      milliseconds: (_duration.inMilliseconds * fraction).round(),
    );
    _service.seek(target);
  }
}
