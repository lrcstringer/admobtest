import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../concurrency/keyed_mutex.dart';
import '../network/network_info.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/community_remote_datasource.dart';
import '../../data/mappers/local_community_mapper.dart';
import '../../data/mappers/local_community_member_mapper.dart';
import '../../data/mappers/local_message_mapper.dart';
import '../../domain/entities/message.dart';
import 'media_recovery_service.dart';
import 'sender_key_service.dart';
import 'signal_protocol_service.dart';

/// Background service that syncs Firestore communities → decrypts sender-key
/// messages once → stores in local DB. Mirrors [MessageSyncService] but for
/// community chats.
@lazySingleton
class CommunitySyncService {
  final CommunityRemoteDataSource _remoteDataSource;
  final SenderKeyService _senderKeyService;
  final SignalProtocolService _signalProtocolService;
  final AppDatabase _appDatabase;
  final MediaRecoveryService _mediaRecoveryService;
  final NetworkInfo _networkInfo; // 6.1

  CommunitySyncService(
    this._remoteDataSource,
    this._senderKeyService,
    this._signalProtocolService,
    this._appDatabase,
    this._mediaRecoveryService,
    this._networkInfo,
  );

  /// Community list stream subscription.
  StreamSubscription? _communityListSub;

  /// 6.1 Connectivity recovery subscription.
  StreamSubscription? _connectivitySub;

  /// Per-community message stream subscriptions.
  final Map<String, StreamSubscription> _messageSubs = {};

  /// Per-community member stream subscriptions.
  final Map<String, StreamSubscription> _memberSubs = {};

  /// Previous member IDs per community (for detecting departures → rekey).
  final Map<String, Set<String>> _previousMemberIds = {};

  /// Previous ACTIVE member IDs per community (for detecting new joins →
  /// clear sender key distribution flag so next send re-distributes).
  final Map<String, Set<String>> _previousActiveMemberIds = {};

  /// Per-community processing lock for sequential message processing.
  final _processingLock = KeyedMutex();

  /// Serialises community-list callbacks (same pattern as MessageSyncService).
  final _listLock = KeyedMutex();

  /// Track community IDs we're currently syncing.
  final Set<String> _syncingCommunityIds = {};

  /// M8: Track retry counts for exponential backoff on stream errors.
  final Map<String, int> _syncRetryCount = {};

  bool _isSyncing = false;

  /// First-sync flag: reconcile local DB with Firestore on first successful
  /// snapshot to clean up stale communities (e.g., deleted while app was
  /// closed). Only runs when the snapshot is non-empty (to avoid wiping
  /// everything on a permission-denied / empty-query edge case).
  bool _isFirstSync = true;

  /// Communities force-started by [ensureSyncing] before the community list
  /// stream emitted. These are protected from first-sync reconciliation
  /// because they were explicitly requested by the UI/BLoC.
  final Set<String> _ensureSyncedIds = {};

  /// Plaintext cache for sent messages (keyed by messageId).
  /// The sender cannot decrypt their own sender-key messages because the key
  /// is stored under _ownKeyPrefix, not _peerKeyPrefix.
  /// HIGH-4: Uses a single insertion-ordered map for deterministic eviction.
  final _sentPlaintextCache = <String, ({String plaintext, DateTime timestamp})>{};
  static const _maxCacheSize = 200;
  static const _maxCacheAge = Duration(minutes: 10);

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  /// Whether community list sync is active (may be before E2EE).
  bool _communityListSyncing = false;

  /// Community IDs known from list sync (populated before E2EE is ready).
  final Set<String> _latestCommunityIds = {};

  /// Start community list sync early (before E2EE keys are ready).
  ///
  /// Mirrors [MessageSyncService.startConversationListSync]: populates
  /// community metadata in the local DB so the Communities tab shows data
  /// immediately. Message-level sync (which needs E2EE) starts only when
  /// [startSync] is called later.
  void startCommunityListSync() {
    if (_communityListSyncing) return;
    _communityListSyncing = true;

    debugPrint('CommunitySyncService: Starting community list sync (pre-E2EE)');
    _startCommunityListSync();
  }

  /// Start full syncing (message decryption + storage).
  ///
  /// Requires E2EE keys to be ready. If [startCommunityListSync] was already
  /// called, message-level sync is kicked off for all known communities.
  /// Otherwise, starts the community list sync too.
  void startSync() {
    if (_isSyncing) return;
    _isSyncing = true;

    debugPrint('CommunitySyncService: Starting full sync (E2EE ready)');

    // 6.1 Listen for connectivity changes to restart sync
    _connectivitySub?.cancel();
    _connectivitySub = _networkInfo.onConnectivityChanged.listen((_) async {
      if (_isSyncing && await _networkInfo.isConnected) {
        debugPrint('CommunitySyncService: Network restored, restarting sync');
        _restartCommunityListSync();
      }
    });

    // If community list sync was already started (pre-E2EE), kick off
    // message-level sync for all known communities.
    if (_communityListSyncing) {
      for (final id in _latestCommunityIds) {
        if (!_syncingCommunityIds.contains(id)) {
          _startMessageSync(id);
          _startMemberSync(id);
        }
      }
    } else {
      _startCommunityListSync();
    }
  }

