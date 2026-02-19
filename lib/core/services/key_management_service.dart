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
  static const _otkThreshold = 5;
  static const _otkBatchSize = 10;

  /// Generate a full key bundle (identity key pair, signed pre-key,
  /// one-time pre-keys) for initial device registration.
  Future<KeyBundle> generateKeyBundle() async {
    // Identity key pair
    final identityKp = await _cryptoService.generateX25519KeyPair();
    final identityEncoded = _encodeKeyPair(identityKp);

    // Signed pre-key pair
    final signedPreKp = await _cryptoService.generateX25519KeyPair();
    final signedPreEncoded = _encodeKeyPair(signedPreKp);

    // Sign the signed pre-key's public key with the identity private key
    final signature = _signKey(identityKp['privateKey']!, signedPreKp['publicKey']!);
    final signatureBase64 = base64Encode(signature);

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
      signedPreKeySignature: signatureBase64,
      oneTimePreKeys: otks,
      registrationId: registrationId,
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

    // Sign with identity private key
    final identityPrivate = _extractPrivateBytes(bundle.identityKeyPair);
    final signature = _signKey(identityPrivate, newSignedPreKp['publicKey']!);
    final signatureBase64 = base64Encode(signature);

    // Upload to server
    final callable = _functions.httpsCallable('rotateSignedPreKey');
    await callable.call<dynamic>({
      'newSignedPreKey': _extractPublicBase64(newSignedPreEncoded),
      'newSignedPreKeySignature': signatureBase64,
    });

    // Update local storage
    await storePrivateKeys(bundle.copyWith(
      signedPreKey: newSignedPreEncoded,
      signedPreKeySignature: signatureBase64,
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
    );
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
