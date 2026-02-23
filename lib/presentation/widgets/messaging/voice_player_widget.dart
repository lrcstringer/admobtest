import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/di/injection.dart';
import '../../../core/services/audio_playback_service.dart';
import '../../../domain/entities/message.dart';
import '../../theme/app_colors.dart';

/// Inline voice message player that replaces the static stub in message bubbles.
///
/// Shows play/pause, progress slider, and duration. Uses the singleton
/// [AudioPlaybackService] so only one voice plays at a time.
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

  bool get _isActive => _service.currentMessageId == widget.message.id;

  @override
  void initState() {
    super.initState();

    // Set initial duration from message metadata
    final metaDuration = widget.message.media?.duration ?? 0;
    _duration = Duration(seconds: metaDuration);

    _stateSub = _service.playerStateStream.listen((state) {
      if (!mounted) return;
      final active = _isActive;
      setState(() {
        _isThisPlaying = active && state.playing;
        // Reset when this player's audio completes
        if (active && state.processingState == ProcessingState.completed) {
          _isThisPlaying = false;
          _position = Duration.zero;
        }
        // If another message started playing, reset our state
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
  }

  @override
  void dispose() {
    _stateSub.cancel();
    _posSub.cancel();
    _durSub.cancel();
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

  void _onSliderChanged(double value) {
    if (!_isActive) return;
    final newPos = Duration(milliseconds: value.toInt());
    _service.seek(newPos);
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(1, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final voiceColor =
        widget.isMe ? AppColors.chatBubbleText : AppColors.chatBubbleReceivedText;
    final sliderActiveColor = widget.isMe
        ? AppColors.chatBubbleText.withValues(alpha: 0.9)
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.9);
    final sliderInactiveColor = widget.isMe
        ? AppColors.chatBubbleText.withValues(alpha: 0.3)
        : AppColors.chatBubbleReceivedText.withValues(alpha: 0.3);

    final maxMs = _duration.inMilliseconds.toDouble();
    final posMs = _position.inMilliseconds.toDouble().clamp(0.0, maxMs);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      constraints: const BoxConstraints(minWidth: 180),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Play/Pause/Loading button
          SizedBox(
            width: 36,
            height: 36,
            child: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(6),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: voiceColor,
                    ),
                  )
                : IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      _hasError
                          ? Icons.error_outline
                          : _isThisPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                      color: _hasError ? AppColors.error : voiceColor,
                      size: 32,
                    ),
                    onPressed: _togglePlayPause,
                  ),
          ),
          const SizedBox(width: 4),
          // Slider + time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 5,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 10,
                    ),
                    activeTrackColor: sliderActiveColor,
                    inactiveTrackColor: sliderInactiveColor,
                    thumbColor: sliderActiveColor,
                  ),
                  child: Slider(
                    value: posMs,
                    max: maxMs > 0 ? maxMs : 1,
                    onChanged: _isActive ? _onSliderChanged : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            _isThisPlaying || _isActive
                ? _formatDuration(_position)
                : _formatDuration(_duration),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: voiceColor,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
          ),
        ],
      ),
    );
  }
}
