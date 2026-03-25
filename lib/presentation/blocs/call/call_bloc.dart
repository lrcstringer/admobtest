import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/call_analytics_service.dart';
import '../../../core/services/call_quality_monitor.dart';
import '../../../core/services/call_signaling_service.dart';
import '../../../core/services/perfect_negotiation_handler.dart';
import '../../../core/services/webrtc_service.dart';
import '../../../domain/entities/call_session.dart';
import '../../../domain/enums/call_status.dart';
import '../../../domain/enums/call_type.dart';
import '../../../domain/enums/connection_quality.dart';
import '../../../domain/repositories/call_repository.dart';

part 'call_bloc.freezed.dart';
part 'call_event.dart';
part 'call_state.dart';

/// Full call state machine: handles outgoing/incoming calls, WebRTC lifecycle,
/// Perfect Negotiation, heartbeats, reconnection, and video upgrade.
@injectable
class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository _callRepository;
  final WebRtcServiceFactory _webRtcServiceFactory;
  final CallSignalingService _signalingService;
  final CallAnalyticsService _analyticsService;

  WebRtcService? _webRtcService;
  PerfectNegotiationHandler? _negotiationHandler;

  /// Expose WebRtcService so screens can subscribe to media streams
  /// (onLocalStream / onRemoteStream) and set renderer.srcObject.
  /// MediaStream can't be stored in Freezed state — this is the standard
  /// flutter_webrtc approach.
  WebRtcService? get webRtcService => _webRtcService;
  CallQualityMonitor? _qualityMonitor;

  StreamSubscription<CallSession>? _callDocSub;
  StreamSubscription<RTCIceCandidate>? _iceCandidateSub;
  StreamSubscription<RTCIceConnectionState>? _iceStateSub;
  StreamSubscription<ConnectionQuality>? _qualitySub;
  StreamSubscription<RTCSessionDescription>? _sdpSub;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  StreamSubscription<bool>? _remoteVideoSub;
  Timer? _callTimer;
  Timer? _heartbeatTimer;
  Timer? _ringTimer;
  Timer? _connectingTimer;
  int _iceRestartAttempts = 0;
  static const _maxIceRestarts = 5;
  DateTime? _callSetupStartedAt;

  /// Prevent duplicate SDP processing — RTDB onValue fires on every write,
  /// including the initial snapshot. We store the last processed SDP string
  /// (not a boolean) so that ICE restart and video upgrade renegotiations —
  /// which produce NEW SDPs — are still processed correctly.
  String? _lastProcessedRemoteSdp;

  /// Consecutive heartbeat failures. When this reaches [_maxHeartbeatFailures],
  /// we warn the user via a reconnecting status.
  int _heartbeatFailures = 0;
  static const _maxHeartbeatFailures = 2;

  /// Wait for the app to reach resumed (foreground) lifecycle state.
  /// On cold start from a CallKit accept, the app may still be paused
  /// when _onAcceptCall runs — getUserMedia will fail with NotAllowedError
  /// if we try to acquire the mic while the app is in background.
  static Future<void> _waitForForeground() async {
    final binding = WidgetsBinding.instance;
    if (binding.lifecycleState == AppLifecycleState.resumed ||
        binding.lifecycleState == null) {
      return;
    }
    final completer = Completer<void>();
    late final AppLifecycleListener listener;
    listener = AppLifecycleListener(
      onResume: () {
        if (!completer.isCompleted) completer.complete();
      },
    );
    await completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {},
    );
    listener.dispose();
  }

  CallBloc(
    this._callRepository,
    this._webRtcServiceFactory,
    this._signalingService,
    this._analyticsService,
  ) : super(const CallState()) {
    on<_InitiateCall>(_onInitiateCall);
    on<_IncomingCall>(_onIncomingCall);
    on<_AcceptCall>(_onAcceptCall);
    on<_RejectCall>(_onRejectCall);
    on<_EndCall>(_onEndCall);
    on<_ToggleMute>(_onToggleMute);
    on<_ToggleSpeaker>(_onToggleSpeaker);
    on<_ToggleVideo>(_onToggleVideo);
    on<_SwitchCamera>(_onSwitchCamera);
    on<_RequestVideoUpgrade>(_onRequestVideoUpgrade);
    on<_RespondVideoUpgrade>(_onRespondVideoUpgrade);
    on<_CallDocUpdated>(_onCallDocUpdated);
    on<_IceConnectionStateChanged>(_onIceConnectionStateChanged);
    on<_CallTimerTick>(_onCallTimerTick);
    on<_QualityChanged>(_onQualityChanged);
    on<_PerformIceRestart>(_onPerformIceRestart);
    on<_NetworkChanged>(_onNetworkChanged);
    on<_RemoteVideoStateChanged>(_onRemoteVideoStateChanged);
  }

  // ── TURN Retry Helper ──

  Future<Map<String, dynamic>> _fetchTurnWithRetry() async {
    try {
      final creds = await _callRepository.getTurnCredentials();
      if (creds['hasTurn'] == true) return creds;
      // STUN-only — retry once in case of transient failure
      await Future.delayed(const Duration(milliseconds: 500));
      return await _callRepository.getTurnCredentials();
    } catch (_) {
      await Future.delayed(const Duration(milliseconds: 500));
      return await _callRepository.getTurnCredentials();
    }
  }

  // ── Outgoing Call ──

  Future<void> _onInitiateCall(
    _InitiateCall event,
    Emitter<CallState> emit,
  ) async {
    // Guard: don't initiate if already in an active/ringing/connecting call
    if (state.status != CallStatus.idle &&
        state.status != CallStatus.failed) {
      return;
    }

    try {
      // Network connectivity check — fail fast if offline
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity.every((r) => r == ConnectivityResult.none)) {
        emit(const CallState().copyWith(
          status: CallStatus.failed,
          errorMessage: 'No network connection',
        ));
        return;
      }

      _callSetupStartedAt = DateTime.now();

      // Start from a clean state to avoid stale callId from prior attempts
      emit(const CallState().copyWith(
        status: CallStatus.ringing,
        conversationId: event.conversationId,
        remoteUserId: event.recipientId,
        remoteUserName: event.recipientName,
        remoteUserAvatarUrl: event.recipientAvatarUrl,
        callType: event.callType,
        isCaller: true,
        isSpeakerOn: event.callType == CallType.video,
      ));

      // Start Cloud Function call and TURN credential fetch in parallel
      final callIdFuture = _callRepository.initiateCall(
        conversationId: event.conversationId,
        recipientId: event.recipientId,
        callType: event.callType,
      );
      final turnFuture = _fetchTurnWithRetry();

      final callId = await callIdFuture;
      emit(state.copyWith(callId: callId));

      final iceConfig = await turnFuture;

      _analyticsService.logCallStarted(
        callId: callId,
        callType: event.callType.name,
        isCaller: true,
        hasTurn: iceConfig['hasTurn'] == true,
      );

      // Ensure the app is in foreground before acquiring mic/camera
      await _waitForForeground();

      // Create WebRTC service (fresh instance per call)
      _webRtcService = _webRtcServiceFactory.create();

      await _webRtcService!.initialize(
        isVideo: event.callType == CallType.video,
        iceServers: iceConfig,
        onIceCandidate: (candidate) {
          _signalingService.sendIceCandidate(
              callId, candidate, isCaller: true);
        },
      );

      // Voice calls: ensure earpiece (not speaker) on iOS.
      // The iOS audio session has defaultToSpeaker for Bluetooth compat,
      // but voice calls should route to earpiece by default.
      if (event.callType == CallType.voice) {
        await _webRtcService!.setSpeakerphone(false);
      }

      // Set up Perfect Negotiation (caller = impolite)
      _negotiationHandler = PerfectNegotiationHandler(
        pc: _webRtcService!.peerConnection!,
        polite: false,
        sendDescription: (desc) async {
          await _signalingService.sendDescription(callId, desc,
              isCaller: true);
        },
      );

      // Wire up video upgrade renegotiation callback
      _webRtcService!.onNeedRenegotiation = () {
        _negotiationHandler?.negotiate().catchError((_) {});
      };

      // Explicitly create and send the initial SDP offer.
      // onRenegotiationNeeded from addTrack() fired during initialize()
      // when pc.onRenegotiationNeeded was still null — that event was dropped.
      await _negotiationHandler!.negotiate();

      // Watch for remote SDP descriptions via RTDB (fast path — ~10-50ms).
      // Role-based: caller watches calleeDescription node for both
      // answers (normal flow) and offers (callee-initiated renegotiation).
      _sdpSub = _signalingService
          .watchRemoteDescription(callId, isCaller: true)
          .listen(
        (desc) {
          if (desc.sdp != _lastProcessedRemoteSdp) {
            _lastProcessedRemoteSdp = desc.sdp;
            _negotiationHandler?.handleDescription(desc);
          }
        },
        onError: (_) {},
      );

      // Listen for call document changes (status changes, video upgrade)
      _callDocSub = _signalingService.watchCall(callId).listen(
        (session) => add(CallEvent.callDocUpdated(session)),
        onError: (_) {},
      );

      // Listen for remote ICE candidates
      _iceCandidateSub = _signalingService
          .watchRemoteIceCandidates(callId, isCaller: true)
          .listen(
        (candidate) {
          _negotiationHandler?.handleCandidate(candidate);
        },
        onError: (_) {},
      );

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
        onError: (_) {},
      );

      // Listen for remote video track mute/unmute
      _remoteVideoSub = _webRtcService!.onRemoteVideoEnabled.listen(
        (enabled) => add(CallEvent.remoteVideoStateChanged(enabled: enabled)),
      );

      // Ring timeout: 30 seconds
      _ringTimer = Timer(const Duration(seconds: 30), () {
        if (state.status == CallStatus.ringing) {
          add(const CallEvent.endCall());
        }
      });
    } catch (e) {
      // Capture callId before cleanup resets internal state
      final failedCallId = state.callId;

      _analyticsService.logCallFailed(
        callId: failedCallId ?? 'unknown',
        error: e.toString(),
      );

      // Clean up any partially-initialised resources (WebRTC, subscriptions,
      // camera/mic) so they don't leak after the screen pops.
      await _cleanup();

      // If the call was created on the server, end it so the callee isn't
      // left with a phantom ringing call.
      if (failedCallId != null) {
        try {
          await _callRepository.endCall(failedCallId, reason: 'error');
        } catch (_) {}
      }

      // Emit a FRESH failed state — don't use state.copyWith() which would
      // preserve a stale callId causing the next attempt's stream listener
      // to immediately navigate to a dead call.
      emit(const CallState().copyWith(
        status: CallStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  // ── Incoming Call ──

  Future<void> _onIncomingCall(
    _IncomingCall event,
    Emitter<CallState> emit,
  ) async {
    // If already handling this exact call, skip (prevents duplicate setup
    // when CallKit accept/decline fires after showIncomingCall already started).
    if (state.callId == event.callId) return;

    // Reject second incoming call if one is already active/ringing
    if (state.status != CallStatus.idle) {
      // Dismiss the CallKit UI that the FCM handler already showed
      try {
        await FlutterCallkitIncoming.endCall(event.callId);
      } catch (_) {}
      // Notify server so caller sees "busy" instead of waiting for timeout
      try {
        await _callRepository.endCall(event.callId, reason: 'busy');
      } catch (_) {}
      return;
    }

    emit(state.copyWith(
      status: CallStatus.ringing,
      callId: event.callId,
      conversationId: event.conversationId,
      remoteUserId: event.callerId,
      remoteUserName: event.callerName,
      remoteUserAvatarUrl: event.callerAvatarUrl,
      callType: event.callType,
      isCaller: false,
      isSpeakerOn: event.callType == CallType.video,
    ));

    // Listen for call document changes
    _callDocSub = _signalingService.watchCall(event.callId).listen(
      (session) => add(CallEvent.callDocUpdated(session)),
      onError: (_) {},
    );

    // Pre-fetch TURN credentials so accept is faster (fire-and-forget)
    _callRepository.getTurnCredentials().ignore();
  }

  // ── Accept Incoming Call ──

  Future<void> _onAcceptCall(
    _AcceptCall event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;
    final callId = state.callId!;

    try {
      _callSetupStartedAt = DateTime.now();
      emit(state.copyWith(status: CallStatus.connecting));

      // Phase 1: start all independent operations concurrently
      final answerFuture = _callRepository.answerCall(callId);
      final turnFuture = _fetchTurnWithRetry();
      final foregroundFuture = _waitForForeground();

      // Need TURN config + foreground before WebRTC init
      final iceConfig = await turnFuture;
      await foregroundFuture;

      _analyticsService.logCallStarted(
        callId: callId,
        callType: state.callType.name,
        isCaller: false,
        hasTurn: iceConfig['hasTurn'] == true,
      );

      // Phase 2: WebRTC init and offer fetch in parallel (RTDB — fast)
      _webRtcService = _webRtcServiceFactory.create();
      final initFuture = _webRtcService!.initialize(
        isVideo: state.callType == CallType.video,
        iceServers: iceConfig,
        onIceCandidate: (candidate) {
          _signalingService.sendIceCandidate(
              callId, candidate, isCaller: false);
        },
      );
      final offerFuture = _signalingService.getRemoteDescription(
          callId, isCaller: false);

      await initFuture;

      // Voice calls: ensure earpiece (not speaker) on iOS.
      if (state.callType == CallType.voice) {
        await _webRtcService!.setSpeakerphone(false);
      }

      final offer = await offerFuture;

      // Ensure answerCall completed (surfaces server errors)
      await answerFuture;

      // If offer not yet available via one-shot, wait up to 10s for it via
      // the RTDB watch stream. Without this, a slow caller would leave the
      // callee stuck in 'connecting' until the ring timer fires.
      RTCSessionDescription? resolvedOffer = offer;
      if (resolvedOffer == null) {
        try {
          resolvedOffer = await _signalingService
              .watchRemoteDescription(callId, isCaller: false)
              .first
              .timeout(const Duration(seconds: 10));
        } on TimeoutException {
          throw Exception('Caller offer not received within 10 seconds');
        }
      }

      final pc = _webRtcService!.peerConnection!;
      await pc.setRemoteDescription(resolvedOffer);
      final answer = await pc.createAnswer();
      final optimizedAnswer = WebRtcService.optimizeSdp(answer);
      await pc.setLocalDescription(optimizedAnswer);
      final localDesc = await pc.getLocalDescription();
      if (localDesc != null) {
        await _signalingService.sendDescription(callId, localDesc,
            isCaller: false);
      }
      _lastProcessedRemoteSdp = resolvedOffer.sdp;

      // Set up Perfect Negotiation for future renegotiation (video upgrade,
      // ICE restart). If the offer wasn't available yet, the watch stream
      // will route it through this handler when it arrives.
      //
      // initialRemoteDescriptionSet: true because setRemoteDescription was
      // already called above — any caller ICE candidates arriving via
      // _iceCandidateSub will be applied directly without queuing.
      _negotiationHandler = PerfectNegotiationHandler(
        pc: _webRtcService!.peerConnection!,
        polite: true,
        sendDescription: (desc) async {
          await _signalingService.sendDescription(callId, desc,
              isCaller: false);
        },
        initialRemoteDescriptionSet: true,
      );

      // Wire up video upgrade renegotiation callback
      _webRtcService!.onNeedRenegotiation = () {
        _negotiationHandler?.negotiate().catchError((_) {});
      };

      // Watch for remote SDP description changes via RTDB.
      // Role-based: callee watches callerDescription node for both
      // offers (normal + renegotiation) and answers (if callee offered).
      _sdpSub = _signalingService
          .watchRemoteDescription(callId, isCaller: false)
          .listen(
        (desc) {
          if (desc.sdp != _lastProcessedRemoteSdp) {
            _lastProcessedRemoteSdp = desc.sdp;
            _negotiationHandler?.handleDescription(desc);
          }
        },
        onError: (_) {},
      );

      // Listen for remote ICE candidates
      _iceCandidateSub = _signalingService
          .watchRemoteIceCandidates(callId, isCaller: false)
          .listen(
        (candidate) {
          _negotiationHandler?.handleCandidate(candidate);
        },
        onError: (_) {},
      );

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
        onError: (_) {},
      );

      // Listen for remote video track mute/unmute
      _remoteVideoSub = _webRtcService!.onRemoteVideoEnabled.listen(
        (enabled) => add(CallEvent.remoteVideoStateChanged(enabled: enabled)),
      );

      // Start connecting timeout — ends call if ICE never reaches 'connected'.
      _startConnectingTimer();

    } catch (e) {
      _analyticsService.logCallFailed(
        callId: callId,
        error: e.toString(),
      );

      // Dismiss the CallKit system-level call so it doesn't leave a phantom
      // "active call" notification after setup fails.
      try {
        await FlutterCallkitIncoming.endCall(callId);
      } catch (_) {}

      // Clean up any partially-initialised resources (WebRTC, subscriptions,
      // camera/mic) so they don't leak after the screen pops.
      await _cleanup();

      // Notify the server so the caller is informed immediately instead of
      // waiting up to 60s for the stale-heartbeat scheduler.
      try {
        await _callRepository.endCall(callId, reason: 'error');
      } catch (_) {
        // Best effort — scheduler will clean up eventually
      }

      emit(const CallState().copyWith(
        status: CallStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  // ── Reject Incoming Call ──

  Future<void> _onRejectCall(
    _RejectCall event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;
    final callId = state.callId!;
    // Dismiss the native CallKit / full-screen notification UI immediately,
    // before the async CF call, so the callee sees instant dismissal.
    try {
      await FlutterCallkitIncoming.endCall(callId);
    } catch (_) {}
    try {
      await _callRepository
          .endCall(callId, reason: 'declined')
          .timeout(const Duration(seconds: 5));
    } catch (_) {}
    await _cleanup();
    emit(const CallState());
  }

  // ── End Call ──

  Future<void> _onEndCall(
    _EndCall event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;

    // Determine reason based on current state
    String reason;
    if (state.status == CallStatus.ringing && state.isCaller) {
      reason = 'cancelled';
    } else if (state.status == CallStatus.ringing && !state.isCaller) {
      reason = 'missed';
    } else if (state.status == CallStatus.connecting) {
      reason = 'error'; // ICE never connected — maps to 'failed' status in CF
    } else {
      reason = 'normal';
    }

    _analyticsService.logCallEnded(
      callId: state.callId!,
      endReason: reason,
      durationSeconds: state.callDuration.inSeconds,
      iceRestarts: _iceRestartAttempts,
      finalQuality: state.connectionQuality.name,
    );

    try {
      await _callRepository
          .endCall(state.callId!, reason: reason)
          .timeout(const Duration(seconds: 5));
    } catch (_) {}
    await _cleanup();
    // Show error state for timeout/error so the screen stays visible briefly
    // with a message, rather than silently dismissing. Screens pop after 2s.
    if (reason == 'error') {
      emit(const CallState().copyWith(
        status: CallStatus.failed,
        errorMessage: 'Call failed — could not connect',
      ));
    } else {
      emit(const CallState());
    }
  }

  // ── Media Controls ──

  void _onToggleMute(_ToggleMute event, Emitter<CallState> emit) {
    _webRtcService?.toggleMute();
    emit(state.copyWith(
      isAudioEnabled: _webRtcService?.isAudioEnabled ?? state.isAudioEnabled,
    ));
  }

  void _onToggleSpeaker(_ToggleSpeaker event, Emitter<CallState> emit) {
    _webRtcService?.toggleSpeaker();
    emit(state.copyWith(
      isSpeakerOn: _webRtcService?.isSpeakerOn ?? state.isSpeakerOn,
    ));
  }

  Future<void> _onToggleVideo(
    _ToggleVideo event,
    Emitter<CallState> emit,
  ) async {
    await _webRtcService?.toggleVideo();
    emit(state.copyWith(
      isVideoEnabled:
          _webRtcService?.isVideoEnabled ?? state.isVideoEnabled,
    ));
  }

  Future<void> _onSwitchCamera(
    _SwitchCamera event,
    Emitter<CallState> emit,
  ) async {
    await _webRtcService?.switchCamera();
    emit(state.copyWith(
      isFrontCamera:
          _webRtcService?.isFrontCamera ?? state.isFrontCamera,
    ));
  }

  // ── Video Upgrade ──

  Future<void> _onRequestVideoUpgrade(
    _RequestVideoUpgrade event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null || state.remoteUserId == null) return;

    // Optimistically upgrade our own media immediately (requester starts camera
    // now, so video is ready to flow as soon as the responder accepts).
    // This avoids the race where both peers upgrade simultaneously on 'accepted'.
    try {
      await _webRtcService?.upgradeToVideo();
      emit(state.copyWith(
        callType: CallType.video,
        isVideoEnabled: true,
        isSpeakerOn: true,
      ));
    } catch (_) {
      emit(state.copyWith(
        errorMessage: 'Camera unavailable. Check permissions.',
      ));
      return; // Don't send the request if our own camera failed
    }

    await _signalingService.requestVideoUpgrade(
      state.callId!,
      state.isCaller ? 'caller' : 'callee',
    );
  }

  Future<void> _onRespondVideoUpgrade(
    _RespondVideoUpgrade event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;
    await _signalingService.respondVideoUpgrade(
        state.callId!, event.accepted);

    if (event.accepted) {
      // Accept: upgrade our local media to video
      try {
        await _webRtcService?.upgradeToVideo();
        emit(state.copyWith(
          callType: CallType.video,
          isVideoEnabled: true,
          isSpeakerOn: true,
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
        ));
      } catch (_) {
        emit(state.copyWith(
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
          errorMessage: 'Camera unavailable. Check permissions.',
        ));
      }
    } else {
      emit(state.copyWith(
        videoUpgradeRequested: false,
        videoUpgradeRequesterId: null,
      ));
    }
  }

  // ── Call Document Updates ──

  Future<void> _onCallDocUpdated(
    _CallDocUpdated event,
    Emitter<CallState> emit,
  ) async {
    // Guard: ignore stale events arriving after cleanup
    if (state.callId == null) return;

    final session = event.session;

    // Handle remote hangup
    if (terminalCallStatuses.contains(session.status) &&
        !terminalCallStatuses.contains(state.status)) {
      // Dismiss CallKit native UI if we're the callee still ringing
      if (!state.isCaller &&
          state.status == CallStatus.ringing &&
          state.callId != null) {
        try {
          await FlutterCallkitIncoming.endCall(state.callId!);
        } catch (_) {}
      }
      await _cleanup();
      emit(const CallState());
      return;
    }

    // Callee has answered — cancel the caller's ring timer so it doesn't fire
    // and end the call while ICE is still connecting. The caller transitions to
    // 'connecting' here; ICE state will move it to 'active' once established.
    if (session.status == CallStatus.active &&
        state.status == CallStatus.ringing &&
        state.isCaller) {
      _ringTimer?.cancel();
      _ringTimer = null;
      emit(state.copyWith(status: CallStatus.connecting));
      _startConnectingTimer();
    }

    // SDP offer/answer handling has moved to RTDB (watchOffer / watchAnswer)
    // for ~10-50ms latency vs Firestore's 100-300ms. This handler now only
    // processes call lifecycle (status) and video upgrade events.

    // Handle video upgrade request from remote peer
    if (session.videoUpgradeRequest == 'pending' &&
        session.videoUpgradeRequesterId != null &&
        !state.videoUpgradeRequested) {
      // Only show the upgrade dialog if WE are not the requester
      final weAreRequester = (state.isCaller && session.videoUpgradeRequesterId == 'caller') ||
          (!state.isCaller && session.videoUpgradeRequesterId == 'callee');
      if (!weAreRequester) {
        emit(state.copyWith(
          videoUpgradeRequested: true,
          videoUpgradeRequesterId: session.videoUpgradeRequesterId,
        ));
      }
    }

    // Handle video upgrade accepted by remote peer.
    // Only the RESPONDER needs to upgrade here — the requester already upgraded
    // optimistically in _onRequestVideoUpgrade to avoid both sides renegotiating
    // simultaneously.
    if (session.videoUpgradeRequest == 'accepted' &&
        state.callType == CallType.voice) {
      try {
        await _webRtcService?.upgradeToVideo();
        emit(state.copyWith(
          callType: CallType.video,
          isVideoEnabled: true,
          isSpeakerOn: true,
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
        ));
      } catch (_) {
        emit(state.copyWith(
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
          errorMessage: 'Camera unavailable. Check permissions.',
        ));
      }
    }
  }

  // ── ICE Connection State ──

  Future<void> _onIceConnectionStateChanged(
    _IceConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {
    // Guard: ignore stale events arriving after cleanup (BLoC queues events,
    // so an ICE event dispatched before _cleanup can be processed after it).
    if (state.callId == null) return;

    switch (event.state) {
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
      case RTCIceConnectionState.RTCIceConnectionStateCompleted:
        // Reset ICE restart counter on successful connection
        _iceRestartAttempts = 0;

        // Cancel ring/connecting timers — call is connected
        _ringTimer?.cancel();
        _ringTimer = null;
        _connectingTimer?.cancel();
        _connectingTimer = null;

        if (state.status != CallStatus.active) {
          emit(state.copyWith(status: CallStatus.active));

          // Log setup duration
          if (_callSetupStartedAt != null) {
            final setupMs = DateTime.now()
                .difference(_callSetupStartedAt!)
                .inMilliseconds;
            _analyticsService.logCallConnected(
              callId: state.callId ?? 'unknown',
              setupDurationMs: setupMs,
            );
          }
        }

        // Start call timer
        _callTimer?.cancel();
        _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
          add(const CallEvent.callTimerTick());
        });

        // Start heartbeat (every 3 seconds) with failure tracking
        _heartbeatTimer?.cancel();
        _heartbeatFailures = 0;
        _heartbeatTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
          if (state.callId != null) {
            try {
              await _signalingService.sendHeartbeat(
                  state.callId!, isCaller: state.isCaller);
              _heartbeatFailures = 0;
            } catch (_) {
              _heartbeatFailures++;
              if (_heartbeatFailures >= _maxHeartbeatFailures &&
                  state.status == CallStatus.active) {
                add(const CallEvent.iceConnectionStateChanged(
                    RTCIceConnectionState
                        .RTCIceConnectionStateDisconnected));
              }
            }
          }
        });

        // Start network monitoring for proactive ICE restart on WiFi↔cellular
        _startNetworkMonitoring();

        // Start quality monitoring
        if (_qualityMonitor == null && _webRtcService?.peerConnection != null) {
          _qualityMonitor =
              CallQualityMonitor(_webRtcService!.peerConnection!);
          _qualitySub = _qualityMonitor!.onQualityChanged.listen(
            (quality) => add(CallEvent.qualityChanged(quality)),
          );
          _qualityMonitor!.start();
        }

      case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
        // Temporary disconnection — try ICE restart with exponential backoff.
        // The actual restart is dispatched as a BLoC event so it runs within
        // the event queue, avoiding races with cleanup/endCall.
        if (_iceRestartAttempts < _maxIceRestarts) {
          emit(state.copyWith(status: CallStatus.reconnecting));
          _iceRestartAttempts++;
          // Exponential backoff: 0ms, 500ms, 1s, 2s, 4s
          final delay = _iceRestartAttempts <= 1
              ? Duration.zero
              : Duration(
                  milliseconds: 500 * (1 << (_iceRestartAttempts - 2)));
          _analyticsService.logIceRestart(
            callId: state.callId ?? 'unknown',
            attempt: _iceRestartAttempts,
          );
          Future.delayed(delay, () {
            if (!isClosed) {
              add(const CallEvent.performIceRestart());
            }
          });
        }

      case RTCIceConnectionState.RTCIceConnectionStateFailed:
        _connectingTimer?.cancel();
        _connectingTimer = null;
        if (state.callId != null) {
          try {
            await _callRepository.endCall(
                state.callId!, reason: 'reconnection_failed');
          } catch (_) {}
        }
        await _cleanup();
        emit(state.copyWith(
          status: CallStatus.failed,
          errorMessage: 'Connection failed',
        ));

      case RTCIceConnectionState.RTCIceConnectionStateClosed:
        // Connection fully closed
        break;

      default:
        break;
    }
  }

  // ── Timer ──

  void _onCallTimerTick(_CallTimerTick event, Emitter<CallState> emit) {
    emit(state.copyWith(
      callDuration: state.callDuration + const Duration(seconds: 1),
    ));
  }

  // ── Quality ──

  void _onQualityChanged(
      _QualityChanged event, Emitter<CallState> emit) {
    emit(state.copyWith(connectionQuality: event.quality));
  }

  // ── Remote Video State ──

  void _onRemoteVideoStateChanged(
    _RemoteVideoStateChanged event,
    Emitter<CallState> emit,
  ) {
    emit(state.copyWith(isRemoteVideoEnabled: event.enabled));
  }

  // ── ICE Restart (runs inside BLoC event queue — safe from races) ──

  Future<void> _onPerformIceRestart(
    _PerformIceRestart event,
    Emitter<CallState> emit,
  ) async {
    // Guard: cleanup may have run between the delayed dispatch and now
    if (state.callId == null ||
        state.status != CallStatus.reconnecting ||
        _webRtcService == null ||
        _webRtcService!.isDisposed) {
      return;
    }
    _webRtcService!.peerConnection?.restartIce();
    _signalingService.updateIceRestartCount(
        state.callId!, _iceRestartAttempts);
  }

  // ── Network Change Detection ──

  void _startNetworkMonitoring() {
    _connectivitySub?.cancel();
    _connectivitySub = Connectivity().onConnectivityChanged.listen(
      (results) {
        final isConnected =
            results.any((r) => r != ConnectivityResult.none);
        add(CallEvent.networkChanged(isConnected: isConnected));
      },
    );
  }

  Future<void> _onNetworkChanged(
    _NetworkChanged event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;

    if (event.isConnected &&
        state.status == CallStatus.active &&
        _webRtcService?.peerConnection != null) {
      // Network came back — proactively restart ICE instead of waiting for
      // the 15-30s WebRTC timeout to detect the dead path.
      _webRtcService!.peerConnection!.restartIce();
    }

    if (!event.isConnected && state.status == CallStatus.active) {
      emit(state.copyWith(status: CallStatus.reconnecting));
    }
  }

  // ── Connecting Timeout ──

  void _startConnectingTimer() {
    _connectingTimer?.cancel();
    _connectingTimer = Timer(const Duration(seconds: 30), () {
      if (state.status == CallStatus.connecting) {
        add(const CallEvent.endCall());
      }
    });
  }

  // ── Cleanup ──

  Future<void> _cleanup() async {
    // Clean up RTDB signaling data (best effort)
    if (state.callId != null) {
      _signalingService.cleanupSignaling(state.callId!);
    }

    _ringTimer?.cancel();
    _ringTimer = null;
    _connectingTimer?.cancel();
    _connectingTimer = null;
    _callTimer?.cancel();
    _callTimer = null;
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;

    await _callDocSub?.cancel();
    _callDocSub = null;
    await _iceCandidateSub?.cancel();
    _iceCandidateSub = null;
    await _sdpSub?.cancel();
    _sdpSub = null;
    await _iceStateSub?.cancel();
    _iceStateSub = null;
    await _qualitySub?.cancel();
    _qualitySub = null;
    await _connectivitySub?.cancel();
    _connectivitySub = null;
    await _remoteVideoSub?.cancel();
    _remoteVideoSub = null;

    _negotiationHandler?.dispose();
    _negotiationHandler = null;

    _qualityMonitor?.dispose();
    _qualityMonitor = null;

    _webRtcService?.onNeedRenegotiation = null;
    await _webRtcService?.dispose();
    _webRtcService = null;

    _iceRestartAttempts = 0;
    _heartbeatFailures = 0;
    _lastProcessedRemoteSdp = null;
    _callSetupStartedAt = null;
  }

  @override
  Future<void> close() async {
    await _cleanup();
    return super.close();
  }
}
