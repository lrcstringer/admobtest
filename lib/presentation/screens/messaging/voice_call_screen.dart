import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../domain/enums/call_status.dart';
import '../../../domain/enums/call_type.dart';
import '../../../domain/enums/connection_quality.dart';
import '../../blocs/call/call_bloc.dart';
import '../../widgets/messaging/call_controls_widget.dart';

/// Voice call screen with avatar, caller info, status, duration, and controls.
///
/// Also handles video upgrade: when the call transitions to video, switches
/// to showing RTCVideoViews.
class VoiceCallScreen extends StatefulWidget {
  final String callId;

  const VoiceCallScreen({super.key, required this.callId});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  bool _videoUpgradeDialogShown = false;
  bool _videoUpgradeNavigated = false;
  Timer? _failedPopTimer;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    _failedPopTimer?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallBloc, CallState>(
      listener: (context, state) {
        // Navigate away when call ends normally
        if (state.status == CallStatus.idle) {
          _failedPopTimer?.cancel();
          if (context.canPop()) context.pop();
        }

        // On failure, show the error for 2 seconds before dismissing
        if (state.status == CallStatus.failed) {
          _failedPopTimer?.cancel();
          _failedPopTimer = Timer(const Duration(seconds: 2), () {
            if (context.mounted && context.canPop()) context.pop();
          });
        }

        // Handle video upgrade dialog (guard against repeated shows)
        if (state.videoUpgradeRequested && !_videoUpgradeDialogShown) {
          _videoUpgradeDialogShown = true;
          _showVideoUpgradeDialog(context);
        }
        if (!state.videoUpgradeRequested) {
          _videoUpgradeDialogShown = false;
        }

        // Navigate to VideoCallScreen when upgraded to video.
        // Replace this route so pressing back doesn't return to voice screen.
        // Guard with _videoUpgradeNavigated to prevent duplicate pushReplacement
        // if BLoC emits consecutive states with callType == video.
        if (state.callType == CallType.video &&
            state.callId != null &&
            state.conversationId != null &&
            !_videoUpgradeNavigated) {
          _videoUpgradeNavigated = true;
          context.pushReplacement(
            '/chat/conversation/${state.conversationId}/call/${state.callId}',
            extra: {'isVideo': true},
          );
          return; // Don't process further — we're navigating away
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF1A1A2E),
          body: Stack(
            children: [
              // Background gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF16213E), Color(0xFF0F3460)],
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // Top bar with back button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () {
                              // Minimize to PiP or go back (call continues)
                              if (context.canPop()) context.pop();
                            },
                          ),
                          const Spacer(),
                          if (state.status == CallStatus.active)
                            _buildQualityIndicator(state.connectionQuality),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Avatar
                    _buildAvatar(state),
                    const SizedBox(height: 24),

                    // Caller name
                    Text(
                      state.remoteUserName ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Status text or duration
                    Text(
                      _getStatusText(state),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 16,
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Controls — show accept/reject for incoming ringing, normal controls otherwise
                    if (state.status == CallStatus.ringing && !state.isCaller)
                      _buildIncomingCallControls(context)
                    else
                      CallControlsWidget(
                        isAudioEnabled: state.isAudioEnabled,
                        isSpeakerOn: state.isSpeakerOn,
                        isVideoEnabled: state.isVideoEnabled,
                        isFrontCamera: state.isFrontCamera,
                        showVideoControls: state.callType == CallType.video,
                        onToggleMute: () => context
                            .read<CallBloc>()
                            .add(const CallEvent.toggleMute()),
                        onToggleSpeaker: () => context
                            .read<CallBloc>()
                            .add(const CallEvent.toggleSpeaker()),
                        onEndCall: () => context
                            .read<CallBloc>()
                            .add(const CallEvent.endCall()),
                        onToggleVideo: state.callType == CallType.video
                            ? () => context
                                .read<CallBloc>()
                                .add(const CallEvent.toggleVideo())
                            : null,
                        onRequestVideoUpgrade:
                            state.callType == CallType.voice &&
                                    state.status == CallStatus.active
                                ? () => context.read<CallBloc>().add(
                                    const CallEvent.requestVideoUpgrade())
                                : null,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(CallState state) {
    final url = state.remoteUserAvatarUrl;
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      backgroundImage:
          url != null && url.isNotEmpty ? CachedNetworkImageProvider(url) : null,
      child: url == null || url.isEmpty
          ? Text(
              (state.remoteUserName ?? '?')[0].toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w300),
            )
          : null,
    );
  }

  Widget _buildQualityIndicator(ConnectionQuality quality) {
    final (icon, color) = switch (quality) {
      ConnectionQuality.excellent => (Icons.signal_cellular_4_bar, Colors.green),
      ConnectionQuality.good => (Icons.signal_cellular_alt, Colors.lightGreen),
      ConnectionQuality.fair =>
        (Icons.signal_cellular_alt_2_bar, Colors.orange),
      ConnectionQuality.poor =>
        (Icons.signal_cellular_alt_1_bar, Colors.red),
    };
    return Icon(icon, color: color, size: 20);
  }

  String _getStatusText(CallState state) {
    return switch (state.status) {
      CallStatus.ringing => state.isCaller ? 'Ringing...' : 'Incoming call',
      CallStatus.connecting => 'Connecting...',
      CallStatus.active => _formatDuration(state.callDuration),
      CallStatus.reconnecting => 'Reconnecting...',
      CallStatus.failed => state.errorMessage ?? 'Call failed',
      _ => '',
    };
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) return '$hours:$minutes:$seconds';
    return '$minutes:$seconds';
  }

  Widget _buildIncomingCallControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Decline
          GestureDetector(
            onTap: () =>
                context.read<CallBloc>().add(const CallEvent.rejectCall()),
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call_end, color: Colors.white, size: 32),
            ),
          ),
          // Accept
          GestureDetector(
            onTap: () =>
                context.read<CallBloc>().add(const CallEvent.acceptCall()),
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call, color: Colors.white, size: 32),
            ),
          ),
        ],
      ),
    );
  }

  void _showVideoUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Video Request'),
        content: Text(
            '${context.read<CallBloc>().state.remoteUserName ?? 'Caller'} wants to switch to video'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<CallBloc>().add(
                  const CallEvent.respondVideoUpgrade(accepted: false));
            },
            child: const Text('Decline'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<CallBloc>().add(
                  const CallEvent.respondVideoUpgrade(accepted: true));
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }
}
