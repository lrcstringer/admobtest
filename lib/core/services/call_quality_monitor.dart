import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../domain/enums/connection_quality.dart';

/// Monitors WebRTC call quality by polling getStats() every 2 seconds.
///
/// Calculates RTT, packet loss, and jitter to classify connection quality.
/// Adjusts video bitrate adaptively based on quality with hysteresis to
/// prevent thrashing between levels.
///
/// Not a singleton — created per call, disposed when call ends.
class CallQualityMonitor {
  final RTCPeerConnection _pc;
  Timer? _pollTimer;
  bool _isDisposed = false;
  bool _isAdjusting = false;

  final _qualityController = StreamController<ConnectionQuality>.broadcast();

  Stream<ConnectionQuality> get onQualityChanged => _qualityController.stream;

  // Previous stats for delta calculation
  int _prevPacketsLost = 0;
  int _prevPacketsReceived = 0;

  // Hysteresis: require N consecutive readings at a new level before changing
  ConnectionQuality _currentQuality = ConnectionQuality.excellent;
  ConnectionQuality? _pendingQuality;
  int _pendingCount = 0;
  static const _hysteresisThreshold = 2; // 2 polls = 4 seconds

  CallQualityMonitor(this._pc);

  /// Start polling stats every 2 seconds.
  void start() {
    _pollTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _pollStats();
    });
  }

  Future<void> _pollStats() async {
    if (_isDisposed) return;

    try {
      final stats = await _pc.getStats();
      double rtt = 0;
      double packetLossRate = 0;
      double jitter = 0;
      int currentPacketsLost = 0;
      int currentPacketsReceived = 0;

      for (final report in stats) {
        final values = report.values;

        // Candidate pair stats (RTT)
        // W3C spec: currentRoundTripTime is in seconds
        if (report.type == 'candidate-pair' &&
            values['state'] == 'succeeded') {
          rtt = (values['currentRoundTripTime'] as num?)?.toDouble() ?? 0;
          rtt *= 1000; // Convert seconds → ms
        }

        // Inbound RTP stats (packet loss, jitter)
        // W3C spec: jitter is in seconds
        if (report.type == 'inbound-rtp' && values['kind'] == 'audio') {
          currentPacketsLost = (values['packetsLost'] as num?)?.toInt() ?? 0;
          currentPacketsReceived =
              (values['packetsReceived'] as num?)?.toInt() ?? 0;
          jitter = (values['jitter'] as num?)?.toDouble() ?? 0;
          jitter *= 1000; // Convert seconds → ms
        }

        // Remote inbound RTP stats (alternative RTT source)
        if (report.type == 'remote-inbound-rtp') {
          final reportRtt =
              (values['roundTripTime'] as num?)?.toDouble() ?? 0;
          if (reportRtt > 0 && rtt == 0) {
            rtt = reportRtt * 1000;
          }
        }
      }

      // Calculate packet loss rate (delta-based).
      // Clamp deltas to >= 0: SSRC changes (codec switch, ICE restart) reset
      // cumulative counters, producing negative deltas.
      final deltaLost =
          (currentPacketsLost - _prevPacketsLost).clamp(0, 1 << 30);
      final deltaReceived =
          (currentPacketsReceived - _prevPacketsReceived).clamp(0, 1 << 30);
      if (deltaReceived + deltaLost > 0) {
        packetLossRate = deltaLost / (deltaReceived + deltaLost) * 100;
      }

      _prevPacketsLost = currentPacketsLost;
      _prevPacketsReceived = currentPacketsReceived;

      // Classify quality
      final rawQuality = _classifyQuality(rtt, packetLossRate, jitter);

      // Hysteresis: only change quality level after N consecutive readings
      // at the new level. This prevents bitrate thrashing on transient spikes.
      final quality = _applyHysteresis(rawQuality);

      if (!_isDisposed && !_qualityController.isClosed) {
        _qualityController.add(quality);
      }

      // Adaptive bitrate (serialized — no overlapping adjustments)
      if (!_isAdjusting) {
        _isAdjusting = true;
        try {
          await _adjustBitrate(quality);
        } finally {
          _isAdjusting = false;
        }
      }
    } catch (e) {
      debugPrint('CallQualityMonitor: getStats error: $e');
    }
  }

  ConnectionQuality _applyHysteresis(ConnectionQuality rawQuality) {
    if (rawQuality == _currentQuality) {
      // Stable — reset pending
      _pendingQuality = null;
      _pendingCount = 0;
      return _currentQuality;
    }

    if (rawQuality == _pendingQuality) {
      _pendingCount++;
      if (_pendingCount >= _hysteresisThreshold) {
        // Sustained change — adopt new level
        _currentQuality = rawQuality;
        _pendingQuality = null;
        _pendingCount = 0;
        return _currentQuality;
      }
    } else {
      // New candidate — start counting
      _pendingQuality = rawQuality;
      _pendingCount = 1;
    }

    return _currentQuality; // Hold current level until threshold met
  }

  ConnectionQuality _classifyQuality(
    double rttMs,
    double packetLossPercent,
    double jitterMs,
  ) {
    if (rttMs < 100 && packetLossPercent < 1 && jitterMs < 20) {
      return ConnectionQuality.excellent;
    } else if (rttMs < 200 && packetLossPercent < 3 && jitterMs < 40) {
      return ConnectionQuality.good;
    } else if (rttMs < 400 && packetLossPercent < 5 && jitterMs < 60) {
      return ConnectionQuality.fair;
    } else {
      return ConnectionQuality.poor;
    }
  }

  Future<void> _adjustBitrate(ConnectionQuality quality) async {
    try {
      final senders = await _pc.getSenders();
      for (final sender in senders) {
        if (sender.track?.kind == 'video') {
          final params = sender.parameters;
          if (params.encodings != null && params.encodings!.isNotEmpty) {
            final encoding = params.encodings!.first;
            switch (quality) {
              case ConnectionQuality.excellent:
                encoding.maxBitrate = 1500000; // 1.5 Mbps
              case ConnectionQuality.good:
                encoding.maxBitrate = 800000; // 800 kbps
              case ConnectionQuality.fair:
                encoding.maxBitrate = 400000; // 400 kbps
              case ConnectionQuality.poor:
                encoding.maxBitrate = 150000; // 150 kbps
            }
            await sender.setParameters(params);
          }
        }
      }
    } catch (e) {
      debugPrint('CallQualityMonitor: adjustBitrate error: $e');
    }
  }

  void dispose() {
    _isDisposed = true;
    _pollTimer?.cancel();
    _pollTimer = null;
    _qualityController.close();
  }
}
