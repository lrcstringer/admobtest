import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../core/services/community_sync_service.dart';
import '../../core/services/offline_action_queue.dart';
import '../../core/services/outgoing_message_queue.dart';
import '../../core/services/sender_key_service.dart';
import '../datasources/remote/media_upload_datasource.dart';
import '../../domain/entities/community.dart';
import '../../domain/entities/community_member.dart';
import '../../domain/entities/community_transaction.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/stokvel_analytics.dart';
import '../../domain/enums/member_role.dart';
import '../../domain/enums/member_status.dart';
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
  final MediaUploadDatasource _mediaUploadDatasource;
  final CommunitySyncService _communitySyncService;
  final SenderKeyService _senderKeyService;

  static const _uuid = Uuid();

  CommunityRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._appDatabase,
    this._offlineActionQueue,
    this._outgoingMessageQueue,
    this._mediaUploadDatasource,
    this._communitySyncService,
    this._senderKeyService,
  );

  String? get _currentUserId => _remoteDataSource.currentUserId;

  // =========================================================================
  // COMMUNITY CRUD
  // =========================================================================

  @override
  Future<Either<Failure, Community>> createCommunity(
    CreateCommunityParams params,
  ) async {
    // No premature network check — let the Cloud Function call attempt to
    // run. internet_connection_checker_plus actively probes endpoints and
    // produces false negatives on slow mobile networks, blocking the user
    // even when the network is fine.
    try {
      final model = await _remoteDataSource.createCommunity(params);
      final entity = model.toEntity();
      // Seed local cache so UI shows the new community immediately
      try {
        await _appDatabase.upsertLocalCommunity(
          LocalCommunityMapper.toCompanion(entity),
        );
      } catch (e) {
        debugPrint('WARNING: Failed to seed local cache after create: $e');
      }
      return Right(entity);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      // SocketException / TimeoutException from the HTTP call indicate
      // actual network failure — surface a user-friendly message.
      final msg = e.toString();
      if (msg.contains('SocketException') || msg.contains('TimeoutException')) {
        return const Left(Failure.network());
      }
      return Left(Failure.serverError(message: msg));
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
      // Re-fetch and seed local cache so UI reflects changes immediately
      try {
        final updated = await _remoteDataSource.getCommunity(communityId);
        if (updated != null) {
          await _appDatabase.upsertLocalCommunity(
            LocalCommunityMapper.toCompanion(updated.toEntity()),
          );
        }
      } catch (e) {
        debugPrint('WARNING: Failed to seed local cache after update: $e');
      }
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
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } catch (e) {
      // If Firestore doc is already gone (orphaned local data), still
      // clean up the local DB below instead of returning an error.
      final isNotFound = e.toString().contains('not-found') ||
          e.toString().contains('NOT_FOUND');
      if (!isNotFound) {
        return Left(Failure.serverError(
          message: e is ServerException ? e.message : e.toString(),
        ));
      }
      debugPrint('deleteCommunity: Firestore doc already gone, '
          'cleaning up orphaned local data for $communityId');
    }

    // Clean up ALL local DB data so the deleted community doesn't reappear
    await _appDatabase.deleteLocalCommunity(communityId);
    await _appDatabase.deleteLocalCommunityMembersForCommunity(communityId);
    await _appDatabase.deleteLocalMessagesForConversation(communityId);

    // Clean up E2EE sender keys for this community
    try {
      await _senderKeyService.resetAllKeysForCommunity(communityId);
    } catch (e) {
      debugPrint('deleteCommunity: Failed to clean sender keys: $e');
    }

    return const Right(null);
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

      // Seed the community into local DB so it appears immediately in the list
      try {
        final communityModel =
            await _remoteDataSource.getCommunity(communityId);
        if (communityModel != null) {
          await _appDatabase.upsertLocalCommunity(
            LocalCommunityMapper.toCompanion(communityModel.toEntity()),
          );
        }
      } catch (e) {
        debugPrint(
            'WARNING: Failed to seed community after accept: $e');
      }

      // Update local member status to active
      final userId = _currentUserId;
      if (userId != null) {
        try {
          final memberId = '${communityId}_$userId';
          final local = await _appDatabase.getLocalCommunityMember(memberId);
          if (local != null) {
            final entity = LocalCommunityMemberMapper.toEntity(local);
            final updated = entity.copyWith(
              status: MemberStatus.active,
              joinedAt: DateTime.now(),
            );
            await _appDatabase.upsertLocalCommunityMember(
              LocalCommunityMemberMapper.toCompanion(updated),
            );
          }
        } catch (e) {
          debugPrint('WARNING: Failed to update local member after accept: $e');
        }
      }
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
      // Remove local member record
      final userId = _currentUserId;
      if (userId != null) {
        try {
          await _appDatabase.deleteLocalCommunityMember('${communityId}_$userId');
        } catch (e) {
          debugPrint('WARNING: Failed to remove local member after decline: $e');
        }
      }
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
      // Clean local DB so the left community doesn't reappear
      try {
        await _appDatabase.deleteLocalCommunity(communityId);
        await _appDatabase.deleteLocalCommunityMembersForCommunity(communityId);
      } catch (e) {
        debugPrint('WARNING: Failed to clean local DB after leave: $e');
      }
      // Clean up E2EE sender keys for this community
      try {
        await _senderKeyService.resetAllKeysForCommunity(communityId);
      } catch (e) {
        debugPrint('leaveCommunity: Failed to clean sender keys: $e');
      }
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  /// Returns members from the **local DB only**. The local cache is populated
  /// by [CommunitySyncService] in the background, or can be force-populated
  /// by calling [refreshMembers] first.
  @override
  Future<Either<Failure, List<CommunityMember>>> getMembers(
    String communityId,
  ) async {
    try {
      final rows = await _appDatabase.getLocalCommunityMembers(communityId);
      return Right(rows.map(LocalCommunityMemberMapper.toEntity).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  /// Fetches members from Firestore and seeds the local DB cache.
  /// Call this to ensure the local DB is populated before using
  /// [getMembers] or [watchMembers]. Requires network connectivity.
  @override
  Future<Either<Failure, void>> refreshMembers(String communityId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getMembers(communityId);
      // Batch upsert all members
      await _appDatabase.batch((b) {
        for (final model in models) {
          final entity = model.toEntity();
          b.insert(
            _appDatabase.localCommunityMembers,
            LocalCommunityMemberMapper.toCompanion(entity),
            onConflict: DoUpdate(
              (_) => LocalCommunityMemberMapper.toCompanion(entity),
            ),
          );
        }
      });
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  /// Streams members from the **local DB only** (reactive via Drift `.watch()`).
  /// [CommunitySyncService] keeps the local cache up-to-date in the background.
  /// Call [refreshMembers] first if the cache may be empty.
  @override
  Stream<Either<Failure, List<CommunityMember>>> watchMembers(
    String communityId,
  ) {
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
      // Pass before/limit to DB query for efficient filtering
      final rows = await _appDatabase.getLocalMessages(
        communityId,
        limit: limit ?? 50,
        before: before,
      );
      final messages = rows.map(LocalMessageMapper.toEntity).toList();
      return Right(messages);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String communityId,
    int? limit,
  }) {
    // Belt-and-suspenders: ensure CommunitySyncService is syncing messages
    // for this community. If the community list stream failed silently,
    // this is the safety net that starts per-community message sync.
    _communitySyncService.ensureSyncing(communityId);

    // Offline-first: stream pre-decrypted messages from local DB
    return _appDatabase
        .watchLocalMessages(communityId, limit: limit ?? 50)
        .map((rows) {
      try {
        final messages = rows.map(LocalMessageMapper.toEntity).toList();
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
    required File mediaFile,
    required String mediaType,
    String? caption,
    int? durationSeconds,
    File? thumbnailFile,
  }) async {
    try {
      final isAudio = mediaType.startsWith('audio');
      final isDocument =
          mediaType == 'document' || mediaType.startsWith('application');
      final isVideo = mediaType.startsWith('video');
      final tempMessageId = _uuid.v4();

      final MediaUploadResult uploadResult;

      if (isAudio) {
        uploadResult = await _mediaUploadDatasource.uploadEncryptedVoice(
          voiceFile: mediaFile,
          parentCollection: 'communities',
          parentId: communityId,
          messageId: tempMessageId,
          durationSeconds: durationSeconds ?? 0,
        );
      } else if (isDocument) {
        uploadResult = await _mediaUploadDatasource.uploadEncryptedDocument(
          documentFile: mediaFile,
          parentCollection: 'communities',
          parentId: communityId,
          messageId: tempMessageId,
        );
      } else if (isVideo) {
        if (thumbnailFile == null) {
          return const Left(
            Failure.serverError(message: 'Video upload requires a thumbnail'),
          );
        }
        uploadResult = await _mediaUploadDatasource.uploadEncryptedVideo(
          videoFile: mediaFile,
          thumbnailFile: thumbnailFile,
          parentCollection: 'communities',
          parentId: communityId,
          messageId: tempMessageId,
          durationSeconds: durationSeconds ?? 0,
        );
      } else {
        // Default: image
        uploadResult = await _mediaUploadDatasource.uploadEncryptedImage(
          imageFile: mediaFile,
          parentCollection: 'communities',
          parentId: communityId,
          messageId: tempMessageId,
        );
      }

      // Build structured JSON payload with encrypted media metadata
      final payloadJson = jsonEncode({
        if (caption != null) 'text': caption,
        'media': uploadResult.toMediaMap(),
      });

      final message = await _outgoingMessageQueue.enqueueCommunityMediaMessage(
        communityId: communityId,
        payloadJson: payloadJson,
        mediaType: mediaType,
        caption: caption,
      );
      return Right(message);
    } catch (e) {
      return Left(Failure.serverError(message: 'Media upload failed: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead({required String communityId}) async {
    try {
      await _remoteDataSource.markAsRead(communityId);
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
      final idempotencyKey = _uuid.v4();
      final model = await _remoteDataSource.contribute(
        communityId,
        amount,
        description: description,
        idempotencyKey: idempotencyKey,
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
      final idempotencyKey = _uuid.v4();
      final model = await _remoteDataSource.withdraw(
        communityId,
        amount,
        description: description,
        idempotencyKey: idempotencyKey,
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
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

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
      try {
        return Right<Failure, List<CommunityTransaction>>(
          models.map((m) => m.toEntity()).toList(),
        );
      } catch (e) {
        return Left<Failure, List<CommunityTransaction>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  @override
  Future<Either<Failure, List<CommunityApproval>>> getPendingApprovals(
    String communityId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

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
      try {
        return Right<Failure, List<CommunityApproval>>(
          models.map((m) => m.toEntity()).toList(),
        );
      } catch (e) {
        return Left<Failure, List<CommunityApproval>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  @override
  Future<Either<Failure, int>> getBalance(String communityId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

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
            } catch (e) {
              debugPrint('WARNING: Corrupt unreadCounts JSON for ${row.id}: $e');
            }
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
