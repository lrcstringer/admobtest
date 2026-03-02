import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:imalichat/core/services/call_signaling_service.dart';
import 'package:imalichat/core/services/webrtc_service.dart';
import 'package:imalichat/domain/entities/call_session.dart';
import 'package:imalichat/domain/enums/call_status.dart';
import 'package:imalichat/domain/enums/call_type.dart';
import 'package:imalichat/domain/enums/connection_quality.dart';
import 'package:imalichat/domain/repositories/call_repository.dart';
import 'package:imalichat/presentation/blocs/call/call_bloc.dart';
import 'package:mocktail/mocktail.dart';

// ── Mocks ──

class MockCallRepository extends Mock implements CallRepository {}

class MockWebRtcServiceFactory extends Mock implements WebRtcServiceFactory {}

class MockWebRtcService extends Mock implements WebRtcService {}

class MockCallSignalingService extends Mock implements CallSignalingService {}

class MockRTCPeerConnection extends Mock implements RTCPeerConnection {}

void main() {
  late MockCallRepository mockRepo;
  late MockWebRtcServiceFactory mockFactory;
  late MockWebRtcService mockWebRtc;
  late MockCallSignalingService mockSignaling;
  late MockRTCPeerConnection mockPc;

  setUpAll(() {
    registerFallbackValue(CallType.voice);
    registerFallbackValue(RTCSessionDescription('', 'offer'));
    registerFallbackValue(RTCIceCandidate('', '', 0));
  });

  setUp(() {
    mockRepo = MockCallRepository();
    mockFactory = MockWebRtcServiceFactory();
    mockWebRtc = MockWebRtcService();
    mockSignaling = MockCallSignalingService();
    mockPc = MockRTCPeerConnection();

    // Default stubs for factory
    when(() => mockFactory.create()).thenReturn(mockWebRtc);

    // Default stubs for WebRtcService
    when(() => mockWebRtc.peerConnection).thenReturn(mockPc);
    when(() => mockWebRtc.isAudioEnabled).thenReturn(true);
    when(() => mockWebRtc.isVideoEnabled).thenReturn(false);
    when(() => mockWebRtc.isSpeakerOn).thenReturn(false);
    when(() => mockWebRtc.isFrontCamera).thenReturn(true);
    when(() => mockWebRtc.isDisposed).thenReturn(false);
    when(() => mockWebRtc.onIceConnectionState)
        .thenAnswer((_) => const Stream<RTCIceConnectionState>.empty());
    when(() => mockWebRtc.onRemoteStream)
        .thenAnswer((_) => const Stream<MediaStream?>.empty());
    when(() => mockWebRtc.onLocalStream)
        .thenAnswer((_) => const Stream<MediaStream?>.empty());
    when(() => mockWebRtc.onConnectionState)
        .thenAnswer((_) => const Stream<RTCPeerConnectionState>.empty());
    when(() => mockWebRtc.onIceGatheringState)
        .thenAnswer((_) => const Stream<RTCIceGatheringState>.empty());
    when(() => mockWebRtc.initialize(
          isVideo: any(named: 'isVideo'),
          iceServers: any(named: 'iceServers'),
          onIceCandidate: any(named: 'onIceCandidate'),
        )).thenAnswer((_) async {});
    when(() => mockWebRtc.dispose()).thenAnswer((_) async {});

    // Default stubs for peer connection
    when(() => mockPc.signalingState)
        .thenReturn(RTCSignalingState.RTCSignalingStateStable);
    when(() => mockPc.onRenegotiationNeeded).thenReturn(null);

    // Default stubs for signaling
    when(() => mockSignaling.watchCall(any()))
        .thenAnswer((_) => const Stream<CallSession>.empty());
    when(() => mockSignaling.watchRemoteIceCandidates(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) => const Stream<RTCIceCandidate>.empty());
    when(() => mockSignaling.sendDescription(any(), any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) async {});
    when(() => mockSignaling.getRemoteDescription(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) async => null);
    when(() => mockSignaling.watchRemoteDescription(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockSignaling.cleanupSignaling(any()))
        .thenAnswer((_) async {});
    when(() => mockSignaling.sendIceCandidate(any(), any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) async {});
    when(() => mockSignaling.sendHeartbeat(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) async {});
    when(() => mockSignaling.requestVideoUpgrade(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockSignaling.respondVideoUpgrade(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockSignaling.updateIceRestartCount(any(), any()))
        .thenAnswer((_) async {});
  });

  CallBloc buildBloc() => CallBloc(mockRepo, mockFactory, mockSignaling);

  group('CallBloc', () {
    test('initial state is idle with defaults', () {
      final bloc = buildBloc();
      expect(bloc.state.status, CallStatus.idle);
      expect(bloc.state.callId, isNull);
      expect(bloc.state.conversationId, isNull);
      expect(bloc.state.callType, CallType.voice);
      expect(bloc.state.isCaller, true);
      expect(bloc.state.isAudioEnabled, true);
      expect(bloc.state.isVideoEnabled, false);
      expect(bloc.state.isSpeakerOn, false);
      expect(bloc.state.callDuration, Duration.zero);
      expect(bloc.state.connectionQuality, ConnectionQuality.excellent);
      expect(bloc.state.videoUpgradeRequested, false);
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    // ── Initiate Call ──

    group('initiateCall', () {
      blocTest<CallBloc, CallState>(
        'emits [ringing with callId] on successful initiation',
        build: () {
          when(() => mockRepo.initiateCall(
                conversationId: any(named: 'conversationId'),
                recipientId: any(named: 'recipientId'),
                callType: any(named: 'callType'),
              )).thenAnswer((_) async => 'call_123');
          when(() => mockRepo.getTurnCredentials())
              .thenAnswer((_) async => {'iceServers': []});
          return buildBloc();
        },
        act: (bloc) => bloc.add(const CallEvent.initiateCall(
          conversationId: 'conv_1',
          recipientId: 'user_b',
          recipientName: 'Bob',
          recipientAvatarUrl: 'https://img.com/bob.jpg',
          callType: CallType.voice,
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // First emit: ringing state with remote user info
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.ringing)
              .having((s) => s.conversationId, 'convId', 'conv_1')
              .having((s) => s.remoteUserId, 'remoteUserId', 'user_b')
              .having((s) => s.remoteUserName, 'remoteUserName', 'Bob')
              .having((s) => s.callType, 'callType', CallType.voice)
              .having((s) => s.isCaller, 'isCaller', true)
              .having((s) => s.isSpeakerOn, 'speaker', false),
          // Second emit: callId set
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.ringing)
              .having((s) => s.callId, 'callId', 'call_123'),
        ],
        verify: (_) {
          verify(() => mockRepo.initiateCall(
                conversationId: 'conv_1',
                recipientId: 'user_b',
                callType: CallType.voice,
              )).called(1);
          verify(() => mockRepo.getTurnCredentials()).called(1);
          verify(() => mockFactory.create()).called(1);
          verify(() => mockWebRtc.initialize(
                isVideo: false,
                iceServers: any(named: 'iceServers'),
                onIceCandidate: any(named: 'onIceCandidate'),
              )).called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'sets speaker on for video calls',
        build: () {
          when(() => mockRepo.initiateCall(
                conversationId: any(named: 'conversationId'),
                recipientId: any(named: 'recipientId'),
                callType: any(named: 'callType'),
              )).thenAnswer((_) async => 'call_v1');
          when(() => mockRepo.getTurnCredentials())
              .thenAnswer((_) async => {'iceServers': []});
          return buildBloc();
        },
        act: (bloc) => bloc.add(const CallEvent.initiateCall(
          conversationId: 'conv_1',
          recipientId: 'user_b',
          recipientName: 'Bob',
          callType: CallType.video,
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.callType, 'callType', CallType.video)
              .having((s) => s.isSpeakerOn, 'speaker', true),
          isA<CallState>()
              .having((s) => s.callId, 'callId', 'call_v1'),
        ],
      );

      blocTest<CallBloc, CallState>(
        'emits failed state when initiateCall throws',
        build: () {
          when(() => mockRepo.initiateCall(
                conversationId: any(named: 'conversationId'),
                recipientId: any(named: 'recipientId'),
                callType: any(named: 'callType'),
              )).thenThrow(Exception('Network error'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const CallEvent.initiateCall(
          conversationId: 'conv_1',
          recipientId: 'user_b',
          recipientName: 'Bob',
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.ringing),
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.failed)
              .having((s) => s.errorMessage, 'error', isNotNull),
        ],
      );

      blocTest<CallBloc, CallState>(
        'emits failed state when getTurnCredentials throws',
        build: () {
          when(() => mockRepo.initiateCall(
                conversationId: any(named: 'conversationId'),
                recipientId: any(named: 'recipientId'),
                callType: any(named: 'callType'),
              )).thenAnswer((_) async => 'call_123');
          when(() => mockRepo.getTurnCredentials())
              .thenThrow(Exception('TURN server error'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const CallEvent.initiateCall(
          conversationId: 'conv_1',
          recipientId: 'user_b',
          recipientName: 'Bob',
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.ringing),
          isA<CallState>()
              .having((s) => s.callId, 'callId', 'call_123'),
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.failed)
              .having((s) => s.errorMessage, 'error',
                  contains('TURN server error')),
        ],
      );
    });

    // ── Incoming Call ──

    group('incomingCall', () {
      blocTest<CallBloc, CallState>(
        'emits ringing state with caller info',
        build: buildBloc,
        act: (bloc) => bloc.add(const CallEvent.incomingCall(
          callId: 'call_inc1',
          callerName: 'Alice',
          callerAvatarUrl: 'https://img.com/alice.jpg',
          callType: CallType.voice,
          conversationId: 'conv_99',
          callerId: 'user_a',
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.ringing)
              .having((s) => s.callId, 'callId', 'call_inc1')
              .having((s) => s.conversationId, 'convId', 'conv_99')
              .having((s) => s.remoteUserId, 'remoteUser', 'user_a')
              .having((s) => s.remoteUserName, 'name', 'Alice')
              .having(
                  (s) => s.remoteUserAvatarUrl, 'avatar', contains('alice'))
              .having((s) => s.isCaller, 'isCaller', false),
        ],
      );

      blocTest<CallBloc, CallState>(
        'sets speaker on for incoming video call',
        build: buildBloc,
        act: (bloc) => bloc.add(const CallEvent.incomingCall(
          callId: 'call_v',
          callerName: 'Alice',
          callType: CallType.video,
          conversationId: 'conv_99',
          callerId: 'user_a',
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.callType, 'callType', CallType.video)
              .having((s) => s.isSpeakerOn, 'speaker', true),
        ],
      );
    });

    // ── Accept Call ──

    group('acceptCall', () {
      blocTest<CallBloc, CallState>(
        'transitions from ringing to connecting on accept',
        build: () {
          when(() => mockRepo.answerCall(any())).thenAnswer((_) async {});
          when(() => mockRepo.getTurnCredentials())
              .thenAnswer((_) async => {'iceServers': []});
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.ringing,
          callId: 'call_a1',
          conversationId: 'conv_1',
          remoteUserId: 'user_a',
          remoteUserName: 'Alice',
          callType: CallType.voice,
          isCaller: false,
        ),
        act: (bloc) => bloc.add(const CallEvent.acceptCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.connecting)
              .having((s) => s.callId, 'callId', 'call_a1'),
        ],
        verify: (_) {
          verify(() => mockRepo.answerCall('call_a1')).called(1);
          verify(() => mockRepo.getTurnCredentials()).called(1);
          verify(() => mockFactory.create()).called(1);
          verify(() => mockWebRtc.initialize(
                isVideo: false,
                iceServers: any(named: 'iceServers'),
                onIceCandidate: any(named: 'onIceCandidate'),
              )).called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'does nothing when callId is null',
        build: buildBloc,
        seed: () => const CallState(status: CallStatus.ringing),
        act: (bloc) => bloc.add(const CallEvent.acceptCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [],
      );

      blocTest<CallBloc, CallState>(
        'emits failed when answerCall throws',
        build: () {
          when(() => mockRepo.answerCall(any()))
              .thenThrow(Exception('Answer failed'));
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.ringing,
          callId: 'call_a2',
          conversationId: 'conv_1',
          remoteUserId: 'user_a',
          callType: CallType.voice,
          isCaller: false,
        ),
        act: (bloc) => bloc.add(const CallEvent.acceptCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.connecting),
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.failed)
              .having((s) => s.errorMessage, 'error',
                  contains('Answer failed')),
        ],
      );
    });

    // ── Reject Call ──

    group('rejectCall', () {
      blocTest<CallBloc, CallState>(
        'calls endCall with declined reason and resets state',
        build: () {
          when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
              .thenAnswer((_) async {});
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.ringing,
          callId: 'call_rej1',
          conversationId: 'conv_1',
          remoteUserId: 'user_a',
          isCaller: false,
        ),
        act: (bloc) => bloc.add(const CallEvent.rejectCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.idle)
              .having((s) => s.callId, 'callId', isNull),
        ],
        verify: (_) {
          verify(() => mockRepo.endCall('call_rej1', reason: 'declined'))
              .called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'does nothing when callId is null',
        build: buildBloc,
        act: (bloc) => bloc.add(const CallEvent.rejectCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [],
      );
    });

    // ── End Call ──

    group('endCall', () {
      blocTest<CallBloc, CallState>(
        'caller ending during ringing sends cancelled reason',
        build: () {
          when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
              .thenAnswer((_) async {});
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.ringing,
          callId: 'call_end1',
          isCaller: true,
        ),
        act: (bloc) => bloc.add(const CallEvent.endCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.idle),
        ],
        verify: (_) {
          verify(() => mockRepo.endCall('call_end1', reason: 'cancelled'))
              .called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'callee ending during ringing sends missed reason',
        build: () {
          when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
              .thenAnswer((_) async {});
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.ringing,
          callId: 'call_end2',
          isCaller: false,
        ),
        act: (bloc) => bloc.add(const CallEvent.endCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.idle),
        ],
        verify: (_) {
          verify(() => mockRepo.endCall('call_end2', reason: 'missed'))
              .called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'ending active call sends normal reason',
        build: () {
          when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
              .thenAnswer((_) async {});
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_end3',
          isCaller: true,
        ),
        act: (bloc) => bloc.add(const CallEvent.endCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.idle),
        ],
        verify: (_) {
          verify(() => mockRepo.endCall('call_end3', reason: 'normal'))
              .called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'does nothing when callId is null',
        build: buildBloc,
        act: (bloc) => bloc.add(const CallEvent.endCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [],
      );

      blocTest<CallBloc, CallState>(
        'still resets state even if endCall throws',
        build: () {
          when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
              .thenThrow(Exception('Server error'));
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_end_err',
          isCaller: true,
        ),
        act: (bloc) => bloc.add(const CallEvent.endCall()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.idle),
        ],
      );
    });

    // ── Media Controls ──

    group('toggleMute', () {
      blocTest<CallBloc, CallState>(
        'no-ops when WebRTC service not initialized',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_mute',
          isAudioEnabled: true,
        ),
        act: (bloc) => bloc.add(const CallEvent.toggleMute()),
        wait: const Duration(milliseconds: 50),
        // WebRtcService is null — fallback returns same value, so no emission
        expect: () => [],
      );
    });

    group('toggleSpeaker', () {
      blocTest<CallBloc, CallState>(
        'no-ops when WebRTC service not initialized',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_spk',
          isSpeakerOn: false,
        ),
        act: (bloc) => bloc.add(const CallEvent.toggleSpeaker()),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
      );
    });

    group('toggleVideo', () {
      blocTest<CallBloc, CallState>(
        'no-ops when WebRTC service not initialized',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_vid',
          isVideoEnabled: false,
        ),
        act: (bloc) => bloc.add(const CallEvent.toggleVideo()),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
      );
    });

    group('switchCamera', () {
      blocTest<CallBloc, CallState>(
        'no-ops when WebRTC service not initialized',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_cam',
          isFrontCamera: true,
        ),
        act: (bloc) => bloc.add(const CallEvent.switchCamera()),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
      );
    });

    // ── Video Upgrade ──

    group('requestVideoUpgrade', () {
      blocTest<CallBloc, CallState>(
        'calls signaling requestVideoUpgrade for caller',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_upg1',
          remoteUserId: 'user_b',
          isCaller: true,
        ),
        act: (bloc) =>
            bloc.add(const CallEvent.requestVideoUpgrade()),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
        verify: (_) {
          verify(() =>
                  mockSignaling.requestVideoUpgrade('call_upg1', 'caller'))
              .called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'calls signaling requestVideoUpgrade for callee',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_upg2',
          remoteUserId: 'user_a',
          isCaller: false,
        ),
        act: (bloc) =>
            bloc.add(const CallEvent.requestVideoUpgrade()),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
        verify: (_) {
          verify(() =>
                  mockSignaling.requestVideoUpgrade('call_upg2', 'callee'))
              .called(1);
        },
      );

      blocTest<CallBloc, CallState>(
        'does nothing when callId is null',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          remoteUserId: 'user_b',
        ),
        act: (bloc) =>
            bloc.add(const CallEvent.requestVideoUpgrade()),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
        verify: (_) {
          verifyNever(() =>
              mockSignaling.requestVideoUpgrade(any(), any()));
        },
      );
    });

    group('respondVideoUpgrade', () {
      blocTest<CallBloc, CallState>(
        'accepted=false clears upgrade state',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_resp1',
          callType: CallType.voice,
          videoUpgradeRequested: true,
          videoUpgradeRequesterId: 'caller',
        ),
        act: (bloc) => bloc.add(
            const CallEvent.respondVideoUpgrade(accepted: false)),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CallState>()
              .having((s) => s.videoUpgradeRequested, 'req', false)
              .having((s) => s.videoUpgradeRequesterId, 'reqId', isNull)
              .having((s) => s.callType, 'type', CallType.voice),
        ],
        verify: (_) {
          verify(() =>
                  mockSignaling.respondVideoUpgrade('call_resp1', false))
              .called(1);
        },
      );
    });

    // ── Call Document Updates ──

    group('callDocUpdated', () {
      blocTest<CallBloc, CallState>(
        'handles remote hangup (terminal status)',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_hang',
          conversationId: 'conv_1',
        ),
        act: (bloc) => bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'call_hang',
            conversationId: 'conv_1',
            callerId: 'user_a',
            calleeId: 'user_b',
            callerName: 'Alice',
            callType: CallType.voice,
            status: CallStatus.ended,
          ),
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // Resets to idle state
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.idle)
              .having((s) => s.callId, 'callId', isNull),
        ],
      );

      blocTest<CallBloc, CallState>(
        'detects video upgrade request from remote peer for callee',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_vu1',
          conversationId: 'conv_1',
          isCaller: false,
          videoUpgradeRequested: false,
        ),
        act: (bloc) => bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'call_vu1',
            conversationId: 'conv_1',
            callerId: 'user_a',
            calleeId: 'user_b',
            callerName: 'Alice',
            callType: CallType.voice,
            status: CallStatus.active,
            videoUpgradeRequest: 'pending',
            videoUpgradeRequesterId: 'caller',
          ),
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.videoUpgradeRequested, 'req', true)
              .having(
                  (s) => s.videoUpgradeRequesterId, 'reqId', 'caller'),
        ],
      );

      blocTest<CallBloc, CallState>(
        'does NOT show upgrade dialog if WE are the requester',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_vu2',
          conversationId: 'conv_1',
          isCaller: true, // We are the caller
          videoUpgradeRequested: false,
        ),
        act: (bloc) => bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'call_vu2',
            conversationId: 'conv_1',
            callerId: 'user_a',
            calleeId: 'user_b',
            callerName: 'Alice',
            callType: CallType.voice,
            status: CallStatus.active,
            videoUpgradeRequest: 'pending',
            videoUpgradeRequesterId: 'caller', // Same as us
          ),
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [],
      );
    });

    // ── ICE Connection State ──

    group('iceConnectionStateChanged', () {
      blocTest<CallBloc, CallState>(
        'connected transitions to active and resets ICE restart counter',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.connecting,
          callId: 'call_ice1',
        ),
        act: (bloc) => bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        )),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.active),
        ],
      );

      blocTest<CallBloc, CallState>(
        'completed also transitions to active',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.connecting,
          callId: 'call_ice2',
        ),
        act: (bloc) => bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateCompleted,
        )),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.active),
        ],
      );

      blocTest<CallBloc, CallState>(
        'does not re-emit active if already active',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_ice3',
        ),
        act: (bloc) => bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        )),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
      );

      blocTest<CallBloc, CallState>(
        'disconnected triggers reconnecting state',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_ice_disc',
        ),
        act: (bloc) => bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateDisconnected,
        )),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.reconnecting),
        ],
      );

      blocTest<CallBloc, CallState>(
        'failed ends call with reconnection_failed reason',
        build: () {
          when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
              .thenAnswer((_) async {});
          return buildBloc();
        },
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_ice_fail',
        ),
        act: (bloc) => bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateFailed,
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<CallState>()
              .having((s) => s.status, 'status', CallStatus.failed)
              .having((s) => s.errorMessage, 'err', 'Connection failed'),
        ],
        verify: (_) {
          verify(() => mockRepo.endCall('call_ice_fail',
              reason: 'reconnection_failed')).called(1);
        },
      );
    });

    // ── Call Timer ──

    group('callTimerTick', () {
      blocTest<CallBloc, CallState>(
        'increments duration by 1 second',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_timer',
          callDuration: Duration(seconds: 5),
        ),
        act: (bloc) => bloc.add(const CallEvent.callTimerTick()),
        expect: () => [
          isA<CallState>().having(
              (s) => s.callDuration, 'duration', const Duration(seconds: 6)),
        ],
      );
    });

    // ── Quality Changed ──

    group('qualityChanged', () {
      blocTest<CallBloc, CallState>(
        'updates connection quality',
        build: buildBloc,
        seed: () => const CallState(
          status: CallStatus.active,
          callId: 'call_q',
          connectionQuality: ConnectionQuality.excellent,
        ),
        act: (bloc) => bloc.add(
            const CallEvent.qualityChanged(ConnectionQuality.poor)),
        expect: () => [
          isA<CallState>().having(
              (s) => s.connectionQuality, 'quality', ConnectionQuality.poor),
        ],
      );
    });

    // ── Cleanup / close ──

    group('close', () {
      test('close disposes resources without throwing', () async {
        final bloc = buildBloc();
        // No setup needed — just ensure close doesn't throw
        await expectLater(bloc.close(), completes);
      });
    });
  });
}
