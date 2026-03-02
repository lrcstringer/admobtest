import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:imalichat/core/services/call_analytics_service.dart';
import 'package:imalichat/core/services/call_signaling_service.dart';
import 'package:imalichat/core/services/webrtc_service.dart';
import 'package:imalichat/domain/entities/call_session.dart';
import 'package:imalichat/domain/enums/call_status.dart';
import 'package:imalichat/domain/enums/call_type.dart';
import 'package:imalichat/domain/repositories/call_repository.dart';
import 'package:imalichat/presentation/blocs/call/call_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCallRepository extends Mock implements CallRepository {}

class MockWebRtcServiceFactory extends Mock implements WebRtcServiceFactory {}

class MockWebRtcService extends Mock implements WebRtcService {}

class MockCallSignalingService extends Mock implements CallSignalingService {}

class MockCallAnalyticsService extends Mock implements CallAnalyticsService {}

class MockRTCPeerConnection extends Mock implements RTCPeerConnection {}

void main() {
  late MockCallRepository mockRepo;
  late MockWebRtcServiceFactory mockFactory;
  late MockWebRtcService mockWebRtc;
  late MockCallSignalingService mockSignaling;
  late MockCallAnalyticsService mockAnalytics;
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
    mockAnalytics = MockCallAnalyticsService();
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

    when(() => mockSignaling.watchCall(any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockSignaling.watchRemoteIceCandidates(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) => const Stream.empty());
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
    when(() => mockSignaling.updateIceRestartCount(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockSignaling.requestVideoUpgrade(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockSignaling.respondVideoUpgrade(any(), any()))
        .thenAnswer((_) async {});

    when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
        .thenAnswer((_) async {});
  });

  CallBloc buildBloc() => CallBloc(mockRepo, mockFactory, mockSignaling, mockAnalytics);

  group('Video Upgrade Flow Integration', () {
    blocTest<CallBloc, CallState>(
      'caller requests video upgrade → sends signaling request',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_up_1',
        callType: CallType.voice,
        isCaller: true,
        remoteUserId: 'user_b',
      ),
      act: (bloc) async {
        bloc.add(const CallEvent.requestVideoUpgrade());
        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      // requestVideoUpgrade only calls signaling, doesn't emit state locally.
      // State change happens via callDocUpdated when remote doc is updated.
      expect: () => [],
      verify: (_) {
        verify(() =>
                mockSignaling.requestVideoUpgrade('call_up_1', 'caller'))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'callee requests video upgrade → sends signaling request',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_up_2',
        callType: CallType.voice,
        isCaller: false,
        remoteUserId: 'user_a',
      ),
      act: (bloc) async {
        bloc.add(const CallEvent.requestVideoUpgrade());
        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [],
      verify: (_) {
        verify(() =>
                mockSignaling.requestVideoUpgrade('call_up_2', 'callee'))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'remote video upgrade request arrives via callDocUpdated',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_up_3',
        callType: CallType.voice,
        isCaller: false,
        videoUpgradeRequested: false,
      ),
      act: (bloc) async {
        bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'call_up_3',
            conversationId: 'conv_1',
            callerId: 'user_a',
            calleeId: 'user_b',
            callerName: 'Alice',
            callType: CallType.voice,
            status: CallStatus.active,
            videoUpgradeRequest: 'pending',
            videoUpgradeRequesterId: 'caller',
          ),
        ));

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CallState>()
            .having((s) => s.videoUpgradeRequested, 'req', true)
            .having((s) => s.videoUpgradeRequesterId, 'reqId', 'caller'),
      ],
    );

    blocTest<CallBloc, CallState>(
      'respond to video upgrade: declined → clears upgrade state',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_up_4',
        callType: CallType.voice,
        isCaller: false,
        videoUpgradeRequested: true,
        videoUpgradeRequesterId: 'caller',
      ),
      act: (bloc) async {
        bloc.add(const CallEvent.respondVideoUpgrade(accepted: false));
        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CallState>()
            .having((s) => s.videoUpgradeRequested, 'req', false)
            .having((s) => s.videoUpgradeRequesterId, 'reqId', isNull),
      ],
      verify: (_) {
        verify(() =>
                mockSignaling.respondVideoUpgrade('call_up_4', false))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'ignore own video upgrade request in callDocUpdated',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_up_5',
        callType: CallType.voice,
        isCaller: true,
        videoUpgradeRequested: true,
        videoUpgradeRequesterId: 'caller',
      ),
      act: (bloc) async {
        // Self-update should not re-trigger upgrade notification
        bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'call_up_5',
            conversationId: 'conv_1',
            callerId: 'user_a',
            calleeId: 'user_b',
            callerName: 'Alice',
            callType: CallType.voice,
            status: CallStatus.active,
            videoUpgradeRequest: 'pending',
            videoUpgradeRequesterId: 'caller',
          ),
        ));
        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      // State already has videoUpgradeRequested=true with same requesterId
      // BLoC deduplicates identical states → no emission
      expect: () => [],
    );
  });
}