  void _startCommunityListSync() {
    _communityListSub?.cancel();
    _communityListSub = _remoteDataSource.watchUserCommunities().listen(
      (communityModels) {
        _listLock.protect('_', () async {
          final currentIds = <String>{};

          for (final model in communityModels) {
            // 6.3 Soft-delete filter: skip closed communities
            if (model.status == 'closed') {
              try {
                await _appDatabase.deleteLocalCommunity(model.id);
                await _appDatabase
                    .deleteLocalCommunityMembersForCommunity(model.id);
                await _appDatabase
                    .deleteLocalMessagesForConversation(model.id);
                await _senderKeyService.resetAllKeysForCommunity(model.id);
              } catch (e) {
                debugPrint('CommunitySyncService: Failed to clean up closed '
                    'community ${model.id}: $e');
              }
              continue;
            }

            currentIds.add(model.id);

            try {
              var community = model.toEntity();

              // M7: Preserve locally-decrypted preview fields when Firestore
              // sends null/stale values (E2EE messages have lastMessageText=null
              // on the server). Also preserve when local preview is newer.
              // Also preserve local memberCount when local member data is
              // more accurate than the Firestore doc's cached count.
              final existing =
                  await _appDatabase.getLocalCommunity(community.id);
              if (existing != null) {
                final existingEntity =
                    LocalCommunityMapper.toEntity(existing);
                final localHasPreview = existingEntity.lastMessageText != null;
                final remoteHasNoPreview = community.lastMessageText == null;
                final localIsNewer = existingEntity.lastMessageAt != null &&
                    community.lastMessageAt != null &&
                    existingEntity.lastMessageAt!
                        .isAfter(community.lastMessageAt!);

                if (localHasPreview && (remoteHasNoPreview || localIsNewer)) {
                  community = community.copyWith(
                    lastMessageText: existingEntity.lastMessageText,
                    lastMessageSenderId:
                        existingEntity.lastMessageSenderId ??
                            community.lastMessageSenderId,
                    lastMessageSenderName:
                        existingEntity.lastMessageSenderName ??
                            community.lastMessageSenderName,
                    lastMessageAt:
                        localIsNewer
                            ? existingEntity.lastMessageAt
                            : community.lastMessageAt,
                    lastMessageType:
                        existingEntity.lastMessageType ??
                            community.lastMessageType,
                  );
                }

                // Preserve local memberCount when member sync has already
                // written the correct member data. The Firestore community
                // doc's memberCount only counts active members and can be
                // stale, while local member sync keeps an accurate count
                // of ALL members (active + invited).
                final localMembers = await _appDatabase
                    .getLocalCommunityMembers(community.id);
                if (localMembers.isNotEmpty &&
                    localMembers.length > community.memberCount) {
                  community = community.copyWith(
                    memberCount: localMembers.length,
                  );
                }
              }
              await _appDatabase.upsertLocalCommunity(
                LocalCommunityMapper.toCompanion(community),
              );
            } catch (e) {
              debugPrint('CommunitySyncService: Failed to store community '
                  '${model.id}: $e');
            }
          }

          // Track known community IDs for deferred message sync
          _latestCommunityIds
            ..clear()
            ..addAll(currentIds);

          debugPrint('CommunitySyncService: Community list stream emitted '
              '${communityModels.length} communities '
              '(${currentIds.length} active, isSyncing=$_isSyncing)');

          // Start message-level sync only if full sync is active (E2EE ready)
          if (_isSyncing) {
            for (final id in currentIds) {
              if (!_syncingCommunityIds.contains(id)) {
                _startMessageSync(id);
                _startMemberSync(id);
              }
            }
          }

          // Stop syncing removed communities and clean local DB.
          // Safety: only clean up if Firestore returned at least 1 community.
          // An empty emission likely means a query/permission error, not that
          // the user has zero communities — deleting everything would be
          // destructive and wrong.
          if (currentIds.isNotEmpty) {
            final removedIds = _syncingCommunityIds.difference(currentIds);
            for (final id in removedIds) {
              _stopMessageSync(id);
              _stopMemberSync(id);
              try {
                await _appDatabase.deleteLocalCommunity(id);
                await _appDatabase
                    .deleteLocalCommunityMembersForCommunity(id);
                await _appDatabase
                    .deleteLocalMessagesForConversation(id);
                await _senderKeyService.resetAllKeysForCommunity(id);
                debugPrint('CommunitySyncService: Cleaned local data for '
                    'removed community $id');
              } catch (e) {
                debugPrint('CommunitySyncService: Failed to clean local data '
                    'for $id: $e');
              }
            }

            // First-sync reconciliation: clean up communities in local DB
            // that no longer exist in Firestore (e.g., deleted while app
            // was closed). Guarded by:
            //  1. currentIds.isNotEmpty — don't wipe on empty/failed query
            //  2. Skip _ensureSyncedIds — those were explicitly requested
            //     by the UI before the list stream emitted
            if (_isFirstSync) {
              _isFirstSync = false;
              try {
                final localCommunities =
                    await _appDatabase.getLocalCommunities();
                final localIds =
                    localCommunities.map((c) => c.id).toSet();
                final staleIds = localIds
                    .difference(currentIds)
                    .difference(_ensureSyncedIds);
                for (final id in staleIds) {
                  _stopMessageSync(id);
                  _stopMemberSync(id);
                  await _appDatabase.deleteLocalCommunity(id);
                  await _appDatabase
                      .deleteLocalCommunityMembersForCommunity(id);
                  await _appDatabase
                      .deleteLocalMessagesForConversation(id);
                  await _senderKeyService.resetAllKeysForCommunity(id);
                  debugPrint('CommunitySyncService: Reconciled stale '
                      'community $id from local DB');
                }
              } catch (e) {
                debugPrint('CommunitySyncService: First-sync reconciliation '
                    'error: $e');
              }
            }
          }
        }).catchError((Object e) {
          debugPrint('CommunitySyncService: Community list error: $e');
        });
      },
      onError: (e) {
        debugPrint('CommunitySyncService: Community list stream error: $e');
      },
    );
  }

