import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../concurrency/keyed_mutex.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/conversation_remote_datasource.dart';
import '../../data/mappers/local_conversation_mapper.dart';
import '../../data/mappers/local_message_mapper.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/message.dart';
import 'message_decryption_service.dart';

/// Background service that syncs Firestore messages → decrypts once → stores
/// in local DB. This is the core of the WhatsApp-style architecture:
/// messages are decrypted exactly once on receipt and stored as plaintext
/// in the encrypted local database. The UI reads from local DB only.
@lazySingleton
class MessageSyncService {
  final ConversationRemoteDataSource _remoteDataSource;
  final MessageDecryptionService _decryptionService;
  final AppDatabase _appDatabase;

  MessageSyncService(
    this._remoteDataSource,
    this._decryptionService,
    this._appDatabase,
  );

  /// Per-conversation message stream subscriptions.
  final Map<String, StreamSubscription> _messageSubs = {};

  /// Per-conversation processing lock. Ensures _processIncomingMessages calls
  /// are always sequential — never concurrent — for the same conversation.
  final _processingLock = KeyedMutex();

  /// Conversation list stream subscription.
  StreamSubscription? _conversationListSub;

  /// Serialises conversation-list callbacks. Dart stream listeners with async
  /// bodies do not await previous invocations — rapid Firestore updates (e.g.
  /// conversation created + metadata updated) can spawn two concurrent async
  /// callbacks that both see a conversation as "not yet syncing" and call
  /// _startMessageSync twice, creating a duplicate subscription.
  final _convListLock = KeyedMutex();

  /// Track conversation IDs we're currently syncing.
  final Set<String> _syncingConversationIds = {};

  /// Conversation IDs from the most recent conversation list snapshot.
  /// Used to kick-start message sync when startSync() is called after
  /// startConversationListSync() has already been running.
  final Set<String> _latestConversationIds = {};

  /// Forwarding getter — the repository writes to this cache on send;
  /// the decryption service reads it when resolving own outgoing messages.
  Map<String, String> get sentPlaintextCache =>
      _decryptionService.sentPlaintextCache;

  /// Cache a sent message's plaintext with bounded eviction.
  void cacheSentPlaintext(String messageId, String plaintext) =>
      _decryptionService.cacheSentPlaintext(messageId, plaintext);

  bool _isSyncing = false;
  bool _conversationListSyncing = false;

  /// Periodic timer that purges locally-stored messages past their [expiresAt].
  Timer? _cleanupTimer;

