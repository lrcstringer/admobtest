import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/chat_thread.dart';
import '../entities/chat_card.dart';

/// @deprecated Use [ConversationRepository] instead. Will be removed in a future cleanup PR.
abstract class ChatRepository {
  /// Get all chat threads
  Future<Either<Failure, List<ChatThread>>> getChatThreads();

  /// Stream chat threads
  Stream<Either<Failure, List<ChatThread>>> watchChatThreads();

  /// Get thread by ID
  Future<Either<Failure, ChatThread>> getThreadById(String threadId);

  /// Get or create thread with user
  Future<Either<Failure, ChatThread>> getOrCreateThread({
    required String participantId,
  });

  /// Get messages for thread
  Future<Either<Failure, List<ChatCard>>> getMessages({
    required String threadId,
    int? limit,
    DateTime? startAfter,
  });

  /// Stream messages for thread
  Stream<Either<Failure, List<ChatCard>>> watchMessages({
    required String threadId,
    int? limit,
  });

  /// Send text message
  Future<Either<Failure, ChatCard>> sendTextMessage({
    required String threadId,
    required String text,
  });

  /// Send tokens
  Future<Either<Failure, ChatCard>> sendTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  });

  /// Request tokens
  Future<Either<Failure, ChatCard>> requestTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  });

  /// Accept token request
  Future<Either<Failure, ChatCard>> acceptTokenRequest({
    required String cardId,
  });

  /// Decline token request
  Future<Either<Failure, ChatCard>> declineTokenRequest({
    required String cardId,
  });

  /// Mark messages as read
  Future<Either<Failure, void>> markAsRead({
    required String threadId,
    required List<String> messageIds,
  });

  /// Pin/unpin thread
  Future<Either<Failure, void>> togglePinThread({
    required String threadId,
    required bool isPinned,
  });

  /// Mute/unmute thread
  Future<Either<Failure, void>> toggleMuteThread({
    required String threadId,
    required bool isMuted,
  });

  /// Archive thread
  Future<Either<Failure, void>> archiveThread(String threadId);

  /// Get total unread count
  Future<Either<Failure, int>> getTotalUnreadCount();

  /// Stream total unread count
  Stream<Either<Failure, int>> watchTotalUnreadCount();
}