  /// 6.1 Restart community list sync (e.g. after connectivity recovery).
  void _restartCommunityListSync() {
    _communityListSub?.cancel();
    _startCommunityListSync();
  }

  /// Stop all syncing (on sign-out or app background).
  void stopSync() {
    if (!_isSyncing && !_communityListSyncing) return;
    _isSyncing = false;
    _communityListSyncing = false;

    debugPrint('CommunitySyncService: Stopping sync');

    // 6.9 Cancel connectivity subscription
    _connectivitySub?.cancel();
    _connectivitySub = null;

    _communityListSub?.cancel();
    _communityListSub = null;

    for (final sub in _messageSubs.values) {
      sub.cancel();
    }
    _messageSubs.clear();

    for (final sub in _memberSubs.values) {
      sub.cancel();
    }
    _memberSubs.clear();

    _syncingCommunityIds.clear();
    _latestCommunityIds.clear();
    _syncRetryCount.clear();
    // HIGH-6: Clear stale member IDs to prevent spurious rekeys on restart
    _previousMemberIds.clear();
    _previousActiveMemberIds.clear();
    // Clear protected IDs so first-sync reconciliation on next sign-in
    // can properly clean up deleted communities from local DB.
    _ensureSyncedIds.clear();
    // Reset first-sync flag so reconciliation runs on next sign-in.
    _isFirstSync = true;
    // 6.9 Dispose keyed mutexes
    _processingLock.clear();
    _listLock.clear();
    _sentPlaintextCache.clear();
  }

  /// Cache a sent message's plaintext so we can display it immediately.
  /// HIGH-4: Single insertion-ordered map for deterministic FIFO eviction.
  void cacheSentPlaintext(String messageId, String plaintext) {
    final now = DateTime.now();
    // Evict entries older than _maxCacheAge
    _sentPlaintextCache.removeWhere((_, v) =>
        now.difference(v.timestamp) > _maxCacheAge);

    if (_sentPlaintextCache.length >= _maxCacheSize) {
      // Evict oldest entry (insertion order — first key is oldest)
      _sentPlaintextCache.remove(_sentPlaintextCache.keys.first);
    }
    _sentPlaintextCache[messageId] = (plaintext: plaintext, timestamp: now);
  }

  /// Stop syncing a specific community and remove it from all tracking sets.
  ///
  /// Called when a community is deleted — ensures the sync service won't
  /// re-add it to the local DB or protect it from reconciliation.
  void stopSyncingCommunity(String communityId) {
    _stopMessageSync(communityId);
    _stopMemberSync(communityId);
    _ensureSyncedIds.remove(communityId);
    _latestCommunityIds.remove(communityId);
    _syncRetryCount.remove(communityId);
    _syncRetryCount.remove('member_$communityId');
    _previousMemberIds.remove(communityId);
    _previousActiveMemberIds.remove(communityId);
    debugPrint('CommunitySyncService: Stopped syncing deleted community '
        '$communityId');
  }