  /// Start syncing just the conversation list (metadata only).
  ///
  /// Called immediately after auth to populate the conversation list UI
  /// before E2EE keys are ready. Message-level syncing (decryption) starts
  /// later via [startSync] after E2EE initialization completes.
  void startConversationListSync() {
    if (_conversationListSyncing) return;
    _conversationListSyncing = true;

    debugPrint('MessageSyncService: Starting conversation list sync');

    _conversationListSub = _remoteDataSource.watchConversations().listen(
      (conversationModels) {
        _convListLock.protect('_', () async {
          final conversations =
              conversationModels.map((m) => m.toEntity()).toList();
          final currentIds = conversations.map((c) => c.id).toSet();
          _latestConversationIds
            ..clear()
            ..addAll(currentIds);

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

          // Start message-level sync only if full sync is active (E2EE ready)
          if (_isSyncing) {
            for (final convId in currentIds) {
              if (!_syncingConversationIds.contains(convId)) {
                _startMessageSync(convId);
              }
            }

            final removedIds = _syncingConversationIds.difference(currentIds);
            for (final convId in removedIds) {
              _stopMessageSync(convId);
            }
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

  /// Start full message syncing (decryption + storage).
  ///
  /// Requires E2EE keys to be ready. If [startConversationListSync] was
  /// already called, message-level sync is kicked off for all known
  /// conversations. Otherwise, starts the conversation list sync too.
  void startSync() {
    if (_isSyncing) return;
    _isSyncing = true;

    debugPrint('MessageSyncService: Starting full message sync');

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

    if (!_conversationListSyncing) {
      // Conversation list sync wasn't started early — start it now
      startConversationListSync();
    } else {
      // Already running — kick-start message sync for known conversations
      for (final convId in _latestConversationIds) {
        if (!_syncingConversationIds.contains(convId)) {
          _startMessageSync(convId);
        }
      }
    }
  }

  /// Stop all syncing (on sign-out or app background).
  void stopSync() {
    if (!_isSyncing && !_conversationListSyncing) return;
    _isSyncing = false;
    _conversationListSyncing = false;

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
    _latestConversationIds.clear();
    _processingLock.clear();
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
        _processingLock.protect(
          conversationId,
          () => _processIncomingMessages(conversationId, messageModels),
        ).catchError((Object e) {
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
    // Lock auto-cleans after completion; no manual removal needed.
  }

  /// Process incoming messages from Firestore: decrypt new ones, store locally.
  ///
  /// Messages arrive newest-first from the Firestore query but are **sorted
  /// oldest-first** for decryption. This ensures the initial message in a
  /// session (which carries the x3dhHeader for receiver-side X3DH) is decrypted
  /// first, establishing the session before newer messages are processed.
  ///
  /// Without oldest-first ordering, newer messages (without x3dhHeader) would
  /// fail before the session-establishing message is reached, causing a cascade
  /// of "[Cannot decrypt]" failures.
  ///
  /// After the first pass, any messages that failed due to a missing session
  /// (but might now succeed because an older message established one) are
  /// retried in a second pass.
  Future<void> _processIncomingMessages(
    String conversationId,
    List<MessageModel> messageModels,
  ) async {
    final currentUserId = _remoteDataSource.currentUserId;
    if (currentUserId == null) return;

    // Sort oldest-first so x3dhHeader messages (which establish the session)
    // are processed before newer messages that depend on that session.
    final sorted = List<MessageModel>.from(messageModels)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    // Load chatClearedAt once for the batch to avoid per-message DB reads
    DateTime? chatClearedAt;
    final localConv = await _appDatabase.getLocalConversation(conversationId);
    if (localConv != null) {
      chatClearedAt = _parseChatClearedAt(localConv.chatClearedAtJson, currentUserId);
    }

    // Track senders whose session was successfully used in this batch.
    // Once an older message establishes the session, newer messages from the
    // same sender use protectSession=true to avoid destructive recovery that
    // would overwrite the working session.
    final sendersWithGoodSession = <String>{};

    // Track messages that failed decryption in this pass so we can retry them
    // after a session-establishing message may have succeeded.
    final failedInThisPass = <MessageModel>[];

    for (final model in sorted) {
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
            _decryptionService.isPermanentlyFailed(msg.id);
        if (isPermanentlyFailed) continue;

        // Decrypt if needed
        var decryptedMsg = msg;
        var isDecrypted = true;

        if (msg.isEncrypted) {
          // If an earlier message from this sender already established the
          // session in this batch, protect it from destructive recovery.
          final protectSession =
              sendersWithGoodSession.contains(msg.senderId);

          final plaintext = await _decryptionService.decryptMessage(
            msg,
            currentUserId,
            protectSession: protectSession,
          );
          if (plaintext != null) {
            decryptedMsg = _decryptionService.applyDecryptedPayload(msg, plaintext);
            _decryptionService.decryptFailures.remove(msg.id);
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
            // Track for second-pass retry: a later message in this batch
            // (with x3dhHeader) might establish the session.
            if (!_decryptionService.isPermanentlyFailed(msg.id)) {
              failedInThisPass.add(model);
            }
            final isPermanent =
                _decryptionService.isPermanentlyFailed(msg.id);
            decryptedMsg = msg.copyWith(
              textContent: isPermanent
                  ? '[Session expired — message cannot be recovered]'
                  : '[Cannot decrypt]',
            );
            if (!isPermanent) {
              _decryptionService.recordFailure(msg.id);
              if (_decryptionService.isPermanentlyFailed(msg.id)) {
                debugPrint('MessageSyncService: Permanently failed to decrypt '
                    '${msg.id} — will not retry until app restart');
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

    // Second pass: retry messages that failed in this batch because the session
    // hadn't been established yet. A newer message with x3dhHeader may have
    // since established the session via receiver X3DH.
    if (failedInThisPass.isNotEmpty && sendersWithGoodSession.isNotEmpty) {
      debugPrint('MessageSyncService: Retrying ${failedInThisPass.length} '
          'messages after session established in this batch');
      for (final model in failedInThisPass) {
        try {
          final msg = model.toEntity();
          if (!sendersWithGoodSession.contains(msg.senderId)) continue;
          if (_decryptionService.isPermanentlyFailed(msg.id)) continue;

          final plaintext = await _decryptionService.decryptMessage(
            msg,
            currentUserId,
            protectSession: true, // session was established — protect it
          );
          if (plaintext != null) {
            final decryptedMsg =
                _decryptionService.applyDecryptedPayload(msg, plaintext);
            _decryptionService.decryptFailures.remove(msg.id);
            await _appDatabase.upsertLocalMessage(
              LocalMessageMapper.toCompanion(
                decryptedMsg,
                conversationId,
                isDecrypted: true,
              ),
            );
            if (decryptedMsg.textContent != null) {
              try {
                await _appDatabase.cacheDecryptedPlaintext(
                  msg.id,
                  decryptedMsg.textContent!,
                );
              } catch (_) {}
            }
            await _updateConversationPreview(conversationId, decryptedMsg);
            debugPrint('MessageSyncService: Retry SUCCESS for ${msg.id}');
          }
        } catch (e) {
          debugPrint('MessageSyncService: Retry failed for ${model.id}: $e');
        }
      }
    }

    // Reset failure counters for senders whose sessions are now established.
    // The next Firestore sync event will re-process undecrypted messages
    // from these senders (ciphertext is only available from Firestore, not
    // the local DB, so we rely on the stream to retry).
    if (sendersWithGoodSession.isNotEmpty) {
      final undecryptedIds = <String>[];
      for (final senderId in sendersWithGoodSession) {
        try {
          final undecrypted = await _appDatabase.getUndecryptedMessages(
            conversationId,
            senderId,
          );
          undecryptedIds.addAll(undecrypted.map((m) => m.id));
        } catch (_) {}
      }
      if (undecryptedIds.isNotEmpty) {
        _decryptionService.resetFailures(undecryptedIds);
        debugPrint('MessageSyncService: Reset failure counters for '
            '${undecryptedIds.length} undecrypted messages — '
            'will retry on next sync event');
      }
    }
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
