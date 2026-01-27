import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../models/chat_thread_model.dart';
import '../../models/chat_card_model.dart';

abstract class ChatRemoteDataSource {
  String? get currentUserId;
  Future<List<ChatThreadModel>> getChatThreads();
  Stream<List<ChatThreadModel>> watchChatThreads();
  Future<ChatThreadModel?> getThreadById(String threadId);
  Future<ChatThreadModel> getOrCreateThread({required String participantId});
  Future<List<ChatCardModel>> getMessages({
    required String threadId,
    int? limit,
    DateTime? startAfter,
  });
  Stream<List<ChatCardModel>> watchMessages({
    required String threadId,
    int? limit,
  });
  Future<ChatCardModel> sendTextMessage({
    required String threadId,
    required String text,
  });
  Future<ChatCardModel> sendTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  });
  Future<ChatCardModel> requestTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  });
  Future<ChatCardModel> acceptTokenRequest({required String cardId});
  Future<ChatCardModel> declineTokenRequest({required String cardId});
  Future<void> markAsRead({
    required String threadId,
    required List<String> messageIds,
  });
  Future<void> togglePinThread({
    required String threadId,
    required bool isPinned,
  });
  Future<void> toggleMuteThread({
    required String threadId,
    required bool isMuted,
  });
  Future<void> archiveThread(String threadId);
  Future<int> getTotalUnreadCount();
  Stream<int> watchTotalUnreadCount();
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  ChatRemoteDataSourceImpl(this._firestore, this._firebaseAuth);

  CollectionReference<Map<String, dynamic>> get _threadsCollection =>
      _firestore.collection('chatThreads');

  CollectionReference<Map<String, dynamic>> get _messagesCollection =>
      _firestore.collection('chatMessages');

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<List<ChatThreadModel>> getChatThreads() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final snapshot = await _threadsCollection
          .where('participantIds', arrayContains: userId)
          .where('isArchived', isEqualTo: false)
          .orderBy('lastMessageAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return ChatThreadModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<ChatThreadModel>> watchChatThreads() {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    return _threadsCollection
        .where('participantIds', arrayContains: userId)
        .where('isArchived', isEqualTo: false)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatThreadModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
    });
  }

  @override
  Future<ChatThreadModel?> getThreadById(String threadId) async {
    try {
      final doc = await _threadsCollection.doc(threadId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return ChatThreadModel.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ChatThreadModel> getOrCreateThread({
    required String participantId,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      // Check for existing thread
      final existingQuery = await _threadsCollection
          .where('participantIds', arrayContains: userId)
          .where('type', isEqualTo: 'p2p')
          .get();

      for (final doc in existingQuery.docs) {
        final participants = List<String>.from(doc.data()['participantIds'] ?? []);
        if (participants.contains(participantId) && participants.length == 2) {
          return ChatThreadModel.fromJson({...doc.data(), 'id': doc.id});
        }
      }

      // Get participant info for display name
      final participantDoc = await _usersCollection.doc(participantId).get();
      final participantData = participantDoc.data();
      final participantName = participantData?['displayName'] ?? 'User';

      // Create new thread
      final now = DateTime.now();
      final threadModel = ChatThreadModel(
        id: '',
        type: 'p2p',
        participantIds: [userId, participantId],
        displayName: participantName,
        avatarUrl: participantData?['photoUrl'],
        avatarColor: null,
        lastMessagePreview: null,
        lastMessageAt: null,
        unreadCount: 0,
        isPinned: false,
        isMuted: false,
        isArchived: false,
        createdAt: now,
        updatedAt: null,
      );

      final docRef = await _threadsCollection.add(threadModel.toFirestoreJson());
      return ChatThreadModel(
        id: docRef.id,
        type: 'p2p',
        participantIds: [userId, participantId],
        displayName: participantName,
        avatarUrl: participantData?['photoUrl'],
        avatarColor: null,
        lastMessagePreview: null,
        lastMessageAt: null,
        unreadCount: 0,
        isPinned: false,
        isMuted: false,
        isArchived: false,
        createdAt: now,
        updatedAt: null,
      );
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ChatCardModel>> getMessages({
    required String threadId,
    int? limit,
    DateTime? startAfter,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      var query = _messagesCollection
          .where('threadId', isEqualTo: threadId)
          .orderBy('createdAt', descending: true);

      if (startAfter != null) {
        query = query.startAfter([Timestamp.fromDate(startAfter)]);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        return ChatCardModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<ChatCardModel>> watchMessages({
    required String threadId,
    int? limit,
  }) {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    var query = _messagesCollection
        .where('threadId', isEqualTo: threadId)
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatCardModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
    });
  }

  @override
  Future<ChatCardModel> sendTextMessage({
    required String threadId,
    required String text,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final now = DateTime.now();
      final messageModel = ChatCardModel(
        id: '',
        threadId: threadId,
        senderId: userId,
        type: 'text',
        status: 'pending',
        textContent: text,
        tokenAmount: null,
        mediaUrl: null,
        mediaType: null,
        actionData: null,
        expiresAt: null,
        createdAt: now,
        readAt: null,
        actionedAt: null,
        recipientId: null,
      );

      final docRef = await _messagesCollection.add(messageModel.toFirestoreJson());

      // Update thread with last message
      await _threadsCollection.doc(threadId).update({
        'lastMessagePreview': text.length > 50 ? '${text.substring(0, 50)}...' : text,
        'lastMessageAt': Timestamp.fromDate(now),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return ChatCardModel(
        id: docRef.id,
        threadId: threadId,
        senderId: userId,
        type: 'text',
        status: 'pending',
        textContent: text,
        tokenAmount: null,
        mediaUrl: null,
        mediaType: null,
        actionData: null,
        expiresAt: null,
        createdAt: now,
        readAt: null,
        actionedAt: null,
        recipientId: null,
      );
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ChatCardModel> sendTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final now = DateTime.now();
      final messageModel = ChatCardModel(
        id: '',
        threadId: threadId,
        senderId: userId,
        type: 'tokenSend',
        status: 'paid',
        textContent: message,
        tokenAmount: amount,
        mediaUrl: null,
        mediaType: null,
        actionData: null,
        expiresAt: null,
        createdAt: now,
        readAt: null,
        actionedAt: now,
        recipientId: recipientId,
      );

      final docRef = await _messagesCollection.add(messageModel.toFirestoreJson());

      // Update thread with last message
      await _threadsCollection.doc(threadId).update({
        'lastMessagePreview': 'Sent $amount tokens',
        'lastMessageAt': Timestamp.fromDate(now),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return ChatCardModel(
        id: docRef.id,
        threadId: threadId,
        senderId: userId,
        type: 'tokenSend',
        status: 'paid',
        textContent: message,
        tokenAmount: amount,
        mediaUrl: null,
        mediaType: null,
        actionData: null,
        expiresAt: null,
        createdAt: now,
        readAt: null,
        actionedAt: now,
        recipientId: recipientId,
      );
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ChatCardModel> requestTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final now = DateTime.now();
      // Requests expire in 7 days
      final expiresAt = now.add(const Duration(days: 7));

      final messageModel = ChatCardModel(
        id: '',
        threadId: threadId,
        senderId: userId,
        type: 'tokenRequest',
        status: 'pending',
        textContent: message,
        tokenAmount: amount,
        mediaUrl: null,
        mediaType: null,
        actionData: null,
        expiresAt: expiresAt,
        createdAt: now,
        readAt: null,
        actionedAt: null,
        recipientId: recipientId,
      );

      final docRef = await _messagesCollection.add(messageModel.toFirestoreJson());

      // Update thread with last message
      await _threadsCollection.doc(threadId).update({
        'lastMessagePreview': 'Requested $amount tokens',
        'lastMessageAt': Timestamp.fromDate(now),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return ChatCardModel(
        id: docRef.id,
        threadId: threadId,
        senderId: userId,
        type: 'tokenRequest',
        status: 'pending',
        textContent: message,
        tokenAmount: amount,
        mediaUrl: null,
        mediaType: null,
        actionData: null,
        expiresAt: expiresAt,
        createdAt: now,
        readAt: null,
        actionedAt: null,
        recipientId: recipientId,
      );
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ChatCardModel> acceptTokenRequest({required String cardId}) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final doc = await _messagesCollection.doc(cardId).get();
      if (!doc.exists) {
        throw const ServerException(message: 'Message not found');
      }

      final data = doc.data()!;
      final now = DateTime.now();

      await _messagesCollection.doc(cardId).update({
        'status': 'paid',
        'actionedAt': Timestamp.fromDate(now),
      });

      return ChatCardModel.fromJson({
        ...data,
        'id': doc.id,
        'status': 'paid',
        'actionedAt': now,
      });
    } catch (e) {
      if (e is ServerException || e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ChatCardModel> declineTokenRequest({required String cardId}) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final doc = await _messagesCollection.doc(cardId).get();
      if (!doc.exists) {
        throw const ServerException(message: 'Message not found');
      }

      final data = doc.data()!;
      final now = DateTime.now();

      await _messagesCollection.doc(cardId).update({
        'status': 'declined',
        'actionedAt': Timestamp.fromDate(now),
      });

      return ChatCardModel.fromJson({
        ...data,
        'id': doc.id,
        'status': 'declined',
        'actionedAt': now,
      });
    } catch (e) {
      if (e is ServerException || e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> markAsRead({
    required String threadId,
    required List<String> messageIds,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final batch = _firestore.batch();
      final now = Timestamp.fromDate(DateTime.now());

      for (final messageId in messageIds) {
        batch.update(_messagesCollection.doc(messageId), {
          'readAt': now,
        });
      }

      // Reset unread count for this user's view
      batch.update(_threadsCollection.doc(threadId), {
        'unreadCount': 0,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> togglePinThread({
    required String threadId,
    required bool isPinned,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      await _threadsCollection.doc(threadId).update({
        'isPinned': isPinned,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> toggleMuteThread({
    required String threadId,
    required bool isMuted,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      await _threadsCollection.doc(threadId).update({
        'isMuted': isMuted,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> archiveThread(String threadId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      await _threadsCollection.doc(threadId).update({
        'isArchived': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<int> getTotalUnreadCount() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final snapshot = await _threadsCollection
          .where('participantIds', arrayContains: userId)
          .where('isArchived', isEqualTo: false)
          .get();

      int totalUnread = 0;
      for (final doc in snapshot.docs) {
        totalUnread += (doc.data()['unreadCount'] as int?) ?? 0;
      }
      return totalUnread;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<int> watchTotalUnreadCount() {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    return _threadsCollection
        .where('participantIds', arrayContains: userId)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      int totalUnread = 0;
      for (final doc in snapshot.docs) {
        totalUnread += (doc.data()['unreadCount'] as int?) ?? 0;
      }
      return totalUnread;
    });
  }
}
