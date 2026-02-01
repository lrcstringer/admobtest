import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/firestore_helpers.dart';
import '../../models/wallet_model.dart';
import '../../models/transaction_model.dart';
import '../../models/earn_thread_model.dart';
import '../../models/chat_thread_model.dart';
import '../../../domain/entities/contact.dart';

/// Remote data source for sync operations
class SyncRemoteDataSource {
  final FirebaseFirestore _firestore;

  SyncRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetch user's wallet from Firestore
  Future<WalletModel?> fetchWallet(String userId) async {
    final query = await _firestore
        .collection('wallets')
        .where('oddienceUserId', isEqualTo: userId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      return null;
    }

    return WalletModel.fromJson(sanitizeFirestoreData(query.docs.first.data()));
  }

  /// Fetch transactions since a given timestamp
  Future<List<TransactionModel>> fetchTransactionsSince(
    String userId,
    DateTime? since,
  ) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('transactions')
        .where('oddienceUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(100);

    if (since != null) {
      query = query.where(
        'createdAt',
        isGreaterThan: Timestamp.fromDate(since),
      );
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => TransactionModel.fromJson(sanitizeFirestoreData(doc.data())))
        .toList();
  }

  /// Fetch earn threads since a given timestamp
  Future<List<EarnThreadModel>> fetchEarnThreadsSince(
    String userId,
    DateTime? since,
  ) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('earnThreads')
        .where('oddienceUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50);

    if (since != null) {
      query = query.where(
        'createdAt',
        isGreaterThan: Timestamp.fromDate(since),
      );
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => EarnThreadModel.fromJson(sanitizeFirestoreData(doc.data())))
        .toList();
  }

  /// Fetch chat threads since a given timestamp
  Future<List<ChatThreadModel>> fetchChatThreadsSince(
    String userId,
    DateTime? since,
  ) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('chatThreads')
        .where('participantIds', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .limit(50);

    if (since != null) {
      query = query.where(
        'lastMessageAt',
        isGreaterThan: Timestamp.fromDate(since),
      );
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => ChatThreadModel.fromJson(sanitizeFirestoreData(doc.data())))
        .toList();
  }

  /// Fetch all contacts for a user
  Future<List<Contact>> fetchContacts(String userId) async {
    final snapshot = await _firestore
        .collection('contacts')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Contact(
        id: doc.id,
        userId: data['userId'] ?? '',
        contactUserId: data['contactUserId'] ?? '',
        displayName: data['displayName'] ?? 'User',
        username: data['username'],
        avatarUrl: data['avatarUrl'],
        avatarColor: data['avatarColor'],
        phoneNumber: data['phoneNumber'],
        status: ContactStatus.values.firstWhere(
          (e) => e.name == data['status'],
          orElse: () => ContactStatus.pending,
        ),
        isFavorite: data['isFavorite'] ?? false,
        nickname: data['nickname'],
        notes: data['notes'],
        createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        lastInteractionAt: (data['lastInteractionAt'] as Timestamp?)?.toDate(),
      );
    }).toList();
  }

  /// Push a pending change to Firestore
  Future<void> pushChange({
    required String tableName,
    required String recordId,
    required String changeType,
    required Map<String, dynamic> changeData,
  }) async {
    switch (tableName) {
      case 'localTransactions':
        if (changeType == 'insert') {
          await _firestore
              .collection('transactions')
              .doc(recordId)
              .set(changeData);
        } else if (changeType == 'update') {
          await _firestore
              .collection('transactions')
              .doc(recordId)
              .update(changeData);
        } else if (changeType == 'delete') {
          await _firestore.collection('transactions').doc(recordId).delete();
        }
        break;

      case 'localChatMessages':
        if (changeType == 'insert') {
          await _firestore
              .collection('chatMessages')
              .doc(recordId)
              .set(changeData);
        } else if (changeType == 'update') {
          await _firestore
              .collection('chatMessages')
              .doc(recordId)
              .update(changeData);
        } else if (changeType == 'delete') {
          await _firestore.collection('chatMessages').doc(recordId).delete();
        }
        break;

      case 'localContacts':
        if (changeType == 'insert') {
          await _firestore.collection('contacts').doc(recordId).set(changeData);
        } else if (changeType == 'update') {
          await _firestore
              .collection('contacts')
              .doc(recordId)
              .update(changeData);
        } else if (changeType == 'delete') {
          await _firestore.collection('contacts').doc(recordId).delete();
        }
        break;

      case 'localChatThreads':
        if (changeType == 'update') {
          await _firestore
              .collection('chatThreads')
              .doc(recordId)
              .update(changeData);
        }
        break;

      default:
        throw Exception('Unknown table: $tableName');
    }
  }

  /// Batch push multiple changes
  Future<void> pushChanges(
    List<Map<String, dynamic>> changes,
  ) async {
    final batch = _firestore.batch();

    for (final change in changes) {
      final tableName = change['tableName'] as String;
      final recordId = change['recordId'] as String;
      final changeType = change['changeType'] as String;
      final changeData = change['changeData'] as Map<String, dynamic>;

      final collectionName = _tableToCollection(tableName);
      final docRef = _firestore.collection(collectionName).doc(recordId);

      switch (changeType) {
        case 'insert':
          batch.set(docRef, changeData);
          break;
        case 'update':
          batch.update(docRef, changeData);
          break;
        case 'delete':
          batch.delete(docRef);
          break;
      }
    }

    await batch.commit();
  }

  String _tableToCollection(String tableName) {
    switch (tableName) {
      case 'localTransactions':
        return 'transactions';
      case 'localChatMessages':
        return 'chatMessages';
      case 'localChatThreads':
        return 'chatThreads';
      case 'localContacts':
        return 'contacts';
      case 'localEarnThreads':
        return 'earnThreads';
      case 'localWallets':
        return 'wallets';
      default:
        return tableName.replaceFirst('local', '').toLowerCase();
    }
  }
}