  /// Ensure message sync is running for a specific community.
  ///
  /// Called by BLoC/repository as a fallback when the local DB stream
  /// returns empty. If the community isn't being synced yet (e.g. because
  /// the community list stream never emitted or errored), this starts
  /// message sync immediately.
  void ensureSyncing(String communityId) {
    if (!_isSyncing) {
      debugPrint('CommunitySyncService.ensureSyncing: Full sync not started '
          'yet for $communityId — skipping (E2EE not ready)');
      return;
    }
    if (_syncingCommunityIds.contains(communityId)) {
      debugPrint('CommunitySyncService.ensureSyncing: Already syncing '
          '$communityId');
      return;
    }
    debugPrint('CommunitySyncService.ensureSyncing: Force-starting message '
        'sync for $communityId (was not syncing!)');
    _ensureSyncedIds.add(communityId);
    _startMessageSync(communityId);
    _startMemberSync(communityId);
  }

  // =========================================================================
  // PER-COMMUNITY MESSAGE SYNC
  // =========================================================================

  void _startMessageSync(String communityId) {
    // CRIT-2: Cancel any existing subscription before creating a new one.
    // Prevents duplicate subscriptions from retry timer + community list race.
    _messageSubs[communityId]?.cancel();
    _syncingCommunityIds.add(communityId);

    debugPrint('CommunitySyncService: Starting message listener for '
        '$communityId (now syncing ${_syncingCommunityIds.length} communities)');

    _messageSubs[communityId] = _remoteDataSource
        .watchMessages(communityId: communityId, limit: 50)
        .listen(
      (messageModels) {
        debugPrint('CommunitySyncService: Firestore emitted '
            '${messageModels.length} messages for $communityId');
        // M8: Reset retry count on successful stream data
        _syncRetryCount.remove(communityId);
        // CRIT-3: No timeout — interrupting mid-ratchet decryption corrupts
        // chain state permanently. The KeyedMutex FIFO design prevents deadlock.
        _processingLock.protect(
          communityId,
          () => _processIncomingMessages(communityId, messageModels),
        ).catchError((Object e) {
          debugPrint(
              'CommunitySyncService: processing error for $communityId: $e');
        });
      },
      // 6.2 Subscription error cleanup with retry
      // M8: Exponential backoff instead of fixed 10s delay
      onError: (e) {
        debugPrint(
            'CommunitySyncService: Message sync error for $communityId: $e');
        _messageSubs.remove(communityId);
        _syncingCommunityIds.remove(communityId);
        final retryCount = (_syncRetryCount[communityId] ?? 0) + 1;
        _syncRetryCount[communityId] = retryCount;
        if (retryCount > 5) {
          debugPrint('CommunitySyncService: Max retries reached for '
              '$communityId message sync — will retry on next connectivity');
          return;
        }
        // 10s, 20s, 40s, 60s, 60s
        final delaySec = math.min(60, 10 * (1 << (retryCount - 1)));
        Future.delayed(Duration(seconds: delaySec), () {
          if (_isSyncing && !_syncingCommunityIds.contains(communityId)) {
            _startMessageSync(communityId);
          }
        });
      },
    );
  }

  void _stopMessageSync(String communityId) {
    _messageSubs[communityId]?.cancel();
    _messageSubs.remove(communityId);
    _syncingCommunityIds.remove(communityId);
  }

  // =========================================================================
  // PER-COMMUNITY MEMBER SYNC
  // =========================================================================

