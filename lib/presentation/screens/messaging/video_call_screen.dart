import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/services/webrtc_service.dart';
import '../../../domain/enums/call_status.dart';
import '../../../domain/enums/connection_quality.dart';
import '../../blocs/call/call_bloc.dart';
import '../../widgets/messaging/call_controls_widget.dart';

/// Full-screen video call screen with remote video, local PiP, and controls.
class VideoCallScreen extends StatefulWidget {
  final String callId;

  const VideoCallScreen({super.key, required this.callId});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _renderersReady = false;
  bool _controlsVisible = true;
  Timer? _hideControlsTimer;
  StreamSubscription? _localStreamSub;
  StreamSubscription? _remoteStreamSub;
  WebRtcService? _lastConnectedService;

  // PiP drag position
  Offset _pipOffset = const Offset(16, 60);

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _initRenderers();
    _startControlsHideTimer();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    if (!mounted) return;
    setState(() => _renderersReady = true);

    // Try connecting immediately (works for caller, may be null for callee)
    _connectToStreams();
  }

  /// Connect renderers to WebRTC media streams.
  ///
  /// Called from [_initRenderers] (initState path) and from the BlocConsumer
  /// listener when the accept flow completes and webRtcService becomes
  /// available. This handles the callee timing issue: the screen is pushed
  /// before _onAcceptCall creates the WebRtcService, so initState sees null.
  /// Safe to call multiple times — cancels previous subscriptions first.
  void _connectToStreams() {
    final webRtc = context.read<CallBloc>().webRtcService;
    if (webRtc == null) return;
    if (webRtc.isDisposed) return;
    // Already connected to this service instance — skip
    if (webRtc == _lastConnectedService) return;
    _lastConnectedService = webRtc;

    // Cancel previous subscriptions to prevent stacking
    _localStreamSub?.cancel();
    _remoteStreamSub?.cancel();

    if (webRtc.localStream != null) {
      _localRenderer.srcObject = webRtc.localStream;
    }
    _localStreamSub = webRtc.onLocalStream.listen((stream) {
      if (mounted) setState(() => _localRenderer.srcObject = stream);
    });
    _remoteStreamSub = webRtc.onRemoteStream.listen((stream) {
      if (mounted) setState(() => _remoteRenderer.srcObject = stream);
    });
  }

  void _startControlsHideTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _controlsVisible = false);
    });
  }

  void _toggleControls() {
    setState(() => _controlsVisible = !_controlsVisible);
    if (_controlsVisible) _startControlsHideTimer();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _hideControlsTimer?.cancel();
    _localStreamSub?.cancel();
    _remoteStreamSub?.cancel();
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallBloc, CallState>(
      listener: (context, state) {
        // Connect renderers once WebRTC is ready (callee path — initState
        // runs before _onAcceptCall creates webRtcService).
        // _connectToStreams is safe to call multiple times (cancels previous).
        if (_renderersReady) {
          _connectToStreams();
        }

        if (state.status == CallStatus.idle ||
            state.status == CallStatus.failed) {
          if (context.canPop()) context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: _toggleControls,
            child: Stack(
              children: [
                // Remote video (full screen)
                if (_renderersReady)
                  Positioned.fill(
                    child: RTCVideoView(
                      _remoteRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  ),

                // Fallback when no remote video or remote camera is off
                if (!_renderersReady ||
                    state.status != CallStatus.active ||
                    !state.isRemoteVideoEnabled)
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xFF1A1A2E),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.1),
                              child: Text(
                                (state.remoteUserName ?? '?')[0]
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.remoteUserName ?? 'Unknown',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.status == CallStatus.active &&
                                      !state.isRemoteVideoEnabled
                                  ? 'Camera off'
                                  : _getStatusText(state),
                              style: TextStyle(
                                color:
                                    Colors.white.withValues(alpha: 0.7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Local PiP (draggable, clamped to screen bounds)
                if (_renderersReady && state.isVideoEnabled)
                  Positioned(
                    left: _pipOffset.dx,
                    top: _pipOffset.dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          final size = MediaQuery.sizeOf(context);
                          const pipW = 120.0;
                          const pipH = 160.0;
                          final newDx = (_pipOffset.dx + details.delta.dx)
                              .clamp(0.0, size.width - pipW);
                          final newDy = (_pipOffset.dy + details.delta.dy)
                              .clamp(0.0, size.height - pipH);
                          _pipOffset = Offset(newDx, newDy);
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3)),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: RTCVideoView(
                          _localRenderer,
                          mirror: state.isFrontCamera,
                          objectFit: RTCVideoViewObjectFit
                              .RTCVideoViewObjectFitCover,
                        ),
                      ),
                    ),
                  ),

                // Top overlay (name, status, quality)
                if (_controlsVisible)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  if (context.canPop()) context.pop();
                                },
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      state.remoteUserName ?? 'Unknown',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (state.status == CallStatus.active)
                                      Text(
                                        _formatDuration(
                                            state.callDuration),
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.7),
                                          fontSize: 14,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (state.status == CallStatus.active)
                                _buildQualityIndicator(
                                    state.connectionQuality),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                // Bottom controls overlay
                if (_controlsVisible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: state.status == CallStatus.ringing && !state.isCaller
                          ? _buildIncomingCallControls(context)
                          : CallControlsWidget(
                              isAudioEnabled: state.isAudioEnabled,
                              isSpeakerOn: state.isSpeakerOn,
                              isVideoEnabled: state.isVideoEnabled,
                              isFrontCamera: state.isFrontCamera,
                              showVideoControls: true,
                              onToggleMute: () => context
                                  .read<CallBloc>()
                                  .add(const CallEvent.toggleMute()),
                              onToggleSpeaker: () => context
                                  .read<CallBloc>()
                                  .add(const CallEvent.toggleSpeaker()),
                              onEndCall: () => context
                                  .read<CallBloc>()
                                  .add(const CallEvent.endCall()),
                              onToggleVideo: () => context
                                  .read<CallBloc>()
                                  .add(const CallEvent.toggleVideo()),
                              onSwitchCamera: () => context
                                  .read<CallBloc>()
                                  .add(const CallEvent.switchCamera()),
                            ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
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
              child: const Icon(Icons.videocam, color: Colors.white, size: 32),
            ),
          ),
        ],
      ),
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
}
