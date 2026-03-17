import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/community_remote_datasource.dart';
import '../../data/datasources/remote/conversation_remote_datasource.dart';
import '../network/network_info.dart';

/// Queues outgoing actions (mark-read, toggle pin/mute, reactions, etc.)
/// when offline and processes them when connectivity returns.
///
/// Text message sending uses its own optimistic-insert flow in the repository,
/// so this queue only handles lightweight metadata mutations.
@lazySingleton
class OfflineActionQueue {
  final AppDatabase _appDatabase;
  final NetworkInfo _networkInfo;
  final ConversationRemoteDataSource _remoteDataSource;
  final CommunityRemoteDataSource _communityRemoteDataSource;

  StreamSubscription<bool>? _connectivitySub;
  bool _isProcessing = false;

  OfflineActionQueue(
    this._appDatabase,
    this._networkInfo,
    this._remoteDataSource,
    this._communityRemoteDataSource,
  );

  /// Start listening for connectivity changes.
  void startListening() {
    _connectivitySub?.cancel();
    _connectivitySub = _networkInfo.onConnectivityChanged.listen((connected) {
      if (connected) {
        processPendingActions();
      }
    });
  }

  /// Stop listening for connectivity changes.
  void stopListening() {
    _connectivitySub?.cancel();
    _connectivitySub = null;
  }

  /// Queue an action for execution when online.
  ///
  /// If currently online, attempts immediate execution.
  /// If offline (or immediate execution fails), persists to local DB.
  Future<void> enqueue({
    required String table,
    required String recordId,
    required String changeType,
    required Map<String, dynamic> data,
  }) async {
    final isOnline = await _networkInfo.isConnected;

    if (isOnline) {
      // Try immediate execution
      try {
        await _executeAction(table, recordId, changeType, data);
        return;
      } catch (e) {
      }
    }

    // Queue for later
    await _appDatabase.addPendingChange(
      entityTable: table,
      recordId: recordId,
      changeType: changeType,
      changeData: jsonEncode(data),
    );
  }

  /// Process all pending actions (called on connectivity restored).
  Future<void> processPendingActions() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final pending = await _appDatabase.getPendingChanges();
      if (pending.isEmpty) return;

      for (final change in pending) {
        try {
          final data = jsonDecode(change.changeData) as Map<String, dynamic>;
          await _executeAction(
            change.entityTable,
            change.recordId,
            change.changeType,
            data,
          );
          await _appDatabase.markChangeAsSynced(change.id);
        } catch (e) {
          // Leave unsynced for next retry
        }
      }

      // Clean up synced entries
      await _appDatabase.clearSyncedChanges();
    } finally {
      _isProcessing = false;
    }
  }

  /// Execute a single queued action against the remote datasource.
  Future<void> _executeAction(
    String table,
    String recordId,
    String changeType,
    Map<String, dynamic> data,
  ) async {
    switch (changeType) {
      case 'mark_read':
        await _remoteDataSource.markAsRead(conversationId: recordId);
        break;

      case 'toggle_pin':
        await _remoteDataSource.togglePin(
          conversationId: recordId,
          pinned: data['pinned'] as bool,
        );
        break;

      case 'toggle_mute':
        await _remoteDataSource.toggleMute(
          conversationId: recordId,
          muted: data['muted'] as bool,
        );
        break;

      case 'archive':
        await _remoteDataSource.archiveConversation(recordId);
        break;

      case 'add_reaction':
        await _remoteDataSource.addReaction(
          conversationId: data['conversationId'] as String,
          messageId: recordId,
          emoji: data['emoji'] as String,
        );
        break;

      case 'remove_reaction':
        await _remoteDataSource.removeReaction(
          conversationId: data['conversationId'] as String,
          messageId: recordId,
          emoji: data['emoji'] as String,
        );
        break;

      case 'clear_chat':
        await _remoteDataSource.clearChat(conversationId: recordId);
        break;

      case 'accept_conversation':
        await _remoteDataSource.acceptConversationRequest(
          conversationId: recordId,
        );
        break;

      case 'delete_for_everyone':
        await _remoteDataSource.deleteMessageForEveryone(
          conversationId: data['conversationId'] as String,
          messageId: recordId,
        );
        break;

      case 'accept_token_request':
        await _remoteDataSource.acceptTokenRequest(
          messageId: recordId,
          conversationId: data['conversationId'] as String,
        );
        break;

      case 'decline_token_request':
        await _remoteDataSource.declineTokenRequest(
          messageId: recordId,
          conversationId: data['conversationId'] as String,
        );
        break;

      case 'set_disappearing':
        await _remoteDataSource.setDisappearingMessages(
          conversationId: recordId,
          durationMs: data['durationMs'] as int?,
        );
        break;

      case 'community_mark_read':
        await _communityRemoteDataSource.markAsRead(recordId);
        break;

      case 'community_add_reaction':
        await _communityRemoteDataSource.addReaction(
          communityId: data['communityId'] as String,
          messageId: recordId,
          emoji: data['emoji'] as String,
        );
        break;

      case 'community_remove_reaction':
        await _communityRemoteDataSource.removeReaction(
          communityId: data['communityId'] as String,
          messageId: recordId,
          emoji: data['emoji'] as String,
        );
        break;

      default:
    }
  }
}
