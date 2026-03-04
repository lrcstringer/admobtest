import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../security/keystore_service.dart';
import 'crypto_service.dart';

/// Manages per-message payload recovery for E2EE messages.
///
/// On send/receive: encrypts the full decrypted JSON payload with a recovery
/// key and stores it on Firestore `users/{uid}/payloadVault/{msgId}`.
///
/// On reinstall: fetches the TEE-wrapped recovery key blob from the device
/// record, unwraps it using the hardware-backed AES key, then batch-fetches
/// and decrypts stored payloads.
@lazySingleton
class MediaRecoveryService {
  final KeystoreService _keystoreService;
  final CryptoService _cryptoService;
  final FlutterSecureStorage _secureStorage;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  MediaRecoveryService(
    this._keystoreService,
    this._cryptoService,
    this._secureStorage,
    this._firestore,
    this._auth,
  );

  static const _recoveryKeyCache = 'e2ee_recovery_key';

  /// In-memory cache of the 256-bit recovery key (base64).
  String? _cachedRecoveryKey;

  /// Whether initialization has completed this session.
  bool _initialized = false;

  /// Whether the wrapped recovery key blob has been stored on the device doc.
  /// False when initialize() completed without a deviceId (race condition on
  /// first install — device binding hadn't finished yet).
  bool _blobStoredOnFirestore = false;

  /// Guards against concurrent initialize() calls (e.g. DeviceBindingService
  /// and AuthBloc both fire-and-forget initialize() on first install).
  Completer<bool>? _initCompleter;

  /// Payloads queued while initialization is still in progress.
  /// Flushed automatically once [initialize] completes successfully.
  final Map<String, String> _pendingPayloads = {};

  /// Whether the recovery service is initialized and ready.
  bool get isReady => _initialized && _cachedRecoveryKey != null;

  // ===========================================================================
  // INITIALIZATION
  // ===========================================================================

  /// Initialize the recovery system. Called during device binding or app start.
  ///
  /// Concurrent calls are coalesced — the second caller awaits the first's
  /// result. This prevents two callers from generating different recovery keys
  /// and overwriting each other's Firestore blob.
  ///
  /// Flow:
  /// 1. Ensure TEE wrapping key exists (create if first time, never overwrite).
  /// 2. Try loading recovery key from FlutterSecureStorage (fast path).
  /// 3. If not cached (reinstall), fetch wrapped blob from Firestore and unwrap.
  /// 4. If no blob exists either (first device), generate new recovery key,
  ///    wrap with TEE, store blob to Firestore, cache locally.
  Future<bool> initialize() async {
    if (_initialized && _cachedRecoveryKey != null) return true;

    // Coalesce concurrent calls — second caller awaits the first's result
    if (_initCompleter != null) return _initCompleter!.future;
    _initCompleter = Completer<bool>();

    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      _initCompleter!.complete(false);
      _initCompleter = null;
      return false;
    }

