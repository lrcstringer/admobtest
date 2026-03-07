import 'dart:async';

import 'package:flutter/foundation.dart';
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
  Timer? _callTimer;
  Timer? _heartbeatTimer;
  Timer? _ringTimer;
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
    debugPrint('CallBloc: app is ${binding.lifecycleState} — '
        'waiting for foreground before getUserMedia');
    final completer = Completer<void>();
    late final AppLifecycleListener listener;
    listener = AppLifecycleListener(
      onResume: () {
        if (!completer.isCompleted) completer.complete();
      },
    );
    await completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        debugPrint('CallBloc: foreground wait timed out — proceeding anyway');
      },
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
  }

  // ── TURN Retry Helper ──

  Future<Map<String, dynamic>> _fetchTurnWithRetry() async {
    try {
      final creds = await _callRepository.getTurnCredentials();
      if (creds['hasTurn'] == true) return creds;
      // STUN-only — retry once in case of transient failure
      debugPrint('CallBloc: TURN not available, retrying...');
      await Future.delayed(const Duration(milliseconds: 500));
      return await _callRepository.getTurnCredentials();
    } catch (e) {
      debugPrint('CallBloc: TURN fetch failed, retrying: $e');
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
      debugPrint('CallBloc: ignoring initiateCall — '
          'already in call (status=${state.status})');
      return;
    }

    try {
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
      debugPrint('CallBloc: TURN available: ${iceConfig['hasTurn']}, '
          'servers: ${(iceConfig['iceServers'] as List?)?.length ?? 0}');

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
        _negotiationHandler?.negotiate();
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
        onError: (e) =>
            debugPrint('CallBloc: watchRemoteDescription error: $e'),
      );

      // Listen for call document changes (status changes, video upgrade)
      _callDocSub = _signalingService.watchCall(callId).listen(
        (session) => add(CallEvent.callDocUpdated(session)),
        onError: (e) => debugPrint('CallBloc: watchCall error: $e'),
      );

      // Listen for remote ICE candidates
      _iceCandidateSub = _signalingService
          .watchRemoteIceCandidates(callId, isCaller: true)
          .listen(
        (candidate) {
          _negotiationHandler?.handleCandidate(candidate);
        },
        onError: (e) =>
            debugPrint('CallBloc: watchRemoteIceCandidates error: $e'),
      );

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
        onError: (e) =>
            debugPrint('CallBloc: onIceConnectionState error: $e'),
      );

      // Ring timeout: 30 seconds
      _ringTimer = Timer(const Duration(seconds: 30), () {
        if (state.status == CallStatus.ringing) {
          add(const CallEvent.endCall());
        }
      });
    } catch (e, stack) {
      debugPrint('CallBloc: [initiate] FAILED: $e');
      debugPrint('CallBloc: [initiate] stack: $stack');

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
      debugPrint('CallBloc: ignoring incoming call — already in call '
          '(status=${state.status})');
      // Dismiss the CallKit UI that the FCM handler already showed
      try {
        await FlutterCallkitIncoming.endCall(event.callId);
      } catch (e) {
        debugPrint('CallBloc: endCallKit (busy) error: $e');
      }
      // Notify server so caller sees "busy" instead of waiting for timeout
      try {
        await _callRepository.endCall(event.callId, reason: 'busy');
      } catch (e) {
        debugPrint('CallBloc: endCall (busy) error: $e');
      }
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
      onError: (e) => debugPrint('CallBloc: watchCall error: $e'),
    );

    // Pre-fetch TURN credentials so accept is faster (fire-and-forget)
    _callRepository.getTurnCredentials().then((_) {
      debugPrint('CallBloc: pre-fetched TURN credentials for incoming call');
    }).catchError((Object e) {
      debugPrint('CallBloc: pre-fetch TURN failed (non-fatal): $e');
    });
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
      debugPrint('CallBloc: [accept] phase 1 — parallel: '
          'answerCall + getTurnCredentials + waitForForeground');
      final answerFuture = _callRepository.answerCall(callId);
      final turnFuture = _fetchTurnWithRetry();
      final foregroundFuture = _waitForForeground();

      // Need TURN config + foreground before WebRTC init
      final iceConfig = await turnFuture;
      debugPrint('CallBloc: TURN available: ${iceConfig['hasTurn']}, '
          'servers: ${(iceConfig['iceServers'] as List?)?.length ?? 0}');
      await foregroundFuture;

      _analyticsService.logCallStarted(
        callId: callId,
        callType: state.callType.name,
        isCaller: false,
        hasTurn: iceConfig['hasTurn'] == true,
      );

      // Phase 2: WebRTC init and offer fetch in parallel (RTDB — fast)
      debugPrint('CallBloc: [accept] phase 2 — parallel: '
          'WebRTC initialize + fetch offer (RTDB)');
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

      debugPrint('CallBloc: [accept] offer present: ${offer != null}');

      // If offer not yet available via one-shot, wait up to 10s for it via
      // the RTDB watch stream. Without this, a slow caller would leave the
      // callee stuck in 'connecting' until the ring timer fires.
      RTCSessionDescription? resolvedOffer = offer;
      if (resolvedOffer == null) {
        debugPrint('CallBloc: [accept] no offer yet — '
            'waiting up to 10s via RTDB watch');
        try {
          resolvedOffer = await _signalingService
              .watchRemoteDescription(callId, isCaller: false)
              .first
              .timeout(const Duration(seconds: 10));
        } on TimeoutException {
          throw Exception('Caller offer not received within 10 seconds');
        }
      }

      debugPrint('CallBloc: [accept] step 5 — setRemoteDescription');
      final pc = _webRtcService!.peerConnection!;
      await pc.setRemoteDescription(resolvedOffer);
      debugPrint('CallBloc: [accept] step 6 — createAnswer');
      final answer = await pc.createAnswer();
      await pc.setLocalDescription(answer);
      final localDesc = await pc.getLocalDescription();
      if (localDesc != null) {
        debugPrint('CallBloc: [accept] step 7 — sendAnswer');
        await _signalingService.sendDescription(callId, localDesc,
            isCaller: false);
      }
      _lastProcessedRemoteSdp = resolvedOffer.sdp;
      debugPrint('CallBloc: [accept] SDP exchange complete');

      // Set up Perfect Negotiation for future renegotiation (video upgrade,
      // ICE restart). If the offer wasn't available yet, the watch stream
      // will route it through this handler when it arrives.
      _negotiationHandler = PerfectNegotiationHandler(
        pc: _webRtcService!.peerConnection!,
        polite: true,
        sendDescription: (desc) async {
          await _signalingService.sendDescription(callId, desc,
              isCaller: false);
        },
      );

      // Wire up video upgrade renegotiation callback
      _webRtcService!.onNeedRenegotiation = () {
        _negotiationHandler?.negotiate();
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
        onError: (e) =>
            debugPrint('CallBloc: watchRemoteDescription error: $e'),
      );

      // Listen for remote ICE candidates
      _iceCandidateSub = _signalingService
          .watchRemoteIceCandidates(callId, isCaller: false)
          .listen(
        (candidate) {
          _negotiationHandler?.handleCandidate(candidate);
        },
        onError: (e) =>
            debugPrint('CallBloc: watchRemoteIceCandidates error: $e'),
      );

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
        onError: (e) =>
            debugPrint('CallBloc: onIceConnectionState error: $e'),
      );

      debugPrint('CallBloc: [accept] setup complete — waiting for ICE');
    } catch (e, stack) {
      debugPrint('CallBloc: [accept] FAILED: $e');
      debugPrint('CallBloc: [accept] stack: $stack');

      _analyticsService.logCallFailed(
        callId: callId,
        error: e.toString(),
      );

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
    try {
      await _callRepository.endCall(state.callId!, reason: 'declined');
    } catch (e) {
      debugPrint('CallBloc: rejectCall error: $e');
    }
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
      await _callRepository.endCall(state.callId!, reason: reason);
    } catch (e) {
      debugPrint('CallBloc: endCall error: $e');
    }
    await _cleanup();
    emit(const CallState());
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

  void _onToggleVideo(_ToggleVideo event, Emitter<CallState> emit) {
    _webRtcService?.toggleVideo();
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
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
        ));
      } catch (e) {
        debugPrint('CallBloc: upgradeToVideo error: $e');
        // Clear upgrade flags so UI doesn't stay stuck
        emit(state.copyWith(
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
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
        } catch (e) {
          debugPrint('CallBloc: endCallKit error: $e');
        }
      }
      await _cleanup();
      emit(const CallState());
      return;
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

    // Handle video upgrade accepted by remote peer
    if (session.videoUpgradeRequest == 'accepted' &&
        state.callType == CallType.voice) {
      try {
        await _webRtcService?.upgradeToVideo();
        emit(state.copyWith(
          callType: CallType.video,
          isVideoEnabled: true,
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
        ));
      } catch (e) {
        debugPrint('CallBloc: upgrade accepted but failed: $e');
        emit(state.copyWith(
          videoUpgradeRequested: false,
          videoUpgradeRequesterId: null,
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

        // Cancel ring timer — call is connected
        _ringTimer?.cancel();
        _ringTimer = null;

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
        // Temporary disconnection — try ICE restart with exponential backoff
        if (_iceRestartAttempts < _maxIceRestarts) {
          emit(state.copyWith(status: CallStatus.reconnecting));
          _iceRestartAttempts++;
          // Exponential backoff: 0ms, 500ms, 1s, 2s, 4s
          final delay = _iceRestartAttempts <= 1
              ? Duration.zero
              : Duration(
                  milliseconds: 500 * (1 << (_iceRestartAttempts - 2)));
          debugPrint('CallBloc: ICE restart #$_iceRestartAttempts '
              'after ${delay.inMilliseconds}ms');
          _analyticsService.logIceRestart(
            callId: state.callId ?? 'unknown',
            attempt: _iceRestartAttempts,
          );
          Future.delayed(delay, () {
            if (!isClosed && state.status == CallStatus.reconnecting) {
              _webRtcService?.peerConnection?.restartIce();
              if (state.callId != null) {
                _signalingService.updateIceRestartCount(
                    state.callId!, _iceRestartAttempts);
              }
            }
          });
        }

      case RTCIceConnectionState.RTCIceConnectionStateFailed:
        // ICE failed — end call
        if (state.callId != null) {
          try {
            await _callRepository.endCall(
                state.callId!, reason: 'reconnection_failed');
          } catch (e) {
            debugPrint('CallBloc: endCall on ICE failure error: $e');
          }
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

  // ── Cleanup ──

  Future<void> _cleanup() async {
    // Clean up RTDB signaling data (best effort)
    if (state.callId != null) {
      _signalingService.cleanupSignaling(state.callId!);
    }

    _ringTimer?.cancel();
    _ringTimer = null;
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
