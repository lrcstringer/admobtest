import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';

/// Per-call WebRTC wrapper. Create via [WebRtcServiceFactory], dispose after
/// the call ends. NOT a singleton — each call gets a fresh instance to avoid
/// stale StreamController issues.
class WebRtcService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  RTCRtpTransceiver? _videoTransceiver;
  final List<RTCRtpSender> _senders = [];

  bool _isFrontCamera = true;
  bool _isAudioEnabled = true;
  bool _isVideoEnabled = true;
  bool _isSpeakerOn = false;
  bool _isDisposed = false;

  /// Callback to notify that renegotiation is needed after video upgrade.
  /// Set by CallBloc after PerfectNegotiationHandler is created.
  VoidCallback? onNeedRenegotiation;

  // Stream controllers — fresh per instance, safe to close once
  final _remoteStreamController = StreamController<MediaStream?>.broadcast();
  final _localStreamController = StreamController<MediaStream?>.broadcast();
  final _connectionStateController =
      StreamController<RTCPeerConnectionState>.broadcast();
  final _iceConnectionStateController =
      StreamController<RTCIceConnectionState>.broadcast();
  final _iceGatheringStateController =
      StreamController<RTCIceGatheringState>.broadcast();

  Stream<MediaStream?> get onRemoteStream => _remoteStreamController.stream;
  Stream<MediaStream?> get onLocalStream => _localStreamController.stream;
  Stream<RTCPeerConnectionState> get onConnectionState =>
      _connectionStateController.stream;
  Stream<RTCIceConnectionState> get onIceConnectionState =>
      _iceConnectionStateController.stream;
  Stream<RTCIceGatheringState> get onIceGatheringState =>
      _iceGatheringStateController.stream;

  RTCPeerConnection? get peerConnection => _peerConnection;
  MediaStream? get localStream => _localStream;
  bool get isFrontCamera => _isFrontCamera;
  bool get isAudioEnabled => _isAudioEnabled;
  bool get isVideoEnabled => _isVideoEnabled;
  bool get isSpeakerOn => _isSpeakerOn;
  bool get isDisposed => _isDisposed;

  /// Initialize peer connection and acquire local media.
  ///
  /// [isVideo]: true for video call, false for voice-only.
  /// [iceServers]: ICE server config from getTurnCredentials().
  /// [onIceCandidate]: callback for each local ICE candidate.
  Future<void> initialize({
    required bool isVideo,
    required Map<String, dynamic> iceServers,
    required void Function(RTCIceCandidate) onIceCandidate,
  }) async {
    // Safety: dispose previous state if initialize() called twice
    if (_peerConnection != null) {
      await dispose();
      _isDisposed = false; // Reset so this instance is usable
    }

    // Platform audio configuration (with timeout to prevent Bluetooth hangs)
    try {
      if (!kIsWeb && Platform.isAndroid) {
        await Helper.setAndroidAudioConfiguration(
          AndroidAudioConfiguration(
            androidAudioMode: AndroidAudioMode.inCommunication,
            androidAudioFocusMode: AndroidAudioFocusMode.gain,
            androidAudioStreamType: AndroidAudioStreamType.voiceCall,
          ),
        ).timeout(const Duration(seconds: 3));
      } else if (!kIsWeb && Platform.isIOS) {
        await Helper.setAppleAudioConfiguration(
          AppleAudioConfiguration(
            appleAudioCategory: AppleAudioCategory.playAndRecord,
            appleAudioCategoryOptions: {
              AppleAudioCategoryOption.allowBluetooth,
              AppleAudioCategoryOption.allowBluetoothA2DP,
              AppleAudioCategoryOption.defaultToSpeaker,
            },
            appleAudioMode: AppleAudioMode.voiceChat,
          ),
        ).timeout(const Duration(seconds: 3));
      }
    } catch (e) {
      // Audio config failure is non-fatal — call proceeds with default routing
      debugPrint('WebRtcService: audio config timeout/error (non-fatal): $e');
    }

    // Create peer connection with ICE candidate pooling for faster setup.
    // iceCandidatePoolSize pre-gathers candidates before createOffer(),
    // saving ~200-500ms from the offer creation path.
    _peerConnection = await createPeerConnection(
      {
        ...iceServers,
        'iceCandidatePoolSize': 1,
      },
      {
        'optional': [
          {'DtlsSrtpKeyAgreement': true},
        ],
      },
    );

    // Register event handlers
    _peerConnection!.onIceCandidate = (candidate) {
      if (candidate.candidate != null && !_isDisposed) {
        onIceCandidate(candidate);
      }
    };

    _peerConnection!.onTrack = (event) {
      if (event.streams.isNotEmpty && !_isDisposed) {
        _remoteStream = event.streams.first;
        _remoteStreamController.add(_remoteStream);
      }
    };

    _peerConnection!.onConnectionState = (state) {
      if (!_isDisposed) _connectionStateController.add(state);
    };

    _peerConnection!.onIceConnectionState = (state) {
      if (!_isDisposed) _iceConnectionStateController.add(state);
    };

    _peerConnection!.onIceGatheringState = (state) {
      if (!_isDisposed) _iceGatheringStateController.add(state);
    };

    // Acquire local media
    try {
      debugPrint('WebRtcService: getUserMedia isVideo=$isVideo');
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': {
          'echoCancellation': true,
          'noiseSuppression': true,
          'autoGainControl': true,
        },
        'video': isVideo
            ? {
                'width': {'ideal': 480},
                'height': {'ideal': 640},
                'frameRate': {'ideal': 24},
                'facingMode': 'user',
              }
            : false,
      });
      debugPrint('WebRtcService: getUserMedia success — '
          'tracks: ${_localStream!.getTracks().length}');
    } catch (e) {
      debugPrint('WebRtcService: getUserMedia FAILED: $e');
      await dispose();
      rethrow; // Permission denied or hardware failure
    }
    _localStreamController.add(_localStream);

    // Add tracks to peer connection
    for (final track in _localStream!.getTracks()) {
      final sender = await _peerConnection!.addTrack(track, _localStream!);
      _senders.add(sender);
    }

    // Reserve video transceiver for voice calls (enables upgrade without full renegotiation)
    if (!isVideo) {
      _videoTransceiver = await _peerConnection!.addTransceiver(
        kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
        init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.RecvOnly),
      );
    }
  }

  // ── SDP Optimization ──

  /// Optimize Opus codec parameters in the SDP for voice calls:
  /// - useinbandfec=1: Forward Error Correction for lossy networks
  /// - usedtx=1: Discontinuous Transmission — saves bandwidth during silence
  /// - maxaveragebitrate=32000: Cap bandwidth for voice (32 kbps is high quality mono)
  /// - stereo=0: Mono for voice calls (saves bandwidth)
  static RTCSessionDescription optimizeSdp(RTCSessionDescription desc) {
    if (desc.sdp == null) return desc;
    var sdp = desc.sdp!;

    // Find the Opus fmtp line and append parameters
    final opusPayloadRegex = RegExp(r'a=rtpmap:(\d+) opus/48000/2');
    final match = opusPayloadRegex.firstMatch(sdp);
    if (match != null) {
      final payloadType = match.group(1);
      final fmtpPrefix = 'a=fmtp:$payloadType';
      if (sdp.contains(fmtpPrefix)) {
        // Append to existing fmtp line if params not already present
        sdp = sdp.replaceAllMapped(
          RegExp('($fmtpPrefix [^\r\n]*)'),
          (m) {
            var line = m.group(1)!;
            if (!line.contains('useinbandfec')) {
              line += ';useinbandfec=1';
            }
            if (!line.contains('usedtx')) {
              line += ';usedtx=1';
            }
            if (!line.contains('maxaveragebitrate')) {
              line += ';maxaveragebitrate=32000';
            }
            if (!line.contains('stereo')) {
              line += ';stereo=0';
            }
            return line;
          },
        );
      } else {
        // No fmtp line for Opus — add one after the rtpmap line
        sdp = sdp.replaceFirst(
          match.group(0)!,
          '${match.group(0)}\r\n$fmtpPrefix '
              'minptime=10;useinbandfec=1;usedtx=1;'
              'maxaveragebitrate=32000;stereo=0',
        );
      }
    }

    return RTCSessionDescription(sdp, desc.type);
  }

  // ── Media Controls ──

  void toggleMute() {
    if (_localStream == null) return;
    final audioTracks = _localStream!.getAudioTracks();
    if (audioTracks.isEmpty) return;
    final audioTrack = audioTracks.first;
    audioTrack.enabled = !audioTrack.enabled;
    _isAudioEnabled = audioTrack.enabled;
  }

  void toggleVideo() {
    if (_localStream == null) return;
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;
    videoTracks.first.enabled = !videoTracks.first.enabled;
    _isVideoEnabled = videoTracks.first.enabled;
  }

  Future<void> switchCamera() async {
    if (_localStream == null) return;
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;
    await Helper.switchCamera(videoTracks.first);
    _isFrontCamera = !_isFrontCamera;
  }

  Future<void> toggleSpeaker() async {
    _isSpeakerOn = !_isSpeakerOn;
    await Helper.setSpeakerphoneOn(_isSpeakerOn);
  }

  /// Explicitly set speakerphone on or off (non-toggle).
  /// Used to force earpiece for voice calls on iOS where the audio session
  /// config includes defaultToSpeaker for Bluetooth compatibility.
  Future<void> setSpeakerphone(bool enabled) async {
    _isSpeakerOn = enabled;
    await Helper.setSpeakerphoneOn(enabled);
  }

  /// Upgrade voice call to video by replacing the reserved transceiver's track.
  Future<void> upgradeToVideo() async {
    final mediaStream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'width': {'ideal': 480},
        'height': {'ideal': 640},
        'frameRate': {'ideal': 24},
        'facingMode': 'user',
      },
    });
    final videoTrack = mediaStream.getVideoTracks().first;

    try {
      if (_videoTransceiver != null) {
        await _videoTransceiver!.sender.replaceTrack(videoTrack);
        await _videoTransceiver!
            .setDirection(TransceiverDirection.SendRecv);
      }

      // Add video track to local stream for preview
      _localStream?.addTrack(videoTrack);
      _localStreamController.add(_localStream);
      _isVideoEnabled = true;

      // Explicitly notify that renegotiation is needed
      // (setDirection doesn't always fire onRenegotiationNeeded on all platforms)
      onNeedRenegotiation?.call();
    } catch (e) {
      // Clean up the acquired track so the camera light turns off
      await videoTrack.stop();
      rethrow;
    }
  }

  // ── Cleanup ──

  Future<void> dispose() async {
    if (_isDisposed) return;
    _isDisposed = true;

    // 1. Stop all local tracks (use for loop, NOT forEach with async)
    for (final track in _localStream?.getTracks() ?? <MediaStreamTrack>[]) {
      await track.stop();
    }

    // 2. Dispose local stream
    await _localStream?.dispose();
    _localStream = null;
    if (!_localStreamController.isClosed) {
      _localStreamController.add(null);
    }

    // 3. Close peer connection
    await _peerConnection?.close();
    _peerConnection = null;

    // 4. Clear state
    _senders.clear();
    _videoTransceiver = null;
    _remoteStream = null;
    if (!_remoteStreamController.isClosed) {
      _remoteStreamController.add(null);
    }

    // 5. Close all stream controllers
    _remoteStreamController.close();
    _localStreamController.close();
    _connectionStateController.close();
    _iceConnectionStateController.close();
    _iceGatheringStateController.close();
  }
}

/// Factory registered with GetIt. Creates fresh [WebRtcService] per call.
@lazySingleton
class WebRtcServiceFactory {
  WebRtcService create() => WebRtcService();
}
