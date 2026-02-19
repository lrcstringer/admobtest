import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/chat_thread.dart';
import '../../domain/entities/chat_card.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/remote/chat_remote_datasource.dart';

// DEPRECATED: Use ConversationRepositoryImpl instead. Will be removed in a future cleanup PR.
@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ChatThread>>> getChatThreads() async {
    try {
      final threads = await _remoteDataSource.getChatThreads();
      return Right(threads.map((t) => t.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ChatThread>>> watchChatThreads() {
    return _remoteDataSource.watchChatThreads().map((threads) {
      return Right<Failure, List<ChatThread>>(
        threads.map((t) => t.toEntity()).toList(),
      );
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<ChatThread>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<ChatThread>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, ChatThread>> getThreadById(String threadId) async {
    try {
      final thread = await _remoteDataSource.getThreadById(threadId);
      if (thread == null) {
        return Left(Failure.serverError(message: 'Thread not found'));
      }
      return Right(thread.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatThread>> getOrCreateThread({
    required String participantId,
  }) async {
    try {
      final thread = await _remoteDataSource.getOrCreateThread(
        participantId: participantId,
      );
      return Right(thread.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatCard>>> getMessages({
    required String threadId,
    int? limit,
    DateTime? startAfter,
  }) async {
    try {
      final messages = await _remoteDataSource.getMessages(
        threadId: threadId,
        limit: limit,
        startAfter: startAfter,
      );
      return Right(messages.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ChatCard>>> watchMessages({
    required String threadId,
    int? limit,
  }) {
    return _remoteDataSource
        .watchMessages(threadId: threadId, limit: limit)
        .map((messages) {
      return Right<Failure, List<ChatCard>>(
        messages.map((m) => m.toEntity()).toList(),
      );
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<ChatCard>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<ChatCard>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, ChatCard>> sendTextMessage({
    required String threadId,
    required String text,
  }) async {
    try {
      final message = await _remoteDataSource.sendTextMessage(
        threadId: threadId,
        text: text,
      );
      return Right(message.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatCard>> sendTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  }) async {
    try {
      final card = await _remoteDataSource.sendTokens(
        threadId: threadId,
        recipientId: recipientId,
        amount: amount,
        message: message,
      );
      return Right(card.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatCard>> requestTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  }) async {
    try {
      final card = await _remoteDataSource.requestTokens(
        threadId: threadId,
        recipientId: recipientId,
        amount: amount,
        message: message,
      );
      return Right(card.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatCard>> acceptTokenRequest({
    required String cardId,
  }) async {
    try {
      final card = await _remoteDataSource.acceptTokenRequest(cardId: cardId);
      return Right(card.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatCard>> declineTokenRequest({
    required String cardId,
  }) async {
    try {
      final card = await _remoteDataSource.declineTokenRequest(cardId: cardId);
      return Right(card.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead({
    required String threadId,
    required List<String> messageIds,
  }) async {
    try {
      await _remoteDataSource.markAsRead(
        threadId: threadId,
        messageIds: messageIds,
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
  Future<Either<Failure, void>> togglePinThread({
    required String threadId,
    required bool isPinned,
  }) async {
    try {
      await _remoteDataSource.togglePinThread(
        threadId: threadId,
        isPinned: isPinned,
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
  Future<Either<Failure, void>> toggleMuteThread({
    required String threadId,
    required bool isMuted,
  }) async {
    try {
      await _remoteDataSource.toggleMuteThread(
        threadId: threadId,
        isMuted: isMuted,
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
  Future<Either<Failure, void>> archiveThread(String threadId) async {
    try {
      await _remoteDataSource.archiveThread(threadId);
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
        return const Left<Failure, int>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, int>(
        Failure.serverError(message: error.toString()),
      );
    });
  }
}
