import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

/// W3C Perfect Negotiation pattern for glare-free SDP exchange.
///
/// Caller is "impolite" (ignores colliding offers when making one).
/// Callee is "polite" (rolls back own offer when a collision occurs).
///
/// All SDP exchange goes through this handler — no manual createOffer/createAnswer
/// anywhere else in the codebase.
///
/// Reference: https://w3c.github.io/webrtc-pc/#perfect-negotiation-example
class PerfectNegotiationHandler {
  final RTCPeerConnection pc;

  /// true = polite (callee), false = impolite (caller).
  final bool polite;

  /// Callback to send a description (offer or answer) to the remote peer
  /// via Firestore signaling.
  final Future<void> Function(RTCSessionDescription desc) sendDescription;

  bool _makingOffer = false;
  bool _ignoreOffer = false;

  PerfectNegotiationHandler({
    required this.pc,
    required this.polite,
    required this.sendDescription,
  }) {
    // The PC fires onRenegotiationNeeded when tracks are added/removed or
    // transceiver directions change. This is our single entry point for
    // creating offers.
    pc.onRenegotiationNeeded = () => _onNegotiationNeeded();
  }

  /// Called when the peer connection needs renegotiation.
  Future<void> _onNegotiationNeeded() async {
    try {
      _makingOffer = true;
      final offer = await pc.createOffer();
      await pc.setLocalDescription(offer);
      final localDesc = await pc.getLocalDescription();
      if (localDesc != null) {
        await sendDescription(localDesc);
      }
    } catch (e) {
      debugPrint('PerfectNegotiation: onNegotiationNeeded error: $e');
    } finally {
      _makingOffer = false;
    }
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
        debugPrint('PerfectNegotiation: ignoring colliding offer (impolite)');
        return;
      }

      // W3C spec: polite peer must rollback own offer before accepting remote
      if (offerCollision && polite) {
        await pc.setLocalDescription(
            RTCSessionDescription('', 'rollback'));
      }

      await pc.setRemoteDescription(description);

      if (description.type == 'offer') {
        final answer = await pc.createAnswer();
        await pc.setLocalDescription(answer);
        final localDesc = await pc.getLocalDescription();
        if (localDesc != null) {
          await sendDescription(localDesc);
        }
      }
    } catch (e) {
      debugPrint('PerfectNegotiation: handleDescription error: $e');
    }
  }

  /// Handle a remote ICE candidate from signaling.
  Future<void> handleCandidate(RTCIceCandidate candidate) async {
    try {
      if (!_ignoreOffer) {
        await pc.addCandidate(candidate);
      }
    } catch (e) {
      // Non-fatal: a single dropped candidate is recoverable via ICE restart
      debugPrint('PerfectNegotiation: addCandidate error: $e');
    }
  }

  /// Explicitly trigger renegotiation (create and send an offer).
  ///
  /// Must be called on the CALLER side after construction, because
  /// `onRenegotiationNeeded` from `addTrack()` fires during
  /// `WebRtcService.initialize()` when `pc.onRenegotiationNeeded` is still
  /// null — so the event is silently dropped. This method compensates.
  Future<void> negotiate() => _onNegotiationNeeded();

  /// Dispose — remove the onRenegotiationNeeded handler.
  void dispose() {
    pc.onRenegotiationNeeded = null;
  }
}
