import 'dart:async';
import 'dart:convert';

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

  /// Per-community processing lock for sequential message processing.
  final _processingLock = KeyedMutex();

  /// Serialises community-list callbacks (same pattern as MessageSyncService).
  final _listLock = KeyedMutex();

  /// Track community IDs we're currently syncing.
  final Set<String> _syncingCommunityIds = {};

  bool _isSyncing = false;

  /// Plaintext cache for sent messages (keyed by messageId).
  /// The sender cannot decrypt their own sender-key messages because the key
  /// is stored under _ownKeyPrefix, not _peerKeyPrefix.
  final Map<String, String> _sentPlaintextCache = {};
  final Map<String, DateTime> _cacheTimestamps = {}; // 6.7
  static const _maxCacheSize = 200; // 6.7 reduced from 500
  static const _maxCacheAge = Duration(minutes: 10); // 6.7

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  /// Start syncing all communities for the current user.
  void startSync() {
    if (_isSyncing) return;
    _isSyncing = true;

    debugPrint('CommunitySyncService: Starting sync');

    // 6.1 Listen for connectivity changes to restart sync
    _connectivitySub?.cancel();
    _connectivitySub = _networkInfo.onConnectivityChanged.listen((_) async {
      if (_isSyncing && await _networkInfo.isConnected) {
        debugPrint('CommunitySyncService: Network restored, restarting sync');
        _restartCommunityListSync();
      }
    });

    _startCommunityListSync();
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
              } catch (e) {
                debugPrint('CommunitySyncService: Failed to clean up closed '
                    'community ${model.id}: $e');
              }
              continue;
            }

            currentIds.add(model.id);

            try {
              var community = model.toEntity();

              // Preserve local lastMessageText when Firestore sends null (E2EE
              // messages have lastMessageText=null on the server).
              if (community.lastMessageText == null &&
                  community.lastMessageAt != null) {
                final existing =
                    await _appDatabase.getLocalCommunity(community.id);
                if (existing != null) {
                  final existingEntity =
                      LocalCommunityMapper.toEntity(existing);
                  if (existingEntity.lastMessageText != null) {
                    community = community.copyWith(
                      lastMessageText: existingEntity.lastMessageText,
                    );
                  }
                }
              }
              await _appDatabase.upsertLocalCommunity(
                LocalCommunityMapper.toCompanion(community),
              );

              // Reconcile memberCount from actual local member data.
              // The Firestore community doc may have a stale cached
              // memberCount, while the member sync has already written
              // the correct members. Use local member count if available.
              final localMembers = await _appDatabase
                  .getLocalCommunityMembers(community.id);
              if (localMembers.isNotEmpty) {
                await _appDatabase.updateLocalCommunityMemberCount(
                  communityId: community.id,
                  memberCount: localMembers.length,
                );
              }
            } catch (e) {
              debugPrint('CommunitySyncService: Failed to store community '
                  '${model.id}: $e');
            }
          }

          // Start syncing new communities
          for (final id in currentIds) {
            if (!_syncingCommunityIds.contains(id)) {
              _startMessageSync(id);
              _startMemberSync(id);
            }
          }

          // Stop syncing removed communities and clean local DB
          final removedIds = _syncingCommunityIds.difference(currentIds);
          for (final id in removedIds) {
            _stopMessageSync(id);
            _stopMemberSync(id);
            try {
              await _appDatabase.deleteLocalCommunity(id);
              await _appDatabase.deleteLocalCommunityMembersForCommunity(id);
              await _appDatabase.deleteLocalMessagesForConversation(id);
              debugPrint('CommunitySyncService: Cleaned local data for '
                  'removed community $id');
            } catch (e) {
              debugPrint('CommunitySyncService: Failed to clean local data '
                  'for $id: $e');
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
    if (!_isSyncing) return;
    _isSyncing = false;

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
    // 6.9 Dispose keyed mutexes
    _processingLock.clear();
    _listLock.clear();
    _sentPlaintextCache.clear();
    _cacheTimestamps.clear();
  }

  /// Cache a sent message's plaintext so we can display it immediately.
  /// 6.7 Time-based eviction + bounded cache size.
  void cacheSentPlaintext(String messageId, String plaintext) {
    final now = DateTime.now();
    // Evict entries older than _maxCacheAge
    _sentPlaintextCache.removeWhere((key, _) =>
        now.difference(_cacheTimestamps[key] ?? now) > _maxCacheAge);
    _cacheTimestamps.removeWhere((key, _) =>
        !_sentPlaintextCache.containsKey(key));

    if (_sentPlaintextCache.length >= _maxCacheSize) {
      // Evict oldest entry
      _sentPlaintextCache.remove(_sentPlaintextCache.keys.first);
      _cacheTimestamps.remove(_cacheTimestamps.keys.first);
    }
    _sentPlaintextCache[messageId] = plaintext;
    _cacheTimestamps[messageId] = now;
  }

  // =========================================================================
  // PER-COMMUNITY MESSAGE SYNC
  // =========================================================================

  void _startMessageSync(String communityId) {
    _syncingCommunityIds.add(communityId);

    _messageSubs[communityId] = _remoteDataSource
        .watchMessages(communityId: communityId, limit: 50)
        .listen(
      (messageModels) {
        // 6.6 Add timeout to prevent deadlock
        _processingLock.protect(
          communityId,
          () => _processIncomingMessages(communityId, messageModels)
              .timeout(const Duration(seconds: 30), onTimeout: () {
            debugPrint(
                'CommunitySyncService: Processing timeout for $communityId');
          }),
        ).catchError((Object e) {
          debugPrint(
              'CommunitySyncService: processing error for $communityId: $e');
        });
      },
      // 6.2 Subscription error cleanup with retry
      onError: (e) {
        debugPrint(
            'CommunitySyncService: Message sync error for $communityId: $e');
        _messageSubs.remove(communityId);
        _syncingCommunityIds.remove(communityId);
        Future.delayed(const Duration(seconds: 10), () {
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
    _memberSubs[communityId] =
        _remoteDataSource.watchMembers(communityId).listen(
      (memberModels) {
        // Member upserts run WITHOUT _processingLock — they write to a
        // different table (localCommunityMembers) than message processing
        // (localMessages) and must not be blocked by slow decryption.
        // Using an async IIFE so the listener callback stays non-blocking.
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
        }();
      },
      // 6.2 Subscription error cleanup with retry
      onError: (e) {
        debugPrint(
            'CommunitySyncService: Member stream error for $communityId: $e');
        _memberSubs.remove(communityId);
        Future.delayed(const Duration(seconds: 10), () {
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
    if (currentUserId == null) return;

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
          if (existing.isDecrypted) continue;
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
          } catch (_) {}
        }

        // Update community preview
        await _updateCommunityPreview(communityId, decryptedMsg);
      } catch (e) {
        debugPrint(
            'CommunitySyncService: Failed to process msg in $communityId: $e');
      }
    }
  }

  /// Apply decrypted plaintext to a message, parsing structured JSON payloads
  /// for media messages (e.g. `{"text":"caption","media":{...}}`).
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
      final cached = _sentPlaintextCache[msg.id];
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

    try {
      return await _senderKeyService.decryptCommunity(
        communityId,
        msg.senderId,
        encrypted,
      );
    } on StateError {
      // Sender key missing — try fetching pending key distributions
      debugPrint('CommunitySyncService: Sender key missing for '
          '${msg.senderId} in $communityId, fetching distributions...');
      await _processIncomingKeyDistributions(communityId);

      // Retry decryption
      try {
        return await _senderKeyService.decryptCommunity(
          communityId,
          msg.senderId,
          encrypted,
        );
      } catch (_) {
        debugPrint('CommunitySyncService: Still cannot decrypt msg '
            '${msg.id} after key fetch');
        return null;
      }
    } catch (e) {
      debugPrint('CommunitySyncService: Sender Key decrypt failed for '
          'msg ${msg.id}: $e');
      return null;
    }
  }

  // =========================================================================
  // KEY DISTRIBUTION PROCESSING
  // =========================================================================

  /// Fetch and process pending sender key distributions from other members.
  /// 6.8 Retries up to 3 times on failure.
  Future<void> _processIncomingKeyDistributions(String communityId) async {
    for (int attempt = 0; attempt < 3; attempt++) {
      try {
        final distributions =
            await _remoteDataSource.fetchPendingKeyDistributions(communityId);

        for (final dist in distributions) {
          final fromUserId = dist['fromUserId'] as String;
          final encryptedKeyData = dist['encryptedKeyData'] as String;
          final e2ee = dist['e2ee'] as Map<String, dynamic>?;
          final x3dhHeader = dist['x3dhHeader'] as Map<String, dynamic>?;
          final distributionId = dist['distributionId'] as String;

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

            // Parse and store the sender key
            final keyData = jsonDecode(decrypted) as Map<String, dynamic>;
            await _senderKeyService.processReceivedSenderKey(
              communityId,
              fromUserId,
              keyData,
            );

            // Mark as consumed on server
            await _remoteDataSource.markKeyDistributionConsumed(
              communityId,
              distributionId,
            );
          } catch (e) {
            debugPrint(
                'CommunitySyncService: Failed to process key distribution '
                'from $fromUserId: $e');
          }
        }
        return; // Success — exit retry loop
      } catch (e) {
        if (attempt < 2) {
          await Future.delayed(Duration(seconds: attempt * 2 + 1));
        } else {
          debugPrint('CommunitySyncService: Key distribution fetch failed '
              'after 3 attempts for $communityId: $e');
        }
      }
    }
  }

  // =========================================================================
  // HELPERS
  // =========================================================================

  /// Update community's last message preview in local DB.
  Future<void> _updateCommunityPreview(
    String communityId,
    Message msg,
  ) async {
    try {
      final existing = await _appDatabase.getLocalCommunity(communityId);
      if (existing == null) return;

      final existingEntity = LocalCommunityMapper.toEntity(existing);

      // Only update if this message is newer
      if (existingEntity.lastMessageAt != null &&
          msg.createdAt.isBefore(existingEntity.lastMessageAt!)) {
        return;
      }

      String? preview;
      if (msg.textContent != null) {
        preview = msg.textContent!.length > 100
            ? '${msg.textContent!.substring(0, 100)}...'
            : msg.textContent!;
      }

      final updated = existingEntity.copyWith(
        lastMessageText: preview,
        lastMessageSenderId: msg.senderId,
        lastMessageSenderName: msg.senderName,
        lastMessageType: msg.type.name,
        lastMessageAt: msg.createdAt,
      );

      await _appDatabase.upsertLocalCommunity(
        LocalCommunityMapper.toCompanion(updated),
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
