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
import '../../domain/enums/conversation_type.dart';
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


  // =========================================================================
  // CONVERSATION LIST
  // =========================================================================

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      // Offline-first: read from local Drift DB for instant display.
      // MessageSyncService keeps this in sync with Firestore in the background.
      final rows = await _appDatabase.getLocalConversations();
      return Right(rows.map(LocalConversationMapper.toEntity).toList());
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
      // Offline-first: try local DB
      final localRow = await _appDatabase.getLocalConversation(id);
      if (localRow != null) {
        return Right(LocalConversationMapper.toEntity(localRow));
      }
      // Fallback to Firestore
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

      // E2EE encrypt with staleness check
      final encrypted = await _encryptWithFreshnessCheck(actualRecipientId, text);

      final now = DateTime.now();

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

      // Send to server (BLoC handles optimistic UI — no local temp insert needed)
      final messageId = await _remoteDataSource.sendEncryptedMessage(
        conversationId: conversationId,
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
        replyToMessageId: replyToMessageId,
      );

      // Cache plaintext for sync service to pick up
      _messageSyncService.cacheSentPlaintext(messageId, text);

      // Store real message in local DB
      final sentMessage = Message(
        id: messageId,
        senderId: currentUserId!,
        senderName: '',
        type: MessageType.text,
        status: MessageStatus.sent,
        textContent: text,
        createdAt: now,
      );
      try {
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
    String? replyToMessageId,
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

      // 3. Encrypt the entire payload with Signal Protocol (includes staleness check)
      final encrypted = await _encryptWithFreshnessCheck(recipientId, payload);

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
        replyToMessageId: replyToMessageId,
      );

      // 5. Cache plaintext locally
      _messageSyncService.cacheSentPlaintext(messageId, payload);

      final sentMessage = Message(
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
      );

      // Store in local DB so MessageSyncService finds isDecrypted=true
      // and skips re-decryption on app restart (matches sendTextMessage).
      try {
        await _appDatabase.upsertLocalMessage(
          LocalMessageMapper.toCompanion(sentMessage, conversationId),
        );
        await _appDatabase.cacheDecryptedPlaintext(messageId, payload);
      } catch (e) {
        debugPrint('Failed to persist sent media msg $messageId: $e');
      }

      return Right(sentMessage);
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
        final encrypted = await _encryptWithFreshnessCheck(recipientId, message);
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
        final encrypted = await _encryptWithFreshnessCheck(recipientId, message);
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
  // DISAPPEARING MESSAGES
  // =========================================================================

  @override
  Future<Either<Failure, void>> setDisappearingMessages({
    required String conversationId,
    required Duration? duration,
  }) async {
    try {
      await _remoteDataSource.setDisappearingMessages(
        conversationId: conversationId,
        durationMs: duration?.inMilliseconds,
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // MESSAGE REQUESTS
  // =========================================================================

  @override
  Future<Either<Failure, void>> acceptConversation({
    required String conversationId,
  }) async {
    try {
      // 1. Optimistically update local DB so UI reflects acceptance immediately
      if (currentUserId != null) {
        final localConv =
            await _appDatabase.getLocalConversation(conversationId);
        if (localConv != null) {
          final conv = LocalConversationMapper.toEntity(localConv);
          final updatedAccepted = Map<String, bool>.from(conv.accepted);
          updatedAccepted[currentUserId!] = true;
          await _appDatabase.upsertLocalConversation(
            LocalConversationMapper.toCompanion(
              conv.copyWith(accepted: updatedAccepted),
            ),
          );
        }
      }

      // 2. Enqueue for server execution (works offline too)
      await _offlineActionQueue.enqueue(
        table: 'conversations',
        recordId: conversationId,
        changeType: 'accept_conversation',
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
      // 1. Delete local messages immediately
      await _appDatabase.deleteLocalMessagesForConversation(conversationId);

      // 2. Set chatClearedAt on local conversation (prevents re-sync of old messages)
      final localConv = await _appDatabase.getLocalConversation(conversationId);
      if (localConv != null && currentUserId != null) {
        final conv = LocalConversationMapper.toEntity(localConv);
        final updatedClearedAt = Map<String, DateTime>.from(conv.chatClearedAt);
        updatedClearedAt[currentUserId!] = DateTime.now();
        await _appDatabase.upsertLocalConversation(
          LocalConversationMapper.toCompanion(conv.copyWith(
            chatClearedAt: updatedClearedAt,
            lastMessageText: null,
            lastMessageId: null,
            lastMessageSenderId: null,
            lastMessageSenderName: null,
            lastMessageType: null,
          )),
        );
      }

      // 3. Enqueue server-side clear (offline-safe)
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
  // Removed: in-memory _peerIdentityKeyCache was never invalidated, causing
  // stale sessions when the peer regenerated keys during the same app session.

  /// Encrypt plaintext for [recipientId] with a pre- and post-encryption
  /// staleness check on the recipient's key bundle.
  ///
  /// **Pre-check**: reads the recipient's current identity key from Firestore
  /// and resets any stale session whose `peerIdentityKey` doesn't match.
  ///
  /// **Post-check**: after `encryptP2P` (which calls `establishSession` →
  /// `fetchKeyBundle`), re-reads the identity key. If it changed between the
  /// pre-check and the encrypt (recipient uploaded new keys while we were
  /// establishing the session), the encrypted message uses stale keys and
  /// the recipient can't decrypt it. In that case we reset and re-encrypt
  /// once with the now-current bundle.
  ///
  /// This eliminates the race condition where the sender fetches a stale
  /// key bundle just before the recipient finishes uploading new keys
  /// (e.g., after a reinstall).
  Future<Map<String, dynamic>> _encryptWithFreshnessCheck(
    String recipientId,
    String plaintext,
  ) async {
    // ── Pre-encrypt: reset stale session ──
    String? preEncryptPeerKey;
    try {
      preEncryptPeerKey =
          await _remoteDataSource.getUserE2eeIdentityKey(recipientId);
      if (preEncryptPeerKey != null) {
        final isStale = await _signalProtocolService.isPeerKeyStale(
          recipientId,
          preEncryptPeerKey,
        );
        if (isStale) {
          debugPrint('E2EE: Peer $recipientId identity key changed — '
              'resetting stale session for re-establishment');
          await _signalProtocolService.resetSession(recipientId);
        }
      }
    } catch (e) {
      debugPrint('E2EE: Pre-encrypt freshness check failed: $e');
    }

    // ── Encrypt (may call establishSession → fetchKeyBundle internally) ──
    var encrypted = await _signalProtocolService.encryptP2P(
      recipientId,
      plaintext,
    );

    // ── Post-encrypt: verify the bundle didn't change while we were encrypting ──
    try {
      final postEncryptPeerKey =
          await _remoteDataSource.getUserE2eeIdentityKey(recipientId);
      if (postEncryptPeerKey != null && preEncryptPeerKey != null &&
          postEncryptPeerKey != preEncryptPeerKey) {
        // Recipient uploaded a new key bundle between our pre-check and the
        // fetchKeyBundle call inside establishSession. The encrypted message
        // uses the OLD bundle — recipient can't decrypt it.
        debugPrint('E2EE: Recipient $recipientId key changed during encrypt '
            '(pre=${preEncryptPeerKey.substring(0, 8)}… → '
            'post=${postEncryptPeerKey.substring(0, 8)}…) — '
            're-encrypting with fresh bundle');
        await _signalProtocolService.resetSession(recipientId);
        encrypted = await _signalProtocolService.encryptP2P(
          recipientId,
          plaintext,
        );
      }
    } catch (e) {
      debugPrint('E2EE: Post-encrypt freshness check failed: $e');
      // Non-fatal — proceed with the original encrypted message.
      // Worst case: recipient's recovery mechanism handles it.
    }

    return encrypted;
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

  // =========================================================================
  // TYPING INDICATORS
  // =========================================================================

  @override
  Future<Either<Failure, void>> setTyping({
    required String conversationId,
    required bool isTyping,
  }) async {
    try {
      await _remoteDataSource.setTyping(
        conversationId: conversationId,
        isTyping: isTyping,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Map<String, bool>> watchTypingState({
    required String conversationId,
  }) {
    return _remoteDataSource.watchTypingState(
      conversationId: conversationId,
    );
  }

  // =========================================================================
  // MESSAGE SEARCH
  // =========================================================================

  @override
  Future<Either<Failure, List<Message>>> searchMessages({
    required String conversationId,
    required String query,
  }) async {
    try {
      final rows = await _appDatabase.searchLocalMessages(
        conversationId,
        query,
      );
      final messages = rows.map(LocalMessageMapper.toEntity).toList();
      return Right(messages);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // MESSAGE FORWARDING
  // =========================================================================

  @override
  Future<Either<Failure, String>> forwardMessage({
    required String sourceConversationId,
    required String sourceMessageId,
    required String targetConversationId,
    String? plaintextContent,
  }) async {
    try {
      String? ciphertext;
      Map<String, dynamic>? e2ee;
      Map<String, dynamic>? x3dhHeader;

      // Re-encrypt the plaintext for the target conversation's recipient.
      if (plaintextContent != null && plaintextContent.isNotEmpty) {
        final targetConvModel =
            await _remoteDataSource.getConversationById(targetConversationId);
        if (targetConvModel != null) {
          final targetConv = targetConvModel.toEntity();
          if (targetConv.type == ConversationType.p2p) {
            final recipientId = targetConv.participantIds.firstWhere(
              (id) => id != currentUserId,
              orElse: () => '',
            );
            if (recipientId.isNotEmpty) {
              final encrypted = await _encryptWithFreshnessCheck(
                  recipientId, plaintextContent);
              ciphertext = encrypted['ciphertext'] as String;
              e2ee = encrypted['e2ee'] as Map<String, dynamic>;
              x3dhHeader =
                  encrypted['x3dhHeader'] as Map<String, dynamic>?;
            }
          }
        }
      }

      final messageId = await _remoteDataSource.forwardMessage(
        sourceConversationId: sourceConversationId,
        sourceMessageId: sourceMessageId,
        targetConversationId: targetConversationId,
        ciphertext: ciphertext,
        e2ee: e2ee,
        x3dhHeader: x3dhHeader,
      );
      return Right(messageId);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      if (e is ServerException) {
        return Left(Failure.serverError(message: e.message ?? 'Forward failed'));
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
