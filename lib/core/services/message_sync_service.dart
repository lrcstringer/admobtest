import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/conversation_remote_datasource.dart';
import '../../data/mappers/local_conversation_mapper.dart';
import '../../data/mappers/local_message_mapper.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/message.dart';
import 'signal_protocol_service.dart' show SignalProtocolService, PermanentDecryptionError;

/// Background service that syncs Firestore messages → decrypts once → stores
/// in local DB. This is the core of the WhatsApp-style architecture:
/// messages are decrypted exactly once on receipt and stored as plaintext
/// in the encrypted local database. The UI reads from local DB only.
@lazySingleton
class MessageSyncService {
  final ConversationRemoteDataSource _remoteDataSource;
  final SignalProtocolService _signalProtocolService;
  final AppDatabase _appDatabase;

  MessageSyncService(
    this._remoteDataSource,
    this._signalProtocolService,
    this._appDatabase,
  );

  /// Per-conversation message stream subscriptions.
  final Map<String, StreamSubscription> _messageSubs = {};

  /// Conversation list stream subscription.
  StreamSubscription? _conversationListSub;

  /// Track conversation IDs we're currently syncing.
  final Set<String> _syncingConversationIds = {};

  /// In-memory cache of sent message plaintext (populated by repository on send).
  /// Used to resolve own outgoing messages without decryption.
  final Map<String, String> sentPlaintextCache = {};

  /// Tracks decryption failure counts per message ID. After [_maxDecryptAttempts]
  /// failures, the message is marked permanently undecryptable. Resets on app
  /// restart, giving one more chance if the user fixed their keys.
  final Map<String, int> _decryptFailures = {};
  static const _maxDecryptAttempts = 3;

  bool _isSyncing = false;

  /// Start syncing all conversations for the current user.
  ///
  /// Subscribes to the Firestore conversation list, then creates
  /// per-conversation message subscriptions that decrypt and store locally.
  void startSync() {
    if (_isSyncing) return;
    _isSyncing = true;

    debugPrint('MessageSyncService: Starting sync');

    _conversationListSub = _remoteDataSource.watchConversations().listen(
      (conversationModels) async {
        final conversations = conversationModels.map((m) => m.toEntity()).toList();
        final currentIds = conversations.map((c) => c.id).toSet();

        // Store/update conversation metadata locally
        for (final conv in conversations) {
          try {
            await _appDatabase.upsertLocalConversation(
              LocalConversationMapper.toCompanion(conv),
            );
          } catch (e) {
            debugPrint('MessageSyncService: Failed to store conv ${conv.id}: $e');
          }
        }

        // Start syncing new conversations
        for (final convId in currentIds) {
          if (!_syncingConversationIds.contains(convId)) {
            _startMessageSync(convId);
          }
        }

        // Stop syncing removed conversations
        final removedIds = _syncingConversationIds.difference(currentIds);
        for (final convId in removedIds) {
          _stopMessageSync(convId);
        }
      },
      onError: (e) {
        debugPrint('MessageSyncService: Conversation list error: $e');
      },
    );
  }

  /// Stop all syncing (on sign-out or app background).
  void stopSync() {
    if (!_isSyncing) return;
    _isSyncing = false;

    debugPrint('MessageSyncService: Stopping sync');

    _conversationListSub?.cancel();
    _conversationListSub = null;

    for (final sub in _messageSubs.values) {
      sub.cancel();
    }
    _messageSubs.clear();
    _syncingConversationIds.clear();
  }

  /// Start syncing messages for a specific conversation.
  void _startMessageSync(String conversationId) {
    _syncingConversationIds.add(conversationId);

    _messageSubs[conversationId] = _remoteDataSource
        .watchMessages(conversationId: conversationId, limit: 50)
        .listen(
      (messageModels) async {
        await _processIncomingMessages(conversationId, messageModels);
      },
      onError: (e) {
        debugPrint('MessageSyncService: Message sync error for $conversationId: $e');
      },
    );
  }

  /// Stop syncing messages for a specific conversation.
  void _stopMessageSync(String conversationId) {
    _messageSubs[conversationId]?.cancel();
    _messageSubs.remove(conversationId);
    _syncingConversationIds.remove(conversationId);
  }

