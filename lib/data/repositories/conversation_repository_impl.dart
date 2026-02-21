import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/services/signal_protocol_service.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../../domain/value_objects/user_search_result.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/conversation_remote_datasource.dart';

@LazySingleton(as: ConversationRepository)
class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource _remoteDataSource;
  final SignalProtocolService _signalProtocolService;
  final AppDatabase _appDatabase;

  ConversationRepositoryImpl(this._remoteDataSource, this._signalProtocolService, this._appDatabase);

  /// Cache of sent encrypted messages: messageId → plaintext.
  /// Allows the sender to see their own E2EE messages without decryption
  /// (sender can't decrypt own messages — session is stored under recipient's ID).
  final Map<String, String> _sentPlaintextCache = {};

  /// Cache of received decrypted messages: messageId → plaintext.
  /// Prevents re-decryption on subsequent stream emissions (which would
  /// ratchet the chain key forward and corrupt the session state).
  final Map<String, String> _receivedPlaintextCache = {};

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
    return _remoteDataSource.watchConversations().map((models) {
      return Right<Failure, List<Conversation>>(
        models.map((m) => m.toEntity()).toList(),
      );
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<Conversation>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<Conversation>>(
        Failure.serverError(message: error.toString()),
      );
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
      final models = await _remoteDataSource.getMessages(
        conversationId: conversationId,
        limit: limit,
        before: before,
      );
      final messages = models.map((m) => m.toEntity()).toList();
      // Decrypt sequentially to avoid concurrent chain key ratcheting
      // for messages from the same sender (corrupts session state).
      final decrypted = <Message>[];
      for (final m in messages) {
        decrypted.add(await _decryptIfNeeded(m));
      }
      return Right(decrypted);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String conversationId,
    int? limit,
  }) {
    return _remoteDataSource
        .watchMessages(conversationId: conversationId, limit: limit)
        .asyncMap((models) async {
      final messages = models.map((m) => m.toEntity()).toList();
      // Decrypt sequentially to avoid concurrent chain key ratcheting
      final decrypted = <Message>[];
      for (final m in messages) {
        decrypted.add(await _decryptIfNeeded(m));
      }
      return Right<Failure, List<Message>>(decrypted);
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<Message>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<Message>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, Message>> sendTextMessage({
    required String conversationId,
    required String text,
    String? replyToMessageId,
  }) async {
    try {
      // Try to encrypt via Signal Protocol
      final currentUserId = _remoteDataSource.currentUserId;
      try {
        if (currentUserId != null) {
          // Get conversation to find recipient
          final convModel = await _remoteDataSource.getConversationById(conversationId);
          if (convModel != null) {
            final conv = convModel.toEntity();
            // Find the other participant using actual current user ID
            final recipientId = conv.participantIds.firstWhere(
              (id) => id != currentUserId,
              orElse: () => '',
            );
            if (recipientId.isNotEmpty) {
              final encrypted = await _signalProtocolService.encryptP2P(recipientId, text);
              final messageId = await _remoteDataSource.sendEncryptedMessage(
                conversationId: conversationId,
                ciphertext: encrypted['ciphertext'] as String,
                e2ee: encrypted['e2ee'] as Map<String, dynamic>,
                x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
                replyToMessageId: replyToMessageId,
              );
              // Cache plaintext so sender can view their own E2EE message
              _sentPlaintextCache[messageId] = text;
              // Persist to encrypted DB so it survives app restart
              _appDatabase.cacheDecryptedPlaintext(messageId, text);
              // Return optimistic message with original text for immediate UI
              return Right(Message(
                id: messageId,
                senderId: currentUserId,
                senderName: '',
                type: MessageType.text,
                status: MessageStatus.sent,
                textContent: text,
                createdAt: DateTime.now(),
              ));
            }
          }
        }
      } catch (e) {
        // E2EE failed — fall through to plaintext
        debugPrint('E2EE encrypt failed (falling back to plaintext): $e');
      }

      // Fallback: send plaintext
      final model = await _remoteDataSource.sendTextMessage(
        conversationId: conversationId,
        text: text,
        replyToMessageId: replyToMessageId,
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
  Future<Either<Failure, Message>> sendMediaMessage({
    required String conversationId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) async {
    try {
      final model = await _remoteDataSource.sendMediaMessage(
        conversationId: conversationId,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        caption: caption,
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
      final model = await _remoteDataSource.sendTokens(
        conversationId: conversationId,
        recipientId: recipientId,
        amount: amount,
        message: message,
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
  Future<Either<Failure, Message>> requestTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
  }) async {
    try {
      final model = await _remoteDataSource.requestTokens(
        conversationId: conversationId,
        recipientId: recipientId,
        amount: amount,
        message: message,
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
      await _remoteDataSource.markAsRead(conversationId: conversationId);
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
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
      await _remoteDataSource.togglePin(
        conversationId: conversationId,
        pinned: pinned,
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

  @override
  Future<Either<Failure, void>> toggleMute({
    required String conversationId,
    required bool muted,
  }) async {
    try {
      await _remoteDataSource.toggleMute(
        conversationId: conversationId,
        muted: muted,
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

  @override
  Future<Either<Failure, void>> archiveConversation(
    String conversationId,
  ) async {
    try {
      await _remoteDataSource.archiveConversation(conversationId);
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
  // MESSAGE DELETION
  // =========================================================================

  @override
  Future<Either<Failure, void>> deleteMessageForEveryone({
    required String conversationId,
    required String messageId,
  }) async {
    try {
      await _remoteDataSource.deleteMessageForEveryone(
        conversationId: conversationId,
        messageId: messageId,
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

  @override
  Future<Either<Failure, void>> clearChat({
    required String conversationId,
  }) async {
    try {
      await _remoteDataSource.clearChat(conversationId: conversationId);
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
  // REACTIONS
  // =========================================================================

  @override
  Future<Either<Failure, void>> addReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _remoteDataSource.addReaction(
        conversationId: conversationId,
        messageId: messageId,
        emoji: emoji,
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

  @override
  Future<Either<Failure, void>> removeReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _remoteDataSource.removeReaction(
        conversationId: conversationId,
        messageId: messageId,
        emoji: emoji,
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

  Future<Message> _decryptIfNeeded(Message msg) async {
    if (!msg.isEncrypted) return msg;

    // Sender cannot decrypt their own outgoing E2EE messages because
    // the Signal session is stored under the *recipient's* ID, not their own.
    // Use the in-memory plaintext cache for messages sent this session.
    final currentUserId = _remoteDataSource.currentUserId;
    if (msg.senderId == currentUserId) {
      final cached = _sentPlaintextCache[msg.id];
      if (cached != null) {
        return msg.copyWith(textContent: cached);
      }
      // Fallback: check persistent DB (survives app restart)
      final dbCached = await _appDatabase.getDecryptedPlaintext(msg.id);
      if (dbCached != null) {
        _sentPlaintextCache[msg.id] = dbCached; // re-hydrate in-memory
        return msg.copyWith(textContent: dbCached);
      }
      // No cached plaintext available — UI shows lock icon
      return msg;
    }

    // Check received cache to avoid re-decrypting (which corrupts session state)
    final cachedReceived = _receivedPlaintextCache[msg.id];
    if (cachedReceived != null) {
      return msg.copyWith(textContent: cachedReceived);
    }
    // Fallback: check persistent DB (survives app restart)
    final dbCachedReceived = await _appDatabase.getDecryptedPlaintext(msg.id);
    if (dbCachedReceived != null) {
      _receivedPlaintextCache[msg.id] = dbCachedReceived; // re-hydrate in-memory
      return msg.copyWith(textContent: dbCachedReceived);
    }

    // Decrypt incoming message from the other participant
    try {
      final encryptedMap = {
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
      final plaintext = await _signalProtocolService.decryptP2P(
        msg.senderId,
        encryptedMap,
      );
      _receivedPlaintextCache[msg.id] = plaintext;
      // Persist to encrypted DB so it survives app restart
      _appDatabase.cacheDecryptedPlaintext(msg.id, plaintext);
      return msg.copyWith(textContent: plaintext);
    } catch (e) {
      final isAlreadyConsumed = e.toString().contains('already consumed');
      debugPrint('E2EE decrypt failed for msg ${msg.id}: $e');

      if (!isAlreadyConsumed) {
        // Session is corrupted — reset it so the next outgoing message
        // triggers a fresh X3DH key exchange.
        debugPrint('E2EE: Resetting corrupted session with ${msg.senderId}');
        await _signalProtocolService.resetSession(msg.senderId);
      }

      return msg.copyWith(textContent: '[Cannot decrypt]');
    }
  }
}
