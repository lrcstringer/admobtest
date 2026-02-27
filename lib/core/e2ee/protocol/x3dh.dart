import 'dart:typed_data';

import '../../services/crypto_service.dart';
import '../session/session_state.dart';
import 'kdf.dart';

/// Spec-compliant X3DH (Extended Triple Diffie-Hellman) key agreement.
///
/// Implements X3DH as specified at:
/// https://signal.org/docs/specifications/x3dh/
///
/// Key differences from the legacy (v1) implementation:
/// - Prepends 32 bytes of 0xFF to the DH concatenation (deviation #1 fix)
/// - Uses 32 zero bytes as HKDF salt (deviation #2 fix)
/// - AD = IK_A || IK_B only, no header fields (deviation #7 fix)
/// - Uses application-specific info string "iMaliChat" (deviation #9 fix)
/// - SPK verification uses Ed25519 (separate key, pragmatic decision)
///
/// All methods are stateless — no I/O, no storage, no network.
class SpecX3dh {
  final CryptoService _crypto;
  final SignalKdf _kdf;

  SpecX3dh(this._crypto, this._kdf);

  /// Perform the initiator (Alice) side of X3DH.
  ///
  /// Alice fetches Bob's published key bundle and computes the shared secret
  /// and initial session state.
  ///
  /// Returns the shared secret (SK), associated data (AD), and initial
  /// [SessionState] for Alice's Double Ratchet session.
  ///
  /// Per spec §3.3:
  /// ```
  /// DH1 = DH(IK_A, SPK_B)
  /// DH2 = DH(EK_A, IK_B)
  /// DH3 = DH(EK_A, SPK_B)
  /// DH4 = DH(EK_A, OPK_B)     [if OPK available]
  /// SK  = KDF(F || DH1 || DH2 || DH3 [|| DH4])
  /// AD  = Encode(IK_A) || Encode(IK_B)
  /// ```
  Future<X3dhInitiatorResult> computeInitiator({
    required Uint8List ourIdentityPrivate,
    required Uint8List ourIdentityPublic,
    required Uint8List theirIdentityPublic,
    required Uint8List theirSignedPreKey,
    Uint8List? theirOneTimePreKey,
  }) async {
    // Generate ephemeral key pair
    final ephemeralKp = await _crypto.generateX25519KeyPair();
    final ephemeralPrivate = ephemeralKp['privateKey']!;
    final ephemeralPublic = ephemeralKp['publicKey']!;

    // Perform DH computations
    final dh1 = await _crypto.diffieHellman(ourIdentityPrivate, theirSignedPreKey);
    final dh2 = await _crypto.diffieHellman(ephemeralPrivate, theirIdentityPublic);
    final dh3 = await _crypto.diffieHellman(ephemeralPrivate, theirSignedPreKey);
    Uint8List? dh4;
    if (theirOneTimePreKey != null) {
      dh4 = await _crypto.diffieHellman(ephemeralPrivate, theirOneTimePreKey);
    }

    // Concatenate DH outputs (without 0xFF prefix — kdfX3dh adds it)
    final masterSecret = _concatDhOutputs(dh1, dh2, dh3, dh4);

    // Derive shared secret
    final sk = await _kdf.kdfX3dh(masterSecret);

    // Associated data: IK_A || IK_B
    final ad = _computeAd(ourIdentityPublic, theirIdentityPublic);

    // Generate Alice's first DH ratchet key pair
    final dhRatchetKp = await _crypto.generateX25519KeyPair();

    // Perform first KDF_RK to initialize Alice's send chain
    final dhOutput = await _crypto.diffieHellman(
      dhRatchetKp['privateKey']!,
      theirSignedPreKey,
    );
    final ratchetResult = await _kdf.kdfRk(sk, dhOutput);

    // Build initial session state for Alice
    final sessionState = SessionState(
      rootKey: ratchetResult.rootKey,
      sendChainKey: ratchetResult.chainKey,
      recvChainKey: null, // No recv chain until Bob replies
      dhSendPrivate: dhRatchetKp['privateKey']!,
      dhSendPublic: dhRatchetKp['publicKey']!,
      dhRecvPublic: theirSignedPreKey,
      localIdentityKey: ourIdentityPublic,
      remoteIdentityKey: theirIdentityPublic,
      isInitiator: true,
      createdAt: DateTime.now(),
    );

    return X3dhInitiatorResult(
      sharedSecret: sk,
      associatedData: ad,
      ephemeralPublic: ephemeralPublic,
      sessionState: sessionState,
    );
  }

