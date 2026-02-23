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
  static const _backupVersion = 1;

  /// Automatically backup keys using server-side secret. Zero user interaction.
  ///
  /// Encrypts the key bundle with a key derived from a per-user server secret
  /// via PBKDF2, then uploads the encrypted blob to the server.
  Future<void> autoBackup() async {
    final bundle = await _keyManagementService.loadPrivateKeys();
    if (bundle == null) return;

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    // Get or create server-side secret
    final serverSecret = await _getOrCreateServerSecret(uid);

    // Derive encryption key (uid as salt — deterministic, unique per user)
    final salt = Uint8List.fromList(utf8.encode(uid));
    final derivedKey = await _cryptoService.pbkdf2(
      passphrase: serverSecret,
      salt: salt,
    );

    // Encrypt key bundle
    final bundleJson = jsonEncode(bundle.toJson());
    final plaintext = Uint8List.fromList(utf8.encode(bundleJson));
    final encrypted = await _cryptoService.encrypt(plaintext, derivedKey);
    final blobBase64 = base64Encode(encrypted);

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
  Future<bool> autoRestore() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return false;

    try {
      // Fetch server secret
      final serverSecret = await _getServerSecret(uid);
      if (serverSecret == null) return false;

      // Download encrypted blob
      final callable = _functions.httpsCallable('getKeyBackup');
      final result = await callable.call<dynamic>({});
      final data = result.data as Map<String, dynamic>?;
      if (data == null || data['encryptedBlob'] == null) return false;

      final encrypted = base64Decode(data['encryptedBlob'] as String);

      // Derive key (uid as salt — same as in autoBackup)
      final salt = Uint8List.fromList(utf8.encode(uid));
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
    } catch (e) {
      debugPrint('E2EE autoRestore failed: $e');
      return false;
    }
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