  /// Process incoming messages from Firestore: decrypt new ones, store locally.
  Future<void> _processIncomingMessages(
    String conversationId,
    List<MessageModel> messageModels,
  ) async {
    final currentUserId = _remoteDataSource.currentUserId;
    if (currentUserId == null) return;

    // Load chatClearedAt once for the batch to avoid per-message DB reads
    DateTime? chatClearedAt;
    final localConv = await _appDatabase.getLocalConversation(conversationId);
    if (localConv != null) {
      chatClearedAt = _parseChatClearedAt(localConv.chatClearedAtJson, currentUserId);
    }

    for (final model in messageModels) {
      try {
        final msg = model.toEntity();

        // Skip messages that predate this user's chatClearedAt
        if (chatClearedAt != null && msg.createdAt.isBefore(chatClearedAt)) {
          continue;
        }

        // Check if already stored and decrypted
        final existing = await _appDatabase.getLocalMessageById(msg.id);
        if (existing != null && existing.isDecrypted) {
          // Already processed — check if any mutable field changed
          final deletedForChanged =
              existing.deletedForJson != jsonEncode(msg.deletedFor);
          final deletedForEveryoneChanged =
              existing.deletedForEveryone != msg.deletedForEveryone;
          if (existing.status != msg.status.name ||
              existing.reactionsJson != _encodeReactions(msg.reactions) ||
              deletedForChanged ||
              deletedForEveryoneChanged) {
            // Update mutable fields without re-decrypting
            await _appDatabase.upsertLocalMessage(
              LocalMessageMapper.toCompanion(
                msg.copyWith(textContent: existing.textContent),
                conversationId,
              ),
            );
          }
          continue;
        }

        // Skip messages that have permanently failed decryption
        if (existing != null &&
            !existing.isDecrypted &&
            (_decryptFailures[msg.id] ?? 0) >= _maxDecryptAttempts) {
          continue;
        }

        // Decrypt if needed
        Message decryptedMsg = msg;
        var isDecrypted = true;

        if (msg.isEncrypted) {
          final plaintext = await _decryptMessage(msg, currentUserId);
          if (plaintext != null) {
            decryptedMsg = _applyDecryptedPayload(msg, plaintext);
            _decryptFailures.remove(msg.id);
          } else {
            isDecrypted = false;
            final isPermanent =
                (_decryptFailures[msg.id] ?? 0) >= _maxDecryptAttempts;
            decryptedMsg = msg.copyWith(
              textContent: isPermanent
                  ? '[Session expired — message cannot be recovered]'
                  : '[Cannot decrypt]',
            );
            if (!isPermanent) {
              final attempts = (_decryptFailures[msg.id] ?? 0) + 1;
              _decryptFailures[msg.id] = attempts;
              if (attempts >= _maxDecryptAttempts) {
                debugPrint('MessageSyncService: Permanently failed to decrypt '
                    '${msg.id} after $attempts attempts — will not retry until '
                    'app restart');
              }
            }
          }
        }

        // Store in local DB
        await _appDatabase.upsertLocalMessage(
          LocalMessageMapper.toCompanion(
            decryptedMsg,
            conversationId,
            isDecrypted: isDecrypted,
          ),
        );

        // Also store in DecryptedMessageCache for backward compatibility
        if (isDecrypted && decryptedMsg.textContent != null) {
          try {
            await _appDatabase.cacheDecryptedPlaintext(
              msg.id,
              decryptedMsg.textContent!,
            );
          } catch (_) {}
        }

        // Update conversation preview with latest message
        await _updateConversationPreview(conversationId, decryptedMsg);
      } catch (e) {
        debugPrint('MessageSyncService: Failed to process msg ${model.id}: $e');
      }
    }
  }

