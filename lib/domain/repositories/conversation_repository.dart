import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/conversation.dart';
import '../entities/message.dart';
import '../value_objects/user_search_result.dart';

/// Parameters for creating a conversation (future-proofing for brand/system types)
class CreateConversationParams {
  final String participantId;

  const CreateConversationParams({required this.participantId});

  Map<String, dynamic> toJson() => {'participantId': participantId};
}

/// Conversation repository interface
///
/// Defines the contract for P2P direct messaging operations including:
/// - Conversation list management (inbox)
/// - Message CRUD and streaming
/// - Token transfers within conversations
/// - Thread management (pin, mute, archive)
/// - Reactions
abstract class ConversationRepository {
  // =========================================================================
  // CONVERSATION LIST (INBOX)
  // =========================================================================

  /// Get all conversations for the current user
  Future<Either<Failure, List<Conversation>>> getConversations();

  /// Watch conversations in real-time (for inbox updates)
  Stream<Either<Failure, List<Conversation>>> watchConversations();

  /// Get or create a P2P conversation with another user
  Future<Either<Failure, Conversation>> getOrCreateConversation({
    required String participantId,
  });

  /// Get a single conversation by ID
  Future<Either<Failure, Conversation>> getConversationById(String id);

  /// Search for users by display name or username
  Future<Either<Failure, List<UserSearchResult>>> searchUsers(String query);

  // =========================================================================
  // MESSAGES
  // =========================================================================

  /// Get messages for a conversation (paginated)
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int? limit,
    DateTime? before,
  });

  /// Watch messages in real-time (latest page)
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String conversationId,
    int? limit,
  });

  /// Send a text message
  Future<Either<Failure, Message>> sendTextMessage({
    required String conversationId,
    required String text,
    String? replyToMessageId,
  });

  /// Send a media message (image or voice)
  Future<Either<Failure, Message>> sendMediaMessage({
    required String conversationId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  });

  // =========================================================================
  // TOKEN OPERATIONS
  // =========================================================================

  /// Send tokens to another user in a conversation
  Future<Either<Failure, Message>> sendTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
  });

  /// Request tokens from another user in a conversation
  Future<Either<Failure, Message>> requestTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
  });

  /// Accept an incoming token request
  Future<Either<Failure, Message>> acceptTokenRequest({
    required String messageId,
    required String conversationId,
  });

  /// Decline an incoming token request
  Future<Either<Failure, Message>> declineTokenRequest({
    required String messageId,
    required String conversationId,
  });

  // =========================================================================
  // THREAD MANAGEMENT
  // =========================================================================

  /// Mark all messages in a conversation as read
  Future<Either<Failure, void>> markAsRead({required String conversationId});

  /// Pin or unpin a conversation
  Future<Either<Failure, void>> togglePin({
    required String conversationId,
    required bool pinned,
  });

  /// Mute or unmute a conversation
  Future<Either<Failure, void>> toggleMute({
    required String conversationId,
    required bool muted,
  });

  /// Archive a conversation
  Future<Either<Failure, void>> archiveConversation(String conversationId);

  // =========================================================================
  // REACTIONS
  // =========================================================================

  /// Add a reaction to a message
  Future<Either<Failure, void>> addReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  });

  /// Remove a reaction from a message
  Future<Either<Failure, void>> removeReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  });

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  /// Get total unread count across all conversations
  Future<Either<Failure, int>> getTotalUnreadCount();

  /// Watch total unread count in real-time (for tab badge)
  Stream<Either<Failure, int>> watchTotalUnreadCount();
}