  void _startMemberSync(String communityId) {
    _memberSubs[communityId]?.cancel();
    _memberSubs[communityId] =
        _remoteDataSource.watchMembers(communityId).listen(
      (memberModels) {
        // M9: Reset member sync retry count on successful stream data
        _syncRetryCount.remove('member_$communityId');
        // HIGH-5: Serialize member sync callbacks with _processingLock to
        // prevent concurrent rekeys from rapid Firestore emissions. The rekey
        // operation mutates sender key state, so it must be serialized with
        // message decryption to avoid chain corruption.
        _processingLock.protect(
          'member_$communityId',
          () async {
            try {
              final currentIds = <String>{};
              for (final model in memberModels) {
                final entity = model.toEntity();
                currentIds.add(entity.userId);
                await _appDatabase.upsertLocalCommunityMember(
                  LocalCommunityMemberMapper.toCompanion(entity),
                );
              }

              // Update memberCount in local community to stay in sync
              await _appDatabase.updateLocalCommunityMemberCount(
                communityId: communityId,
                memberCount: currentIds.length,
              );

              // Track active members to detect new joins → clear
              // distribution flag so next send re-distributes the key.
              final activeIds = <String>{};
              for (final model in memberModels) {
                if (model.status == 'active') {
                  activeIds.add(model.userId);
                }
              }
              final previousActiveIds =
                  _previousActiveMemberIds[communityId];
              if (previousActiveIds != null &&
                  previousActiveIds.isNotEmpty) {
                final newActive =
                    activeIds.difference(previousActiveIds);
                if (newActive.isNotEmpty) {
                  debugPrint(
                      'CommunitySyncService: ${newActive.length} new '
                      'active member(s) in $communityId — clearing '
                      'distribution flag');
                  try {
                    await _senderKeyService
                        .clearDistributed(communityId);
                  } catch (e) {
                    debugPrint('CommunitySyncService: clearDistributed '
                        'failed for $communityId: $e');
                  }
                }
              }
              _previousActiveMemberIds[communityId] = activeIds;

              // Detect member departures → rekey sender key for forward secrecy
              final previousIds = _previousMemberIds[communityId];
              if (previousIds != null && previousIds.isNotEmpty) {
                final removed = previousIds.difference(currentIds);
                if (removed.isNotEmpty) {
                  debugPrint(
                      'CommunitySyncService: ${removed.length} member(s) '
                      'left $communityId — rekeying sender key');
                  try {
                    await _senderKeyService.rekeyAllSenderKeys(communityId);
                  } catch (e) {
                    debugPrint('CommunitySyncService: Rekey failed for '
                        '$communityId: $e');
                  }
                }
              }
              _previousMemberIds[communityId] = currentIds;
            } catch (e) {
              debugPrint(
                  'CommunitySyncService: Member sync error for $communityId: $e');
            }
          },
        ).catchError((Object e) {
          debugPrint(
              'CommunitySyncService: Member lock error for $communityId: $e');
        });
      },
      // 6.2 + M8: Subscription error cleanup with exponential backoff
      onError: (e) {
        debugPrint(
            'CommunitySyncService: Member stream error for $communityId: $e');
        _memberSubs.remove(communityId);
        final key = 'member_$communityId';
        final retryCount = (_syncRetryCount[key] ?? 0) + 1;
        _syncRetryCount[key] = retryCount;
        if (retryCount > 5) {
          debugPrint('CommunitySyncService: Max retries for member sync '
              '$communityId — will retry on next connectivity');
          return;
        }
        final delaySec = math.min(60, 10 * (1 << (retryCount - 1)));
        Future.delayed(Duration(seconds: delaySec), () {
          if (_isSyncing) {
            _startMemberSync(communityId);
          }
        });
      },
    );
  }

  void _stopMemberSync(String communityId) {
    _memberSubs[communityId]?.cancel();
    _memberSubs.remove(communityId);
  }

  // =========================================================================
  // INCOMING MESSAGE PROCESSING
  // =========================================================================

