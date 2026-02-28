import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../concurrency/keyed_mutex.dart';
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

  CommunitySyncService(
    this._remoteDataSource,
    this._senderKeyService,
    this._signalProtocolService,
    this._appDatabase,
    this._mediaRecoveryService,
  );

  /// Community list stream subscription.
  StreamSubscription? _communityListSub;

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
  static const _maxCacheSize = 500;

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  /// Start syncing all communities for the current user.
  void startSync() {
    if (_isSyncing) return;
    _isSyncing = true;

    debugPrint('CommunitySyncService: Starting sync');

    _communityListSub = _remoteDataSource.watchUserCommunities().listen(
      (communityModels) {
        _listLock.protect('_', () async {
          final communities =
              communityModels.map((m) => m.toEntity()).toList();
          final currentIds = communities.map((c) => c.id).toSet();

          // Store/update community metadata locally.
          // Preserve local lastMessageText when Firestore sends null (E2EE
          // messages have lastMessageText=null on the server).
          for (final community in communities) {
            try {
              var toStore = community;
              if (community.lastMessageText == null &&
                  community.lastMessageAt != null) {
                final existing =
                    await _appDatabase.getLocalCommunity(community.id);
                if (existing != null) {
                  final existingEntity = LocalCommunityMapper.toEntity(existing);
                  if (existingEntity.lastMessageText != null) {
                    toStore = community.copyWith(
                      lastMessageText: existingEntity.lastMessageText,
                    );
                  }
                }
              }
              await _appDatabase.upsertLocalCommunity(
                LocalCommunityMapper.toCompanion(toStore),
              );
            } catch (e) {
              debugPrint(
                  'CommunitySyncService: Failed to store community '
                  '${community.id}: $e');
            }
          }

          // Start syncing new communities
          for (final id in currentIds) {
            if (!_syncingCommunityIds.contains(id)) {
              _startMessageSync(id);
              _startMemberSync(id);
            }
          }

          // Stop syncing removed communities
          final removedIds = _syncingCommunityIds.difference(currentIds);
          for (final id in removedIds) {
            _stopMessageSync(id);
            _stopMemberSync(id);
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

  /// Stop all syncing (on sign-out or app background).
  void stopSync() {
    if (!_isSyncing) return;
    _isSyncing = false;

    debugPrint('CommunitySyncService: Stopping sync');

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
    _processingLock.clear();
    _sentPlaintextCache.clear();
  }

  /// Cache a sent message's plaintext so we can display it immediately.
  void cacheSentPlaintext(String messageId, String plaintext) {
    if (_sentPlaintextCache.length >= _maxCacheSize) {
      // Evict oldest entry
      _sentPlaintextCache.remove(_sentPlaintextCache.keys.first);
    }
    _sentPlaintextCache[messageId] = plaintext;
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
        _processingLock.protect(
          communityId,
          () => _processIncomingMessages(communityId, messageModels),
        ).catchError((Object e) {
          debugPrint(
              'CommunitySyncService: processing error for $communityId: $e');
        });
      },
      onError: (e) {
        debugPrint(
            'CommunitySyncService: Message sync error for $communityId: $e');
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
      (memberModels) async {
        try {
          final currentIds = <String>{};
          for (final model in memberModels) {
            final entity = model.toEntity();
            currentIds.add(entity.userId);
            await _appDatabase.upsertLocalCommunityMember(
              LocalCommunityMemberMapper.toCompanion(entity),
            );
          }

          // Detect member departures → rekey sender key for forward secrecy
          final previousIds = _previousMemberIds[communityId];
          if (previousIds != null && previousIds.isNotEmpty) {
            final removed = previousIds.difference(currentIds);
            if (removed.isNotEmpty) {
              debugPrint('CommunitySyncService: ${removed.length} member(s) '
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
      onError: (e) {
        debugPrint(
            'CommunitySyncService: Member stream error for $communityId: $e');
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
        if (existing != null && existing.isDecrypted) {
          // Check if any mutable field changed
          final deletedForChanged =
              existing.deletedForJson != jsonEncode(msg.deletedFor);
          final deletedForEveryoneChanged =
              existing.deletedForEveryone != msg.deletedForEveryone;
          if (existing.status != msg.status.name ||
              existing.reactionsJson != _encodeReactions(msg.reactions) ||
              deletedForChanged ||
              deletedForEveryoneChanged) {
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
          continue;
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
            if (_mediaRecoveryService.isReady) {
              _mediaRecoveryService.storePayload(msg.id, plaintext).catchError((_) {});
            }
          } else {
            // Sender's own: try vault recovery before falling back to placeholder
            if (msg.senderId == currentUserId) {
              if (_mediaRecoveryService.isReady) {
                final recovered = await _mediaRecoveryService.recoverPayload(msg.id);
                if (recovered != null) {
                  debugPrint('CommunitySyncService: Vault recovery SUCCESS for '
                      '${msg.id}');
                  decryptedMsg = _applyDecryptedPayload(msg, recovered);
                  await _appDatabase.upsertLocalMessage(
                    LocalMessageMapper.toCompanion(
                      decryptedMsg.copyWith(communityId: communityId),
                      communityId,
                      isDecrypted: true,
                    ),
                  );
                  await _appDatabase.cacheDecryptedPlaintext(msg.id, recovered);
                  await _updateCommunityPreview(communityId, decryptedMsg);
                  continue;
                }
              }
              debugPrint('CommunitySyncService: Sender own-message cache miss '
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
              final recovered = await _mediaRecoveryService.recoverPayload(msg.id);
              if (recovered != null) {
                debugPrint('CommunitySyncService: Vault recovery SUCCESS for '
                    'received msg ${msg.id}');
                decryptedMsg = _applyDecryptedPayload(msg, recovered);
                await _appDatabase.upsertLocalMessage(
                  LocalMessageMapper.toCompanion(
                    decryptedMsg.copyWith(communityId: communityId),
                    communityId,
                    isDecrypted: true,
                  ),
                );
                await _appDatabase.cacheDecryptedPlaintext(msg.id, recovered);
                await _updateCommunityPreview(communityId, decryptedMsg);
                continue;
              }
            }
            isDecrypted = false;
            decryptedMsg =
                msg.copyWith(textContent: '[Cannot decrypt community message]');
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
          if (msg.e2ee!.signature != null)
            'signature': msg.e2ee!.signature,
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
  Future<void> _processIncomingKeyDistributions(String communityId) async {
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
          debugPrint('CommunitySyncService: Failed to process key distribution '
              'from $fromUserId: $e');
        }
      }
    } catch (e) {
      debugPrint('CommunitySyncService: Failed to fetch key distributions '
          'for $communityId: $e');
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
