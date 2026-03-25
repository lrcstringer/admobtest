import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'webrtc_service.dart';

/// W3C Perfect Negotiation pattern for glare-free SDP exchange.
///
/// Caller is "impolite" (ignores colliding offers when making one).
/// Callee is "polite" (rolls back own offer when a collision occurs).
///
/// All SDP exchange goes through this handler — no manual createOffer/createAnswer
/// anywhere else in the codebase.
///
/// Applies Opus codec optimizations (FEC, DTX, bitrate cap) to all outgoing SDPs.
///
/// Reference: https://w3c.github.io/webrtc-pc/#perfect-negotiation-example
class PerfectNegotiationHandler {
  final RTCPeerConnection pc;

  /// true = polite (callee), false = impolite (caller).
  final bool polite;

  /// Callback to send a description (offer or answer) to the remote peer
  /// via RTDB signaling.
  final Future<void> Function(RTCSessionDescription desc) sendDescription;

  bool _makingOffer = false;
  bool _ignoreOffer = false;

  /// Whether setRemoteDescription has been called on the peer connection.
  /// ICE candidates received before this point are queued and flushed once
  /// the remote description is set, preventing silent addCandidate failures.
  bool _hasRemoteDescription;

  /// ICE candidates buffered while waiting for the remote description.
  final List<RTCIceCandidate> _pendingCandidates = [];

  PerfectNegotiationHandler({
    required this.pc,
    required this.polite,
    required this.sendDescription,
    /// Pass true when the peer connection already has a remote description
    /// set before this handler is created (callee manually sets it in
    /// _onAcceptCall before constructing PerfectNegotiationHandler).
    bool initialRemoteDescriptionSet = false,
  }) : _hasRemoteDescription = initialRemoteDescriptionSet {
    // The PC fires onRenegotiationNeeded when tracks are added/removed or
    // transceiver directions change. This is our single entry point for
    // creating offers.
    pc.onRenegotiationNeeded = () => _onNegotiationNeeded();
  }

  /// Core offer-creation logic. Throws on failure so callers can decide
  /// whether to propagate or swallow the error.
  Future<void> _doNegotiate() async {
    // Re-entrant guard: if we're already creating an offer, skip. The in-flight
    // offer will include any pending track/transceiver changes. Without this,
    // a second call while the first await is suspended can corrupt _makingOffer.
    if (_makingOffer) return;
    _makingOffer = true;
    try {
      final offer = await pc.createOffer();
      // Apply Opus optimizations (FEC, DTX, bitrate cap) before setting local
      final optimizedOffer = WebRtcService.optimizeSdp(offer);
      await pc.setLocalDescription(optimizedOffer);
      final localDesc = await pc.getLocalDescription();
      if (localDesc != null) {
        await sendDescription(localDesc);
      }
    } finally {
      _makingOffer = false;
    }
  }

  /// Called when the peer connection needs renegotiation (automatic callback).
  /// Errors are swallowed — we cannot propagate from a PC callback.
  Future<void> _onNegotiationNeeded() async {
    try {
      await _doNegotiate();
    } catch (_) {}
  }

  /// Handle a remote SDP description (offer or answer) from signaling.
  ///
  /// This implements the "Perfect Negotiation" glare resolution:
  /// - If we receive an offer while we're making one (glare):
  ///   - Polite peer: rolls back own offer, accepts remote
  ///   - Impolite peer: ignores the incoming offer
  Future<void> handleDescription(RTCSessionDescription description) async {
    try {
      final offerCollision =
          description.type == 'offer' &&
          (_makingOffer || pc.signalingState != RTCSignalingState.RTCSignalingStateStable);

      _ignoreOffer = !polite && offerCollision;
      if (_ignoreOffer) {
        return;
      }

      // W3C spec: polite peer must rollback own offer before accepting remote
      if (offerCollision && polite) {
        await pc.setLocalDescription(
            RTCSessionDescription('', 'rollback'));
      }

      await pc.setRemoteDescription(description);
      _hasRemoteDescription = true;

      // Flush any ICE candidates that arrived before the remote description.
      // This prevents silent addCandidate failures on the caller's side when
      // callee ICE candidates reach the caller before the callee's answer.
      if (_pendingCandidates.isNotEmpty) {
        final toAdd = List<RTCIceCandidate>.from(_pendingCandidates);
        _pendingCandidates.clear();
        for (final candidate in toAdd) {
          try {
            await pc.addCandidate(candidate);
          } catch (_) {
            // Non-fatal: a single dropped candidate is recoverable via ICE restart
          }
        }
      }

      if (description.type == 'offer') {
        final answer = await pc.createAnswer();
        final optimizedAnswer = WebRtcService.optimizeSdp(answer);
        await pc.setLocalDescription(optimizedAnswer);
        final localDesc = await pc.getLocalDescription();
        if (localDesc != null) {
          await sendDescription(localDesc);
        }
      }
    } catch (_) {
      // Non-fatal: glare resolution or SDP errors during renegotiation
    }
  }

  /// Handle a remote ICE candidate from signaling.
  ///
  /// If the remote description is not yet set, the candidate is queued and
  /// will be applied once [handleDescription] sets the remote description.
  Future<void> handleCandidate(RTCIceCandidate candidate) async {
    try {
      if (_ignoreOffer) return;
      if (_hasRemoteDescription) {
        await pc.addCandidate(candidate);
      } else {
        _pendingCandidates.add(candidate);
      }
    } catch (e) {
      // Non-fatal: a single dropped candidate is recoverable via ICE restart
    }
  }

  /// Explicitly trigger renegotiation (create and send an offer).
  ///
  /// Must be called on the CALLER side after construction, because
  /// `onRenegotiationNeeded` from `addTrack()` fires during
  /// `WebRtcService.initialize()` when `pc.onRenegotiationNeeded` is still
  /// null — so the event is silently dropped. This method compensates.
  ///
  /// Unlike [_onNegotiationNeeded], this propagates exceptions so that
  /// call setup failures are surfaced to the BLoC error handler.
  Future<void> negotiate() => _doNegotiate();

  /// Dispose — remove the onRenegotiationNeeded handler and clear queue.
  void dispose() {
    pc.onRenegotiationNeeded = null;
    _pendingCandidates.clear();
  }
}
