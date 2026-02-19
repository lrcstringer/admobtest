import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/e2ee_types.dart';
import 'crypto_service.dart';
import 'key_management_service.dart';

/// Manages encrypted backups of the user's E2EE private keys.
///
/// Backups are encrypted with a passphrase-derived key (PBKDF2) before
/// being uploaded to the server, so the server never sees plaintext keys.
@lazySingleton
class KeyBackupService {
  final KeyManagementService _keyManagementService;
  final CryptoService _cryptoService;
  final FirebaseFunctions _functions;
  final FlutterSecureStorage _secureStorage;

  KeyBackupService(
    this._keyManagementService,
    this._cryptoService,
    this._functions,
    this._secureStorage,
  );

  static const _backupBlobKey = 'e2ee_backup_blob';
  static const _backupSaltKey = 'e2ee_backup_salt';
  static const _backupPassphraseKey = 'e2ee_backup_passphrase';
  static const _backupTimestampKey = 'e2ee_backup_timestamp';
  static const _backupVersion = 1;
  // Re-backup if older than 7 days
  static const _backupStaleDays = 7;

  /// Create an encrypted backup of the user's private keys.
  ///
  /// The [passphrase] is used to derive an AES-256 key via PBKDF2,
  /// which encrypts the key bundle before storing locally and saving
  /// metadata to the server.
  Future<void> createBackup(String passphrase) async {
    final bundle = await _keyManagementService.loadPrivateKeys();
    if (bundle == null) {
      throw StateError('E2EE: No key bundle to backup');
    }

    // Generate salt for PBKDF2
    final salt = _cryptoService.randomBytes(32);

    // Derive encryption key from passphrase
    final derivedKey = await _cryptoService.pbkdf2(
      passphrase: passphrase,
      salt: salt,
    );

    // Serialize key bundle to JSON
    final bundleJson = jsonEncode(bundle.toJson());
    final plaintextBytes = Uint8List.fromList(utf8.encode(bundleJson));

    // Encrypt with AES-256-GCM
    final encrypted = await _cryptoService.encrypt(plaintextBytes, derivedKey);

    // Store encrypted blob + salt locally
    await _secureStorage.write(
      key: _backupBlobKey,
      value: base64Encode(encrypted),
    );
    await _secureStorage.write(
      key: _backupSaltKey,
      value: base64Encode(salt),
    );

    // Cache passphrase for auto-backup
    await _secureStorage.write(
      key: _backupPassphraseKey,
      value: passphrase,
    );

    final now = DateTime.now().toIso8601String();
    await _secureStorage.write(key: _backupTimestampKey, value: now);

    // Save metadata to server
    final callable = _functions.httpsCallable('saveBackupMetadata');
    await callable.call<dynamic>({
      'backupVersion': _backupVersion,
      'lastBackupAt': now,
    });
  }

  /// Restore private keys from an encrypted local backup.
  ///
  /// Returns `true` if the restore was successful, `false` if the
  /// passphrase was incorrect or the backup was corrupted.
  Future<bool> restoreFromBackup(String passphrase) async {
    final blobBase64 = await _secureStorage.read(key: _backupBlobKey);
    final saltBase64 = await _secureStorage.read(key: _backupSaltKey);

    if (blobBase64 == null || saltBase64 == null) return false;

    try {
      final encrypted = base64Decode(blobBase64);
      final salt = base64Decode(saltBase64);

      // Derive key from passphrase
      final derivedKey = await _cryptoService.pbkdf2(
        passphrase: passphrase,
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

      // Cache passphrase for future auto-backups
      await _secureStorage.write(
        key: _backupPassphraseKey,
        value: passphrase,
      );

      return true;
    } catch (_) {
      // Wrong passphrase or corrupted backup
      return false;
    }
  }

  /// Check whether an encrypted backup exists.
  Future<bool> hasBackup() async {
    final metadata = await getBackupMetadata();
    return metadata?.backupExists ?? false;
  }

  /// Fetch metadata about the user's backup.
  ///
  /// Returns `null` if no backup exists.
  Future<BackupMetadata?> getBackupMetadata() async {
    try {
      final callable = _functions.httpsCallable('getBackupMetadata');
      final result = await callable.call<dynamic>({});
      final data = result.data as Map<String, dynamic>?;
      if (data == null) return null;

      return BackupMetadata(
        backupExists: data['backupExists'] as bool? ?? false,
        lastBackupAt: data['lastBackupAt'] != null
            ? DateTime.parse(data['lastBackupAt'] as String)
            : null,
        backupVersion: data['backupVersion'] as int?,
        userId: data['userId'] as String? ?? '',
      );
    } catch (_) {
      return null;
    }
  }

  /// Automatically create or update the backup if conditions are met
  /// (e.g., keys have changed since last backup, or backup is stale).
  Future<void> autoBackupIfNeeded() async {
    // Check for cached passphrase
    final passphrase =
        await _secureStorage.read(key: _backupPassphraseKey);
    if (passphrase == null) return; // No passphrase cached, skip

    // Check staleness
    final timestampStr =
        await _secureStorage.read(key: _backupTimestampKey);
    if (timestampStr != null) {
      final lastBackup = DateTime.parse(timestampStr);
      final daysSince = DateTime.now().difference(lastBackup).inDays;
      if (daysSince < _backupStaleDays) return; // Still fresh
    }

    // Create backup
    await createBackup(passphrase);
  }
}
