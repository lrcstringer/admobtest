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
    try {
      emit(state.copyWith(
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

      // Listen for call document changes (answer, status changes)
      _callDocSub = _signalingService.watchCall(callId).listen(
        (session) => add(CallEvent.callDocUpdated(session)),
      );

      // Listen for remote ICE candidates
      _iceCandidateSub = _signalingService
          .watchRemoteIceCandidates(callId, isCaller: true)
          .listen((candidate) {
        _negotiationHandler?.handleCandidate(candidate);
      });

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
      );

      // Ring timeout: 30 seconds
      _ringTimer = Timer(const Duration(seconds: 30), () {
        if (state.status == CallStatus.ringing) {
          add(const CallEvent.endCall());
        }
      });
    } catch (e) {
      emit(state.copyWith(
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

      // Validate answer via Cloud Function
      await _callRepository.answerCall(callId);

      // Get TURN credentials
      final iceConfig = await _callRepository.getTurnCredentials();

      // Create WebRTC service
      _webRtcService = _webRtcServiceFactory.create();

      await _webRtcService!.initialize(
        isVideo: state.callType == CallType.video,
        iceServers: iceConfig,
        onIceCandidate: (candidate) {
          _signalingService.sendIceCandidate(
              callId, candidate, isCaller: false);
        },
      );

      // Set up Perfect Negotiation (callee = polite)
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
          .listen((candidate) {
        _negotiationHandler?.handleCandidate(candidate);
      });

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
      );

      // The call document watcher (already active from _onIncomingCall)
      // will fire _onCallDocUpdated which handles the buffered offer via
      // _negotiationHandler.handleDescription()
    } catch (e) {
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

    // Handle SDP offer (callee receives this)
    if (session.offer != null && !state.isCaller && _negotiationHandler != null) {
      final offerSdp = session.offer!['sdp'];
      final offerType = session.offer!['type'];
      if (offerSdp != null && offerType != null) {
        await _negotiationHandler!.handleDescription(
          RTCSessionDescription(offerSdp, offerType),
        );
      }
    }

    // Handle SDP answer (caller receives this)
    if (session.answer != null && state.isCaller && _negotiationHandler != null) {
      final answerSdp = session.answer!['sdp'];
      final answerType = session.answer!['type'];
      if (answerSdp != null && answerType != null) {
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
  }

  @override
  Future<void> close() async {
    await _cleanup();
    return super.close();
  }
}
