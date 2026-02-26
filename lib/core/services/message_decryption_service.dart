import 'dart:convert';
import 'dart:math';

import 'package:injectable/injectable.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/conversation_remote_datasource.dart';
import '../../domain/entities/message.dart';
import 'crypto_service.dart';
import 'signal_protocol_service.dart' show SignalProtocolService, PermanentDecryptionError;

/// Orchestrates message decryption — identity verification, Signal Protocol
/// calls, own-message cache resolution, and failure tracking.
///
/// Extracted from MessageSyncService to isolate decryption concerns from
/// Firestore subscriptions and local DB writes.
@lazySingleton
class MessageDecryptionService {
  final SignalProtocolService _signalProtocolService;
  final ConversationRemoteDataSource _remoteDataSource;
  final AppDatabase _appDatabase;

  MessageDecryptionService(
    this._signalProtocolService,
    this._remoteDataSource,
    this._appDatabase,
  );

  /// In-memory cache of sent message plaintext (populated by repository on send).
  /// Used to resolve own outgoing messages without decryption.
  /// Bounded to [_maxCacheSize] entries; oldest entries evicted on overflow.
  final Map<String, String> sentPlaintextCache = {};

  /// Tracks decryption failure counts per message ID. After [maxDecryptAttempts]
  /// failures, the message is marked permanently undecryptable. Resets on app
  /// restart, giving one more chance if the user fixed their keys.
  /// Bounded to [_maxFailureEntries]; oldest entries evicted on overflow.
  final Map<String, int> decryptFailures = {};
  static const maxDecryptAttempts = 3;
  static const _maxCacheSize = 500;
  static const _maxFailureEntries = 1000;

  /// Cache a sent message's plaintext, evicting the oldest entry if at capacity.
  void cacheSentPlaintext(String messageId, String plaintext) {
    if (sentPlaintextCache.length >= _maxCacheSize) {
      sentPlaintextCache.remove(sentPlaintextCache.keys.first);
    }
    sentPlaintextCache[messageId] = plaintext;
  }

  /// Decrypt a single message. Returns plaintext or null on failure.
  ///
  /// When [protectSession] is true, destructive recovery (session reset +
  /// retry) is skipped. This is used when a newer message from the same sender
  /// already decrypted successfully — resetting the session would overwrite
  /// the working session with stale X3DH keys from the older message.
  Future<String?> decryptMessage(
    Message msg,
    String currentUserId, {
    bool protectSession = false,
  }) async {
    // Sender's own messages: use sent plaintext cache or DB cache
    if (msg.senderId == currentUserId) {
      final cached = sentPlaintextCache[msg.id];
      if (cached != null) return cached;

      try {
        final dbCached = await _appDatabase.getDecryptedPlaintext(msg.id);
        if (dbCached != null) return dbCached;
      } catch (_) {}

      // Fallback: lookup by ciphertext fingerprint (survives app kill
      // between server send and messageId-based cache write)
      if (msg.ciphertext != null) {
        try {
          final fpLen = min(64, msg.ciphertext!.length);
          final fp = 'sent_ct:${msg.ciphertext!.substring(0, fpLen)}';
          final fpCached = await _appDatabase.getDecryptedPlaintext(fp);
          if (fpCached != null) {
            // Promote to messageId-based cache for future lookups
            await _appDatabase.cacheDecryptedPlaintext(msg.id, fpCached);
            return fpCached;
          }
        } catch (_) {}
      }

      // Own message with no cached plaintext — can't decrypt
      return null;
    }

    // Diagnostic: log what we received from Firestore
    CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: '
        'sender=${msg.senderId.substring(0, 8)}… '
        'hasCiphertext=${msg.ciphertext != null} '
        'hasE2ee=${msg.e2ee != null} '
        'hasX3dh=${msg.x3dhHeader != null} '
        'msgNum=${msg.e2ee?.messageNumber} '
        'dhPubKey=${msg.e2ee?.dhPublicKey != null ? "${msg.e2ee!.dhPublicKey!.substring(0, 8)}…" : "null"} '
        'ctLen=${msg.ciphertext?.length ?? 0} '
        'protectSession=$protectSession '
        'msgAge=${DateTime.now().difference(msg.createdAt).inSeconds}s');

    // Verify sender identity key against registered Firestore bundle
    // before performing X3DH. Prevents a MITM substituting their own key.
    if (msg.x3dhHeader != null) {
      final claimedKey = msg.x3dhHeader!.identityKey;
      final registeredKey =
          await _remoteDataSource.getUserE2eeIdentityKey(msg.senderId);
      if (registeredKey != null && registeredKey != claimedKey) {
        CryptoService.e2eeLog('E2EE SECURITY [${msg.id}]: '
            'Identity key mismatch for ${msg.senderId} — '
            'claimed=${claimedKey.substring(0, 8)}… '
            'registered=${registeredKey.substring(0, 8)}…');
        _markPermanentlyFailed(msg.id);
        return null;
      }
    }