    try {
      final result = await _doInitialize(uid);
      _initCompleter!.complete(result);
      _initCompleter = null;
      return result;
    } catch (e) {
      debugPrint('MediaRecoveryService: Initialization failed: $e');
      _initCompleter!.complete(false);
      _initCompleter = null;
      return false;
    }
  }

  /// Internal initialization logic — separated so the Completer guard in
  /// [initialize] can route all exit paths through the completer.
  Future<bool> _doInitialize(String uid) async {
    final wrappingAlias = KeystoreService.wrappingKeyAlias(uid);

    // Step 1: Ensure TEE wrapping key exists
    final hasKey = await _keystoreService.hasWrappingKey(wrappingAlias);
    final keyExists = hasKey.fold((err) {
      debugPrint('MediaRecoveryService: hasWrappingKey failed: $err');
      return false;
    }, (v) => v);
    if (!keyExists) {
      final genResult =
          await _keystoreService.generateWrappingKey(wrappingAlias);
      final genOk = genResult.fold((err) {
        debugPrint(
            'MediaRecoveryService: generateWrappingKey failed: $err');
        return false;
      }, (v) => v);
      if (!genOk) {
        debugPrint('MediaRecoveryService: Failed to create TEE wrapping key');
        return false;
      }
    }

    // Step 2: Try local cache (FlutterSecureStorage)
    try {
      final cached = await _secureStorage.read(key: _recoveryKeyCache);
      if (cached != null && cached.isNotEmpty) {
        _cachedRecoveryKey = cached;
        _blobStoredOnFirestore = true; // was stored in a previous init
        _initialized = true;
        debugPrint(
            'MediaRecoveryService: Recovery key loaded from local cache');
        _flushPendingPayloads();
        return true;
      }
    } catch (e) {
      debugPrint(
          'MediaRecoveryService: SecureStorage read failed: $e');
    }

    // Step 3: Try fetching wrapped blob from Firestore (reinstall path)
    final deviceId = await _getDeviceId(uid);
    debugPrint(
        'MediaRecoveryService: deviceId=${deviceId ?? "null"} — '
        '${deviceId != null ? "fetching blob" : "no device found"}');
    if (deviceId != null) {
      final deviceDoc =
          await _firestore.collection('devices').doc(deviceId).get();
      if (deviceDoc.exists) {
        final data = deviceDoc.data()!;
        final blob = data['recoveryKeyBlob'] as String?;
        final iv = data['recoveryKeyIv'] as String?;

        if (blob != null && iv != null) {
          // Unwrap using TEE
          final unwrapResult = await _keystoreService.unwrapData(
            wrappingAlias,
            blob,
            iv,
          );
          final recoveryKey = unwrapResult.fold((err) {
            debugPrint(
                'MediaRecoveryService: TEE unwrap failed: $err');
            return null;
          }, (v) => v);
          if (recoveryKey != null) {
            _cachedRecoveryKey = recoveryKey;
            _blobStoredOnFirestore = true;
            await _secureStorage.write(
                key: _recoveryKeyCache, value: recoveryKey);
            _initialized = true;
            debugPrint(
                'MediaRecoveryService: Recovery key unwrapped from Firestore blob');
            _flushPendingPayloads();
            return true;
          }
        } else {
          debugPrint(
              'MediaRecoveryService: Device doc missing blob/iv — '
              'blob=${blob != null}, iv=${iv != null}');
        }
      } else {
        debugPrint(
            'MediaRecoveryService: Device doc $deviceId does not exist');
      }
    }

    // Step 4: No blob exists — first time. Generate, wrap, store.
    final rawKey = _cryptoService.generateAesKey(); // 32 bytes
    final recoveryKeyB64 = base64Encode(rawKey);

    // Wrap with TEE
    final wrapResult =
        await _keystoreService.wrapData(wrappingAlias, recoveryKeyB64);
    final wrappedData = wrapResult.fold((err) {
      debugPrint('MediaRecoveryService: TEE wrap failed: $err');
      return null;
    }, (v) => v);
    if (wrappedData == null) {
      CryptoService.zeroize(rawKey);
      debugPrint('MediaRecoveryService: Failed to wrap recovery key — '
          'vault will NOT work this session');
      return false;
    }

    // Store wrapped blob on Firestore device doc
    if (deviceId != null) {
      await _firestore.collection('devices').doc(deviceId).update({
        'recoveryKeyBlob': wrappedData['ciphertext'],
        'recoveryKeyIv': wrappedData['iv'],
      });
      _blobStoredOnFirestore = true;
    } else {
      _blobStoredOnFirestore = false;
      debugPrint(
          'MediaRecoveryService: WARNING — no deviceId, wrapped blob '
          'NOT stored on Firestore (won\'t survive reinstall). '
          'Call ensureBlobStored(deviceId) after device registration.');
    }

    // Cache locally
    _cachedRecoveryKey = recoveryKeyB64;
    await _secureStorage.write(
        key: _recoveryKeyCache, value: recoveryKeyB64);
    _initialized = true;

    CryptoService.zeroize(rawKey);
    debugPrint(
        'MediaRecoveryService: New recovery key generated and stored');
    _flushPendingPayloads();
    return true;
  }

  // ===========================================================================
  // DEFERRED BLOB STORAGE
  // ===========================================================================

  /// Store the TEE-wrapped recovery key blob on the Firestore device doc.
  ///
  /// Called by [DeviceBindingService] after device registration completes.
  /// Fixes the race condition where [initialize] ran before the device doc
  /// existed (first install: E2EE init finishes before device binding).
  ///
  /// No-op if the blob was already stored during [initialize].
  Future<void> ensureBlobStored(String deviceId) async {
    if (_blobStoredOnFirestore) return;
    if (_cachedRecoveryKey == null) return;

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      // Double-check: maybe blob was written by another path
      final deviceDoc =
          await _firestore.collection('devices').doc(deviceId).get();
      if (deviceDoc.exists) {
        final data = deviceDoc.data()!;
        if (data['recoveryKeyBlob'] != null && data['recoveryKeyIv'] != null) {
          _blobStoredOnFirestore = true;
          debugPrint(
              'MediaRecoveryService: ensureBlobStored — blob already exists');
          return;
        }
      }

      // Wrap the cached recovery key with TEE
      final wrappingAlias = KeystoreService.wrappingKeyAlias(uid);
      final wrapResult =
          await _keystoreService.wrapData(wrappingAlias, _cachedRecoveryKey!);
      final wrappedData = wrapResult.fold((err) {
        debugPrint(
            'MediaRecoveryService: ensureBlobStored TEE wrap failed: $err');
        return null;
      }, (v) => v);
      if (wrappedData == null) return;

      await _firestore.collection('devices').doc(deviceId).update({
        'recoveryKeyBlob': wrappedData['ciphertext'],
        'recoveryKeyIv': wrappedData['iv'],
      });
      _blobStoredOnFirestore = true;
      debugPrint(
          'MediaRecoveryService: ensureBlobStored — blob stored on device '
          '$deviceId (deferred from init)');
    } catch (e) {
      debugPrint(
          'MediaRecoveryService: ensureBlobStored failed for $deviceId: $e');
    }
  }

  // ===========================================================================
  // STORE PAYLOAD (on send / receive)
  // ===========================================================================

  /// Encrypt and store a decrypted message payload for future recovery.
  ///
  /// Called after successful decryption or after sending a message.
  /// If the vault is not yet initialized, payloads are queued in memory and
  /// flushed automatically once [initialize] completes.
  /// Non-blocking — failures are logged but do not affect message flow.
  Future<void> storePayload(String messageId, String plaintext) async {
    if (_cachedRecoveryKey == null) {
      // Vault not ready yet — queue for later
      _pendingPayloads[messageId] = plaintext;
      return;
    }

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final key = base64Decode(_cachedRecoveryKey!);
      final ptBytes = Uint8List.fromList(utf8.encode(plaintext));
      final encrypted = await _cryptoService.encrypt(ptBytes, key);
      // encrypted = nonce(12) || ciphertext || mac(16)

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('payloadVault')
          .doc(messageId)
          .set({
        'ct': base64Encode(encrypted),
        'ts': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint(
          'MediaRecoveryService: Failed to store payload for $messageId: $e');
    }
  }

  /// Flush any payloads that were queued while initialization was in progress.
  void _flushPendingPayloads() {
    if (_pendingPayloads.isEmpty) return;
    final queued = Map<String, String>.from(_pendingPayloads);
    _pendingPayloads.clear();
    debugPrint(
        'MediaRecoveryService: Flushing ${queued.length} pending payloads');
    storePayloadsBatch(queued).catchError((e) {
      debugPrint('MediaRecoveryService: Pending payload flush failed: $e');
    });
  }

  /// Store payloads for multiple messages in a batched write.
  Future<void> storePayloadsBatch(Map<String, String> payloads) async {
    if (_cachedRecoveryKey == null || payloads.isEmpty) return;

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final key = base64Decode(_cachedRecoveryKey!);
      final vaultRef =
          _firestore.collection('users').doc(uid).collection('payloadVault');

      // Process in chunks of 500 (Firestore batch limit)
      final entries = payloads.entries.toList();
      for (var i = 0; i < entries.length; i += 500) {
        final chunk =
            entries.sublist(i, (i + 500).clamp(0, entries.length));
        final batch = _firestore.batch();

        for (final entry in chunk) {
          final ptBytes = Uint8List.fromList(utf8.encode(entry.value));
          final encrypted = await _cryptoService.encrypt(ptBytes, key);
          batch.set(vaultRef.doc(entry.key), {
            'ct': base64Encode(encrypted),
            'ts': FieldValue.serverTimestamp(),
          });
        }

        await batch.commit();
      }
    } catch (e) {
      debugPrint('MediaRecoveryService: Batch store failed: $e');
    }
  }

  // ===========================================================================
  // RECOVER PAYLOADS (on reinstall)
  // ===========================================================================

  /// Recover decrypted payloads for a list of message IDs.
  ///
  /// Returns a map of messageId → decrypted JSON plaintext.
  Future<Map<String, String>> recoverPayloads(List<String> messageIds) async {
    if (_cachedRecoveryKey == null || messageIds.isEmpty) return {};

    final uid = _auth.currentUser?.uid;
    if (uid == null) return {};

    final result = <String, String>{};
    try {
      final key = base64Decode(_cachedRecoveryKey!);
      final vaultRef =
          _firestore.collection('users').doc(uid).collection('payloadVault');

      // Firestore `whereIn` supports up to 30 values per query
      for (var i = 0; i < messageIds.length; i += 30) {
        final chunk =
            messageIds.sublist(i, (i + 30).clamp(0, messageIds.length));

        final snapshot = await vaultRef
            .where(FieldPath.documentId, whereIn: chunk)
            .get();

        for (final doc in snapshot.docs) {
          try {
            final ctB64 = doc.data()['ct'] as String;
            final encrypted = base64Decode(ctB64);
            // Parse: nonce(12) || ciphertext || mac(16)
            final nonce = Uint8List.fromList(encrypted.sublist(0, 12));
            final ctWithMac = Uint8List.fromList(encrypted.sublist(12));
            final plaintext =
                await _cryptoService.decrypt(ctWithMac, key, nonce: nonce);
            result[doc.id] = utf8.decode(plaintext);
          } catch (e) {
            debugPrint(
                'MediaRecoveryService: Failed to decrypt payload ${doc.id}: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('MediaRecoveryService: Batch recovery failed: $e');
    }

    return result;
  }

  /// Recover a single payload by message ID.
  Future<String?> recoverPayload(String messageId) async {
    final results = await recoverPayloads([messageId]);
    return results[messageId];
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================

  /// Find the current device ID by querying the devices collection.
  ///
  /// The registerDevice CF upserts by userId + platform, so the same
  /// device doc is reused after reinstall.
  Future<String?> _getDeviceId(String uid) async {
    // Try FlutterSecureStorage first (cached by DeviceBindingService)
    try {
      final cached = await _secureStorage.read(key: 'imali_bound_device_id');
      if (cached != null) return cached;
    } catch (_) {}

    // Query Firestore (reinstall: secure storage is empty)
    try {
      final platform =
          defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
      final snapshot = await _firestore
          .collection('devices')
          .where('userId', isEqualTo: uid)
          .where('platform', isEqualTo: platform)
          .where('revoked', isEqualTo: false)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      }
    } catch (e) {
      debugPrint('MediaRecoveryService: Failed to query device ID: $e');
    }

    return null;
  }

  /// Clear cached recovery key (on sign-out).
  Future<void> clear() async {
    _cachedRecoveryKey = null;
    _initialized = false;
    _blobStoredOnFirestore = false;
    try {
      await _secureStorage.delete(key: _recoveryKeyCache);
    } catch (_) {}
  }
}
