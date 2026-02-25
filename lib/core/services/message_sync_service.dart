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

  /// Per-conversation processing chain. Each new Firestore event is chained
  /// onto the previous Future so _processIncomingMessages calls are always
  /// sequential — never concurrent — for the same conversation.
  final Map<String, Future<void>> _processingLocks = {};

  /// Conversation list stream subscription.
  StreamSubscription? _conversationListSub;

  /// Serialises conversation-list callbacks. Dart stream listeners with async
  /// bodies do not await previous invocations — rapid Firestore updates (e.g.
  /// conversation created + metadata updated) can spawn two concurrent async
  /// callbacks that both see a conversation as "not yet syncing" and call
  /// _startMessageSync twice, creating a duplicate subscription.
  Future<void> _conversationListLock = Future.value();

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

  /// Periodic timer that purges locally-stored messages past their [expiresAt].
  Timer? _cleanupTimer;

  /// Start syncing all conversations for the current user.
  ///
  /// Subscribes to the Firestore conversation list, then creates
  /// per-conversation message subscriptions that decrypt and store locally.
  void startSync() {
    if (_isSyncing) return;
    _isSyncing = true;

    debugPrint('MessageSyncService: Starting sync');

    // Purge expired (disappearing) messages every minute
    _cleanupTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
      try {
        final deleted = await _appDatabase.deleteExpiredMessages();
        if (deleted > 0) {
          debugPrint('MessageSyncService: Deleted $deleted expired messages');
        }
      } catch (e) {
        debugPrint('MessageSyncService: Error cleaning expired messages: $e');
      }
    });

    _conversationListSub = _remoteDataSource.watchConversations().listen(
      (conversationModels) {
        _conversationListLock = _conversationListLock.then((_) async {
          final conversations =
              conversationModels.map((m) => m.toEntity()).toList();
          final currentIds = conversations.map((c) => c.id).toSet();

          // Store/update conversation metadata locally.
          // Preserve local lastMessageText when Firestore sends null (E2EE
          // messages have lastMessageText=null on the server — the decrypted
          // preview is only available locally after MessageSyncService decrypts).
          for (final conv in conversations) {
            try {
              var convToStore = conv;
              if (conv.lastMessageText == null && conv.lastMessageAt != null) {
                final existing =
                    await _appDatabase.getLocalConversation(conv.id);
                if (existing != null && existing.lastMessageText != null) {
                  convToStore = conv.copyWith(
                    lastMessageText: existing.lastMessageText,
                  );
                }
              }
              await _appDatabase.upsertLocalConversation(
                LocalConversationMapper.toCompanion(convToStore),
              );
            } catch (e) {
              debugPrint(
                  'MessageSyncService: Failed to store conv ${conv.id}: $e');
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
        }).catchError((Object e) {
          debugPrint('MessageSyncService: Conversation list error: $e');
        });
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

    _cleanupTimer?.cancel();
    _cleanupTimer = null;
    _conversationListSub?.cancel();
    _conversationListSub = null;

    for (final sub in _messageSubs.values) {
      sub.cancel();
    }
    _messageSubs.clear();
    _syncingConversationIds.clear();
    _processingLocks.clear();
  }

  /// Start syncing messages for a specific conversation.
  void _startMessageSync(String conversationId) {
    _syncingConversationIds.add(conversationId);

    _messageSubs[conversationId] = _remoteDataSource
        .watchMessages(conversationId: conversationId, limit: 50)
        .listen(
      (messageModels) {
        // Chain onto the previous processing Future so calls for the same
        // conversation execute sequentially. This prevents two concurrent
        // _processIncomingMessages calls from both reading existing=null for
        // the same message before either writes isDecrypted:true — which would
        // cause the second call's destructive recovery to fire a
        // PermanentDecryptionError (OTK already consumed) and overwrite the
        // first call's successful isDecrypted:true row with the sentinel.
        _processingLocks[conversationId] =
            (_processingLocks[conversationId] ?? Future.value())
                .then((_) => _processIncomingMessages(conversationId, messageModels))
                .catchError((Object e) {
          debugPrint(
              'MessageSyncService: processing error for $conversationId: $e');
        });
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
    _processingLocks.remove(conversationId);
  }

  /// Process incoming messages from Firestore: decrypt new ones, store locally.
  ///
  /// Messages arrive newest-first from the Firestore query. This method tracks
  /// senders that have successfully decrypted a message in this batch — for
  /// subsequent OLDER messages from the same sender, destructive recovery
  /// (session reset + retry) is skipped to prevent corrupting the working
  /// session established by the newer message.
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

    // Track senders whose session was successfully used in this batch.
    // Once a newer message decrypts OK, older messages from the same sender
    // must NOT trigger destructive recovery (session reset) — that would
    // overwrite the working session with stale X3DH keys and break future
    // messages.
    final sendersWithGoodSession = <String>{};

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
          // Already processed — mark sender as having a good session
          if (msg.senderId != currentUserId) {
            sendersWithGoodSession.add(msg.senderId);
          }
          // Check if any mutable field changed
          final deletedForChanged =
              existing.deletedForJson != jsonEncode(msg.deletedFor);
          final deletedForEveryoneChanged =
              existing.deletedForEveryone != msg.deletedForEveryone;
          if (existing.status != msg.status.name ||
              existing.reactionsJson != _encodeReactions(msg.reactions) ||
              deletedForChanged ||
              deletedForEveryoneChanged) {
            // Update ONLY mutable fields — preserve all decrypted content
            // (textContent, media, gift, etc.) from the local row. Using the
            // Firestore `msg` as base would overwrite media/gift with null
            // because those fields are inside the encrypted payload on the server.
            final localEntity = LocalMessageMapper.toEntity(existing);
            final updated = localEntity.copyWith(
              status: msg.status,
              reactions: msg.reactions,
              deletedFor: msg.deletedFor,
              deletedForEveryone: msg.deletedForEveryone,
              readBy: msg.readBy,
            );
            await _appDatabase.upsertLocalMessage(
              LocalMessageMapper.toCompanion(updated, conversationId),
            );
          }
          continue;
        }

        // Skip messages that have permanently failed decryption.
        // Two signals: in-memory counter (this session) OR the permanent
        // sentinel text already written to the local DB (persists across restarts).
        const permanentSentinel = '[Session expired — message cannot be recovered]';
        final isPermanentlyFailed = (existing != null &&
                !existing.isDecrypted &&
                existing.textContent == permanentSentinel) ||
            (_decryptFailures[msg.id] ?? 0) >= _maxDecryptAttempts;
        if (isPermanentlyFailed) continue;

        // Decrypt if needed
        Message decryptedMsg = msg;
        var isDecrypted = true;

        if (msg.isEncrypted) {
          // If a newer message from this sender already succeeded, protect
          // that session by skipping destructive recovery on this older message.
          final protectSession =
              sendersWithGoodSession.contains(msg.senderId);

          final plaintext = await _decryptMessage(
            msg,
            currentUserId,
            protectSession: protectSession,
          );
          if (plaintext != null) {
            decryptedMsg = _applyDecryptedPayload(msg, plaintext);
            _decryptFailures.remove(msg.id);
            sendersWithGoodSession.add(msg.senderId);
          } else {
            // Defensive re-read: if any parallel path (e.g. a lock bypass or
            // future refactor) already committed isDecrypted:true for this
            // message, do NOT overwrite it with a failure row.
            final recheck = await _appDatabase.getLocalMessageById(msg.id);
            if (recheck != null && recheck.isDecrypted) {
              debugPrint('MessageSyncService: Skipping failure write for '
                  '${msg.id} — already stored as decrypted');
              continue;
            }

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
  ///
  /// When [protectSession] is true, destructive recovery (session reset +
  /// retry) is skipped. This is used when a newer message from the same sender
  /// already decrypted successfully — resetting the session would overwrite
  /// the working session with stale X3DH keys from the older message.
  Future<String?> _decryptMessage(
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
    debugPrint('E2EE SYNC [${msg.id}]: '
        'sender=${msg.senderId.substring(0, 8)}… '
        'hasCiphertext=${msg.ciphertext != null} '
        'hasE2ee=${msg.e2ee != null} '
        'hasX3dh=${msg.x3dhHeader != null} '
        'msgNum=${msg.e2ee?.messageNumber} '
        'dhPubKey=${msg.e2ee?.dhPublicKey != null ? "${msg.e2ee!.dhPublicKey!.substring(0, 8)}…" : "null"} '
        'ctLen=${msg.ciphertext?.length ?? 0} '
        'protectSession=$protectSession '
        'msgAge=${DateTime.now().difference(msg.createdAt).inSeconds}s');

    // Fix 2: Verify sender identity key against registered Firestore bundle
    // before performing X3DH. Prevents a MITM substituting their own key.
    if (msg.x3dhHeader != null) {
      final claimedKey = msg.x3dhHeader!.identityKey;
      final registeredKey =
          await _remoteDataSource.getUserE2eeIdentityKey(msg.senderId);
      if (registeredKey != null && registeredKey != claimedKey) {
        debugPrint('E2EE SECURITY [${msg.id}]: '
            'Identity key mismatch for ${msg.senderId} — '
            'claimed=${claimedKey.substring(0, 8)}… '
            'registered=${registeredKey.substring(0, 8)}…');
        _decryptFailures[msg.id] = _maxDecryptAttempts;
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
      // Fix 7: On OTK mismatch the current session is poisoned — reset it
      // so future messages from this sender can establish a fresh session.
      if (e.message.contains('OTK mismatch')) {
        try {
          await _signalProtocolService.resetSession(msg.senderId);
          debugPrint('E2EE SYNC [${msg.id}]: Session reset after OTK mismatch '
              '— next message from ${msg.senderId} will re-establish');
        } catch (_) {}
      }
      return null;
    } catch (e) {
      debugPrint('E2EE SYNC [${msg.id}]: Decrypt FAILED: $e');

      // If a newer message from this sender already decrypted OK, do NOT
      // attempt destructive recovery — it would overwrite the working session
      // with stale keys from this older message.
      if (protectSession) {
        debugPrint('E2EE SYNC [${msg.id}]: Skipping destructive recovery — '
            'protecting working session from older message');
        _decryptFailures[msg.id] = _maxDecryptAttempts;
        return null;
      }

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
      return jsonEncode(reactions);
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