    // Build encrypted map for Signal Protocol
    final encryptedMap = <String, dynamic>{
      'ciphertext': msg.ciphertext,
      if (msg.e2ee != null)
        'e2ee': {
          'protocol': msg.e2ee!.protocol,
          'messageNumber': msg.e2ee!.messageNumber,
          'dhPublicKey': msg.e2ee!.dhPublicKey,
          'previousChainLength': msg.e2ee!.previousChainLength,
        },
      if (msg.x3dhHeader != null)
        'x3dhHeader': {
          'identityKey': msg.x3dhHeader!.identityKey,
          'ephemeralKey': msg.x3dhHeader!.ephemeralKey,
          if (msg.x3dhHeader!.oneTimePreKeyPublicKey != null)
            'oneTimePreKeyPublicKey': msg.x3dhHeader!.oneTimePreKeyPublicKey,
          if (msg.x3dhHeader!.oneTimePreKeyId != null)
            'oneTimePreKeyId': msg.x3dhHeader!.oneTimePreKeyId,
        },
    };

    try {
      final plaintext = await _signalProtocolService.decryptP2P(
        msg.senderId,
        encryptedMap,
      );
      CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Decrypt SUCCESS '
          '(${plaintext.length} chars)');
      return plaintext;
    } on PermanentDecryptionError catch (e) {
      CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: PERMANENT decrypt failure: $e');
      _markPermanentlyFailed(msg.id);
      if (e.message.contains('OTK mismatch')) {
        try {
          await _signalProtocolService.resetSession(msg.senderId);
          CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Session reset after OTK mismatch '
              '— next message from ${msg.senderId} will re-establish');
        } catch (_) {}
      }
      return null;
    } catch (e) {
      CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Decrypt FAILED: $e');

      if (protectSession) {
        CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Skipping destructive recovery — '
            'protecting working session from older message');
        _markPermanentlyFailed(msg.id);
        return null;
      }

      // Session recovery: reset and retry if x3dhHeader present
      if (msg.x3dhHeader != null) {
        try {
          CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Resetting session, retrying…');
          await _signalProtocolService.resetSession(msg.senderId);
          final plaintext = await _signalProtocolService.decryptP2P(
            msg.senderId,
            encryptedMap,
          );
          CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Recovery SUCCESS');
          return plaintext;
        } on PermanentDecryptionError catch (e2) {
          CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: PERMANENT after reset: $e2');
          _markPermanentlyFailed(msg.id);
        } catch (retryError) {
          CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Recovery FAILED: $retryError');
          try {
            await _signalProtocolService.resetSession(msg.senderId);
            CryptoService.e2eeLog('E2EE SYNC [${msg.id}]: Cleaned up corrupted session '
                'after failed recovery');
          } catch (_) {}
        }
      }

      return null;
    }
  }

  /// Apply decrypted plaintext to a message, handling structured JSON payloads
  /// (e.g., encrypted media messages with embedded metadata).
  Message applyDecryptedPayload(Message msg, String plaintext) {
    if (plaintext.startsWith('{')) {
      try {
        final payload = jsonDecode(plaintext) as Map<String, dynamic>;
        if (payload.containsKey('media')) {
          final mediaJson = payload['media'] as Map<String, dynamic>;
          return msg.copyWith(
            textContent: payload['text'] as String?,
            media: MessageMedia.fromJson(mediaJson),
          );
        }
      } catch (_) {
        // Not valid JSON — treat as plain text
      }
    }
    return msg.copyWith(textContent: plaintext);
  }

  /// Check if a message has permanently failed decryption.
  bool isPermanentlyFailed(String messageId) {
    return (decryptFailures[messageId] ?? 0) >= maxDecryptAttempts;
  }

  /// Record a decryption failure for a message.
  void recordFailure(String messageId) {
    _evictFailuresIfNeeded();
    decryptFailures[messageId] = (decryptFailures[messageId] ?? 0) + 1;
  }

  /// Mark a message as permanently failed (max attempts reached).
  void _markPermanentlyFailed(String messageId) {
    _evictFailuresIfNeeded();
    decryptFailures[messageId] = maxDecryptAttempts;
  }

  void _evictFailuresIfNeeded() {
    if (decryptFailures.length >= _maxFailureEntries) {
      decryptFailures.remove(decryptFailures.keys.first);
    }
  }
}
