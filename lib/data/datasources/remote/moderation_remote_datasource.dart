import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

/// Remote datasource for block/report moderation operations.
abstract class ModerationRemoteDatasource {
  /// Block a user (hides conversations, prevents new messages).
  Future<void> blockUser(String userId);

  /// Unblock a user.
  Future<void> unblockUser(String userId);

  /// Get list of blocked user IDs.
  Future<List<String>> getBlockedUserIds();

  /// Report a user, message, or community.
  Future<void> submitReport({
    required String type,
    required String targetId,
    required String reason,
    String? additionalInfo,
  });

  /// Delete a message for the current user only.
  Future<void> deleteMessageForMe({
    required String parentCollection,
    required String parentId,
    required String messageId,
  });

  /// Delete a message for everyone (sender only, within 1 hour).
  Future<void> deleteMessageForEveryone({
    required String parentCollection,
    required String parentId,
    required String messageId,
  });
}

@LazySingleton(as: ModerationRemoteDatasource)
class ModerationRemoteDatasourceImpl implements ModerationRemoteDatasource {
  final FirebaseFunctions _functions;

  ModerationRemoteDatasourceImpl(this._functions);

  @override
  Future<void> blockUser(String userId) async {
    await _functions.httpsCallable('blockUser').call({'targetUserId': userId});
  }

  @override
  Future<void> unblockUser(String userId) async {
    await _functions.httpsCallable('unblockUser').call({'targetUserId': userId});
  }

  @override
  Future<List<String>> getBlockedUserIds() async {
    final result = await _functions.httpsCallable('getBlockedUsers').call();
    final data = result.data as Map<String, dynamic>;
    return List<String>.from(data['blockedUserIds'] as List? ?? []);
  }

  @override
  Future<void> submitReport({
    required String type,
    required String targetId,
    required String reason,
    String? additionalInfo,
  }) async {
    await _functions.httpsCallable('submitReport').call({
      'type': type,
      'targetId': targetId,
      'reason': reason,
      if (additionalInfo != null) 'additionalInfo': additionalInfo,
    });
  }

  @override
  Future<void> deleteMessageForMe({
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async {
    await _functions.httpsCallable('deleteMessageForMe').call({
      'parentCollection': parentCollection,
      'parentId': parentId,
      'messageId': messageId,
    });
  }

  @override
  Future<void> deleteMessageForEveryone({
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async {
    await _functions.httpsCallable('deleteMessageForEveryone').call({
      'parentCollection': parentCollection,
      'parentId': parentId,
      'messageId': messageId,
    });
  }
}
