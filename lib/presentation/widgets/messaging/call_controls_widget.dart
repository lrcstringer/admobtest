import 'package:flutter/material.dart';

/// Shared call control buttons for both voice and video call screens.
class CallControlsWidget extends StatelessWidget {
  final bool isAudioEnabled;
  final bool isSpeakerOn;
  final bool isVideoEnabled;
  final bool isFrontCamera;
  final bool showVideoControls;
  final VoidCallback onToggleMute;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onEndCall;
  final VoidCallback? onToggleVideo;
  final VoidCallback? onSwitchCamera;
  final VoidCallback? onRequestVideoUpgrade;

  const CallControlsWidget({
    super.key,
    required this.isAudioEnabled,
    required this.isSpeakerOn,
    required this.isVideoEnabled,
    required this.isFrontCamera,
    required this.showVideoControls,
    required this.onToggleMute,
    required this.onToggleSpeaker,
    required this.onEndCall,
    this.onToggleVideo,
    this.onSwitchCamera,
    this.onRequestVideoUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Mute
            _ControlButton(
              icon: isAudioEnabled ? Icons.mic : Icons.mic_off,
              label: isAudioEnabled ? 'Mute' : 'Unmute',
              isActive: !isAudioEnabled,
              onPressed: onToggleMute,
            ),

            // Speaker
            _ControlButton(
              icon: isSpeakerOn ? Icons.volume_up : Icons.volume_down,
              label: 'Speaker',
              isActive: isSpeakerOn,
              onPressed: onToggleSpeaker,
            ),

            // Video toggle or upgrade
            if (showVideoControls && onToggleVideo != null)
              _ControlButton(
                icon: isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                label: 'Video',
                isActive: !isVideoEnabled,
                onPressed: onToggleVideo!,
              )
            else if (onRequestVideoUpgrade != null)
              _ControlButton(
                icon: Icons.videocam,
                label: 'Video',
                isActive: false,
                onPressed: onRequestVideoUpgrade!,
              ),

            // Switch camera (video only)
            if (showVideoControls && onSwitchCamera != null)
              _ControlButton(
                icon: Icons.cameraswitch,
                label: 'Flip',
                isActive: false,
                onPressed: onSwitchCamera!,
              ),

            // End call
            _ControlButton(
              icon: Icons.call_end,
              label: 'End',
              isEndCall: true,
              onPressed: onEndCall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isEndCall;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.isEndCall = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isEndCall
        ? Colors.red
        : isActive
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.15);
    final iconColor = isEndCall
        ? Colors.white
        : isActive
            ? Colors.white
            : Colors.white70;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: bgColor,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(icon, color: iconColor, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
