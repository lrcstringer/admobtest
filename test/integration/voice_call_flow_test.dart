import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:imalichat/core/services/call_analytics_service.dart';
import 'package:imalichat/core/services/call_signaling_service.dart';
import 'package:imalichat/core/services/webrtc_service.dart';
import 'package:imalichat/domain/entities/call_session.dart';
import 'package:imalichat/domain/enums/call_status.dart';
import 'package:imalichat/domain/enums/call_type.dart';
import 'package:imalichat/domain/enums/connection_quality.dart';
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
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock connectivity_plus platform channels
  const MethodChannel connectivityChannel =
      MethodChannel('dev.fluttercommunity.plus/connectivity');
  const MethodChannel connectivityEventChannel = MethodChannel(
      'dev.fluttercommunity.plus/connectivity_status',
      StandardMethodCodec());

  late MockCallRepository mockRepo;
  late MockWebRtcServiceFactory mockFactory;
  late MockWebRtcService mockWebRtc;
  late MockCallSignalingService mockSignaling;
  late MockCallAnalyticsService mockAnalytics;
  late MockRTCPeerConnection mockPc;
  late StreamController<CallSession> callDocController;
  late StreamController<RTCIceCandidate> iceCandidateController;
  late StreamController<RTCIceConnectionState> iceStateController;

  setUpAll(() {
    registerFallbackValue(CallType.voice);
    registerFallbackValue(RTCSessionDescription('', 'offer'));
    registerFallbackValue(RTCIceCandidate('', '', 0));

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(connectivityChannel, (call) async {
      if (call.method == 'check') return ['wifi'];
      return null;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(connectivityEventChannel, (call) async {
      return null;
    });
  });

  setUp(() {
    mockRepo = MockCallRepository();
    mockFactory = MockWebRtcServiceFactory();
    mockWebRtc = MockWebRtcService();
    mockSignaling = MockCallSignalingService();
    mockAnalytics = MockCallAnalyticsService();
    mockPc = MockRTCPeerConnection();
    callDocController = StreamController<CallSession>.broadcast();
    iceCandidateController = StreamController<RTCIceCandidate>.broadcast();
    iceStateController = StreamController<RTCIceConnectionState>.broadcast();

    when(() => mockFactory.create()).thenReturn(mockWebRtc);
    when(() => mockWebRtc.peerConnection).thenReturn(mockPc);
    when(() => mockWebRtc.isAudioEnabled).thenReturn(true);
    when(() => mockWebRtc.isVideoEnabled).thenReturn(false);
    when(() => mockWebRtc.isSpeakerOn).thenReturn(false);
    when(() => mockWebRtc.isFrontCamera).thenReturn(true);
    when(() => mockWebRtc.isDisposed).thenReturn(false);
    when(() => mockWebRtc.onIceConnectionState)
        .thenAnswer((_) => iceStateController.stream);
    when(() => mockWebRtc.onRemoteStream)
        .thenAnswer((_) => const Stream<MediaStream?>.empty());
    when(() => mockWebRtc.onLocalStream)
        .thenAnswer((_) => const Stream<MediaStream?>.empty());
    when(() => mockWebRtc.onConnectionState)
        .thenAnswer((_) => const Stream<RTCPeerConnectionState>.empty());
    when(() => mockWebRtc.onIceGatheringState)
        .thenAnswer((_) => const Stream<RTCIceGatheringState>.empty());
    when(() => mockWebRtc.onRemoteVideoEnabled)
        .thenAnswer((_) => const Stream<bool>.empty());
    when(() => mockWebRtc.initialize(
          isVideo: any(named: 'isVideo'),
          iceServers: any(named: 'iceServers'),
          onIceCandidate: any(named: 'onIceCandidate'),
        )).thenAnswer((_) async {});
    when(() => mockWebRtc.dispose()).thenAnswer((_) async {});
    when(() => mockWebRtc.toggleSpeaker()).thenAnswer((_) async {});
    when(() => mockWebRtc.setSpeakerphone(any())).thenAnswer((_) async {});
    when(() => mockWebRtc.upgradeToVideo()).thenAnswer((_) async {});

    when(() => mockPc.signalingState)
        .thenReturn(RTCSignalingState.RTCSignalingStateStable);
    when(() => mockPc.onRenegotiationNeeded).thenReturn(null);
    when(() => mockPc.restartIce()).thenAnswer((_) async {});
    when(() => mockPc.createOffer(any())).thenAnswer(
        (_) async => RTCSessionDescription('sdp', 'offer'));
    when(() => mockPc.createOffer()).thenAnswer(
        (_) async => RTCSessionDescription('sdp', 'offer'));
    when(() => mockPc.createAnswer(any())).thenAnswer(
        (_) async => RTCSessionDescription('sdp', 'answer'));
    when(() => mockPc.createAnswer()).thenAnswer(
        (_) async => RTCSessionDescription('sdp', 'answer'));
    when(() => mockPc.setLocalDescription(any())).thenAnswer((_) async {});
    when(() => mockPc.setRemoteDescription(any())).thenAnswer((_) async {});
    when(() => mockPc.getLocalDescription())
        .thenAnswer((_) async => RTCSessionDescription('sdp', 'offer'));
    when(() => mockPc.addCandidate(any())).thenAnswer((_) async {});

    when(() => mockSignaling.watchCall(any()))
        .thenAnswer((_) => callDocController.stream);
    when(() => mockSignaling.watchRemoteIceCandidates(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) => iceCandidateController.stream);
    when(() => mockSignaling.sendDescription(any(), any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer((_) async {});
    when(() => mockSignaling.getRemoteDescription(any(),
            isCaller: any(named: 'isCaller')))
        .thenAnswer(
            (_) async => RTCSessionDescription('remote-sdp', 'offer'));
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

    when(() => mockRepo.initiateCall(
          conversationId: any(named: 'conversationId'),
          recipientId: any(named: 'recipientId'),
          callType: any(named: 'callType'),
        )).thenAnswer((_) async => 'call_flow_1');
    when(() => mockRepo.getTurnCredentials())
        .thenAnswer((_) async => {'hasTurn': true, 'iceServers': []});
    when(() => mockRepo.answerCall(any())).thenAnswer((_) async {});
    when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
        .thenAnswer((_) async {});
  });

  tearDown(() {
    callDocController.close();
    iceCandidateController.close();
    iceStateController.close();
  });

  CallBloc buildBloc() => CallBloc(mockRepo, mockFactory, mockSignaling, mockAnalytics);

  group('Voice Call Flow Integration', () {
    blocTest<CallBloc, CallState>(
      'outgoing call: initiate → ringing → connected → active → end',
      build: buildBloc,
      act: (bloc) async {
        // 1. Initiate outgoing call
        bloc.add(const CallEvent.initiateCall(
          conversationId: 'conv_1',
          recipientId: 'user_b',
          recipientName: 'Bob',
          callType: CallType.voice,
        ));

        await Future.delayed(const Duration(milliseconds: 200));

        // 2. ICE connected
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        // 3. Timer ticks
        bloc.add(const CallEvent.callTimerTick());
        bloc.add(const CallEvent.callTimerTick());

        await Future.delayed(const Duration(milliseconds: 50));

        // 4. End call
        bloc.add(const CallEvent.endCall());

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        // Ringing with remote user info
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.ringing)
            .having((s) => s.isCaller, 'isCaller', true),
        // Call ID set
        isA<CallState>()
            .having((s) => s.callId, 'callId', 'call_flow_1'),
        // ICE connected → active
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.active),
        // Timer tick 1
        isA<CallState>().having(
            (s) => s.callDuration, 'dur', const Duration(seconds: 1)),
        // Timer tick 2
        isA<CallState>().having(
            (s) => s.callDuration, 'dur', const Duration(seconds: 2)),
        // End call → idle
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.idle),
      ],
      verify: (_) {
        verify(() => mockRepo.initiateCall(
              conversationId: 'conv_1',
              recipientId: 'user_b',
              callType: CallType.voice,
            )).called(1);
        verify(() => mockRepo.endCall('call_flow_1', reason: 'normal'))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'incoming call: incoming → accept → connecting → active → remote hangup',
      build: buildBloc,
      act: (bloc) async {
        // 1. Incoming call notification
        bloc.add(const CallEvent.incomingCall(
          callId: 'call_inc_flow',
          callerName: 'Alice',
          callType: CallType.voice,
          conversationId: 'conv_2',
          callerId: 'user_a',
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        // 2. Accept
        bloc.add(const CallEvent.acceptCall());

        await Future.delayed(const Duration(milliseconds: 200));

        // 3. ICE connected
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        // 4. Remote hangup via call doc update
        bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'call_inc_flow',
            conversationId: 'conv_2',
            callerId: 'user_a',
            calleeId: 'user_b',
            callerName: 'Alice',
            callType: CallType.voice,
            status: CallStatus.ended,
          ),
        ));

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        // Ringing as callee
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.ringing)
            .having((s) => s.isCaller, 'isCaller', false)
            .having((s) => s.callId, 'callId', 'call_inc_flow'),
        // Connecting
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.connecting),
        // Active
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.active),
        // Remote hangup → idle
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.idle),
      ],
      verify: (_) {
        verify(() => mockRepo.answerCall('call_inc_flow')).called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'ICE disconnect → reconnecting → reconnected → active',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_reconnect',
        isCaller: true,
      ),
      act: (bloc) async {
        // 1. ICE disconnected
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateDisconnected,
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        // 2. ICE reconnected
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        ));

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // Reconnecting
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.reconnecting),
        // Back to active (ICE restart counter resets)
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.active),
      ],
    );

    blocTest<CallBloc, CallState>(
      'ICE failed after max retries → call ended',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_ice_fail',
        isCaller: true,
      ),
      act: (bloc) async {
        // 3 disconnects + 1 fail
        for (var i = 0; i < 3; i++) {
          bloc.add(const CallEvent.iceConnectionStateChanged(
            RTCIceConnectionState.RTCIceConnectionStateDisconnected,
          ));
          await Future.delayed(const Duration(milliseconds: 50));
        }

        // After 3 reconnect attempts, next failure ends the call
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateFailed,
        ));

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // First disconnect → reconnecting (subsequent identical states deduplicated by BLoC)
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.reconnecting),
        // ICE failed after 3 internal restart attempts → call failed
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.failed)
            .having((s) => s.errorMessage, 'err', 'Connection failed'),
      ],
      verify: (_) {
        verify(() => mockRepo.endCall('call_ice_fail',
                reason: 'reconnection_failed'))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'quality changes propagate to state',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_quality',
        connectionQuality: ConnectionQuality.excellent,
      ),
      act: (bloc) async {
        bloc.add(
            const CallEvent.qualityChanged(ConnectionQuality.good));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(
            const CallEvent.qualityChanged(ConnectionQuality.poor));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CallState>().having(
            (s) => s.connectionQuality, 'q', ConnectionQuality.good),
        isA<CallState>().having(
            (s) => s.connectionQuality, 'q', ConnectionQuality.poor),
      ],
    );

    blocTest<CallBloc, CallState>(
      'video upgrade: request → accepted → callType changes',
      build: buildBloc,
      seed: () => const CallState(
        status: CallStatus.active,
        callId: 'call_upgrade',
        callType: CallType.voice,
        isCaller: false,
        videoUpgradeRequested: false,
      ),
      act: (bloc) async {
        // Remote peer requests video upgrade
        bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'call_upgrade',
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
            .having(
                (s) => s.videoUpgradeRequesterId, 'reqId', 'caller'),
      ],
    );
  });
}
