import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failures.dart';
import '../../domain/enums/sync_status.dart';
import '../../domain/repositories/sync_repository.dart';

/// Implementation of SyncRepository for offline-first functionality
class SyncRepositoryImpl implements SyncRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Connectivity _connectivity;
  final SharedPreferences _prefs;

  static const String _lastSyncKey = 'last_sync_timestamp';
  static const String _pendingActionsKey = 'pending_offline_actions';

  final StreamController<SyncStatus> _syncStatusController =
      StreamController<SyncStatus>.broadcast();

  SyncRepositoryImpl({
    required SharedPreferences prefs,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    Connectivity? connectivity,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _connectivity = connectivity ?? Connectivity(),
        _prefs = prefs {
    // Initialize connectivity listener
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    _connectivity.onConnectivityChanged.listen((results) async {
      if (!results.contains(ConnectivityResult.none) && results.isNotEmpty) {
        // Back online - attempt to sync
        await processOfflineQueue();
      }
    });
  }

  String? get _currentUserId => _auth.currentUser?.uid;

  @override
  Stream<SyncStatus> get syncStatus => _syncStatusController.stream;

  @override
  Future<bool> isOnline() async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none) && results.isNotEmpty;
  }

  @override
  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((results) {
      return !results.contains(ConnectivityResult.none) && results.isNotEmpty;
    });
  }

  @override
  Future<Either<Failure, void>> syncAll() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final online = await isOnline();
      if (!online) {
        return const Left(Failure.noInternet());
      }

      _syncStatusController.add(SyncStatus.pending);

      // Process any pending offline actions first
      await processOfflineQueue();

      // Sync each entity type
      final entityTypes = ['wallet', 'transactions', 'earnThreads', 'chatThreads', 'contacts'];

      for (final entityType in entityTypes) {
        await syncEntity(entityType);
      }

      // Update last sync timestamp
      await _prefs.setString(
        _lastSyncKey,
        DateTime.now().toIso8601String(),
      );

      _syncStatusController.add(SyncStatus.synced);

      return const Right(null);
    } catch (e) {
      _syncStatusController.add(SyncStatus.failed);
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncEntity(String entityType) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final online = await isOnline();
      if (!online) {
        return const Left(Failure.noInternet());
      }

      switch (entityType) {
        case 'wallet':
          await _syncWallet(userId);
          break;
        case 'transactions':
          await _syncTransactions(userId);
          break;
        case 'earnThreads':
          await _syncEarnThreads(userId);
          break;
        case 'chatThreads':
          await _syncChatThreads(userId);
          break;
        case 'contacts':
          await _syncContacts(userId);
          break;
        default:
          return Left(Failure.serverError(message: 'Unknown entity type: $entityType'));
      }

      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  Future<void> _syncWallet(String userId) async {
    // Fetch latest wallet data from Firestore
    await _firestore
        .collection('wallets')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    // In a full implementation, this would update local cache
  }

  Future<void> _syncTransactions(String userId) async {
    final lastSync = await getLastSyncTime();
    Query query = _firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(100);

    if (lastSync.isRight()) {
      final timestamp = lastSync.getOrElse(() => null);
      if (timestamp != null) {
        query = query.where('createdAt', isGreaterThan: Timestamp.fromDate(timestamp));
      }
    }

    await query.get();
    // In a full implementation, this would update local cache
  }

  Future<void> _syncEarnThreads(String userId) async {
    await _firestore
        .collection('earnThreads')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();
    // In a full implementation, this would update local cache
  }

  Future<void> _syncChatThreads(String userId) async {
    await _firestore
        .collection('chatThreads')
        .where('participantIds', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .limit(50)
        .get();
    // In a full implementation, this would update local cache
  }

  Future<void> _syncContacts(String userId) async {
    await _firestore
        .collection('contacts')
        .where('userId', isEqualTo: userId)
        .get();
    // In a full implementation, this would update local cache
  }

  @override
  Future<Either<Failure, int>> getPendingSyncCount() async {
    try {
      final pendingActions = _prefs.getStringList(_pendingActionsKey) ?? [];
      return Right(pendingActions.length);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLastSyncTime() async {
    try {
      final timestamp = _prefs.getString(_lastSyncKey);
      if (timestamp == null) {
        return const Right(null);
      }
      return Right(DateTime.parse(timestamp));
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forceFullSync() async {
    try {
      // Clear last sync time to force full sync
      await _prefs.remove(_lastSyncKey);

      // Perform full sync
      return syncAll();
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await _prefs.remove(_lastSyncKey);
      await _prefs.remove(_pendingActionsKey);

      // In a full implementation, this would also clear local database

      return const Right(null);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> queueOfflineAction({
    required String actionType,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final pendingActions = _prefs.getStringList(_pendingActionsKey) ?? [];

      final action = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': actionType,
        'payload': payload,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Store as JSON string
      pendingActions.add(_encodeAction(action));
      await _prefs.setStringList(_pendingActionsKey, pendingActions);

      _syncStatusController.add(SyncStatus.pending);

      return const Right(null);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> processOfflineQueue() async {
    try {
      final online = await isOnline();
      if (!online) {
        return const Left(Failure.noInternet());
      }

      final pendingActions = _prefs.getStringList(_pendingActionsKey) ?? [];

      if (pendingActions.isEmpty) {
        _syncStatusController.add(SyncStatus.synced);
        return const Right(null);
      }

      _syncStatusController.add(SyncStatus.pending);

      final failedActions = <String>[];

      for (final actionString in pendingActions) {
        try {
          final action = _decodeAction(actionString);
          await _processAction(action);
        } catch (e) {
          // Keep failed actions for retry
          failedActions.add(actionString);
        }
      }

      // Update pending actions with only failed ones
      await _prefs.setStringList(_pendingActionsKey, failedActions);

      if (failedActions.isEmpty) {
        _syncStatusController.add(SyncStatus.synced);
      } else {
        _syncStatusController.add(SyncStatus.failed);
      }

      return const Right(null);
    } catch (e) {
      _syncStatusController.add(SyncStatus.failed);
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  Future<void> _processAction(Map<String, dynamic> action) async {
    final actionType = action['type'] as String;
    final payload = action['payload'] as Map<String, dynamic>;

    switch (actionType) {
      case 'send_message':
        await _processSendMessage(payload);
        break;
      case 'transfer_tokens':
        await _processTransferTokens(payload);
        break;
      case 'update_profile':
        await _processUpdateProfile(payload);
        break;
      default:
        throw Exception('Unknown action type: $actionType');
    }
  }

  Future<void> _processSendMessage(Map<String, dynamic> payload) async {
    final threadId = payload['threadId'] as String;
    final content = payload['content'] as String;
    final senderId = payload['senderId'] as String;
    final recipientId = payload['recipientId'] as String;

    final messageRef = _firestore.collection('chatMessages').doc();
    await messageRef.set({
      'id': messageRef.id,
      'threadId': threadId,
      'senderId': senderId,
      'recipientId': recipientId,
      'content': content,
      'type': 'text',
      'status': 'sent',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _processTransferTokens(Map<String, dynamic> payload) async {
    // This would call the Cloud Function for token transfer
    // For now, we just log the attempt
    // In production, use Firebase Functions callable
  }

  Future<void> _processUpdateProfile(Map<String, dynamic> payload) async {
    final userId = payload['userId'] as String;
    final updates = payload['updates'] as Map<String, dynamic>;

    await _firestore.collection('users').doc(userId).update(updates);
  }

  String _encodeAction(Map<String, dynamic> action) {
    // Simple encoding - in production use proper JSON encoding
    return '${action['id']}|${action['type']}|${action['timestamp']}|${action['payload']}';
  }

  Map<String, dynamic> _decodeAction(String actionString) {
    // Simple decoding - in production use proper JSON decoding
    final parts = actionString.split('|');
    return {
      'id': parts[0],
      'type': parts[1],
      'timestamp': parts[2],
      'payload': parts.length > 3 ? parts[3] : {},
    };
  }

  void dispose() {
    _syncStatusController.close();
  }
}
