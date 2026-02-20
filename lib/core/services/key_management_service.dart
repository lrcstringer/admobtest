import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart' as hmac_lib;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/e2ee_types.dart';
import 'crypto_service.dart';

/// Manages the Signal Protocol key lifecycle: generation, upload, fetch,
/// rotation, and secure local storage of private keys.
@lazySingleton
class KeyManagementService {
  final CryptoService _cryptoService;
  final FlutterSecureStorage _secureStorage;
  final FirebaseFunctions _functions;

  KeyManagementService(this._cryptoService, this._secureStorage, this._functions);

  // Storage key constants
  static const _identityKeyKey = 'e2ee_identity_key';
  static const _signedPreKeyKey = 'e2ee_signed_pre_key';
  static const _signedPreKeySigKey = 'e2ee_signed_pre_key_sig';
  static const _otkKey = 'e2ee_one_time_pre_keys';
  static const _regIdKey = 'e2ee_registration_id';
  static const _ed25519KeyKey = 'e2ee_ed25519_identity_key';
  static const _ed25519SigKey = 'e2ee_ed25519_signature';
  static const _otkThreshold = 5;
  static const _otkBatchSize = 10;

  /// Generate a full key bundle (identity key pair, signed pre-key,
  /// one-time pre-keys) for initial device registration.
  Future<KeyBundle> generateKeyBundle() async {
    // X25519 identity key pair (for DH)
    final identityKp = await _cryptoService.generateX25519KeyPair();
    final identityEncoded = _encodeKeyPair(identityKp);

    // Ed25519 signing key pair (for verifiable signatures)
    final ed25519Kp = await _cryptoService.generateEd25519KeyPair();
    final ed25519Encoded = _encodeKeyPair(ed25519Kp);

    // Signed pre-key pair
    final signedPreKp = await _cryptoService.generateX25519KeyPair();
    final signedPreEncoded = _encodeKeyPair(signedPreKp);

    // Legacy HMAC "signature" (kept for backward compatibility)
    final hmacSig = _signKey(identityKp['privateKey']!, signedPreKp['publicKey']!);
    final hmacSigBase64 = base64Encode(hmacSig);

    // Ed25519 signature over the signed pre-key's public key bytes
    final ed25519Sig = await _cryptoService.ed25519Sign(
      signedPreKp['publicKey']!,
      ed25519Kp['privateKey']!,
    );
    final ed25519SigBase64 = base64Encode(ed25519Sig);

    // One-time pre-keys
    final otks = <String>[];
    for (var i = 0; i < _otkBatchSize; i++) {
      final otkKp = await _cryptoService.generateX25519KeyPair();
      otks.add(_encodeKeyPair(otkKp));
    }

    // Registration ID (16-bit random)
    final regIdBytes = _cryptoService.randomBytes(2);
    final registrationId = (regIdBytes[0] << 8) | regIdBytes[1];

    return KeyBundle(
      identityKeyPair: identityEncoded,
      signedPreKey: signedPreEncoded,
      signedPreKeySignature: hmacSigBase64,
      oneTimePreKeys: otks,
      registrationId: registrationId,
      ed25519IdentityKeyPair: ed25519Encoded,
      ed25519Signature: ed25519SigBase64,
    );
  }

  /// Upload the public portion of a key bundle to the server.
  ///
  /// The private keys are NEVER uploaded — only public keys, signatures,
  /// and registration ID.
  Future<void> uploadKeyBundle(KeyBundle bundle) async {
    final callable = _functions.httpsCallable('uploadKeyBundle');
    await callable.call<dynamic>({
      'identityKey': _extractPublicBase64(bundle.identityKeyPair),
      'signedPreKey': _extractPublicBase64(bundle.signedPreKey),
      'signedPreKeySignature': bundle.signedPreKeySignature,
      'oneTimePreKeys': bundle.oneTimePreKeys
          .map((encoded) => _extractPublicBase64(encoded))
          .toList(),
      'registrationId': bundle.registrationId,
      if (bundle.ed25519IdentityKeyPair != null)
        'ed25519IdentityKey': _extractPublicBase64(bundle.ed25519IdentityKeyPair!),
      if (bundle.ed25519Signature != null)
        'ed25519Signature': bundle.ed25519Signature,
    });
  }

