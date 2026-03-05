import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/e2ee_types.dart';
import 'crypto_service.dart';
import 'key_management_service.dart';

/// Manages automatic encrypted backups of the user's E2EE private keys.
///
/// Uses a server-side per-user secret to derive the encryption key via PBKDF2.
/// Zero user interaction — backup and restore happen silently during auth flow.
///
/// On reinstall: user logs in → fetches serverSecret from Firestore →
/// derives same key → decrypts blob → restores keys → messages become readable.
@lazySingleton
class KeyBackupService {
  final KeyManagementService _keyManagementService;
  final CryptoService _cryptoService;
  final FirebaseFunctions _functions;
  final FlutterSecureStorage _secureStorage;
  final FirebaseAuth _auth;

  KeyBackupService(
    this._keyManagementService,
    this._cryptoService,
    this._functions,
    this._secureStorage,
    this._auth,
  );

  static const _backupBlobKey = 'e2ee_backup_blob';
  static const _backupTimestampKey = 'e2ee_backup_timestamp';
  static const _backupVersion = 2;

  /// Automatically backup keys using server-side secret. Zero user interaction.
  ///
  /// Encrypts the key bundle with a key derived from a per-user server secret
  /// via PBKDF2 with a random 16-byte salt, then uploads the encrypted blob.
  ///
  /// Blob format (v2): salt(16) || nonce(12) || ciphertext || mac(16)
  Future<void> autoBackup() async {
    final bundle = await _keyManagementService.loadPrivateKeys();
    if (bundle == null) return;

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    // Get or create server-side secret
    final serverSecret = await _getOrCreateServerSecret(uid);

    // Random 16-byte salt per NIST SP 800-132 (H5: replaces deterministic uid salt)
    final salt = _cryptoService.randomBytes(16);
    final derivedKey = await _cryptoService.pbkdf2(
      passphrase: serverSecret,
      salt: salt,
    );

    // Encrypt key bundle
    final bundleJson = jsonEncode(bundle.toJson());
    final plaintext = Uint8List.fromList(utf8.encode(bundleJson));
    final encrypted = await _cryptoService.encrypt(plaintext, derivedKey);

    // Prepend salt to encrypted blob: salt(16) || nonce(12) || ct || mac(16)
    final blobWithSalt = Uint8List(salt.length + encrypted.length);
    blobWithSalt.setRange(0, salt.length, salt);
    blobWithSalt.setRange(salt.length, blobWithSalt.length, encrypted);
    final blobBase64 = base64Encode(blobWithSalt);

    // Upload to server
    final callable = _functions.httpsCallable('saveKeyBackup');
    await callable.call<dynamic>({
      'backupVersion': _backupVersion,
      'encryptedBlob': blobBase64,
    });

    // Cache locally too
    await _secureStorage.write(key: _backupBlobKey, value: blobBase64);
    await _secureStorage.write(
      key: _backupTimestampKey,
      value: DateTime.now().toIso8601String(),
    );
  }

  /// Attempt to restore keys from server backup. Returns true if successful.
  ///
  /// Called on fresh install after login when no local keys exist.
  /// Fetches the server secret and encrypted blob, derives the same key,
  /// decrypts the blob, and restores the key bundle.
  ///
  /// Retries up to [maxAttempts] times with exponential backoff on transient
  /// errors (network, Cloud Function timeouts). A single transient failure
  /// must NOT cause irreversible fresh key generation — that would make all
  /// existing messages permanently undecryptable.
  ///
  /// Supports both v2 (random 16-byte salt prepended) and v1 (uid as salt).
  Future<bool> autoRestore({int maxAttempts = 3}) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return false;

    var backoff = const Duration(seconds: 2);

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final restored = await _attemptRestore(uid);
        if (restored) return true;

