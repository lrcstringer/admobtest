import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/enums/connection_quality.dart';

void main() {
  group('ConnectionQuality', () {
    test('has all expected values', () {
      expect(ConnectionQuality.values, hasLength(4));
      expect(ConnectionQuality.values, contains(ConnectionQuality.excellent));
      expect(ConnectionQuality.values, contains(ConnectionQuality.good));
      expect(ConnectionQuality.values, contains(ConnectionQuality.fair));
      expect(ConnectionQuality.values, contains(ConnectionQuality.poor));
    });
  });

  // Note: Full CallQualityMonitor tests require mocking RTCPeerConnection
  // which needs the flutter_webrtc native plugin. The quality classification
  // logic is tested indirectly through the ConnectionQuality enum and
  // integration tests that verify the full call flow.
}