  /// Decrypt a single message. Returns plaintext or null on failure.
  Future<String?> _decryptMessage(
    Message msg,
    String currentUserId,
  ) async {
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
    debugPrint('E2EE SYNC [${msg.id}]: '
        'sender=${msg.senderId.substring(0, 8)}… '
        'hasCiphertext=${msg.ciphertext != null} '
        'hasE2ee=${msg.e2ee != null} '
        'hasX3dh=${msg.x3dhHeader != null} '
        'msgNum=${msg.e2ee?.messageNumber} '
        'dhPubKey=${msg.e2ee?.dhPublicKey != null ? "${msg.e2ee!.dhPublicKey!.substring(0, 8)}…" : "null"} '
        'ctLen=${msg.ciphertext?.length ?? 0}');

    // Build encrypted map for Signal Protocol
    final encryptedMap = <String, dynamic>{
      'ciphertext': msg.ciphertext,
      if (msg.e2ee != null)
        'e2ee': {
          'protocol': msg.e2ee!.protocol,
          'messageNumber': msg.e2ee!.messageNumber,
          'dhPublicKey': msg.e2ee!.dhPublicKey,
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
      debugPrint('E2EE SYNC [${msg.id}]: Decrypt SUCCESS '
          '(${plaintext.length} chars)');
      return plaintext;
    } on PermanentDecryptionError catch (e) {
      // Message can NEVER be decrypted (no x3dhHeader, OTK mismatch, etc.)
      // Mark as permanently failed immediately — no retries.
      debugPrint('E2EE SYNC [${msg.id}]: PERMANENT decrypt failure: $e');
      _decryptFailures[msg.id] = _maxDecryptAttempts;
      return null;
    } catch (e) {
      debugPrint('E2EE SYNC [${msg.id}]: Decrypt FAILED: $e');

      // Session recovery: reset and retry if x3dhHeader present
      if (msg.x3dhHeader != null) {
        try {
          debugPrint('E2EE SYNC [${msg.id}]: Resetting session, retrying…');
          await _signalProtocolService.resetSession(msg.senderId);
          final plaintext = await _signalProtocolService.decryptP2P(
            msg.senderId,
            encryptedMap,
          );
          debugPrint('E2EE SYNC [${msg.id}]: Recovery SUCCESS');
          return plaintext;
        } on PermanentDecryptionError catch (e2) {
          debugPrint('E2EE SYNC [${msg.id}]: PERMANENT after reset: $e2');
          _decryptFailures[msg.id] = _maxDecryptAttempts;
        } catch (retryError) {
          debugPrint('E2EE SYNC [${msg.id}]: Recovery FAILED: $retryError');
          // CRITICAL: Reset the session after failed recovery. The retry
          // performed a receiver X3DH which created a session with wrong
          // keys (old install's identity/ephemeral keys). Leaving this
          // corrupted session in place would cause the NEXT encrypt to
          // use it — producing a message with no x3dh header that the
          // recipient can never decrypt.
          try {
            await _signalProtocolService.resetSession(msg.senderId);
            debugPrint('E2EE SYNC [${msg.id}]: Cleaned up corrupted session '
                'after failed recovery');
          } catch (_) {}
        }
      }

      return null;
    }
  }

  /// Apply decrypted plaintext to a message, handling structured JSON payloads
  /// (e.g., encrypted media messages with embedded metadata).
  Message _applyDecryptedPayload(Message msg, String plaintext) {
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

  /// Update conversation's last message preview in local DB.
  Future<void> _updateConversationPreview(
    String conversationId,
    Message msg,
  ) async {
    try {
      final existing = await _appDatabase.getLocalConversation(conversationId);
      if (existing == null) return;

      // Only update if this message is newer
      if (existing.lastMessageAt != null &&
          msg.createdAt.isBefore(existing.lastMessageAt!)) {
        return;
      }

      final conv = LocalConversationMapper.toEntity(existing);
      String? preview;
      if (msg.textContent != null) {
        preview = msg.textContent!.length > 100
            ? '${msg.textContent!.substring(0, 100)}...'
            : msg.textContent!;
      }

      await _appDatabase.upsertLocalConversation(
        LocalConversationMapper.toCompanion(
          conv.copyWith(
            lastMessageId: msg.id,
            lastMessageText: preview,
            lastMessageSenderId: msg.senderId,
            lastMessageSenderName: msg.senderName,
            lastMessageType: msg.type.name,
            lastMessageAt: msg.createdAt,
          ),
        ),
      );
    } catch (e) {
      debugPrint('MessageSyncService: Failed to update preview for $conversationId: $e');
    }
  }

  String? _encodeReactions(Map<String, List<String>> reactions) {
    if (reactions.isEmpty) return null;
    try {
      return reactions.toString();
    } catch (_) {
      return null;
    }
  }

  /// Parse the chatClearedAt timestamp for a specific user from the JSON string.
  DateTime? _parseChatClearedAt(String json, String userId) {
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      final value = map[userId] as String?;
      return value != null ? DateTime.parse(value) : null;
    } catch (_) {
      return null;
    }
  }
}
