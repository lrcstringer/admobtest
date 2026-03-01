import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

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
  Timer? _callTimer;
  Timer? _heartbeatTimer;
  Timer? _ringTimer;
  int _iceRestartAttempts = 0;
  static const _maxIceRestarts = 3;

  /// Prevent duplicate SDP processing — Firestore snapshots include the full
  /// document on every change, so the offer/answer fields appear on every
  /// update even when they haven't changed.
  /// We store the last processed SDP string (not a boolean) so that ICE
  /// restart and video upgrade renegotiations — which produce NEW SDPs —
  /// are still processed correctly.
  String? _lastProcessedOfferSdp;
  String? _lastProcessedAnswerSdp;

  CallBloc(
    this._callRepository,
    this._webRtcServiceFactory,
    this._signalingService,
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

      // Create call via Cloud Function (transactional)
      final callId = await _callRepository.initiateCall(
        conversationId: event.conversationId,
        recipientId: event.recipientId,
        callType: event.callType,
      );
      emit(state.copyWith(callId: callId));

      // Get TURN credentials
      final iceConfig = await _callRepository.getTurnCredentials();

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

      // Set up Perfect Negotiation (caller = impolite)
      _negotiationHandler = PerfectNegotiationHandler(
        pc: _webRtcService!.peerConnection!,
        polite: false,
        sendDescription: (desc) async {
          if (desc.type == 'offer') {
            await _signalingService.sendOffer(callId, desc);
          } else {
            await _signalingService.sendAnswer(callId, desc);
          }
        },
      );

      // Explicitly create and send the initial SDP offer.
      // onRenegotiationNeeded from addTrack() fired during initialize()
      // when pc.onRenegotiationNeeded was still null — that event was dropped.
      await _negotiationHandler!.negotiate();

      // Listen for call document changes (answer, status changes)
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
    // Reject second incoming call if one is already active/ringing
    if (state.status != CallStatus.idle) {
      debugPrint('CallBloc: ignoring incoming call — already in call '
          '(status=${state.status})');
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
  }

  // ── Accept Incoming Call ──

  Future<void> _onAcceptCall(
    _AcceptCall event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;
    final callId = state.callId!;

    try {
      emit(state.copyWith(status: CallStatus.connecting));

      debugPrint('CallBloc: [accept] step 1 — answerCall CF');
      await _callRepository.answerCall(callId);

      debugPrint('CallBloc: [accept] step 2 — getTurnCredentials');
      final iceConfig = await _callRepository.getTurnCredentials();

      debugPrint('CallBloc: [accept] step 3 — WebRTC initialize');
      _webRtcService = _webRtcServiceFactory.create();
      await _webRtcService!.initialize(
        isVideo: state.callType == CallType.video,
        iceServers: iceConfig,
        onIceCandidate: (candidate) {
          _signalingService.sendIceCandidate(
              callId, candidate, isCaller: false);
        },
      );

      debugPrint('CallBloc: [accept] step 4 — fetch offer');
      final currentSession = await _signalingService.getCall(callId);
      debugPrint('CallBloc: [accept] offer present: '
          '${currentSession?.offer != null}');

      if (currentSession?.offer != null) {
        final offerSdp = currentSession!.offer!['sdp'];
        final offerType = currentSession.offer!['type'];
        if (offerSdp != null && offerType != null) {
          debugPrint('CallBloc: [accept] step 5 — setRemoteDescription');
          final pc = _webRtcService!.peerConnection!;
          await pc.setRemoteDescription(
            RTCSessionDescription(offerSdp, offerType),
          );
          debugPrint('CallBloc: [accept] step 6 — createAnswer');
          final answer = await pc.createAnswer();
          await pc.setLocalDescription(answer);
          final localDesc = await pc.getLocalDescription();
          if (localDesc != null) {
            debugPrint('CallBloc: [accept] step 7 — sendAnswer');
            await _signalingService.sendAnswer(callId, localDesc);
          }
          _lastProcessedOfferSdp = offerSdp;
          debugPrint('CallBloc: [accept] SDP exchange complete');
        }
      } else {
        debugPrint('CallBloc: [accept] no offer yet — '
            'will process via callDocUpdated when it arrives');
      }

      // Set up Perfect Negotiation for future renegotiation (video upgrade,
      // ICE restart). If the offer wasn't available yet, callDocUpdated will
      // route it through this handler when it arrives.
      _negotiationHandler = PerfectNegotiationHandler(
        pc: _webRtcService!.peerConnection!,
        polite: true,
        sendDescription: (desc) async {
          if (desc.type == 'offer') {
            await _signalingService.sendOffer(callId, desc);
          } else {
            await _signalingService.sendAnswer(callId, desc);
          }
        },
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

      emit(state.copyWith(
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
    final session = event.session;

    // Handle remote hangup
    if (terminalCallStatuses.contains(session.status) &&
        !terminalCallStatuses.contains(state.status)) {
      await _cleanup();
      emit(const CallState());
      return;
    }

    // Handle SDP offer (callee receives this).
    // Compare against last processed SDP to avoid reprocessing on every doc
    // update (Firestore snapshots include the full doc, not a diff), while
    // still allowing NEW offers from ICE restart or video upgrade.
    if (session.offer != null &&
        !state.isCaller &&
        _negotiationHandler != null) {
      final offerSdp = session.offer!['sdp'];
      final offerType = session.offer!['type'];
      if (offerSdp != null &&
          offerType != null &&
          offerSdp != _lastProcessedOfferSdp) {
        _lastProcessedOfferSdp = offerSdp;
        await _negotiationHandler!.handleDescription(
          RTCSessionDescription(offerSdp, offerType),
        );
      }
    }

    // Handle SDP answer (caller receives this).
    // Same SDP-content dedup as above.
    if (session.answer != null &&
        state.isCaller &&
        _negotiationHandler != null) {
      final answerSdp = session.answer!['sdp'];
      final answerType = session.answer!['type'];
      if (answerSdp != null &&
          answerType != null &&
          answerSdp != _lastProcessedAnswerSdp) {
        _lastProcessedAnswerSdp = answerSdp;
        await _negotiationHandler!.handleDescription(
          RTCSessionDescription(answerSdp, answerType),
        );
      }
    }

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
      }
    }
  }

  // ── ICE Connection State ──

  Future<void> _onIceConnectionStateChanged(
    _IceConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {
    switch (event.state) {
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
      case RTCIceConnectionState.RTCIceConnectionStateCompleted:
        // Reset ICE restart counter on successful connection
        _iceRestartAttempts = 0;

        if (state.status != CallStatus.active) {
          emit(state.copyWith(status: CallStatus.active));
        }

        // Start call timer
        _callTimer?.cancel();
        _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
          add(const CallEvent.callTimerTick());
        });

        // Start heartbeat (every 5 seconds)
        _heartbeatTimer?.cancel();
        _heartbeatTimer = Timer.periodic(const Duration(seconds: 5), (_) {
          if (state.callId != null) {
            _signalingService.sendHeartbeat(
                state.callId!, isCaller: state.isCaller);
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
        // Temporary disconnection — try ICE restart
        if (_iceRestartAttempts < _maxIceRestarts) {
          emit(state.copyWith(status: CallStatus.reconnecting));
          _iceRestartAttempts++;
          _webRtcService?.peerConnection?.restartIce();
          if (state.callId != null) {
            _signalingService.updateIceRestartCount(
                state.callId!, _iceRestartAttempts);
          }
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
    await _iceStateSub?.cancel();
    _iceStateSub = null;
    await _qualitySub?.cancel();
    _qualitySub = null;

    _negotiationHandler?.dispose();
    _negotiationHandler = null;

    _qualityMonitor?.dispose();
    _qualityMonitor = null;

    await _webRtcService?.dispose();
    _webRtcService = null;

    _iceRestartAttempts = 0;
    _lastProcessedOfferSdp = null;
    _lastProcessedAnswerSdp = null;
  }

  @override
  Future<void> close() async {
    await _cleanup();
    return super.close();
  }
}