  /// Process incoming messages from Firestore: decrypt new ones, store locally.
  ///
  /// Messages arrive newest-first from the Firestore query. For each message:
  /// 1. If already stored + decrypted → update mutable fields only
  /// 2. If encrypted → decrypt via SenderKeyService → store plaintext
  /// 3. On decrypt failure → try fetching pending key distributions, retry once
  /// 4. Update community preview with latest message
  Future<void> _processIncomingMessages(
    String communityId,
    List<dynamic> messageModels,
  ) async {
    final currentUserId = _remoteDataSource.currentUserId;
    if (currentUserId == null) {
      debugPrint('CommunitySyncService: currentUserId is NULL — '
          'skipping ${messageModels.length} messages for $communityId');
      return;
    }

    var storedCount = 0;
    var skippedCount = 0;
    var errorCount = 0;
    for (final model in messageModels) {
      try {
        final msg = model.toEntity() as Message;

        // Check if already stored and decrypted
        final existing = await _appDatabase.getLocalMessageById(msg.id);

        // 6.5 Update mutable fields for ALL messages (including own)
        // BEFORE the decryption skip — reactions, deletedFor, etc. change
        if (existing != null) {
          final deletedForChanged =
              existing.deletedForJson != jsonEncode(msg.deletedFor);
          final deletedForEveryoneChanged =
              existing.deletedForEveryone != msg.deletedForEveryone;
          final needsUpdate = existing.status != msg.status.name ||
              existing.reactionsJson != _encodeReactions(msg.reactions) ||
              deletedForChanged ||
              deletedForEveryoneChanged;

          if (needsUpdate) {
            final localEntity = LocalMessageMapper.toEntity(existing);
            final updated = localEntity.copyWith(
              status: msg.status,
              reactions: msg.reactions,
              deletedFor: msg.deletedFor,
              deletedForEveryone: msg.deletedForEveryone,
              readBy: msg.readBy,
            );
            await _appDatabase.upsertLocalMessage(
              LocalMessageMapper.toCompanion(updated, communityId),
            );
          }

          // If already decrypted, skip decryption
          if (existing.isDecrypted) {
            skippedCount++;
            continue;
          }
        }

        // Decrypt if needed
        var decryptedMsg = msg;
        var isDecrypted = true;

        if (msg.isEncrypted) {
          final plaintext = await _decryptCommunityMessage(
            communityId,
            msg,
            currentUserId,
          );
          if (plaintext != null) {
            decryptedMsg = _applyDecryptedPayload(msg, plaintext);
            // Store in vault for recovery after reinstall
            _mediaRecoveryService
                .storePayload(msg.id, plaintext)
                .catchError((e) {
              debugPrint(
                  'CommunitySync: vault store failed for ${msg.id}: $e');
            });
          } else {
            // Sender's own: try vault recovery before falling back to placeholder
            if (msg.senderId == currentUserId) {
              await _mediaRecoveryService.initialize();
              if (_mediaRecoveryService.isReady) {
                final recovered =
                    await _mediaRecoveryService.recoverPayload(msg.id);
                if (recovered != null) {
                  debugPrint(
                      'CommunitySyncService: Vault recovery SUCCESS for '
                      '${msg.id}');
                  decryptedMsg = _applyDecryptedPayload(msg, recovered);
                  await _appDatabase.upsertLocalMessage(
                    LocalMessageMapper.toCompanion(
                      decryptedMsg.copyWith(communityId: communityId),
                      communityId,
                      isDecrypted: true,
                    ),
                  );
                  await _appDatabase.cacheDecryptedPlaintext(
                      msg.id, recovered);
                  await _updateCommunityPreview(communityId, decryptedMsg);
                  continue;
                }
              }
              debugPrint(
                  'CommunitySyncService: Sender own-message cache miss '
                  '${msg.id} — storing fallback');
              decryptedMsg = msg.copyWith(textContent: '[Sent by you]');
              await _appDatabase.upsertLocalMessage(
                LocalMessageMapper.toCompanion(
                  decryptedMsg.copyWith(communityId: communityId),
                  communityId,
                  isDecrypted: true,
                ),
              );
              continue;
            }
            // Try vault recovery (may have been decrypted before reinstall)
            if (_mediaRecoveryService.isReady) {
              final recovered =
                  await _mediaRecoveryService.recoverPayload(msg.id);
              if (recovered != null) {
                debugPrint(
                    'CommunitySyncService: Vault recovery SUCCESS for '
                    'received msg ${msg.id}');
                decryptedMsg = _applyDecryptedPayload(msg, recovered);
                await _appDatabase.upsertLocalMessage(
                  LocalMessageMapper.toCompanion(
                    decryptedMsg.copyWith(communityId: communityId),
                    communityId,
                    isDecrypted: true,
                  ),
                );
                await _appDatabase.cacheDecryptedPlaintext(
                    msg.id, recovered);
                await _updateCommunityPreview(communityId, decryptedMsg);
                continue;
              }
            }
            isDecrypted = false;
            decryptedMsg = msg.copyWith(
                textContent: '[Cannot decrypt community message]');
          }
        }

        // Store in local DB with communityId set
        storedCount++;
        await _appDatabase.upsertLocalMessage(
          LocalMessageMapper.toCompanion(
            decryptedMsg.copyWith(communityId: communityId),
            communityId,
            isDecrypted: isDecrypted,
          ),
        );

        // Cache in DecryptedMessageCache for consistency
        if (isDecrypted && decryptedMsg.textContent != null) {
          try {
            await _appDatabase.cacheDecryptedPlaintext(
              msg.id,
              decryptedMsg.textContent!,
            );
          } catch (e) {
            // H4: Log instead of silently swallowing
            debugPrint('CommunitySyncService: Failed to cache plaintext '
                'for ${msg.id}: $e');
          }
        }

        // Update community preview
        await _updateCommunityPreview(communityId, decryptedMsg);
      } catch (e) {
        errorCount++;
        // H4: Include message ID for debuggability
        debugPrint(
            'CommunitySyncService: Failed to process msg ${(model as dynamic).id ?? 'unknown'} '
            'in $communityId: $e');
      }
    }
    debugPrint('CommunitySyncService: Processed ${messageModels.length} msgs '
        'for $communityId — stored=$storedCount, skipped=$skippedCount, '
        'errors=$errorCount');
  }

  /// Apply decrypted plaintext to a message, parsing structured JSON payloads
  /// for media messages (e.g. `{"text":"caption","media":{...}}`).
  ///
  /// M13: Only parses JSON when the payload contains known structural keys
  /// (`media`, `groupGift`). Plain text that happens to start with `{` (e.g.
  /// user typing JSON) is NOT misinterpreted as a structured payload.
  Message _applyDecryptedPayload(Message msg, String plaintext) {
    if (plaintext.startsWith('{') && plaintext.endsWith('}')) {
      try {
        final payload = jsonDecode(plaintext) as Map<String, dynamic>;
        // Only treat as structured payload if it has known media/gift keys
        if (payload.containsKey('media')) {
          final mediaJson = payload['media'] as Map<String, dynamic>;
          return msg.copyWith(
            textContent: payload['text'] as String?,
            media: MessageMedia.fromJson(mediaJson),
          );
        }
        if (payload.containsKey('groupGift')) {
          // Group gift message — store full payload as text for now
          return msg.copyWith(
            textContent: payload['text'] as String? ?? plaintext,
          );
        }
        // Has JSON structure but no known keys — treat as plain text
        // (user may have typed valid JSON as a message)
      } catch (_) {
        // Not valid JSON — treat as plain text
      }
    }
    return msg.copyWith(textContent: plaintext);
  }

