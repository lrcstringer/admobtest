import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../models/conversation_model.dart';
import '../../models/message_model.dart';

/// Abstract interface for conversation data operations
abstract class ConversationRemoteDataSource {
  String? get currentUserId;

  // Conversation list
  Future<List<ConversationModel>> getConversations();
  Stream<List<ConversationModel>> watchConversations();
  Future<ConversationModel> getOrCreateConversation({
    required String participantId,
  });
  Future<ConversationModel?> getConversationById(String id);

  // User search (via Cloud Function)
  Future<List<Map<String, dynamic>>> searchUsers(
    String query, {
    String? accountTypeId,
  });

  // Messages (read from subcollection, write via Cloud Functions)
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int? limit,
    DateTime? before,
  });
  Stream<List<MessageModel>> watchMessages({
    required String conversationId,
    int? limit,
  });
  @Deprecated('Use sendEncryptedMessage for P2P conversations. '
      'Plaintext send is no longer supported for E2EE conversations.')
  Future<MessageModel> sendTextMessage({
    required String conversationId,
    required String text,
    String? replyToMessageId,
  });
  Future<String> sendEncryptedMessage({
    required String conversationId,
    required String ciphertext,
    required Map<String, dynamic> e2ee,
    Map<String, dynamic>? x3dhHeader,
    String? replyToMessageId,
    String? messageType,
  });
  Future<MessageModel> sendMediaMessage({
    required String conversationId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  });

  // Token operations (via Cloud Functions)
  Future<MessageModel> sendTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? encryptedMessage,
    Map<String, dynamic>? messageE2ee,
    Map<String, dynamic>? messageX3dh,
    String? subAccountId,
  });
  Future<MessageModel> requestTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? encryptedMessage,
    Map<String, dynamic>? messageE2ee,
    Map<String, dynamic>? messageX3dh,
    String? subAccountId,
  });
  Future<MessageModel> acceptTokenRequest({
    required String messageId,
    required String conversationId,
  });
  Future<MessageModel> declineTokenRequest({
    required String messageId,
    required String conversationId,
  });

  // Thread management (via Cloud Functions)
  Future<void> markAsRead({required String conversationId});
  Future<void> togglePin({
    required String conversationId,
    required bool pinned,
  });
  Future<void> toggleMute({
    required String conversationId,
    required bool muted,
  });
  Future<void> archiveConversation(String conversationId);

  // Message requests (via Cloud Functions)
  Future<void> acceptConversationRequest({required String conversationId});

  // Message deletion (via Cloud Functions)
  Future<void> deleteMessageForEveryone({
    required String conversationId,
    required String messageId,
  });
  Future<void> clearChat({required String conversationId});

  // Reactions (via Cloud Functions)
  Future<void> addReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  });
  Future<void> removeReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  });

  // Unread count
  Future<int> getTotalUnreadCount();
  Stream<int> watchTotalUnreadCount();

  // Typing indicators (direct Firestore writes — ephemeral data)
  Future<void> setTyping({
    required String conversationId,
    required bool isTyping,
  });
  Stream<Map<String, bool>> watchTypingState({
    required String conversationId,
  });

  // Disappearing messages
  Future<void> setDisappearingMessages({
    required String conversationId,
    required int? durationMs,
  });

  // Message forwarding (via Cloud Function)
  Future<String> forwardMessage({
    required String sourceConversationId,
    required String sourceMessageId,
    required String targetConversationId,
    String? ciphertext,
    Map<String, dynamic>? e2ee,
    Map<String, dynamic>? x3dhHeader,
  });

  // E2EE session renegotiation
  Future<void> requestSessionReset({
    required String conversationId,
    required String targetUserId,
  });
  Future<void> clearSessionReset({required String conversationId});

  // E2EE key lookup
  Future<String?> getUserE2eeIdentityKey(String userId);
}

