import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/webrtc_service.dart';

void main() {
  group('WebRtcService', () {
    test('initializes with correct default state', () {
      final service = WebRtcService();

      expect(service.peerConnection, isNull);
      expect(service.localStream, isNull);
      expect(service.isFrontCamera, isTrue);
      expect(service.isAudioEnabled, isTrue);
      expect(service.isVideoEnabled, isTrue);
      expect(service.isSpeakerOn, isFalse);
      expect(service.isDisposed, isFalse);
    });

    test('streams are accessible before initialization', () {
      final service = WebRtcService();

      expect(service.onRemoteStream, isNotNull);
      expect(service.onLocalStream, isNotNull);
      expect(service.onConnectionState, isNotNull);
      expect(service.onIceConnectionState, isNotNull);
      expect(service.onIceGatheringState, isNotNull);
    });

    test('dispose sets isDisposed flag', () async {
      final service = WebRtcService();
      await service.dispose();

      expect(service.isDisposed, isTrue);
    });

    test('dispose is idempotent — calling twice does not throw', () async {
      final service = WebRtcService();
      await service.dispose();
      await service.dispose(); // Should not throw

      expect(service.isDisposed, isTrue);
    });

    test('toggleMute is safe when localStream is null', () {
      final service = WebRtcService();
      // Should not throw
      service.toggleMute();
      expect(service.isAudioEnabled, isTrue); // Unchanged
    });

    test('toggleVideo is safe when localStream is null', () {
      final service = WebRtcService();
      service.toggleVideo();
      expect(service.isVideoEnabled, isTrue); // Unchanged
    });

    test('switchCamera is safe when localStream is null', () async {
      final service = WebRtcService();
      await service.switchCamera(); // Should not throw
    });
  });

  group('WebRtcServiceFactory', () {
    test('create() returns a new instance each time', () {
      final factory = WebRtcServiceFactory();
      final a = factory.create();
      final b = factory.create();

      expect(a, isNot(same(b)));
    });
  });
}