  /// Fetch another user's public key bundle from the server.
  ///
  /// Used by the sender to establish an X3DH session with [userId].
  Future<PublicKeyBundle> fetchKeyBundle(String userId) async {
    final callable = _functions.httpsCallable('fetchKeyBundle');
    final result = await callable.call<dynamic>({'targetUserId': userId});
    final data = result.data as Map<String, dynamic>;
    // CF returns singular oneTimePreKey (the consumed one), wrap in list
    final otk = data['oneTimePreKey'] as String?;
    return PublicKeyBundle(
      identityKey: data['identityKey'] as String,
      signedPreKey: data['signedPreKey'] as String,
      signedPreKeySignature: data['signedPreKeySignature'] as String,
      oneTimePreKeys: otk != null ? [otk] : [],
      registrationId: data['registrationId'] as int,
      userId: userId,
      ed25519IdentityKey: data['ed25519IdentityKey'] as String?,
      ed25519Signature: data['ed25519Signature'] as String?,
    );
  }

  /// Mark a one-time pre-key as consumed on the server.
  ///
  /// The server already consumes atomically in `fetchKeyBundle`,
  /// so this is a no-op on the client side.
  Future<void> consumeOneTimePreKey(String userId, int preKeyId) async {
    // No-op: server consumes OTK atomically during fetchKeyBundle
  }

  /// Check the server-side one-time pre-key count and upload new ones
  /// if the count falls below the threshold.
  Future<void> replenishOneTimePreKeysIfNeeded() async {
    final bundle = await loadPrivateKeys();
    if (bundle == null) return;

    if (bundle.oneTimePreKeys.length < _otkThreshold) {
      final newOtks = <String>[];
      final newPublicOtks = <String>[];
      for (var i = 0; i < _otkBatchSize; i++) {
        final otkKp = await _cryptoService.generateX25519KeyPair();
        final encoded = _encodeKeyPair(otkKp);
        newOtks.add(encoded);
        newPublicOtks.add(_extractPublicBase64(encoded));
      }

      // Upload public parts to server
      final callable = _functions.httpsCallable('replenishOneTimePreKeys');
      await callable.call<dynamic>({'newPreKeys': newPublicOtks});

      // Append private parts to local storage
      final allOtks = [...bundle.oneTimePreKeys, ...newOtks];
      await storePrivateKeys(bundle.copyWith(oneTimePreKeys: allOtks));
    }
  }

  /// Rotate the signed pre-key.
  ///
  /// Should be called periodically (e.g., every 7 days) to limit the
  /// window of compromise if a signed pre-key is leaked.
  Future<void> rotateSignedPreKey() async {
    final bundle = await loadPrivateKeys();
    if (bundle == null) return;

    // Generate new signed pre-key
    final newSignedPreKp = await _cryptoService.generateX25519KeyPair();
    final newSignedPreEncoded = _encodeKeyPair(newSignedPreKp);

    // Legacy HMAC signature (kept for backward compatibility)
    final identityPrivate = _extractPrivateBytes(bundle.identityKeyPair);
    final hmacSig = _signKey(identityPrivate, newSignedPreKp['publicKey']!);
    final hmacSigBase64 = base64Encode(hmacSig);

    // Ed25519 signature (if Ed25519 key pair is available)
    String? ed25519SigBase64;
    if (bundle.ed25519IdentityKeyPair != null) {
      final ed25519Private = _extractPrivateBytes(bundle.ed25519IdentityKeyPair!);
      final ed25519Sig = await _cryptoService.ed25519Sign(
        newSignedPreKp['publicKey']!,
        ed25519Private,
      );
      ed25519SigBase64 = base64Encode(ed25519Sig);
    }

    // Upload to server
    final callable = _functions.httpsCallable('rotateSignedPreKey');
    await callable.call<dynamic>({
      'newSignedPreKey': _extractPublicBase64(newSignedPreEncoded),
      'newSignedPreKeySignature': hmacSigBase64,
      if (ed25519SigBase64 != null)
        'newEd25519Signature': ed25519SigBase64,
    });

    // Update local storage
    await storePrivateKeys(bundle.copyWith(
      signedPreKey: newSignedPreEncoded,
      signedPreKeySignature: hmacSigBase64,
      ed25519Signature: ed25519SigBase64,
    ));
  }

  /// Store private keys securely in the device keychain / secure storage.
  Future<void> storePrivateKeys(KeyBundle bundle) async {
    await _secureStorage.write(
      key: _identityKeyKey,
      value: bundle.identityKeyPair,
    );
    await _secureStorage.write(
      key: _signedPreKeyKey,
      value: bundle.signedPreKey,
    );
    await _secureStorage.write(
      key: _signedPreKeySigKey,
      value: bundle.signedPreKeySignature,
    );
    await _secureStorage.write(
      key: _otkKey,
      value: jsonEncode(bundle.oneTimePreKeys),
    );
    await _secureStorage.write(
      key: _regIdKey,
      value: bundle.registrationId.toString(),
    );
    // Ed25519 keys (optional, may be null for legacy bundles)
    if (bundle.ed25519IdentityKeyPair != null) {
      await _secureStorage.write(
        key: _ed25519KeyKey,
        value: bundle.ed25519IdentityKeyPair!,
      );
    }
    if (bundle.ed25519Signature != null) {
      await _secureStorage.write(
        key: _ed25519SigKey,
        value: bundle.ed25519Signature!,
      );
    }
  }