        // _attemptRestore returns false for definitive "no backup exists"
        // — no point retrying.
        return false;
      } catch (e) {
        CryptoService.e2eeLog(
            'E2EE autoRestore attempt $attempt/$maxAttempts failed: $e');

        // Don't retry on definitive non-transient errors
        if (_isNonTransientError(e)) {
          CryptoService.e2eeLog(
              'E2EE autoRestore: non-transient error — giving up');
          return false;
        }

        if (attempt < maxAttempts) {
          CryptoService.e2eeLog(
              'E2EE autoRestore: retrying in ${backoff.inSeconds}s');
          await Future<void>.delayed(backoff);
          backoff *= 2;
        }
      }
    }

    CryptoService.e2eeLog(
        'E2EE autoRestore: all $maxAttempts attempts failed');
    return false;
  }

  /// Single restore attempt. Returns true on success, false if no backup
  /// exists. Throws on transient errors (network, timeout) so the caller
  /// can retry.
  Future<bool> _attemptRestore(String uid) async {
    // Fetch server secret
    final serverSecret = await _getServerSecret(uid);
    if (serverSecret == null) return false;

    // Download encrypted blob
    final callable = _functions.httpsCallable('getKeyBackup');
    final result = await callable.call<dynamic>({});
    final data = result.data as Map<String, dynamic>?;
    if (data == null || data['encryptedBlob'] == null) return false;

    final fullBlob = base64Decode(data['encryptedBlob'] as String);
    final backupVersion = data['backupVersion'] as int? ?? 1;

    // Extract salt based on backup version
    final Uint8List salt;
    final Uint8List encrypted;
    if (backupVersion >= 2) {
      // v2: salt(16) || nonce(12) || ciphertext || mac(16)
      salt = Uint8List.fromList(fullBlob.sublist(0, 16));
      encrypted = Uint8List.fromList(fullBlob.sublist(16));
    } else {
      // v1 legacy: uid as salt, no salt prefix in blob
      salt = Uint8List.fromList(utf8.encode(uid));
      encrypted = Uint8List.fromList(fullBlob);
    }

    final derivedKey = await _cryptoService.pbkdf2(
      passphrase: serverSecret,
      salt: salt,
    );

    // Decrypt — format: nonce(12) || ciphertext || mac(16)
    final nonce = Uint8List.fromList(encrypted.sublist(0, 12));
    final ciphertextWithMac = Uint8List.fromList(encrypted.sublist(12));
    final plaintext = await _cryptoService.decrypt(
      ciphertextWithMac,
      derivedKey,
      nonce: nonce,
    );

    // Parse and restore key bundle
    final bundleJson =
        jsonDecode(utf8.decode(plaintext)) as Map<String, dynamic>;
    final bundle = KeyBundle.fromJson(bundleJson);
    await _keyManagementService.storePrivateKeys(bundle);
    await _keyManagementService.uploadKeyBundle(bundle);

    // Cache locally
    await _secureStorage.write(
      key: _backupBlobKey,
      value: data['encryptedBlob'] as String,
    );

    return true;
  }

  /// Returns true for errors that indicate a definitive failure (bad data,
  /// auth error) vs transient failures (network, timeout) that should be
  /// retried.
  bool _isNonTransientError(Object e) {
    if (e is FormatException) return true;
    if (e is TypeError) return true;
    if (e is FirebaseFunctionsException) {
      // permission-denied, unauthenticated = won't succeed on retry
      // not-found = no backup exists
      const nonTransient = {'permission-denied', 'unauthenticated', 'not-found'};
      return nonTransient.contains(e.code);
    }
    return false;
  }

  /// Get or create the per-user server secret used for backup encryption.
  Future<String> _getOrCreateServerSecret(String uid) async {
    // Try reading existing secret
    final existing = await _getServerSecret(uid);
    if (existing != null) return existing;

    // Generate and store new secret
    final secret = base64Encode(_cryptoService.randomBytes(32));
    try {
      final callable = _functions.httpsCallable('saveBackupSecret');
      await callable.call<dynamic>({'secret': secret});
      return secret;
    } on FirebaseFunctionsException catch (e) {
      // Race condition: another device created it first — read theirs
      if (e.code == 'already-exists') {
        final retry = await _getServerSecret(uid);
        if (retry != null) return retry;
      }
      rethrow;
    }
  }

  /// Read the per-user server secret from the server.
  Future<String?> _getServerSecret(String uid) async {
    try {
      final callable = _functions.httpsCallable('getBackupSecret');
      final result = await callable.call<dynamic>({});
      final data = result.data as Map<String, dynamic>?;
      return data?['secret'] as String?;
    } catch (_) {
      return null;
    }
  }
}
