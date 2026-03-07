import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/services/offline_action_queue.dart';
import '../../core/services/outgoing_message_queue.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/enums/conversation_type.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../../domain/value_objects/user_search_result.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/conversation_remote_datasource.dart';
import '../datasources/remote/media_upload_datasource.dart';
import '../mappers/local_conversation_mapper.dart';
import '../mappers/local_message_mapper.dart';

@LazySingleton(as: ConversationRepository)
class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource _remoteDataSource;
  final AppDatabase _appDatabase;
  final MediaUploadDatasource _mediaUploadDatasource;
  final OfflineActionQueue _offlineActionQueue;
  final OutgoingMessageQueue _outgoingMessageQueue;

  ConversationRepositoryImpl(
    this._remoteDataSource,
    this._appDatabase,
    this._mediaUploadDatasource,
    this._offlineActionQueue,
    this._outgoingMessageQueue,
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
      final conversations =
          rows.map(LocalConversationMapper.toEntity).toList();
      return Right(_deduplicateP2P(conversations));
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
        return Right<Failure, List<Conversation>>(
            _deduplicateP2P(conversations));
      } catch (e) {
        return Left<Failure, List<Conversation>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  /// Deduplicate P2P conversations that share the same participant pair.
  /// Keeps the one with the most recent message. This is a safety net
  /// for stale local DB entries that the sync service hasn't pruned yet.
  List<Conversation> _deduplicateP2P(List<Conversation> conversations) {
    final userId = currentUserId ?? '';
    if (userId.isEmpty) return conversations;

    final seen = <String, Conversation>{};
    for (final conv in conversations) {
      if (conv.type != ConversationType.p2p) {
        seen[conv.id] = conv;
        continue;
      }
      final otherIds =
          conv.participantIds.where((id) => id != userId);
      final key = otherIds.isNotEmpty ? otherIds.first : conv.id;
      final existing = seen[key];
      if (existing == null) {
        seen[key] = conv;
      } else {
        final existingTime =
            existing.lastMessageAt ?? existing.createdAt;
        final convTime = conv.lastMessageAt ?? conv.createdAt;
        if (convTime.isAfter(existingTime)) {
          seen[key] = conv;
        }
      }
    }
    return seen.values.toList();
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
    String query, {
    String? accountTypeId,
  }) async {
    try {
      final results = await _remoteDataSource.searchUsers(
        query,
        accountTypeId: accountTypeId,
      );
      return Right(
        results.map((json) => UserSearchResult.fromJson(json)).toList(),
      );
    } catch (e) {
      // Offline fallback: search local contacts
      try {
        final contacts = await _appDatabase.searchLocalContacts(query);
        if (contacts.isNotEmpty) {
          return Right(
            contacts
                .map((c) => UserSearchResult(
                      userId: c.userId,
                      displayName: c.displayName,
                      username: c.username,
                      avatarUrl: c.avatarUrl,
                    ))
                .toList(),
          );
        }
      } catch (_) {}
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

      // Resolve recipient ID (use provided or look up from local DB)
      String? actualRecipientId = recipientId;
      if (actualRecipientId == null || actualRecipientId.isEmpty) {
        final localConv =
            await _appDatabase.getLocalConversation(conversationId);
        if (localConv != null) {
          final conv = LocalConversationMapper.toEntity(localConv);
          actualRecipientId = conv.participantIds.firstWhere(
            (id) => id != currentUserId,
            orElse: () => '',
          );
        }
      }

      if (actualRecipientId == null || actualRecipientId.isEmpty) {
        return const Left(
            Failure.serverError(message: 'Could not determine recipient'));
      }

      // Enqueue for persistent send (queue handles encrypt + send + local DB)
      final message = await _outgoingMessageQueue.enqueueTextMessage(
        conversationId: conversationId,
        text: text,
        recipientId: actualRecipientId,
        replyToMessageId: replyToMessageId,
      );
      return Right(message);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
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
    File? thumbnailFile,
  }) async {
    try {
      if (currentUserId == null) {
        return const Left(Failure.unauthenticated());
      }

      // 1. Upload encrypted media to Firebase Storage (requires network)
      final isAudio = mediaType.startsWith('audio');
      // Fix #4: Accept both 'document' and 'application/' MIME types
      final isDocument =
          mediaType == 'document' || mediaType.startsWith('application');
      final isVideo = mediaType.startsWith('video');
      // Fix #11: Use UUID to avoid temp message ID collisions
      final tempMessageId = const Uuid().v4();
      final MediaUploadResult uploadResult;
      if (isAudio) {
        uploadResult = await _mediaUploadDatasource.uploadEncryptedVoice(
          voiceFile: mediaFile,
          parentCollection: 'conversations',
          parentId: conversationId,
          messageId: tempMessageId,
          durationSeconds: durationSeconds ?? 0,
        );
      } else if (isDocument) {
        uploadResult = await _mediaUploadDatasource.uploadEncryptedDocument(
          documentFile: mediaFile,
          parentCollection: 'conversations',
          parentId: conversationId,
          messageId: tempMessageId,
        );
      } else if (isVideo) {
        // Fix #3: Validate thumbnailFile before using it
        if (thumbnailFile == null) {
          return const Left(
            Failure.serverError(message: 'Video upload requires a thumbnail'),
          );
        }
        uploadResult = await _mediaUploadDatasource.uploadEncryptedVideo(
          videoFile: mediaFile,
          thumbnailFile: thumbnailFile,
          parentCollection: 'conversations',
          parentId: conversationId,
          messageId: tempMessageId,
          durationSeconds: durationSeconds ?? 0,
        );
      } else {
        uploadResult = await _mediaUploadDatasource.uploadEncryptedImage(
          imageFile: mediaFile,
          parentCollection: 'conversations',
          parentId: conversationId,
          messageId: tempMessageId,
        );
      }

      // 2. Build structured JSON payload with encrypted media metadata
      final payload = jsonEncode({
        if (caption != null) 'text': caption,
        'media': uploadResult.toMediaMap(),
      });

      // 3. Enqueue the encrypt + send step (upload already done)
      final message = await _outgoingMessageQueue.enqueueMediaMessage(
        conversationId: conversationId,
        recipientId: recipientId,
        encryptedPayloadJson: payload,
        mediaType: mediaType,
        caption: caption,
        durationSeconds: durationSeconds,
        replyToMessageId: replyToMessageId,
      );
      return Right(message);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: 'Media upload failed: $e'));
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
    String? subAccountId,
  }) async {
    try {
      final msg = await _outgoingMessageQueue.enqueueTokenSend(
        conversationId: conversationId,
        recipientId: recipientId,
        amount: amount,
        message: message,
        subAccountId: subAccountId,
      );
      return Right(msg);
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
    String? subAccountId,
  }) async {
    try {
      final msg = await _outgoingMessageQueue.enqueueTokenRequest(
        conversationId: conversationId,
        recipientId: recipientId,
        amount: amount,
        message: message,
        subAccountId: subAccountId,
      );
      return Right(msg);
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
      await _offlineActionQueue.enqueue(
        table: 'messages',
        recordId: messageId,
        changeType: 'accept_token_request',
        data: {'conversationId': conversationId},
      );
      // Return a placeholder — the real update comes via sync
      return Right(Message(
        id: messageId,
        senderId: currentUserId ?? '',
        senderName: '',
        type: MessageType.tokenSend,
        status: MessageStatus.sent,
        createdAt: DateTime.now(),
      ));
    } on AuthException {
      return const Left(Failure.unauthenticated());
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
      await _offlineActionQueue.enqueue(
        table: 'messages',
        recordId: messageId,
        changeType: 'decline_token_request',
        data: {'conversationId': conversationId},
      );
      // Return a placeholder — the real update comes via sync
      return Right(Message(
        id: messageId,
        senderId: currentUserId ?? '',
        senderName: '',
        type: MessageType.tokenRequest,
        status: MessageStatus.sent,
        createdAt: DateTime.now(),
      ));
    } on AuthException {
      return const Left(Failure.unauthenticated());
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
      final durationMs = duration?.inMilliseconds;

      // Optimistic local update
      final localConv =
          await _appDatabase.getLocalConversation(conversationId);
      if (localConv != null) {
        final conv = LocalConversationMapper.toEntity(localConv);
        await _appDatabase.upsertLocalConversation(
          LocalConversationMapper.toCompanion(
            conv.copyWith(disappearingMessagesDuration: duration),
          ),
        );
      }

      // Queue the server update
      await _offlineActionQueue.enqueue(
        table: 'conversations',
        recordId: conversationId,
        changeType: 'set_disappearing',
        data: {'durationMs': durationMs},
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
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
  // UNREAD COUNT — Local DB (offline-first)
  // =========================================================================

  @override
  Future<Either<Failure, int>> getTotalUnreadCount() async {
    try {
      final convs = await _appDatabase.getLocalConversations();
      int total = 0;
      for (final conv in convs) {
        final unread =
            jsonDecode(conv.unreadCountsJson) as Map<String, dynamic>;
        total += ((unread[currentUserId] as num?) ?? 0).toInt();
      }
      return Right(total);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, int>> watchTotalUnreadCount() {
    return _appDatabase.watchLocalConversations().map((rows) {
      try {
        int total = 0;
        for (final row in rows) {
          final unread =
              jsonDecode(row.unreadCountsJson) as Map<String, dynamic>;
          total += ((unread[currentUserId] as num?) ?? 0).toInt();
        }
        return Right<Failure, int>(total);
      } catch (e) {
        return Left<Failure, int>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  // =========================================================================
  // TYPING INDICATORS (ephemeral, intentionally online-only)
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
      // Resolve recipient from local DB
      String? recipientId;
      final localConv =
          await _appDatabase.getLocalConversation(targetConversationId);
      if (localConv != null) {
        final conv = LocalConversationMapper.toEntity(localConv);
        if (conv.type == ConversationType.p2p) {
          recipientId = conv.participantIds.firstWhere(
            (id) => id != currentUserId,
            orElse: () => '',
          );
        }
      }

      final msg = await _outgoingMessageQueue.enqueueForwardMessage(
        sourceConversationId: sourceConversationId,
        sourceMessageId: sourceMessageId,
        targetConversationId: targetConversationId,
        plaintextContent: plaintextContent,
        recipientId: recipientId,
      );
      return Right(msg.id);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // RETRY
  // =========================================================================

  @override
  Future<Either<Failure, void>> retryMessage(String messageId) async {
    try {
      await _outgoingMessageQueue.retryMessage(messageId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
