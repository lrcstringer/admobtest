import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../core/services/offline_action_queue.dart';
import '../../core/services/outgoing_message_queue.dart';
import '../../domain/entities/community.dart';
import '../../domain/entities/community_member.dart';
import '../../domain/entities/community_transaction.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/stokvel_analytics.dart';
import '../../domain/enums/member_role.dart';
import '../../domain/repositories/community_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/community_remote_datasource.dart';
import '../mappers/local_community_mapper.dart';
import '../mappers/local_community_member_mapper.dart';
import '../mappers/local_message_mapper.dart';

@LazySingleton(as: CommunityRepository)
class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final AppDatabase _appDatabase;
  final OfflineActionQueue _offlineActionQueue;
  final OutgoingMessageQueue _outgoingMessageQueue;

  CommunityRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._appDatabase,
    this._offlineActionQueue,
    this._outgoingMessageQueue,
  );

  String? get _currentUserId => _remoteDataSource.currentUserId;

  // =========================================================================
  // COMMUNITY CRUD
  // =========================================================================

  @override
  Future<Either<Failure, Community>> createCommunity(
    CreateCommunityParams params,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final model = await _remoteDataSource.createCommunity(params);
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Community>> getCommunity(String communityId) async {
    try {
      // Offline-first: try local DB first
      final local = await _appDatabase.getLocalCommunity(communityId);
      if (local != null) {
        return Right(LocalCommunityMapper.toEntity(local));
      }
      // Fallback to remote if not cached locally
      if (!await _networkInfo.isConnected) {
        return const Left(Failure.network());
      }
      final model = await _remoteDataSource.getCommunity(communityId);
      if (model == null) {
        return const Left(
            Failure.serverError(message: 'Community not found'));
      }
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Community>>> getUserCommunities() async {
    try {
      // Offline-first: read from local DB
      final rows = await _appDatabase.getLocalCommunities();
      return Right(rows.map(LocalCommunityMapper.toEntity).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Community>>> watchUserCommunities() {
    // Offline-first: stream from local DB (CommunitySyncService populates it)
    return _appDatabase.watchLocalCommunities().map((rows) {
      try {
        final communities =
            rows.map(LocalCommunityMapper.toEntity).toList();
        return Right<Failure, List<Community>>(communities);
      } catch (e) {
        return Left<Failure, List<Community>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateCommunity(
    String communityId,
    UpdateCommunityParams params,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.updateCommunity(communityId, params);
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
  Future<Either<Failure, void>> deleteCommunity(String communityId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.deleteCommunity(communityId);
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // MEMBERSHIP
  // =========================================================================

  @override
  Future<Either<Failure, void>> inviteMember(
    String communityId,
    String userId,
    MemberRole role,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.inviteMember(communityId, userId, role);
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
  Future<Either<Failure, void>> acceptInvitation(String communityId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.acceptInvitation(communityId);
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
  Future<Either<Failure, void>> declineInvitation(String communityId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.declineInvitation(communityId);
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
  Future<Either<Failure, void>> removeMember(
    String communityId,
    String memberId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.removeMember(communityId, memberId);
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
  Future<Either<Failure, void>> updateMemberRole(
    String communityId,
    String memberId,
    MemberRole role,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.updateMemberRole(communityId, memberId, role);
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
  Future<Either<Failure, void>> leaveCommunity(String communityId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.leaveCommunity(communityId);
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
  Future<Either<Failure, List<CommunityMember>>> getMembers(
    String communityId,
  ) async {
    try {
      // Offline-first: read from local DB
      final rows = await _appDatabase.getLocalCommunityMembers(communityId);
      return Right(rows.map(LocalCommunityMemberMapper.toEntity).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<CommunityMember>>> watchMembers(
    String communityId,
  ) {
    // Offline-first: stream from local DB (CommunitySyncService populates it)
    return _appDatabase.watchLocalCommunityMembers(communityId).map((rows) {
      try {
        return Right<Failure, List<CommunityMember>>(
          rows.map(LocalCommunityMemberMapper.toEntity).toList(),
        );
      } catch (e) {
        return Left<Failure, List<CommunityMember>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  @override
  Future<Either<Failure, List<CommunityMember>>>
      getPendingInvitations() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getPendingInvitations();
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // MESSAGING
  // =========================================================================

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String communityId,
    int? limit,
    DateTime? before,
  }) async {
    try {
      // Offline-first: read pre-decrypted messages from local DB
      final rows = await _appDatabase.getLocalMessages(communityId);
      final messages = rows.map(LocalMessageMapper.toEntity).toList();
      // Apply before/limit filtering
      var filtered = messages;
      if (before != null) {
        filtered = filtered
            .where((m) => m.createdAt.isBefore(before))
            .toList();
      }
      if (limit != null && filtered.length > limit) {
        filtered = filtered.take(limit).toList();
      }
      return Right(filtered);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String communityId,
    int? limit,
  }) {
    // Offline-first: stream pre-decrypted messages from local DB
    return _appDatabase.watchLocalMessages(communityId).map((rows) {
      try {
        var messages = rows.map(LocalMessageMapper.toEntity).toList();
        if (limit != null && messages.length > limit) {
          messages = messages.take(limit).toList();
        }
        return Right<Failure, List<Message>>(messages);
      } catch (e) {
        return Left<Failure, List<Message>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  @override
  Future<Either<Failure, Message>> sendTextMessage({
    required String communityId,
    required String text,
    String? replyToMessageId,
  }) async {
    try {
      final message = await _outgoingMessageQueue.enqueueCommunityTextMessage(
        communityId: communityId,
        text: text,
        replyToMessageId: replyToMessageId,
      );
      return Right(message);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMediaMessage({
    required String communityId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) async {
    try {
      final message = await _outgoingMessageQueue.enqueueCommunityMediaMessage(
        communityId: communityId,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        caption: caption,
      );
      return Right(message);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // FINANCIAL
  // =========================================================================

  @override
  Future<Either<Failure, CommunityTransaction>> contribute(
    String communityId,
    int amount, {
    String? description,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final model = await _remoteDataSource.contribute(
        communityId,
        amount,
        description: description,
      );
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on InsufficientBalanceException {
      return const Left(Failure.insufficientBalance());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommunityTransaction>> withdraw(
    String communityId,
    int amount, {
    String? description,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final model = await _remoteDataSource.withdraw(
        communityId,
        amount,
        description: description,
      );
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on InsufficientBalanceException {
      return const Left(Failure.insufficientBalance());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approveTransaction(
    String communityId,
    String transactionId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.approveTransaction(communityId, transactionId);
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
  Future<Either<Failure, void>> rejectTransaction(
    String communityId,
    String transactionId, {
    String? reason,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.rejectTransaction(
        communityId,
        transactionId,
        reason: reason,
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
  Future<Either<Failure, List<CommunityTransaction>>> getTransactions(
    String communityId, {
    int? limit,
  }) async {
    try {
      final models = await _remoteDataSource.getTransactions(
        communityId,
        limit: limit,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<CommunityTransaction>>> watchTransactions(
    String communityId,
  ) {
    return _remoteDataSource.watchTransactions(communityId).map((models) {
      return Right<Failure, List<CommunityTransaction>>(
        models.map((m) => m.toEntity()).toList(),
      );
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<CommunityTransaction>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<CommunityTransaction>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, List<CommunityApproval>>> getPendingApprovals(
    String communityId,
  ) async {
    try {
      final models = await _remoteDataSource.getPendingApprovals(communityId);
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<CommunityApproval>>> watchPendingApprovals(
    String communityId,
  ) {
    return _remoteDataSource
        .watchPendingApprovals(communityId)
        .map((models) {
      return Right<Failure, List<CommunityApproval>>(
        models.map((m) => m.toEntity()).toList(),
      );
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<CommunityApproval>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<CommunityApproval>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, int>> getBalance(String communityId) async {
    try {
      final balance = await _remoteDataSource.getBalance(communityId);
      return Right(balance);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // STOKVEL-SPECIFIC
  // =========================================================================

  @override
  Future<Either<Failure, StokvelPayoutResult>> triggerPayout(
    String communityId, {
    String? recipientId,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final result = await _remoteDataSource.triggerPayout(
        communityId,
        recipientId: recipientId,
      );
      return Right(result);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StokvelAnalytics>> getAnalytics(
    String communityId, {
    int months = 6,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final analytics = await _remoteDataSource.getAnalytics(
        communityId,
        months: months,
      );
      return Right(analytics);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // REACTIONS — routed through OfflineActionQueue
  // =========================================================================

  @override
  Future<Either<Failure, void>> addReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'community_messages',
        recordId: messageId,
        changeType: 'community_add_reaction',
        data: {'communityId': communityId, 'emoji': emoji},
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _offlineActionQueue.enqueue(
        table: 'community_messages',
        recordId: messageId,
        changeType: 'community_remove_reaction',
        data: {'communityId': communityId, 'emoji': emoji},
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // UNREAD COUNT — computed from local DB
  // =========================================================================

  @override
  Stream<Either<Failure, int>> watchTotalCommunityUnreadCount() {
    return _appDatabase.watchLocalCommunities().map((rows) {
      try {
        int total = 0;
        final userId = _currentUserId;
        if (userId != null) {
          for (final row in rows) {
            try {
              final unread =
                  jsonDecode(row.unreadCountsJson) as Map<String, dynamic>;
              total += (unread[userId] as num?)?.toInt() ?? 0;
            } catch (_) {}
          }
        }
        return Right<Failure, int>(total);
      } catch (e) {
        return Left<Failure, int>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }
}