  /// Perform the receiver (Bob) side of X3DH.
  ///
  /// Bob receives Alice's initial message containing her identity key,
  /// ephemeral key, and (optionally) which OTK she used.
  ///
  /// Returns the shared secret (SK), associated data (AD), and initial
  /// [SessionState] for Bob's Double Ratchet session.
  Future<X3dhReceiverResult> computeReceiver({
    required Uint8List ourIdentityPrivate,
    required Uint8List ourIdentityPublic,
    required Uint8List ourSignedPreKeyPrivate,
    required Uint8List ourSignedPreKeyPublic,
    required Uint8List theirIdentityPublic,
    required Uint8List theirEphemeralPublic,
    Uint8List? ourOneTimePreKeyPrivate,
  }) async {
    // Perform DH computations (mirror of initiator)
    final dh1 = await _crypto.diffieHellman(ourSignedPreKeyPrivate, theirIdentityPublic);
    final dh2 = await _crypto.diffieHellman(ourIdentityPrivate, theirEphemeralPublic);
    final dh3 = await _crypto.diffieHellman(ourSignedPreKeyPrivate, theirEphemeralPublic);
    Uint8List? dh4;
    if (ourOneTimePreKeyPrivate != null) {
      dh4 = await _crypto.diffieHellman(ourOneTimePreKeyPrivate, theirEphemeralPublic);
    }

    // Derive shared secret (same computation as initiator)
    final masterSecret = _concatDhOutputs(dh1, dh2, dh3, dh4);
    final sk = await _kdf.kdfX3dh(masterSecret);

    // Associated data: IK_A || IK_B (A = initiator = them, B = receiver = us)
    final ad = _computeAd(theirIdentityPublic, ourIdentityPublic);

    // Bob's initial session state.
    // Bob doesn't know Alice's DH ratchet key yet (it's in the first message).
    // The Double Ratchet decrypt() will handle the first DH ratchet step.
    final sessionState = SessionState(
      rootKey: sk,
      sendChainKey: null, // No send chain until Bob replies
      recvChainKey: null, // Will be derived on first decrypt
      dhSendPrivate: ourSignedPreKeyPrivate,
      dhSendPublic: ourSignedPreKeyPublic,
      dhRecvPublic: null, // Set when we see Alice's first message header
      localIdentityKey: ourIdentityPublic,
      remoteIdentityKey: theirIdentityPublic,
      isInitiator: false,
      createdAt: DateTime.now(),
    );

    return X3dhReceiverResult(
      sharedSecret: sk,
      associatedData: ad,
      sessionState: sessionState,
    );
  }

  /// Verify an Ed25519 signature on a signed pre-key.
  ///
  /// Bob signs his SPK with his Ed25519 signing key. Alice verifies
  /// the signature before using the SPK in the X3DH handshake.
  Future<bool> verifySignedPreKey({
    required Uint8List signedPreKey,
    required Uint8List signature,
    required Uint8List ed25519PublicKey,
  }) {
    return _crypto.ed25519Verify(signedPreKey, signature, ed25519PublicKey);
  }

  /// Generate an X25519 key pair.
  Future<Map<String, Uint8List>> generateKeyPair() {
    return _crypto.generateX25519KeyPair();
  }

  // ── Private Helpers ────────────────────────────────────────────────────

  /// Concatenate DH outputs: DH1 || DH2 || DH3 [|| DH4].
  ///
  /// Note: the 0xFF prefix is NOT added here — [SignalKdf.kdfX3dh] adds it.
  Uint8List _concatDhOutputs(
    Uint8List dh1,
    Uint8List dh2,
    Uint8List dh3,
    Uint8List? dh4,
  ) {
    final length = dh1.length + dh2.length + dh3.length + (dh4?.length ?? 0);
    final result = Uint8List(length);
    var offset = 0;
    result.setRange(offset, offset + dh1.length, dh1);
    offset += dh1.length;
    result.setRange(offset, offset + dh2.length, dh2);
    offset += dh2.length;
    result.setRange(offset, offset + dh3.length, dh3);
    offset += dh3.length;
    if (dh4 != null) {
      result.setRange(offset, offset + dh4.length, dh4);
    }
    return result;
  }

  /// Compute Associated Data: AD = Encode(IK_A) || Encode(IK_B).
  ///
  /// Per X3DH spec §3.3, AD is always ordered as initiator first,
  /// receiver second.
  Uint8List _computeAd(Uint8List ikInitiator, Uint8List ikReceiver) {
    final ad = Uint8List(ikInitiator.length + ikReceiver.length);
    ad.setAll(0, ikInitiator);
    ad.setAll(ikInitiator.length, ikReceiver);
    return ad;
  }
}

/// Result of the initiator (Alice) X3DH computation.
class X3dhInitiatorResult {
  final Uint8List sharedSecret;
  final Uint8List associatedData;
  final Uint8List ephemeralPublic;
  final SessionState sessionState;

  const X3dhInitiatorResult({
    required this.sharedSecret,
    required this.associatedData,
    required this.ephemeralPublic,
    required this.sessionState,
  });
}

/// Result of the receiver (Bob) X3DH computation.
class X3dhReceiverResult {
  final Uint8List sharedSecret;
  final Uint8List associatedData;
  final SessionState sessionState;

  const X3dhReceiverResult({
    required this.sharedSecret,
    required this.associatedData,
    required this.sessionState,
  });
}