  /// Load private keys from the device keychain / secure storage.
  ///
  /// Returns `null` if no keys have been stored (first launch or after wipe).
  Future<KeyBundle?> loadPrivateKeys() async {
    final identityEncoded = await _secureStorage.read(key: _identityKeyKey);
    if (identityEncoded == null) return null;

    final signedPreEncoded = await _secureStorage.read(key: _signedPreKeyKey);
    final signedPreSig = await _secureStorage.read(key: _signedPreKeySigKey);
    final otkJson = await _secureStorage.read(key: _otkKey);
    final regIdStr = await _secureStorage.read(key: _regIdKey);
    final ed25519KeyEncoded = await _secureStorage.read(key: _ed25519KeyKey);
    final ed25519Sig = await _secureStorage.read(key: _ed25519SigKey);

    if (signedPreEncoded == null || signedPreSig == null || regIdStr == null) {
      return null;
    }

    final otks = otkJson != null
        ? List<String>.from(jsonDecode(otkJson) as List)
        : <String>[];

    return KeyBundle(
      identityKeyPair: identityEncoded,
      signedPreKey: signedPreEncoded,
      signedPreKeySignature: signedPreSig,
      oneTimePreKeys: otks,
      registrationId: int.parse(regIdStr),
      ed25519IdentityKeyPair: ed25519KeyEncoded,
      ed25519Signature: ed25519Sig,
    );
  }

  // ===========================================================================
  // FINGERPRINT VERIFICATION
  // ===========================================================================

  /// Generate a human-readable safety number for identity key verification.
  ///
  /// Computes SHA-256(ourIdentityPublic || theirIdentityPublic) and formats
  /// it as groups of 5 digits. Both users should see the same number when
  /// they combine their keys in the same order.
  String generateSafetyNumber(String ourIdentityPublic, String theirIdentityPublic) {
    // Ensure deterministic ordering: lexicographically smaller key first
    final a = ourIdentityPublic.compareTo(theirIdentityPublic) <= 0
        ? ourIdentityPublic
        : theirIdentityPublic;
    final b = ourIdentityPublic.compareTo(theirIdentityPublic) <= 0
        ? theirIdentityPublic
        : ourIdentityPublic;

    final combined = base64Decode(a) + base64Decode(b);
    final hash = hmac_lib.sha256.convert(combined);
    final bytes = hash.bytes;

    // Convert first 30 bytes to 12 groups of 5 digits
    final buffer = StringBuffer();
    for (var i = 0; i < 12; i++) {
      final idx = i * 2;
      if (idx + 1 >= bytes.length) break;
      final num = ((bytes[idx] << 8) | bytes[idx + 1]) % 100000;
      buffer.write(num.toString().padLeft(5, '0'));
      if (i < 11) buffer.write(' ');
    }
    return buffer.toString();
  }

  /// Get the local user's public identity key (base64).
  ///
  /// Returns null if no key bundle has been stored.
  Future<String?> getOwnPublicIdentityKey() async {
    final identityEncoded = await _secureStorage.read(key: _identityKeyKey);
    if (identityEncoded == null) return null;
    return _extractPublicBase64(identityEncoded);
  }

  // ===========================================================================
  // PRIVATE HELPERS
  // ===========================================================================

  /// Encode a key pair as "base64Private|base64Public".
  String _encodeKeyPair(Map<String, Uint8List> kp) {
    final priv = base64Encode(kp['privateKey']!);
    final pub = base64Encode(kp['publicKey']!);
    return '$priv|$pub';
  }

  /// Extract the public key (base64) from an encoded key pair.
  String _extractPublicBase64(String encodedPair) {
    return encodedPair.split('|')[1];
  }

  /// Extract the private key bytes from an encoded key pair.
  Uint8List _extractPrivateBytes(String encodedPair) {
    return base64Decode(encodedPair.split('|')[0]);
  }

  /// Extract the public key bytes from an encoded key pair.
  Uint8List extractPublicBytes(String encodedPair) {
    return base64Decode(encodedPair.split('|')[1]);
  }

  /// Sign data with HMAC-SHA256 using the given signing key.
  Uint8List _signKey(Uint8List signingKey, Uint8List data) {
    final hmac = hmac_lib.Hmac(hmac_lib.sha256, signingKey);
    final digest = hmac.convert(data);
    return Uint8List.fromList(digest.bytes);
  }
}
