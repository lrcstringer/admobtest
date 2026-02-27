import 'dart:typed_data';

import '../protocol/double_ratchet.dart';
import '../protocol/header.dart';
import 'session_state.dart';

/// Sesame-style multi-session record for a single peer.
///
/// Per the Sesame spec (https://signal.org/docs/specifications/sesame/),
/// a session record holds:
/// - An active session (used for encrypting outgoing messages)
/// - Archived sessions (tried on decrypt if active session fails)
///
/// When a peer re-establishes a session (new X3DH), the old active session
/// is archived and the new one becomes active. On decrypt, all sessions
/// are tried — if an archived session succeeds, it is promoted to active.
///
/// For the current single-device model, this primarily handles the case
/// where the peer reinstalls or rotates keys while we still have an old
/// session cached.
class SessionRecord {
  /// Maximum number of archived sessions to retain.
  static const maxArchivedSessions = 40;

  /// The active session used for encrypting outgoing messages.
  SessionState? activeSession;

  /// Archived sessions tried on decrypt (newest first).
  List<SessionState> archivedSessions;

  /// Pending X3DH header to include in outgoing messages (initiator only).
  /// Contains: identityKey, ephemeralKey, signedPreKeyId, oneTimePreKeyId.
  Map<String, dynamic>? pendingX3dhHeader;

  /// Peer's X3DH ephemeral key (base64) from last session establishment.
  /// Used to detect when the peer re-establishes (changed ephemeral key).
  String? peerX3dhEphemeralKey;

  SessionRecord({
    this.activeSession,
    List<SessionState>? archivedSessions,
    this.pendingX3dhHeader,
    this.peerX3dhEphemeralKey,
  }) : archivedSessions = archivedSessions ?? [];

  /// Whether this record has any session (active or archived).
  bool get hasSession => activeSession != null || archivedSessions.isNotEmpty;

  /// Set a new active session, archiving the previous one.
  void promoteState(SessionState newActive) {
    if (activeSession != null) {
      archivedSessions.insert(0, activeSession!);
      if (archivedSessions.length > maxArchivedSessions) {
        archivedSessions = archivedSessions.sublist(0, maxArchivedSessions);
      }
    }
    activeSession = newActive;
  }

  /// Try to decrypt a message using all available sessions.
  ///
  /// Tries the active session first, then each archived session.
  /// On success with an archived session, that session is promoted to active.
  ///
  /// Returns the decrypted plaintext and updated session state, or null
  /// if no session could decrypt the message.
  Future<({SessionState updatedState, String plaintext})?> tryDecryptAll(
    SpecDoubleRatchet ratchet,
    MessageHeader header,
    Uint8List ciphertext,
  ) async {
    // Try active session first
    if (activeSession != null) {
      try {
        final result = await ratchet.decrypt(
          activeSession!,
          header,
          ciphertext,
        );
        activeSession = result.state;
        return (updatedState: result.state, plaintext: result.plaintext);
      } catch (_) {
        // Active session failed — try archived
      }
    }

    // Try archived sessions
    for (var i = 0; i < archivedSessions.length; i++) {
      try {
        final result = await ratchet.decrypt(
          archivedSessions[i],
          header,
          ciphertext,
        );
        // Promote this archived session to active
        archivedSessions.removeAt(i);
        if (activeSession != null) {
          archivedSessions.insert(0, activeSession!);
        }
        activeSession = result.state;
        return (updatedState: result.state, plaintext: result.plaintext);
      } catch (_) {
        // This archived session didn't work either
      }
    }

    return null; // No session could decrypt
  }

  /// Serialize to JSON for persistence.
  Map<String, dynamic> toJson() {
    return {
      'activeSession': activeSession?.toJson(),
      'archivedSessions':
          archivedSessions.map((s) => s.toJson()).toList(),
      if (pendingX3dhHeader != null) 'pendingX3dhHeader': pendingX3dhHeader,
      if (peerX3dhEphemeralKey != null)
        'peerX3dhEphemeralKey': peerX3dhEphemeralKey,
    };
  }

  /// Deserialize from JSON.
  factory SessionRecord.fromJson(Map<String, dynamic> json) {
    final archivedRaw = json['archivedSessions'] as List<dynamic>? ?? [];
    return SessionRecord(
      activeSession: json['activeSession'] != null
          ? SessionState.fromJson(
              json['activeSession'] as Map<String, dynamic>)
          : null,
      archivedSessions: archivedRaw
          .map((e) => SessionState.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingX3dhHeader:
          json['pendingX3dhHeader'] as Map<String, dynamic>?,
      peerX3dhEphemeralKey: json['peerX3dhEphemeralKey'] as String?,
    );
  }
}