@LazySingleton(as: ConversationRemoteDataSource)
class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  ConversationRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _conversationsCollection =>
      _firestore.collection('conversations');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  String _requireUserId() {
    final uid = currentUserId;
    if (uid == null) {
      throw const AuthException(message: 'User not authenticated');
    }
    return uid;
  }

  // =========================================================================
  // CONVERSATION LIST
  // =========================================================================

  /// Track which conversations have already been healed this session
  /// to avoid redundant writes.
  final Set<String> _healedConversationIds = {};

  @override
  Future<List<ConversationModel>> getConversations() async {
    final userId = _requireUserId();
    try {
      final snapshot = await _conversationsCollection
          .where('participantIds', arrayContains: userId)
          .orderBy('lastMessageAt', descending: true)
          .get();

      final conversations = _deduplicateConversations(
        snapshot.docs
            .map((doc) => ConversationModel.fromFirestore(doc))
            .toList(),
        userId,
      );

      // Clear healed set on explicit refresh so stale data can be re-healed
      _healedConversationIds.clear();

      // Self-heal stale participant data (fire-and-forget)
      _healStaleParticipants(conversations);

      return conversations;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<ConversationModel>> watchConversations() {
    final userId = _requireUserId();
    return _conversationsCollection
        .where('participantIds', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final raw = snapshot.docs
          .map((doc) => ConversationModel.fromFirestore(doc))
          .toList();

      final conversations = _deduplicateConversations(raw, userId);

      // Self-heal on first snapshot (fire-and-forget)
      _healStaleParticipants(conversations);

      return conversations;
    });
  }

  /// Deduplicate P2P conversations that share the same participant pair.
  /// Keeps the one with the most recent message (or earliest creation as tiebreak).
  List<ConversationModel> _deduplicateConversations(
    List<ConversationModel> conversations,
    String currentUserId,
  ) {
    final seen = <String, ConversationModel>{};
    for (final conv in conversations) {
      if (conv.type != 'p2p') {
        // Non-P2P conversations can't be duplicated this way
        seen[conv.id] = conv;
        continue;
      }
      final otherIds = conv.participantIds.where((id) => id != currentUserId);
      final key = otherIds.isNotEmpty ? otherIds.first : conv.id;
      final existing = seen[key];
      if (existing == null) {
        seen[key] = conv;
      } else {
        // Keep the one with the most recent message
        final existingTime = existing.lastMessageAt ?? existing.createdAt;
        final convTime = conv.lastMessageAt ?? conv.createdAt;
        if (convTime.isAfter(existingTime)) {
          seen[key] = conv;
        }
      }
    }
    return seen.values.toList();
  }

  /// Check conversations for participants with null avatarUrl.
  /// For any found, look up the user document and patch the conversation.
  /// This self-heals stale denormalized data from before the
  /// syncUserProfileToConversations trigger was deployed.
  void _healStaleParticipants(List<ConversationModel> conversations) {
    // Collect conversation+participant pairs that need healing
    final staleEntries = <MapEntry<String, String>>[]; // convId -> userId
    for (final conv in conversations) {
      if (_healedConversationIds.contains(conv.id)) continue;
      for (final entry in conv.participants.entries) {
        final url = entry.value['avatarUrl'];
        if (url == null || (url is String && url.isEmpty)) {
          staleEntries.add(MapEntry(conv.id, entry.key));
        }
      }
    }

    if (staleEntries.isEmpty) return;

    // Dedupe user IDs to look up
    final userIdsToLookup = staleEntries.map((e) => e.value).toSet();

    // Fire-and-forget: look up users and patch conversations
    _doHeal(userIdsToLookup, staleEntries);
  }

  Future<void> _doHeal(
    Set<String> userIds,
    List<MapEntry<String, String>> staleEntries,
  ) async {
    try {
      // Build patches list for the Cloud Function
      // (client can't write to conversations — security rules block it)
      final patches = staleEntries
          .map((e) => {
                'conversationId': e.key,
                'participantId': e.value,
              })
          .toList();

      final result = await _functions
          .httpsCallable('healConversationAvatars')
          .call({'patches': patches});

      final healed = result.data['healed'] as int? ?? 0;

      // Mark all as healed so we don't retry this session
      for (final stale in staleEntries) {
        _healedConversationIds.add(stale.key);
      }

      if (healed > 0) {
        developer.log(
          'Healed $healed conversation avatar(s) via Cloud Function',
          name: 'ConversationDS',
        );
      }
    } catch (e) {
      // Self-healing is best-effort; log but don't crash
      developer.log(
        'Avatar self-healing failed: $e',
        name: 'ConversationDS',
      );
    }
  }

  @override
  Future<ConversationModel> getOrCreateConversation({
    required String participantId,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('getOrCreateConversation');
      final result = await callable.call<Map<String, dynamic>>({
        'participantId': participantId,
      });

      final data = deepConvertMap(result.data);
      final conversation = data['conversation'] as Map<String, dynamic>? ?? data;
      return ConversationModel.fromJson(Map<String, dynamic>.from(conversation));
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to get conversation');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ConversationModel?> getConversationById(String id) async {
    _requireUserId();
    try {
      final doc = await _conversationsCollection.doc(id).get();
      if (!doc.exists || doc.data() == null) return null;
      return ConversationModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // USER SEARCH
  // =========================================================================

  @override
  Future<List<Map<String, dynamic>>> searchUsers(
    String query, {
    String? accountTypeId,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('searchUsers');
      final result = await callable.call<Map<String, dynamic>>({
        'query': query,
        if (accountTypeId != null) 'accountTypeId': accountTypeId,
      });

      final data = result.data;
      final users = (data['users'] as List<dynamic>?) ?? [];
      return users
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to search users');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // MESSAGES
  // =========================================================================

  @override
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int? limit,
    DateTime? before,
  }) async {
    _requireUserId();
    try {
      var query = _conversationsCollection
          .doc(conversationId)
          .collection('messages')
          .orderBy('createdAt', descending: true);

      if (before != null) {
        query = query.startAfter([Timestamp.fromDate(before)]);
      }
      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      final messages = <MessageModel>[];
      for (final doc in snapshot.docs) {
        try {
          messages.add(MessageModel.fromFirestore(doc));
        } catch (e) {
          developer.log(
            'Skipping malformed message ${doc.id}: $e',
            name: 'ConversationDS',
          );
        }
      }
      return messages;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<MessageModel>> watchMessages({
    required String conversationId,
    int? limit,
  }) {
    _requireUserId();
    var query = _conversationsCollection
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final messages = <MessageModel>[];
      for (final doc in snapshot.docs) {
        try {
          messages.add(MessageModel.fromFirestore(doc));
        } catch (e) {
          // Skip individual malformed messages instead of failing the batch
          developer.log(
            'Skipping malformed message ${doc.id}: $e',
            name: 'ConversationDS',
          );
        }
      }
      return messages;
    });
  }

  @override
  Future<MessageModel> sendTextMessage({
    required String conversationId,
    required String text,
    String? replyToMessageId,
  }) async {
    final userId = _requireUserId();
    try {
      final callable = _functions.httpsCallable('sendConversationMessage');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'text': text,
        if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      });

      // Cloud Function returns { success, messageId } — not a full message.
      // Return a minimal optimistic model; the real message arrives via watchMessages.
      final data = result.data;
      final messageId = data['messageId'] as String? ?? '';
      return MessageModel.optimistic(
        localId: messageId,
        senderId: userId,
        senderName: '',
        type: 'text',
        textContent: text,
      );
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to send message');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> sendEncryptedMessage({
    required String conversationId,
    required String ciphertext,
    required Map<String, dynamic> e2ee,
    Map<String, dynamic>? x3dhHeader,
    String? replyToMessageId,
    String? messageType,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('sendConversationMessage');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'ciphertext': ciphertext,
        'e2ee': e2ee,
        if (x3dhHeader != null) 'x3dhHeader': x3dhHeader,
        if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
        if (messageType != null) 'messageType': messageType,
      });
      final data = result.data;
      return data['messageId'] as String? ?? '';
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to send encrypted message');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MessageModel> sendMediaMessage({
    required String conversationId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) async {
    final userId = _requireUserId();
    try {
      final callable = _functions.httpsCallable('sendConversationMessage');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        if (caption != null) 'text': caption,
      });

      final data = result.data;
      final messageId = data['messageId'] as String? ?? '';
      return MessageModel.optimistic(
        localId: messageId,
        senderId: userId,
        senderName: '',
        type: mediaType.startsWith('audio') ? 'voice' : 'image',
        media: {'url': mediaUrl, 'mimeType': mediaType},
      );
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to send media');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // TOKEN OPERATIONS
  // =========================================================================

  @override
  Future<MessageModel> sendTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? encryptedMessage,
    Map<String, dynamic>? messageE2ee,
    Map<String, dynamic>? messageX3dh,
    String? subAccountId,
  }) async {
    final userId = _requireUserId();
    try {
      final nonce = _playIntegrity.generateNonce();
      final integrityToken =
          await _playIntegrity.getIntegrityToken(nonce: nonce);

      final callable = _functions.httpsCallable('sendConversationTokens');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'recipientId': recipientId,
        'amount': amount,
        if (encryptedMessage != null) 'encryptedMessage': encryptedMessage,
        if (messageE2ee != null) 'messageE2ee': messageE2ee,
        if (messageX3dh != null) 'messageX3dh': messageX3dh,
        if (subAccountId != null)
          'senderSubAccountId': subAccountId,
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final data = deepConvertMap(result.data);
      if (data.containsKey('messageId') && !data.containsKey('senderId')) {
        return MessageModel.optimistic(
          localId: data['messageId'] as String,
          senderId: userId,
          senderName: '',
          type: 'tokenSend',
          tokenAmount: amount,
          recipientId: recipientId,
        );
      }
      return MessageModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Token transfer failed');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MessageModel> requestTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? encryptedMessage,
    Map<String, dynamic>? messageE2ee,
    Map<String, dynamic>? messageX3dh,
    String? subAccountId,
  }) async {
    final userId = _requireUserId();
    try {
      final callable = _functions.httpsCallable('requestConversationTokens');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'recipientId': recipientId,
        'amount': amount,
        if (encryptedMessage != null) 'encryptedMessage': encryptedMessage,
        if (messageE2ee != null) 'messageE2ee': messageE2ee,
        if (messageX3dh != null) 'messageX3dh': messageX3dh,
        if (subAccountId != null)
          'senderSubAccountId': subAccountId,
      });

      final data = deepConvertMap(result.data);
      if (data.containsKey('messageId') && !data.containsKey('senderId')) {
        return MessageModel.optimistic(
          localId: data['messageId'] as String,
          senderId: userId,
          senderName: '',
          type: 'tokenRequest',
          tokenAmount: amount,
          recipientId: recipientId,
        );
      }
      return MessageModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Token request failed');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MessageModel> acceptTokenRequest({
    required String messageId,
    required String conversationId,
  }) async {
    _requireUserId();
    try {
      final nonce = _playIntegrity.generateNonce();
      final integrityToken =
          await _playIntegrity.getIntegrityToken(nonce: nonce);

      final callable =
          _functions.httpsCallable('acceptConversationTokenRequest');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'messageId': messageId,
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final data = deepConvertMap(result.data);
      return MessageModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to accept token request');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MessageModel> declineTokenRequest({
    required String messageId,
    required String conversationId,
  }) async {
    _requireUserId();
    try {
      final callable =
          _functions.httpsCallable('declineConversationTokenRequest');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'messageId': messageId,
      });

      final data = deepConvertMap(result.data);
      return MessageModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to decline token request');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // THREAD MANAGEMENT
  // =========================================================================

  @override
  Future<void> markAsRead({required String conversationId}) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('markConversationRead');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to mark as read');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> togglePin({
    required String conversationId,
    required bool pinned,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('toggleConversationPin');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'pinned': pinned,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to toggle pin');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> toggleMute({
    required String conversationId,
    required bool muted,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('toggleConversationMute');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'muted': muted,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to toggle mute');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> archiveConversation(String conversationId) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('archiveConversation');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to archive');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // MESSAGE REQUESTS
  // =========================================================================

  @override
  Future<void> acceptConversationRequest({
    required String conversationId,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('acceptConversationRequest');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to accept conversation');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // MESSAGE DELETION
  // =========================================================================

  @override
  Future<void> deleteMessageForEveryone({
    required String conversationId,
    required String messageId,
  }) async {
    _requireUserId();
    try {
      final callable =
          _functions.httpsCallable('deleteConversationMessage');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'messageId': messageId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to delete message');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> clearChat({required String conversationId}) async {
    _requireUserId();
    try {
      final callable =
          _functions.httpsCallable('clearConversationChat');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to clear chat');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // REACTIONS
  // =========================================================================

  @override
  Future<void> addReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('toggleMessageReaction');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'messageId': messageId,
        'emoji': emoji,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to add reaction');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> removeReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) async {
    _requireUserId();
    try {
      // Same CF — toggles on/off
      final callable = _functions.httpsCallable('toggleMessageReaction');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'messageId': messageId,
        'emoji': emoji,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to remove reaction');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  @override
  Future<int> getTotalUnreadCount() async {
    final userId = _requireUserId();
    try {
      final snapshot = await _conversationsCollection
          .where('participantIds', arrayContains: userId)
          .get();

      int total = 0;
      for (final doc in snapshot.docs) {
        final unreadCounts = doc.data()['unreadCounts'];
        if (unreadCounts is Map) {
          total += (unreadCounts[userId] as int?) ?? 0;
        }
      }
      return total;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<int> watchTotalUnreadCount() {
    final userId = _requireUserId();
    return _conversationsCollection
        .where('participantIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      int total = 0;
      for (final doc in snapshot.docs) {
        final unreadCounts = doc.data()['unreadCounts'];
        if (unreadCounts is Map) {
          total += (unreadCounts[userId] as int?) ?? 0;
        }
      }
      return total;
    });
  }

  @override
  Future<String?> getUserE2eeIdentityKey(String userId) async {
    // Read from users/{userId}/keys/bundle instead of users/{userId}.
    // Firestore rules allow any authenticated user to read the keys/bundle
    // subcollection, but restrict the user document to owner-only reads.
    // The 'identityKey' field is set by the uploadKeyBundle Cloud Function.
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('keys')
        .doc('bundle')
        .get();
    if (!doc.exists) return null;
    return doc.data()?['identityKey'] as String?;
  }

  // =========================================================================
  // E2EE SESSION RENEGOTIATION
  // =========================================================================

  @override
  Future<void> requestSessionReset({
    required String conversationId,
    required String targetUserId,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('requestSessionReset');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'targetUserId': targetUserId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
        message: e.message ?? 'Failed to request session reset',
        code: e.code,
      );
    }
  }

  @override
  Future<void> clearSessionReset({required String conversationId}) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('clearSessionReset');
      await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
        message: e.message ?? 'Failed to clear session reset',
        code: e.code,
      );
    }
  }

  // =========================================================================
  // TYPING INDICATORS
  // =========================================================================

  @override
  Future<void> setTyping({
    required String conversationId,
    required bool isTyping,
  }) async {
    final userId = _requireUserId();
    final typingRef = _conversationsCollection
        .doc(conversationId)
        .collection('typing')
        .doc(userId);

    if (isTyping) {
      await typingRef.set({
        'isTyping': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await typingRef.delete();
    }
  }

  @override
  Stream<Map<String, bool>> watchTypingState({
    required String conversationId,
  }) {
    final userId = _requireUserId();
    return _conversationsCollection
        .doc(conversationId)
        .collection('typing')
        .snapshots()
        .map((snapshot) {
      final result = <String, bool>{};
      final cutoff = DateTime.now().subtract(const Duration(seconds: 5));
      for (final doc in snapshot.docs) {
        if (doc.id == userId) continue; // Exclude own typing state
        final data = doc.data();
        final isTyping = data['isTyping'] as bool? ?? false;
        final updatedAt = data['updatedAt'];
        // Auto-expire stale entries
        if (isTyping && updatedAt is Timestamp) {
          if (updatedAt.toDate().isAfter(cutoff)) {
            result[doc.id] = true;
          }
        }
      }
      return result;
    });
  }

  // =========================================================================
  // DISAPPEARING MESSAGES
  // =========================================================================

  @override
  Future<void> setDisappearingMessages({
    required String conversationId,
    required int? durationMs,
  }) async {
    _requireUserId();
    try {
      await _functions
          .httpsCallable('setDisappearingMessages')
          .call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'durationMs': durationMs,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to set disappearing messages');
    }
  }

  // =========================================================================
  // MESSAGE FORWARDING
  // =========================================================================

  @override
  Future<String> forwardMessage({
    required String sourceConversationId,
    required String sourceMessageId,
    required String targetConversationId,
    String? ciphertext,
    Map<String, dynamic>? e2ee,
    Map<String, dynamic>? x3dhHeader,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('forwardConversationMessage')
          .call<Map<String, dynamic>>({
        'sourceConversationId': sourceConversationId,
        'sourceMessageId': sourceMessageId,
        'targetConversationId': targetConversationId,
        'ciphertext': ciphertext,
        'e2ee': e2ee,
        'x3dhHeader': x3dhHeader,
      });
      return result.data['messageId'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to forward message');
    }
  }
}
