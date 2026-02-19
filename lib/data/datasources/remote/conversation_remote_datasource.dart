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
  Future<List<Map<String, dynamic>>> searchUsers(String query);

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
    Map<String, String>? encryptedPreviews,
    String? replyToMessageId,
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
    String? message,
  });
  Future<MessageModel> requestTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
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

  @override
  Future<List<ConversationModel>> getConversations() async {
    final userId = _requireUserId();
    try {
      final snapshot = await _conversationsCollection
          .where('participantIds', arrayContains: userId)
          .orderBy('lastMessageAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ConversationModel.fromFirestore(doc))
          .toList();
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
      return snapshot.docs
          .map((doc) => ConversationModel.fromFirestore(doc))
          .toList();
    });
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
  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('searchUsers');
      final result = await callable.call<Map<String, dynamic>>({
        'query': query,
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
      return snapshot.docs
          .map((doc) => MessageModel.fromFirestore(doc))
          .toList();
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
      return snapshot.docs
          .map((doc) => MessageModel.fromFirestore(doc))
          .toList();
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
    Map<String, String>? encryptedPreviews,
    String? replyToMessageId,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('sendConversationMessage');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'ciphertext': ciphertext,
        'e2ee': e2ee,
        if (x3dhHeader != null) 'x3dhHeader': x3dhHeader,
        if (encryptedPreviews != null) 'encryptedPreviews': encryptedPreviews,
        if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
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
    String? message,
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
        if (message != null) 'message': message,
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final data = deepConvertMap(result.data);
      // If CF returns only success + messageId, build optimistic model
      if (data.containsKey('messageId') && !data.containsKey('senderId')) {
        return MessageModel.optimistic(
          localId: data['messageId'] as String,
          senderId: userId,
          senderName: '',
          type: 'tokenSend',
          textContent: message,
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
    String? message,
  }) async {
    final userId = _requireUserId();
    try {
      final callable = _functions.httpsCallable('requestConversationTokens');
      final result = await callable.call<Map<String, dynamic>>({
        'conversationId': conversationId,
        'recipientId': recipientId,
        'amount': amount,
        if (message != null) 'message': message,
      });

      final data = deepConvertMap(result.data);
      if (data.containsKey('messageId') && !data.containsKey('senderId')) {
        return MessageModel.optimistic(
          localId: data['messageId'] as String,
          senderId: userId,
          senderName: '',
          type: 'tokenRequest',
          textContent: message,
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
}