  /// Decrypt a community message using SenderKeyService.
  ///
  /// For own sent messages: uses the in-memory plaintext cache.
  /// For received messages: decrypts via sender key, retrying after
  /// key distribution fetch if the sender key is missing.
  Future<String?> _decryptCommunityMessage(
    String communityId,
    Message msg,
    String currentUserId,
  ) async {
    // Own sent messages: use plaintext cache
    if (msg.senderId == currentUserId) {
      final cached = _sentPlaintextCache[msg.id]?.plaintext;
      if (cached != null) return cached;
      // Check persistent cache
      final dbCached = await _appDatabase.getDecryptedPlaintext(msg.id);
      if (dbCached != null) return dbCached;
      // Sent in a previous session — plaintext not available
      return null;
    }

    // Build encrypted map for SenderKeyService
    final encrypted = {
      'ciphertext': msg.ciphertext,
      if (msg.e2ee != null)
        'e2ee': {
          'protocol': msg.e2ee!.protocol,
          if (msg.e2ee!.senderKeyChainId != null)
            'senderKeyChainId': msg.e2ee!.senderKeyChainId,
          if (msg.e2ee!.messageNumber != null)
            'messageNumber': msg.e2ee!.messageNumber,
          if (msg.e2ee!.signature != null) 'signature': msg.e2ee!.signature,
        },
    };

    // DIAG-1: Log what we're trying to decrypt
    debugPrint('CommunitySyncService DIAG: Decrypting msg ${msg.id} from '
        '${msg.senderId} in $communityId — '
        'hasCiphertext=${msg.ciphertext != null}, '
        'hasE2ee=${msg.e2ee != null}, '
        'e2eeMsgNum=${msg.e2ee?.messageNumber}, '
        'e2eeChainId=${msg.e2ee?.senderKeyChainId}, '
        'hasSig=${msg.e2ee?.signature != null}');

    try {
      final result = await _senderKeyService.decryptCommunity(
        communityId,
        msg.senderId,
        encrypted,
      );
      debugPrint('CommunitySyncService DIAG: Direct decrypt SUCCESS for '
          'msg ${msg.id}');
      return result;
    } on StateError catch (e) {
      // DIAG-2: Log the specific StateError reason
      debugPrint('CommunitySyncService DIAG: StateError for msg ${msg.id}: $e');
      // C2: Wrap in try-catch so a network error during key fetch
      // doesn't kill the entire message batch
      List<({String communityId, String distributionId})> installed;
      try {
        installed = await _processIncomingKeyDistributions(communityId);
        // DIAG-3: Log what distributions we got
        debugPrint('CommunitySyncService DIAG: Fetched ${installed.length} '
            'distributions for $communityId');
      } catch (e) {
        debugPrint('CommunitySyncService DIAG: Key distribution fetch FAILED '
            'for $communityId: $e — msg ${msg.id} undecryptable until '
            'next sync');
        return null;
      }

      // Retry decryption
      try {
        final result = await _senderKeyService.decryptCommunity(
          communityId,
          msg.senderId,
          encrypted,
        );
        // CRIT-4: Only mark distributions consumed AFTER successful decrypt
        if (installed.isNotEmpty) {
          await _markDistributionsConsumed(installed);
        }
        debugPrint('CommunitySyncService DIAG: Retry decrypt SUCCESS for '
            'msg ${msg.id} after installing ${installed.length} keys');
        return result;
      } catch (retryErr) {
        debugPrint('CommunitySyncService DIAG: Retry decrypt FAILED for '
            'msg ${msg.id}: $retryErr — distributions NOT consumed');
        return null;
      }
    } catch (e) {
      // DIAG-4: Log non-StateError exceptions (unexpected path)
      debugPrint('CommunitySyncService DIAG: NON-StateError decrypt failure '
          'for msg ${msg.id}: ${e.runtimeType}: $e');
      return null;
    }
  }

  // =========================================================================
  // KEY DISTRIBUTION PROCESSING
  // =========================================================================

