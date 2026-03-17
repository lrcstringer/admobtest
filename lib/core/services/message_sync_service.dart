import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../concurrency/keyed_mutex.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/conversation_remote_datasource.dart';
import '../../data/mappers/local_conversation_mapper.dart';
import '../../data/mappers/local_message_mapper.dart';
import '../../data/models/conversation_model.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/message.dart';
import '../../domain/enums/message_type.dart';
import 'crypto_service.dart';
import 'media_recovery_service.dart';
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
  final MediaRecoveryService _mediaRecoveryService;

  MessageSyncService(
    this._remoteDataSource,
    this._decryptionService,
    this._appDatabase,
    this._mediaRecoveryService,
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

    _conversationListSub = _remoteDataSource.watchConversations().listen(
      (conversationModels) {
        _convListLock.protect('_', () async {
          await _syncConversationSnapshot(conversationModels);
        }).catchError((Object e) {
        });
      },
      onError: (e) {
      },
    );
  }

  /// Whether the first conversation sync has completed its authoritative
  /// server prune. Reset on [stopSync].
  bool _initialPruneDone = false;

  /// Process a conversation list snapshot: upsert current conversations,
  /// prune stale ones, and start/stop message-level sync as needed.
  Future<void> _syncConversationSnapshot(
    List<ConversationModel> conversationModels,
  ) async {
    final conversations =
        conversationModels.map((m) => m.toEntity()).toList();
    final currentIds = conversations.map((c) => c.id).toSet();
    _latestConversationIds
      ..clear()
      ..addAll(currentIds);

    // Store/update conversation metadata locally using batch upsert.
    // Preserve local preview in two cases:
    // (a) Firestore has null lastMessageText (E2EE) — keep decrypted local text
    // (b) Firestore has OLDER lastMessageAt — stale offline cache snapshot;
    //     keep the newer local preview so _updateConversationPreview's work
    //     and OutgoingMessageQueue's optimistic updates aren't overwritten.
    try {
      Map<String, ({String? text, DateTime? at})>? localData;
      final localRows = await _appDatabase.getLocalConversations();
      if (localRows.isNotEmpty) {
        localData = {
          for (final r in localRows)
            r.id: (text: r.lastMessageText, at: r.lastMessageAt),
        };
      }

      final companions = conversations.map((conv) {
        var convToStore = conv;
        final local = localData?[conv.id];
        if (local != null) {
          // If local DB has a newer lastMessageAt, a stale Firestore cache
          // snapshot is trying to overwrite it — preserve all local preview
          // fields so _updateConversationPreview's work isn't lost.
          if (local.at != null &&
              conv.lastMessageAt != null &&
              local.at!.isAfter(conv.lastMessageAt!)) {
            convToStore = conv.copyWith(
              lastMessageText: local.text,
              lastMessageAt: local.at,
            );
          } else if (conv.lastMessageText == null &&
              conv.lastMessageAt != null &&
              local.text != null) {
            // E2EE: Firestore has null text — preserve local decrypted preview
            convToStore = conv.copyWith(lastMessageText: local.text);
          }
        }
        return LocalConversationMapper.toCompanion(convToStore);
      }).toList();

      await _appDatabase.upsertLocalConversationsBatch(companions);
    } catch (e) {
    }

    // Check for E2EE session reset signals addressed to us.
    // When a peer's decryption permanently fails, they set
    // sessionResetRequested[ourUserId]=true on the conversation doc.
    // We detect that here, reset our local session, and clear the flag.
    final currentUserId = _remoteDataSource.currentUserId;
    if (currentUserId != null) {
      for (final model in conversationModels) {
        if (model.sessionResetRequested[currentUserId] == true) {
          final peerId = model.participantIds
              .where((id) => id != currentUserId)
              .firstOrNull;
          if (peerId != null) {
            CryptoService.e2eeLog('E2EE SESSION RESET: Peer $peerId '
                'requested session reset in conv ${model.id}');
            _decryptionService.resetSessionForPeer(peerId).then((_) {
              _remoteDataSource.clearSessionReset(
                conversationId: model.id,
              ).catchError((_) {});
              CryptoService.e2eeLog('E2EE SESSION RESET: Reset complete '
                  'for peer $peerId — next send will re-establish');
            }).catchError((e) {
              CryptoService.e2eeLog(
                  'E2EE SESSION RESET failed for $peerId: $e');
            });
          }
        }
      }
    }

    // Start message-level sync FIRST (before pruning) so conversations
    // appear in the UI as quickly as possible.
    // Pre-warm: prioritize the most recent conversations (first in the list,
    // which is sorted by lastMessageAt DESC). The top 2 conversations get
    // their backfill+subscribe kicked off first, so when the user opens the
    // inbox and taps the most recent chat, messages are already loaded.
    if (_isSyncing) {
      final newIds = currentIds
          .where((id) => !_syncingConversationIds.contains(id))
          .toList();

      // Prioritize: conversations list is already sorted by lastMessageAt DESC
      // from Firestore. Start the top conversations first so their messages
      // are available for instant display when the user opens the inbox.
      const preWarmCount = 2;
      final prioritized = newIds.take(preWarmCount);
      final rest = newIds.skip(preWarmCount);

      for (final convId in prioritized) {
        _startMessageSync(convId);
      }
      for (final convId in rest) {
        _startMessageSync(convId);
      }

      final removedIds = _syncingConversationIds.difference(currentIds);
      for (final convId in removedIds) {
        _stopMessageSync(convId);
      }
    }

    // Prune local conversations that no longer exist on the server.
    // Runs AFTER upserts + message sync start so it doesn't block the UI.
    //
    // On the FIRST sync after startup, the stream emission may come from
    // Firestore's local cache — which still contains deleted documents.
    // Fetch the authoritative list from the server to detect stale entries.
    // On subsequent syncs, the stream data is server-confirmed so
    // currentIds is trustworthy.
    try {
      final Set<String> authoritativeIds;
      if (!_initialPruneDone) {
        final serverModels = await _remoteDataSource.getConversations();
        authoritativeIds = serverModels.map((m) => m.id).toSet();
        _initialPruneDone = true;
      } else {
        authoritativeIds = currentIds;
      }

      final localRows = await _appDatabase.getLocalConversations();
      final localIds = localRows.map((r) => r.id).toSet();
      final staleIds = localIds.difference(authoritativeIds);
      if (staleIds.isNotEmpty) {
        for (final id in staleIds) {
          await _appDatabase.deleteLocalConversation(id);
        }
      }
    } catch (e, st) {
    }
  }

  /// Start full message syncing (decryption + storage).
  ///
  /// Requires E2EE keys to be ready. If [startConversationListSync] was
  /// already called, message-level sync is kicked off for all known
  /// conversations. Otherwise, starts the conversation list sync too.
  void startSync() {
    if (_isSyncing) return;
    _isSyncing = true;

    // Purge expired (disappearing) messages every minute
    _cleanupTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
      try {
        final deleted = await _appDatabase.deleteExpiredMessages();
        if (deleted > 0) {
        }
      } catch (e) {
      }
    });

    if (!_conversationListSyncing) {
      // Conversation list sync wasn't started early — start it now
      startConversationListSync();
    } else {
      // Already running — kick-start message sync for known conversations.
      // _latestConversationIds preserves insertion order from the Firestore
      // snapshot (lastMessageAt DESC), so the most recent conversations are
      // synced first for pre-warming.
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
    _backfilledConversationIds.clear();
    _initialPruneDone = false;
    _processingLock.clear();
  }

  /// Set of conversation IDs that have completed their one-time historical
  /// backfill. Prevents re-running backfill on every conversation list update.
  final Set<String> _backfilledConversationIds = {};

  /// Start syncing messages for a specific conversation.
  ///
  /// On fresh install (empty local DB), performs a one-time historical backfill
  /// that pages through ALL messages from Firestore before subscribing to the
  /// live stream. This ensures messages older than the 50-message live window
  /// are fetched, decrypted, and stored locally.
  void _startMessageSync(String conversationId) {
    _syncingConversationIds.add(conversationId);

    // Kick off backfill before subscribing to the live stream.
    // The live stream subscription starts after backfill completes (or skips
    // if already backfilled).
    _backfillAndSubscribe(conversationId);
  }

  /// Run one-time historical backfill then subscribe to live stream.
  Future<void> _backfillAndSubscribe(String conversationId) async {
    if (!_backfilledConversationIds.contains(conversationId)) {
      try {
        await _backfillHistoricalMessages(conversationId);
      } catch (e) {
      }
      _backfilledConversationIds.add(conversationId);
    }

    // Don't subscribe if sync was stopped while backfilling
    if (!_isSyncing || !_syncingConversationIds.contains(conversationId)) {
      return;
    }

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
        });
      },
      onError: (e) {
      },
    );
  }

  /// One-time paginated fetch of historical messages from Firestore.
  ///
  /// Pages through messages oldest-first in batches of 50, processing each
  /// batch through the decrypt-and-store pipeline. Capped at [_maxBackfillMessages]
  /// to avoid excessive Firestore reads and decryption time on reinstall.
  /// Older messages beyond the cap can be fetched on-demand when the user
  /// scrolls up past the backfill boundary.
  static const _maxBackfillMessages = 500;

  Future<void> _backfillHistoricalMessages(String conversationId) async {
    // Check if local DB already has messages — skip backfill if so
    final existingCount = await _appDatabase.getMessageCount(conversationId);
    if (existingCount > 0) {
      return;
    }

    const pageSize = 50;
    var totalFetched = 0;
    DateTime? beforeCursor;

    while (totalFetched < _maxBackfillMessages) {
      // Abort if sync was stopped
      if (!_isSyncing) break;

      final remaining = _maxBackfillMessages - totalFetched;
      final limit = remaining < pageSize ? remaining : pageSize;

      final batch = await _remoteDataSource.getMessages(
        conversationId: conversationId,
        limit: limit,
        before: beforeCursor,
      );

      if (batch.isEmpty) break;

      totalFetched += batch.length;

      // Process through the same decrypt-and-store pipeline
      await _processingLock.protect(
        conversationId,
        () => _processIncomingMessages(conversationId, batch),
      );

      // Move cursor to the oldest message in this batch for next page
      // (getMessages returns newest-first with descending createdAt)
      beforeCursor = batch.last.createdAt;

      // If we got fewer than requested, we've reached the end
      if (batch.length < limit) break;
    }

    if (totalFetched > 0) {
    }
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
          // Gift/spray status is updated directly on the Firestore document
          // by Cloud Functions (openGift, claimGift, etc.), outside the
          // encrypted payload, so msg.gift/msg.tokenSpray are reliable here.
          final localEntity = LocalMessageMapper.toEntity(existing);
          final giftStatusChanged = msg.gift != null &&
              localEntity.gift != null &&
              localEntity.gift!.status != msg.gift!.status;
          final sprayStatusChanged = msg.tokenSpray != null &&
              localEntity.tokenSpray != null &&
              localEntity.tokenSpray!.status != msg.tokenSpray!.status;
          if (existing.status != msg.status.name ||
              existing.reactionsJson != _encodeReactions(msg.reactions) ||
              deletedForChanged ||
              deletedForEveryoneChanged ||
              giftStatusChanged ||
              sprayStatusChanged) {
            // Update ONLY mutable fields — preserve all decrypted content
            // (textContent, media, etc.) from the local row. Using the
            // Firestore `msg` as base would overwrite those with null
            // because they're inside the encrypted payload on the server.
            // Gift/spray status is the exception — CFs update it directly.
            final updated = localEntity.copyWith(
              status: msg.status,
              reactions: msg.reactions,
              deletedFor: msg.deletedFor,
              deletedForEveryone: msg.deletedForEveryone,
              readBy: msg.readBy,
              gift: giftStatusChanged
                  ? localEntity.gift!.copyWith(status: msg.gift!.status)
                  : localEntity.gift,
              tokenSpray: sprayStatusChanged
                  ? localEntity.tokenSpray!
                      .copyWith(status: msg.tokenSpray!.status)
                  : localEntity.tokenSpray,
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

        // Skip sender's own messages when the outgoing queue still has active
        // pending messages for this conversation. The queue's _finalizeSent
        // will atomically replace the pending entry with the real one. If we
        // process the real message here first, both pending_xxx and the real
        // message coexist in localFullMessages and the UI shows a brief duplicate.
        if (msg.senderId == currentUserId && existing == null) {
          final activePending = await _appDatabase
              .getPendingMessagesForConversation(conversationId);
          if (activePending.any((p) => p.status != 'failed')) {
            continue;
          }
        }

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
            conversationId: conversationId,
            protectSession: protectSession,
          );
          if (plaintext != null) {
            decryptedMsg = _decryptionService.applyDecryptedPayload(msg, plaintext);
            _decryptionService.decryptFailures.remove(msg.id);
            sendersWithGoodSession.add(msg.senderId);
            // Store in vault for recovery after reinstall
            _mediaRecoveryService.storePayload(msg.id, plaintext).catchError((e) {
            });
          } else {
            // Defensive re-read: if any parallel path (e.g. a lock bypass or
            // future refactor) already committed isDecrypted:true for this
            // message, do NOT overwrite it with a failure row.
            final recheck = await _appDatabase.getLocalMessageById(msg.id);
            if (recheck != null && recheck.isDecrypted) {
              continue;
            }

            // Sender's own messages: plaintext was only in the local cache.
            // After reinstall the cache is gone and the message can't be
            // recovered (it was encrypted for the recipient, not the sender).
            // Store a graceful fallback with isDecrypted:true so the sync
            // doesn't re-process on every snapshot. If the outgoing queue
            // is still processing (race condition), _finalizeSent will
            // overwrite this with the real content.
            if (msg.senderId == currentUserId) {
              // Try vault recovery before falling back to placeholder.
              // Await initialize() in case it's still in-flight (race condition)
              // — this coalesces with the existing init call and is a no-op if
              // already ready.
              await _mediaRecoveryService.initialize();
              if (_mediaRecoveryService.isReady) {
                final recovered = await _mediaRecoveryService.recoverPayload(msg.id);
                if (recovered != null) {
                  decryptedMsg = _decryptionService.applyDecryptedPayload(
                      msg, recovered);
                  await _appDatabase.upsertLocalMessage(
                    LocalMessageMapper.toCompanion(
                      decryptedMsg,
                      conversationId,
                      isDecrypted: true,
                    ),
                  );
                  _appDatabase
                      .indexMessageForSearch(msg.id, decryptedMsg.textContent)
                      .catchError((_) {});
                  await _appDatabase.cacheDecryptedPlaintext(msg.id, recovered);
                  await _updateConversationPreview(
                      conversationId, decryptedMsg);
                  continue;
                }
              }
              decryptedMsg = msg.copyWith(
                textContent: '[Sent by you]',
              );
              // Mark as "decrypted" so we don't retry every sync cycle
              await _appDatabase.upsertLocalMessage(
                LocalMessageMapper.toCompanion(
                  decryptedMsg,
                  conversationId,
                  isDecrypted: true,
                ),
              );
              await _updateConversationPreview(conversationId, decryptedMsg);
              continue;
            }

            // Try vault recovery for received messages (may have been
            // decrypted in a previous install and stored in the vault).
            // Await initialize() in case it's still in-flight.
            final vaultReady = await _mediaRecoveryService.initialize();
            if (_mediaRecoveryService.isReady) {
              final recovered = await _mediaRecoveryService.recoverPayload(msg.id);
              if (recovered != null) {
                decryptedMsg = _decryptionService.applyDecryptedPayload(
                    msg, recovered);
                await _appDatabase.upsertLocalMessage(
                  LocalMessageMapper.toCompanion(
                    decryptedMsg,
                    conversationId,
                    isDecrypted: true,
                  ),
                );
                _appDatabase
                    .indexMessageForSearch(msg.id, decryptedMsg.textContent)
                    .catchError((_) {});
                await _appDatabase.cacheDecryptedPlaintext(msg.id, recovered);
                await _updateConversationPreview(conversationId, decryptedMsg);
                _decryptionService.decryptFailures.remove(msg.id);
                continue;
              } else {
              }
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

        // Index in FTS5 for fast search (fire-and-forget)
        if (isDecrypted && decryptedMsg.textContent != null) {
          _appDatabase
              .indexMessageForSearch(msg.id, decryptedMsg.textContent)
              .catchError((_) {});
        }

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
      }
    }

    // Second pass: retry messages that failed in this batch because the session
    // hadn't been established yet. A newer message with x3dhHeader may have
    // since established the session via receiver X3DH.
    if (failedInThisPass.isNotEmpty && sendersWithGoodSession.isNotEmpty) {
      for (final model in failedInThisPass) {
        try {
          final msg = model.toEntity();
          if (!sendersWithGoodSession.contains(msg.senderId)) continue;
          if (_decryptionService.isPermanentlyFailed(msg.id)) continue;

          final plaintext = await _decryptionService.decryptMessage(
            msg,
            currentUserId,
            conversationId: conversationId,
            protectSession: true, // session was established — protect it
          );
          if (plaintext != null) {
            final decryptedMsg =
                _decryptionService.applyDecryptedPayload(msg, plaintext);
            _decryptionService.decryptFailures.remove(msg.id);
            // Store in vault for recovery after reinstall
            _mediaRecoveryService.storePayload(msg.id, plaintext).catchError((e) {
            });
            await _appDatabase.upsertLocalMessage(
              LocalMessageMapper.toCompanion(
                decryptedMsg,
                conversationId,
                isDecrypted: true,
              ),
            );
            _appDatabase
                .indexMessageForSearch(msg.id, decryptedMsg.textContent)
                .catchError((_) {});
            if (decryptedMsg.textContent != null) {
              try {
                await _appDatabase.cacheDecryptedPlaintext(
                  msg.id,
                  decryptedMsg.textContent!,
                );
              } catch (_) {}
            }
            await _updateConversationPreview(conversationId, decryptedMsg);
          }
        } catch (e) {
        }
      }
    }

    // Reset failure counters for senders whose sessions are now established.
    // The next Firestore sync event will re-process undecrypted messages
    // from these senders (ciphertext is only available from Firestore, not
    // the local DB, so we rely on the stream to retry).
    //
    // Also clear the permanent sentinel from the DB so that previously
    // permanently-failed messages get a fresh chance. Without this, the
    // sentinel check at line ~563 would skip them forever even though
    // the session is now valid.
    if (sendersWithGoodSession.isNotEmpty) {
      final undecryptedIds = <String>[];
      for (final senderId in sendersWithGoodSession) {
        try {
          // Clear DB permanent sentinel → allows retry on next snapshot
          final cleared = await _appDatabase.clearPermanentSentinel(
            conversationId,
            senderId,
          );
          if (cleared > 0) {
          }
          final undecrypted = await _appDatabase.getUndecryptedMessages(
            conversationId,
            senderId,
          );
          undecryptedIds.addAll(undecrypted.map((m) => m.id));
        } catch (_) {}
      }
      if (undecryptedIds.isNotEmpty) {
        _decryptionService.resetFailures(undecryptedIds);
      }
    }

    // Always refresh the conversation preview from the latest local message.
    // This corrects stale previews that _syncConversationSnapshot may have
    // written from the Firestore offline cache (e.g., a non-null text from an
    // old unencrypted token gift). Since already-decrypted messages are skipped
    // above (and don't call _updateConversationPreview), without this refresh
    // the stale preview would persist indefinitely.
    final latestMessages = await _appDatabase.getLocalMessages(
      conversationId,
      limit: 1,
    );
    if (latestMessages.isNotEmpty) {
      final latestMsg = LocalMessageMapper.toEntity(latestMessages.first);
      await _updateConversationPreview(conversationId, latestMsg);
    }
  }

  /// Update conversation's last message preview in local DB.
  ///
  /// Serialized under [_convListLock] to prevent the Firestore conversation
  /// list sync from overwriting the decrypted preview with null (race
  /// condition: the list handler reads stale null, then overwrites the
  /// freshly-written decrypted text).
  Future<void> _updateConversationPreview(
    String conversationId,
    Message msg,
  ) async {
    await _convListLock.protect('_', () async {
      try {
        final existing =
            await _appDatabase.getLocalConversation(conversationId);
        if (existing == null) return;

        // Only update if this message is newer
        if (existing.lastMessageAt != null &&
            msg.createdAt.isBefore(existing.lastMessageAt!)) {
          return;
        }

        final conv = LocalConversationMapper.toEntity(existing);
        String? preview;
        if (msg.textContent != null && msg.textContent!.isNotEmpty) {
          preview = msg.textContent!.length > 100
              ? '${msg.textContent!.substring(0, 100)}...'
              : msg.textContent!;
        } else if (msg.hasMedia) {
          switch (msg.type) {
            case MessageType.voice:
              preview = '🎙 Voice message';
            case MessageType.document:
              preview = '📄 Document';
            case MessageType.video:
              preview = '🎬 Video message';
            case MessageType.image:
              preview = '📷 Photo';
            default:
              preview = '📎 Attachment';
          }
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
      }
    });
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
