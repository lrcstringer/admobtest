import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'dart:convert';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../core/services/sender_key_service.dart';
import '../../core/services/signal_protocol_service.dart';
import '../../domain/entities/community.dart';
import '../../domain/entities/community_member.dart';
import '../../domain/entities/community_transaction.dart';
import '../../domain/entities/message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../../domain/entities/stokvel_analytics.dart';
import '../../domain/enums/member_role.dart';
import '../../domain/repositories/community_repository.dart';
import '../datasources/remote/community_remote_datasource.dart';

@LazySingleton(as: CommunityRepository)
class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final SenderKeyService _senderKeyService;
  final SignalProtocolService _signalProtocolService;

  CommunityRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._senderKeyService,
    this._signalProtocolService,
  );

  /// Cache of sent encrypted messages: messageId → plaintext.
  /// Allows the sender to see their own community E2EE messages without
  /// decryption (sender key is stored under _ownKeyPrefix, not _peerKeyPrefix).
  final Map<String, String> _sentPlaintextCache = {};

  /// Cache of received decrypted messages: messageId → plaintext.
  /// Prevents re-decryption on subsequent stream emissions (which would
  /// ratchet the sender key chain forward and corrupt the state).
  final Map<String, String> _receivedPlaintextCache = {};

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
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
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
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getUserCommunities();
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
  Stream<Either<Failure, List<Community>>> watchUserCommunities() {
    return _remoteDataSource.watchUserCommunities().map((models) {
      return Right<Failure, List<Community>>(
        models.map((m) => m.toEntity()).toList(),
      );
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<Community>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<Community>>(
        Failure.serverError(message: error.toString()),
      );
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
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getMembers(communityId);
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
  Stream<Either<Failure, List<CommunityMember>>> watchMembers(
    String communityId,
  ) {
    return _remoteDataSource.watchMembers(communityId).map((models) {
      return Right<Failure, List<CommunityMember>>(
        models.map((m) => m.toEntity()).toList(),
      );
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<CommunityMember>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<CommunityMember>>(
        Failure.serverError(message: error.toString()),
      );
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
      final models = await _remoteDataSource.getMessages(
        communityId: communityId,
        limit: limit,
        before: before,
      );
      final messages = models.map((m) => m.toEntity()).toList();
      // Decrypt sequentially to avoid concurrent chain key ratcheting
      // for messages from the same sender (corrupts session state).
      final decrypted = <Message>[];
      for (final m in messages) {
        decrypted.add(await _decryptIfNeeded(communityId, m));
      }
      return Right(decrypted);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String communityId,
    int? limit,
  }) {
    return _remoteDataSource
        .watchMessages(communityId: communityId, limit: limit)
        .asyncMap((models) async {
      final messages = models.map((m) => m.toEntity()).toList();
      // Decrypt sequentially to avoid concurrent chain key ratcheting
      final decrypted = <Message>[];
      for (final m in messages) {
        decrypted.add(await _decryptIfNeeded(communityId, m));
      }
      return Right<Failure, List<Message>>(decrypted);
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, List<Message>>(
          Failure.unauthenticated(),
        );
      }
      return Left<Failure, List<Message>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, Message>> sendTextMessage({
    required String communityId,
    required String text,
    String? replyToMessageId,
  }) async {
    try {
      // Try to encrypt via Sender Key protocol
      try {
        // Ensure sender key is distributed to all members before encrypting
        await _ensureSenderKeyDistributed(communityId);

        final encrypted = await _senderKeyService.encryptCommunity(
          communityId,
          text,
        );
        final messageId = await _remoteDataSource.sendEncryptedCommunityMessage(
          communityId: communityId,
          ciphertext: encrypted['ciphertext'] as String,
          e2ee: encrypted['e2ee'] as Map<String, dynamic>,
          replyToMessageId: replyToMessageId,
        );
        // Cache plaintext so sender can view their own E2EE message
        _sentPlaintextCache[messageId] = text;
        return Right(Message(
          id: messageId,
          senderId: _remoteDataSource.currentUserId ?? '',
          senderName: '',
          type: MessageType.text,
          status: MessageStatus.sent,
          textContent: text,
          communityId: communityId,
          createdAt: DateTime.now(),
        ));
      } catch (e) {
        // Sender Key encryption failed — fall through to plaintext
        debugPrint('Sender Key encrypt failed (falling back to plaintext): $e');
      }

      // Fallback: send plaintext
      final model = await _remoteDataSource.sendTextMessage(
        communityId: communityId,
        text: text,
        replyToMessageId: replyToMessageId,
      );
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
  Future<Either<Failure, Message>> sendMediaMessage({
    required String communityId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) async {
    try {
      final model = await _remoteDataSource.sendMediaMessage(
        communityId: communityId,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        caption: caption,
      );
      return Right(model.toEntity());
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
  // REACTIONS
  // =========================================================================

  @override
  Future<Either<Failure, void>> addReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _remoteDataSource.addReaction(
        communityId: communityId,
        messageId: messageId,
        emoji: emoji,
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
  Future<Either<Failure, void>> removeReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _remoteDataSource.removeReaction(
        communityId: communityId,
        messageId: messageId,
        emoji: emoji,
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

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  @override
  Stream<Either<Failure, int>> watchTotalCommunityUnreadCount() {
    return _remoteDataSource.watchTotalCommunityUnreadCount().map((count) {
      return Right<Failure, int>(count);
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, int>(Failure.unauthenticated());
      }
      return Left<Failure, int>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  // =========================================================================
  // E2EE HELPERS
  // =========================================================================

  /// Gap 1 fix: Ensure our sender key is generated and distributed to all
  /// community members before sending an encrypted message.
  ///
  /// Uses persistent distribution flag (M3) instead of in-memory Set,
  /// so the flag survives app restarts.
  Future<void> _ensureSenderKeyDistributed(String communityId) async {
    if (await _senderKeyService.isDistributed(communityId)) return;

    final hasKey = await _senderKeyService.hasSenderKey(communityId);
    if (!hasKey) {
      await _senderKeyService.generateSenderKey(communityId);
    }

    // Fetch member list and distribute to all (excluding self)
    final members = await _remoteDataSource.getMembers(communityId);
    final currentUserId = _remoteDataSource.currentUserId;
    final otherMemberIds = members
        .map((m) => m.userId)
        .where((id) => id != currentUserId)
        .toList();

    if (otherMemberIds.isNotEmpty) {
      await _senderKeyService.distributeSenderKeyToAll(
        communityId,
        otherMemberIds,
      );
    }

    await _senderKeyService.markDistributed(communityId);
  }

  /// Gap 2 fix: Fetch and process any pending sender key distributions
  /// from other community members, so we can decrypt their messages.
  Future<void> _processIncomingKeyDistributions(String communityId) async {
    try {
      final distributions =
          await _remoteDataSource.fetchPendingKeyDistributions(communityId);

      for (final dist in distributions) {
        final fromUserId = dist['fromUserId'] as String;
        final encryptedKeyData = dist['encryptedKeyData'] as String;
        final e2ee = dist['e2ee'] as Map<String, dynamic>?;
        final x3dhHeader = dist['x3dhHeader'] as Map<String, dynamic>?;
        final distributionId = dist['distributionId'] as String;

        try {
          // Decrypt the sender key via P2P Signal Protocol channel
          final decrypted = await _signalProtocolService.decryptP2P(
            fromUserId,
            {
              'ciphertext': encryptedKeyData,
              if (e2ee != null) 'e2ee': e2ee,
              if (x3dhHeader != null) 'x3dhHeader': x3dhHeader,
            },
          );

          // Parse and store the sender key
          final keyData =
              jsonDecode(decrypted) as Map<String, dynamic>;
          await _senderKeyService.processReceivedSenderKey(
            communityId,
            fromUserId,
            keyData,
          );

          // Mark as consumed on server
          await _remoteDataSource.markKeyDistributionConsumed(
            communityId,
            distributionId,
          );
        } catch (e) {
          debugPrint(
            'Failed to process key distribution from $fromUserId: $e',
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to fetch key distributions for $communityId: $e');
    }
  }

  Future<Message> _decryptIfNeeded(String communityId, Message msg) async {
    if (!msg.isEncrypted) return msg;

    // Sender cannot decrypt their own outgoing community E2EE messages because
    // the sender key is stored under _ownKeyPrefix, not _peerKeyPrefix.
    // Use the in-memory plaintext cache for messages sent this session.
    final currentUserId = _remoteDataSource.currentUserId;
    if (msg.senderId == currentUserId) {
      final cached = _sentPlaintextCache[msg.id];
      if (cached != null) {
        return msg.copyWith(textContent: cached);
      }
      // Message was sent in a previous app session — plaintext is no longer
      // available locally. Return as-is; UI shows the encrypted indicator.
      return msg;
    }

    // Check received cache to avoid re-decrypting (which corrupts sender key state)
    final cachedReceived = _receivedPlaintextCache[msg.id];
    if (cachedReceived != null) {
      return msg.copyWith(textContent: cachedReceived);
    }

    try {
      final encrypted = {
        'ciphertext': msg.ciphertext,
        if (msg.e2ee != null)
          'e2ee': {
            'protocol': msg.e2ee!.protocol,
            if (msg.e2ee!.senderKeyChainId != null)
              'senderKeyChainId': msg.e2ee!.senderKeyChainId,
            if (msg.e2ee!.messageNumber != null)
              'messageNumber': msg.e2ee!.messageNumber,
          },
      };
      final plaintext = await _senderKeyService.decryptCommunity(
        communityId,
        msg.senderId,
        encrypted,
      );
      _receivedPlaintextCache[msg.id] = plaintext;
      return msg.copyWith(textContent: plaintext);
    } on StateError {
      // Sender key missing — try fetching pending key distributions first
      debugPrint('Sender key missing for ${msg.senderId} in $communityId, '
          'checking for pending distributions...');
      await _processIncomingKeyDistributions(communityId);

      // Retry decryption after processing distributions
      try {
        final retryEncrypted = {
          'ciphertext': msg.ciphertext,
          if (msg.e2ee != null)
            'e2ee': {
              'protocol': msg.e2ee!.protocol,
              if (msg.e2ee!.senderKeyChainId != null)
                'senderKeyChainId': msg.e2ee!.senderKeyChainId,
              if (msg.e2ee!.messageNumber != null)
                'messageNumber': msg.e2ee!.messageNumber,
            },
        };
        final plaintext = await _senderKeyService.decryptCommunity(
          communityId,
          msg.senderId,
          retryEncrypted,
        );
        _receivedPlaintextCache[msg.id] = plaintext;
        return msg.copyWith(textContent: plaintext);
      } catch (_) {
        // Still can't decrypt — show waiting indicator
      }
      return msg.copyWith(textContent: '[Waiting for encryption key...]');
    } catch (e) {
      debugPrint('Sender Key decrypt failed for msg ${msg.id}: $e');
      return msg.copyWith(textContent: '[Cannot decrypt]');
    }
  }
}