  /// Fetch and process pending sender key distributions from other members.
  /// CRIT-4: Returns list of (communityId, distributionId) pairs that were
  /// successfully installed. Caller must mark them consumed AFTER confirming
  /// decryption works (to prevent consuming keys that can't be used).
  /// 6.8 Retries up to 3 times on failure.
  Future<List<({String communityId, String distributionId})>>
      _processIncomingKeyDistributions(String communityId) async {
    final installed = <({String communityId, String distributionId})>[];
    for (int attempt = 0; attempt < 3; attempt++) {
      try {
        final distributions =
            await _remoteDataSource.fetchPendingKeyDistributions(communityId);

        // DIAG-5: Log distribution count
        debugPrint('CommunitySyncService DIAG: Found ${distributions.length} '
            'pending distributions for $communityId');

        for (final dist in distributions) {
          final fromUserId = dist['fromUserId'] as String;
          final encryptedKeyData = dist['encryptedKeyData'] as String;
          final e2ee = dist['e2ee'] as Map<String, dynamic>?;
          final x3dhHeader = dist['x3dhHeader'] as Map<String, dynamic>?;
          final distributionId = dist['distributionId'] as String;

          // DIAG-6: Log each distribution's details
          debugPrint('CommunitySyncService DIAG: Processing distribution '
              '$distributionId from $fromUserId — '
              'hasE2ee=${e2ee != null}, hasX3dh=${x3dhHeader != null}');

          try {
            // Decrypt the sender key via P2P Signal Protocol channel
            final decrypted = await _signalProtocolService.decryptP2P(
              fromUserId,
              {
                'ciphertext': encryptedKeyData,
                if (e2ee != null) 'e2ee': e2ee,
                if (x3dhHeader != null) 'x3dhHeader': x3dhHeader,
              },
            );

            // DIAG-7: Log successful P2P decrypt
            debugPrint('CommunitySyncService DIAG: P2P decrypt SUCCESS for '
                'distribution from $fromUserId');

            // Parse and store the sender key
            final keyData = jsonDecode(decrypted) as Map<String, dynamic>;
            await _senderKeyService.processReceivedSenderKey(
              communityId,
              fromUserId,
              keyData,
            );

            debugPrint('CommunitySyncService DIAG: Stored sender key from '
                '$fromUserId — chainId=${keyData['chainId']}, '
                'msgNum=${keyData['messageNumber']}');

            // CRIT-4: Don't mark consumed here — defer until after
            // successful decryption to prevent consuming keys we can't use.
            installed.add((communityId: communityId, distributionId: distributionId));
          } catch (e) {
            // DIAG-8: Log the specific failure with type
            debugPrint(
                'CommunitySyncService DIAG: FAILED to process distribution '
                'from $fromUserId: ${e.runtimeType}: $e');
          }
        }
        return installed;
      } catch (e) {
        if (attempt < 2) {
          await Future.delayed(Duration(seconds: attempt * 2 + 1));
        } else {
          debugPrint('CommunitySyncService: Key distribution fetch failed '
              'after 3 attempts for $communityId: $e');
        }
      }
    }
    return installed;
  }

  /// CRIT-4: Mark key distributions as consumed on the server after confirming
  /// decryption worked.
  Future<void> _markDistributionsConsumed(
    List<({String communityId, String distributionId})> distributions,
  ) async {
    for (final d in distributions) {
      try {
        await _remoteDataSource.markKeyDistributionConsumed(
          d.communityId,
          d.distributionId,
        );
      } catch (e) {
        debugPrint('CommunitySyncService: Failed to mark distribution '
            '${d.distributionId} as consumed: $e');
      }
    }
  }

  // =========================================================================
  // HELPERS
  // =========================================================================

  /// Update community's last message preview in local DB.
  ///
  /// Uses atomic partial update (only preview fields) to avoid overwriting
  /// memberCount or other fields that are managed by community list sync
  /// or member sync — prevents read-modify-write race conditions.
  Future<void> _updateCommunityPreview(
    String communityId,
    Message msg,
  ) async {
    try {
      // Only update if this message is newer than what's stored
      final existing = await _appDatabase.getLocalCommunity(communityId);
      if (existing == null) return;
      if (existing.lastMessageAt != null &&
          msg.createdAt.isBefore(existing.lastMessageAt!)) {
        return;
      }

      String preview = '';
      if (msg.textContent != null) {
        preview = msg.textContent!.length > 100
            ? '${msg.textContent!.substring(0, 100)}...'
            : msg.textContent!;
      }

      await _appDatabase.updateLocalCommunityPreview(
        communityId: communityId,
        lastMessageText: preview,
        lastMessageSenderId: msg.senderId,
        lastMessageSenderName: msg.senderName,
        lastMessageAt: msg.createdAt,
        lastMessageType: msg.type.name,
      );
    } catch (e) {
      debugPrint(
          'CommunitySyncService: Failed to update preview for $communityId: $e');
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
}
