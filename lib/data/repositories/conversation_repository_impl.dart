import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/services/offline_action_queue.dart';
import '../../core/services/signal_protocol_service.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../../domain/value_objects/user_search_result.dart';
import '../../core/services/message_sync_service.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/conversation_remote_datasource.dart';
import '../datasources/remote/media_upload_datasource.dart';
import '../mappers/local_conversation_mapper.dart';
import '../mappers/local_message_mapper.dart';

@LazySingleton(as: ConversationRepository)
class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource _remoteDataSource;
  final SignalProtocolService _signalProtocolService;
  final AppDatabase _appDatabase;
  final MediaUploadDatasource _mediaUploadDatasource;
  final MessageSyncService _messageSyncService;
  final OfflineActionQueue _offlineActionQueue;

  ConversationRepositoryImpl(
    this._remoteDataSource,
    this._signalProtocolService,
    this._appDatabase,
    this._mediaUploadDatasource,
    this._messageSyncService,
    this._offlineActionQueue,
  );

  @override
  String? get currentUserId => _remoteDataSource.currentUserId;

  /// Cache of sent encrypted messages: messageId → plaintext.
  /// Shared with MessageSyncService so it can resolve own outgoing messages.
  final Map<String, String> _sentPlaintextCache = {};

  // =========================================================================
  // CONVERSATION LIST
  // =========================================================================

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      final models = await _remoteDataSource.getConversations();
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Conversation>>> watchConversations() {
    // Read from local DB — MessageSyncService populates it from Firestore
    // with already-decrypted previews. No on-the-fly decryption needed.
    return _appDatabase.watchLocalConversations().map((rows) {
      try {
        final conversations =
            rows.map(LocalConversationMapper.toEntity).toList();
        return Right<Failure, List<Conversation>>(conversations);
      } catch (e) {
        return Left<Failure, List<Conversation>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  @override
  Future<Either<Failure, Conversation>> getOrCreateConversation({
    required String participantId,
  }) async {
    try {
      final model = await _remoteDataSource.getOrCreateConversation(
        participantId: participantId,
      );
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Conversation>> getConversationById(String id) async {
    try {
      final model = await _remoteDataSource.getConversationById(id);
      if (model == null) {
        return Left(Failure.serverError(message: 'Conversation not found'));
      }
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserSearchResult>>> searchUsers(
    String query,
  ) async {
    try {
      final results = await _remoteDataSource.searchUsers(query);
      return Right(
        results.map((json) => UserSearchResult.fromJson(json)).toList(),
      );
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // MESSAGES
  // =========================================================================

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int? limit,
    DateTime? before,
  }) async {
    try {
      // Read from local DB — already decrypted by MessageSyncService
      final rows = await _appDatabase.getLocalMessages(
        conversationId,
        limit: limit ?? 50,
        before: before,
      );
      final messages = rows.map(LocalMessageMapper.toEntity).toList();
      return Right(messages);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String conversationId,
    int? limit,
  }) {
    // Read from local DB — MessageSyncService decrypts once and stores.
    // No decryption here. No permanent failure tracking needed.
    return _appDatabase
        .watchLocalMessages(conversationId, limit: limit ?? 50)
        .map<Either<Failure, List<Message>>>((rows) {
      try {
        final messages = rows.map(LocalMessageMapper.toEntity).toList();
        return Right(messages);
      } catch (e) {
        return Left(Failure.serverError(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, Message>> sendTextMessage({
    required String conversationId,
    required String text,
    String? replyToMessageId,
    String? recipientId,
  }) async {
    try {
      if (currentUserId == null) {
        return const Left(Failure.unauthenticated());
      }

      // Resolve recipient ID (use provided or look up from conversation)
      String? actualRecipientId = recipientId;
      if (actualRecipientId == null || actualRecipientId.isEmpty) {
        final convModel = await _remoteDataSource.getConversationById(conversationId);
        if (convModel != null) {
          final conv = convModel.toEntity();
          actualRecipientId = conv.participantIds.firstWhere(
            (id) => id != currentUserId,
            orElse: () => '',
          );
        }
      }

      if (actualRecipientId == null || actualRecipientId.isEmpty) {
        return const Left(Failure.serverError(message: 'Could not determine recipient'));
      }

      // Verify session is still valid (peer may have regenerated keys)
      await _ensureSessionFresh(actualRecipientId);

      // E2EE encrypt — if this fails, the message fails. No plaintext fallback.
      final encrypted = await _signalProtocolService.encryptP2P(actualRecipientId, text);

      final now = DateTime.now();
      final tempId = 'temp_${now.millisecondsSinceEpoch}';
      final optimisticMessage = Message(
        id: tempId,
        senderId: currentUserId!,
        senderName: '',
        type: MessageType.text,
        status: MessageStatus.sending,
        textContent: text,
        createdAt: now,
      );

      // Pre-cache plaintext by ciphertext fingerprint BEFORE sending.
      // If the app is killed after the server receives the message but
      // before we cache by messageId, MessageSyncService can still
      // resolve the plaintext via ciphertext fingerprint lookup.
      final ciphertextStr = encrypted['ciphertext'] as String;
      final ctFingerprint = _ciphertextFingerprint(ciphertextStr);
      try {
        await _appDatabase.cacheDecryptedPlaintext(ctFingerprint, text);
      } catch (e) {
        debugPrint('Failed to pre-cache plaintext by fingerprint: $e');
      }

      // Optimistic local insert — message appears instantly in UI
      try {
        await _appDatabase.upsertLocalMessage(
          LocalMessageMapper.toCompanion(optimisticMessage, conversationId),
        );
      } catch (e) {
        debugPrint('Failed to insert optimistic message: $e');
      }

      // Send to server
      final messageId = await _remoteDataSource.sendEncryptedMessage(
        conversationId: conversationId,
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
        replyToMessageId: replyToMessageId,
      );

      // Cache plaintext for sync service to pick up
      _sentPlaintextCache[messageId] = text;
      _messageSyncService.sentPlaintextCache[messageId] = text;

      // Replace optimistic message with real one
      final sentMessage = optimisticMessage.copyWith(
        id: messageId,
        status: MessageStatus.sent,
      );
      try {
        await _appDatabase.deleteLocalMessage(tempId);
        await _appDatabase.upsertLocalMessage(
          LocalMessageMapper.toCompanion(sentMessage, conversationId),
        );
        await _appDatabase.cacheDecryptedPlaintext(messageId, text);
      } catch (e) {
        debugPrint('Failed to finalize sent message $messageId: $e');
      }

      return Right(sentMessage);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: 'Encryption failed: $e'));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMediaMessage({
    required String conversationId,
    required File mediaFile,
    required String mediaType,
    required String recipientId,
    String? caption,
    int? durationSeconds,
  }) async {
    try {
      if (currentUserId == null) {
        return const Left(Failure.unauthenticated());
      }

      // 1. Upload encrypted media to Firebase Storage
      final isAudio = mediaType.startsWith('audio');
      final tempMessageId = DateTime.now().millisecondsSinceEpoch.toString();
      final uploadResult = isAudio
          ? await _mediaUploadDatasource.uploadEncryptedVoice(
              voiceFile: mediaFile,
              parentCollection: 'conversations',
              parentId: conversationId,
              messageId: tempMessageId,
              durationSeconds: durationSeconds ?? 0,
            )
          : await _mediaUploadDatasource.uploadEncryptedImage(
              imageFile: mediaFile,
              parentCollection: 'conversations',
              parentId: conversationId,
              messageId: tempMessageId,
            );

      // 2. Build structured JSON payload with encrypted media metadata
      final payload = jsonEncode({
        if (caption != null) 'text': caption,
        'media': uploadResult.toMediaMap(),
      });

      // 3. Verify session, then encrypt the entire payload with Signal Protocol
      await _ensureSessionFresh(recipientId);
      final encrypted = await _signalProtocolService.encryptP2P(recipientId, payload);

      // Pre-cache plaintext by ciphertext fingerprint before sending
      final mediaCiphertextStr = encrypted['ciphertext'] as String;
      final mediaCtFp = _ciphertextFingerprint(mediaCiphertextStr);
      try {
        await _appDatabase.cacheDecryptedPlaintext(mediaCtFp, payload);
      } catch (e) {
        debugPrint('Failed to pre-cache media plaintext by fingerprint: $e');
      }

      // 4. Send via the same encrypted message path
      final msgType = isAudio ? 'voice' : 'image';
      final messageId = await _remoteDataSource.sendEncryptedMessage(
        conversationId: conversationId,
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
        messageType: msgType,
      );

      // 5. Cache plaintext locally
      _sentPlaintextCache[messageId] = payload;
      _messageSyncService.sentPlaintextCache[messageId] = payload;
      try {
        await _appDatabase.cacheDecryptedPlaintext(messageId, payload);
      } catch (e) {
        debugPrint('Failed to persist plaintext for sent media msg $messageId: $e');
      }

      return Right(Message(
        id: messageId,
        senderId: currentUserId!,
        senderName: '',
        type: isAudio ? MessageType.voice : MessageType.image,
        status: MessageStatus.sent,
        textContent: caption,
        media: MessageMedia(
          url: uploadResult.url,
          thumbnailUrl: uploadResult.thumbnailUrl,
          fileName: uploadResult.fileName,
          fileSize: uploadResult.fileSize,
          mimeType: uploadResult.mimeType,
          duration: uploadResult.duration,
          width: uploadResult.width,
          height: uploadResult.height,
          mediaKey: uploadResult.mediaKey,
          thumbKey: uploadResult.thumbKey,
        ),
        createdAt: DateTime.now(),
      ));
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: 'Media encryption failed: $e'));
    }
  }

  // =========================================================================
  // TOKEN OPERATIONS
  // =========================================================================

  @override
  Future<Either<Failure, Message>> sendTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
  }) async {
    try {
      // Encrypt optional user text if present
      String? encryptedMsg;
      Map<String, dynamic>? msgE2ee;
      Map<String, dynamic>? msgX3dh;
      if (message != null && message.isNotEmpty) {
        await _ensureSessionFresh(recipientId);
        final encrypted = await _signalProtocolService.encryptP2P(recipientId, message);
        encryptedMsg = encrypted['ciphertext'] as String;
        msgE2ee = encrypted['e2ee'] as Map<String, dynamic>;
        msgX3dh = encrypted['x3dhHeader'] as Map<String, dynamic>?;
      }

      final model = await _remoteDataSource.sendTokens(
        conversationId: conversationId,
        recipientId: recipientId,
        amount: amount,
        encryptedMessage: encryptedMsg,
        messageE2ee: msgE2ee,
        messageX3dh: msgX3dh,
      );

      // Cache plaintext locally for sender display
      final result = model.toEntity();
      if (message != null && message.isNotEmpty) {
        _sentPlaintextCache[result.id] = message;
        try {
          await _appDatabase.cacheDecryptedPlaintext(result.id, message);
        } catch (e) {
          debugPrint('Failed to persist plaintext for token msg ${result.id}: $e');
        }
      }

      return Right(result);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on InsufficientBalanceException {
      return const Left(Failure.insufficientBalance());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Message>> requestTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
  }) async {
    try {
      // Encrypt optional user text if present
      String? encryptedMsg;
      Map<String, dynamic>? msgE2ee;
      Map<String, dynamic>? msgX3dh;
      if (message != null && message.isNotEmpty) {
        await _ensureSessionFresh(recipientId);
        final encrypted = await _signalProtocolService.encryptP2P(recipientId, message);
        encryptedMsg = encrypted['ciphertext'] as String;
        msgE2ee = encrypted['e2ee'] as Map<String, dynamic>;
        msgX3dh = encrypted['x3dhHeader'] as Map<String, dynamic>?;
      }

      final model = await _remoteDataSource.requestTokens(
        conversationId: conversationId,
        recipientId: recipientId,
        amount: amount,
        encryptedMessage: encryptedMsg,
        messageE2ee: msgE2ee,
        messageX3dh: msgX3dh,
      );

      // Cache plaintext locally for sender display
      final result = model.toEntity();
      if (message != null && message.isNotEmpty) {
        _sentPlaintextCache[result.id] = message;
        try {
          await _appDatabase.cacheDecryptedPlaintext(result.id, message);
        } catch (e) {
          debugPrint('Failed to persist plaintext for token req ${result.id}: $e');
        }
      }

      return Right(result);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Message>> acceptTokenRequest({
    required String messageId,
    required String conversationId,
  }) async {
    try {
      final model = await _remoteDataSource.acceptTokenRequest(
        messageId: messageId,
        conversationId: conversationId,
      );
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on InsufficientBalanceException {
      return const Left(Failure.insufficientBalance());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Message>> declineTokenRequest({
    required String messageId,
    required String conversationId,
  }) async {
    try {
      final model = await _remoteDataSource.declineTokenRequest(
        messageId: messageId,
        conversationId: conversationId,
      );
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // THREAD MANAGEMENT
  // =========================================================================

  @override
  Future<Either<Failure, void>> markAsRead({
    required String conversationId,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'conversations',
        recordId: conversationId,
        changeType: 'mark_read',
        data: {},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> togglePin({
    required String conversationId,
    required bool pinned,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'conversations',
        recordId: conversationId,
        changeType: 'toggle_pin',
        data: {'pinned': pinned},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleMute({
    required String conversationId,
    required bool muted,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'conversations',
        recordId: conversationId,
        changeType: 'toggle_mute',
        data: {'muted': muted},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> archiveConversation(
    String conversationId,
  ) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'conversations',
        recordId: conversationId,
        changeType: 'archive',
        data: {},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // MESSAGE DELETION
  // =========================================================================

  @override
  Future<Either<Failure, void>> deleteMessageForEveryone({
    required String conversationId,
    required String messageId,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'messages',
        recordId: messageId,
        changeType: 'delete_for_everyone',
        data: {'conversationId': conversationId},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearChat({
    required String conversationId,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'conversations',
        recordId: conversationId,
        changeType: 'clear_chat',
        data: {},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // REACTIONS
  // =========================================================================

  @override
  Future<Either<Failure, void>> addReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'messages',
        recordId: messageId,
        changeType: 'add_reaction',
        data: {'conversationId': conversationId, 'emoji': emoji},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'messages',
        recordId: messageId,
        changeType: 'remove_reaction',
        data: {'conversationId': conversationId, 'emoji': emoji},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  @override
  Future<Either<Failure, int>> getTotalUnreadCount() async {
    try {
      final count = await _remoteDataSource.getTotalUnreadCount();
      return Right(count);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, int>> watchTotalUnreadCount() {
    return _remoteDataSource.watchTotalUnreadCount().map((count) {
      return Right<Failure, int>(count);
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, int>(Failure.unauthenticated());
      }
      return Left<Failure, int>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  // =========================================================================
  // E2EE HELPERS
  // =========================================================================

  /// Cache of peer identity keys: userId → e2eeIdentityKey from Firestore.
  /// Populated once per session per peer, avoids repeated Firestore reads.
  final Map<String, String?> _peerIdentityKeyCache = {};

  /// Ensure the Signal Protocol session with [recipientId] is fresh.
  ///
  /// Checks the recipient's current identity key (from their Firestore
  /// profile) against what was stored in the session at establishment time.
  /// If the keys differ (recipient reinstalled, key regeneration, etc.),
  /// resets the session so the next `encryptP2P` call auto-establishes
  /// a fresh session with the recipient's current key bundle.
  Future<void> _ensureSessionFresh(String recipientId) async {
    try {
      // Fetch peer's current identity key (cached per session)
      if (!_peerIdentityKeyCache.containsKey(recipientId)) {
        _peerIdentityKeyCache[recipientId] =
            await _remoteDataSource.getUserE2eeIdentityKey(recipientId);
      }
      final currentPeerKey = _peerIdentityKeyCache[recipientId];
      if (currentPeerKey == null) return; // peer hasn't uploaded keys yet

      final isStale = await _signalProtocolService.isPeerKeyStale(
        recipientId,
        currentPeerKey,
      );
      if (isStale) {
        debugPrint('E2EE: Peer $recipientId identity key changed — '
            'resetting stale session for re-establishment');
        await _signalProtocolService.resetSession(recipientId);
        // Clear the cache so the next send after re-establishment
        // doesn't falsely detect staleness again.
        _peerIdentityKeyCache.remove(recipientId);
      }
    } catch (e) {
      // Non-fatal — if the check fails, proceed with existing session.
      // Worst case: encryption uses stale keys and peer can't decrypt,
      // which triggers the receiver-side session recovery.
      debugPrint('E2EE: Session freshness check failed for $recipientId: $e');
    }
  }

  /// Compute a stable fingerprint from ciphertext for pre-caching plaintext.
  ///
  /// Uses the first 64 chars of the base64 ciphertext (which includes the
  /// 12-byte random nonce, making collisions astronomically unlikely).
  /// Prefixed with `sent_ct:` to avoid key collisions in DecryptedMessageCache.
  static String _ciphertextFingerprint(String ciphertextBase64) {
    final fpLen = min(64, ciphertextBase64.length);
    return 'sent_ct:${ciphertextBase64.substring(0, fpLen)}';
  }
}
