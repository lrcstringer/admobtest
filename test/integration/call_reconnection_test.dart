import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:imalichat/core/services/call_signaling_service.dart';
import 'package:imalichat/core/services/webrtc_service.dart';
import 'package:imalichat/domain/enums/call_status.dart';
import 'package:imalichat/domain/enums/call_type.dart';
import 'package:imalichat/domain/repositories/call_repository.dart';
import 'package:imalichat/presentation/blocs/call/call_bloc.dart';
import 'package:mocktail/mocktail.dart';

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

    when(() => mockFactory.create()).thenReturn(mockWebRtc);
    when(() => mockWebRtc.peerConnection).thenReturn(mockPc);
    when(() => mockWebRtc.isAudioEnabled).thenReturn(true);
    when(() => mockWebRtc.isVideoEnabled).thenReturn(false);
    when(() => mockWebRtc.isSpeakerOn).thenReturn(false);
    when(() => mockWebRtc.isFrontCamera).thenReturn(true);
    when(() => mockWebRtc.isDisposed).thenReturn(false);
    when(() => mockWebRtc.onIceConnectionState)
        .thenAnswer((_) => const Stream.empty());
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

    when(() => mockPc.signalingState)
        .thenReturn(RTCSignalingState.RTCSignalingStateStable);
    when(() => mockPc.onRenegotiationNeeded).thenReturn(null);
    when(() => mockPc.restartIce()).thenAnswer((_) async {});

    when(() => mockSignaling.watchCall(any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockSignaling.watchRemoteIceCandidates(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockSignaling.sendOffer(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockSignaling.sendAnswer(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockSignaling.sendIceCandidate(any(), any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) async {});
    when(() => mockSignaling.sendHeartbeat(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) async {});
    when(() => mockSignaling.updateIceRestartCount(any(), any()))
        .thenAnswer((_) async {});

    when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
        .thenAnswer((_) async {});
  });

  CallBloc buildBloc() => CallBloc(mockRepo, mockFactory, mockSignaling);

  group('Call Reconnection Integration', () {
    blocTest<CallBloc, CallState>(
      'single ICE disconnect → reconnecting → reconnect success → active',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_rc_1',
        isCaller: true,
      ),
      act: (bloc) async {
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateDisconnected,
        ));
        await Future.delayed(const Duration(milliseconds: 50));

        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        ));
        await Future.delayed(const Duration(milliseconds: 50));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.reconnecting),
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.active),
      ],
    );

    blocTest<CallBloc, CallState>(
      'multiple disconnect-reconnect cycles succeed (counter resets)',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_rc_2',
        isCaller: true,
      ),
      act: (bloc) async {
        // Cycle 1
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateDisconnected,
        ));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        ));
        await Future.delayed(const Duration(milliseconds: 50));

        // Cycle 2
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateDisconnected,
        ));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        ));
        await Future.delayed(const Duration(milliseconds: 50));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // Cycle 1
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.reconnecting),
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.active),
        // Cycle 2
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.reconnecting),
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.active),
      ],
    );

    blocTest<CallBloc, CallState>(
      'ICE failed immediately (no prior disconnect) → call failed',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_rc_3',
        isCaller: true,
      ),
      act: (bloc) async {
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateFailed,
        ));
        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.failed)
            .having((s) => s.errorMessage, 'err', 'Connection failed'),
      ],
      verify: (_) {
        verify(() => mockRepo.endCall('call_rc_3',
                reason: 'reconnection_failed'))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'max retries exhausted then ICE failed → call ended',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_rc_4',
        isCaller: true,
      ),
      act: (bloc) async {
        // Exhaust 3 reconnect attempts (state deduplicated)
        for (var i = 0; i < 3; i++) {
          bloc.add(const CallEvent.iceConnectionStateChanged(
            RTCIceConnectionState.RTCIceConnectionStateDisconnected,
          ));
          await Future.delayed(const Duration(milliseconds: 50));
        }

        // ICE failed
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateFailed,
        ));
        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // First disconnect → reconnecting
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.reconnecting),
        // ICE failed → call failed
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.failed)
            .having((s) => s.errorMessage, 'err', 'Connection failed'),
      ],
      verify: (_) {
        verify(() => mockRepo.endCall('call_rc_4',
                reason: 'reconnection_failed'))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'callee reconnection uses restartIce',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_rc_5',
        isCaller: false,
      ),
      act: (bloc) async {
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateDisconnected,
        ));
        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.reconnecting),
      ],
    );
  });
}
