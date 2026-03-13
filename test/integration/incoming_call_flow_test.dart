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
    when(() => mockWebRtc.onRemoteVideoEnabled)
        .thenAnswer((_) => const Stream<bool>.empty());
    when(() => mockWebRtc.initialize(
          isVideo: any(named: 'isVideo'),
          iceServers: any(named: 'iceServers'),
          onIceCandidate: any(named: 'onIceCandidate'),
        )).thenAnswer((_) async {});
    when(() => mockWebRtc.dispose()).thenAnswer((_) async {});
    when(() => mockWebRtc.setSpeakerphone(any())).thenAnswer((_) async {});
    when(() => mockWebRtc.upgradeToVideo()).thenAnswer((_) async {});

    when(() => mockPc.signalingState)
        .thenReturn(RTCSignalingState.RTCSignalingStateStable);
    when(() => mockPc.onRenegotiationNeeded).thenReturn(null);
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
    when(() => mockPc.restartIce()).thenAnswer((_) async {});

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

    when(() => mockRepo.answerCall(any())).thenAnswer((_) async {});
    when(() => mockRepo.getTurnCredentials())
        .thenAnswer((_) async => {'hasTurn': true, 'iceServers': []});
    when(() => mockRepo.endCall(any(), reason: any(named: 'reason')))
        .thenAnswer((_) async {});
  });

  tearDown(() {
    callDocController.close();
    iceCandidateController.close();
  });

  CallBloc buildBloc() => CallBloc(mockRepo, mockFactory, mockSignaling, mockAnalytics);

  group('Incoming Call Flow Integration', () {
    blocTest<CallBloc, CallState>(
      'incoming voice call → accept → connecting → active',
      build: buildBloc,
      act: (bloc) async {
        // 1. Incoming call arrives
        bloc.add(const CallEvent.incomingCall(
          callId: 'inc_v_1',
          callerName: 'Alice',
          callType: CallType.voice,
          conversationId: 'conv_inc_1',
          callerId: 'user_a',
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        // 2. User accepts
        bloc.add(const CallEvent.acceptCall());

        await Future.delayed(const Duration(milliseconds: 200));

        // 3. ICE connected
        bloc.add(const CallEvent.iceConnectionStateChanged(
          RTCIceConnectionState.RTCIceConnectionStateConnected,
        ));

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        // Ringing as callee
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.ringing)
            .having((s) => s.isCaller, 'isCaller', false)
            .having((s) => s.callId, 'callId', 'inc_v_1')
            .having((s) => s.remoteUserName, 'name', 'Alice'),
        // Connecting
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.connecting),
        // Active
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.active),
      ],
      verify: (_) {
        verify(() => mockRepo.answerCall('inc_v_1')).called(1);
        // Called twice: pre-fetch on incomingCall + accept flow
        verify(() => mockRepo.getTurnCredentials()).called(2);
      },
    );

    blocTest<CallBloc, CallState>(
      'incoming video call → accept → sets video callType',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const CallEvent.incomingCall(
          callId: 'inc_vid_1',
          callerName: 'Bob',
          callType: CallType.video,
          conversationId: 'conv_inc_2',
          callerId: 'user_b',
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        bloc.add(const CallEvent.acceptCall());

        await Future.delayed(const Duration(milliseconds: 200));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<CallState>()
            .having((s) => s.callType, 'callType', CallType.video)
            .having((s) => s.callId, 'callId', 'inc_vid_1'),
        // Connecting
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.connecting),
      ],
      verify: (_) {
        verify(() => mockRepo.answerCall('inc_vid_1')).called(1);
        // Video call should initialize with isVideo: true
        verify(() => mockWebRtc.initialize(
              isVideo: true,
              iceServers: any(named: 'iceServers'),
              onIceCandidate: any(named: 'onIceCandidate'),
            )).called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'incoming call → decline → sends rejected reason',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const CallEvent.incomingCall(
          callId: 'inc_dec_1',
          callerName: 'Charlie',
          callType: CallType.voice,
          conversationId: 'conv_dec',
          callerId: 'user_c',
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        bloc.add(const CallEvent.rejectCall());

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        // Ringing
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.ringing)
            .having((s) => s.callId, 'callId', 'inc_dec_1'),
        // Idle after rejection
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.idle),
      ],
      verify: (_) {
        verify(() => mockRepo.endCall('inc_dec_1', reason: 'declined'))
            .called(1);
      },
    );

    blocTest<CallBloc, CallState>(
      'incoming call → remote cancels before accept → idle',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const CallEvent.incomingCall(
          callId: 'inc_cancel_1',
          callerName: 'Dave',
          callType: CallType.voice,
          conversationId: 'conv_cancel',
          callerId: 'user_d',
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        // Remote caller cancels via call doc update
        bloc.add(CallEvent.callDocUpdated(
          CallSession(
            callId: 'inc_cancel_1',
            conversationId: 'conv_cancel',
            callerId: 'user_d',
            calleeId: 'me',
            callerName: 'Dave',
            callType: CallType.voice,
            status: CallStatus.cancelled,
          ),
        ));

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        // Ringing
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.ringing)
            .having((s) => s.callId, 'callId', 'inc_cancel_1'),
        // Remote cancelled → idle
        isA<CallState>()
            .having((s) => s.status, 'status', CallStatus.idle),
      ],
    );

    blocTest<CallBloc, CallState>(
      'incoming call includes avatar URL in state',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const CallEvent.incomingCall(
          callId: 'inc_avatar_1',
          callerName: 'Eve',
          callerAvatarUrl: 'https://example.com/avatar.png',
          callType: CallType.voice,
          conversationId: 'conv_avatar',
          callerId: 'user_e',
        ));

        await Future.delayed(const Duration(milliseconds: 100));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CallState>()
            .having((s) => s.remoteUserName, 'name', 'Eve')
            .having((s) => s.remoteUserAvatarUrl, 'avatar',
                'https://example.com/avatar.png'),
      ],
    );
  });
}
