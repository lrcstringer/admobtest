import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../core/services/sender_key_service.dart';
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

  CommunityRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._senderKeyService,
  );

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
      final decrypted = await Future.wait(
        messages.map((m) => _decryptIfNeeded(communityId, m)),
      );
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
      final decrypted = await Future.wait(
        messages.map((m) => _decryptIfNeeded(communityId, m)),
      );
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
        return Right(Message(
          id: messageId,
          senderId: '',
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

  Future<Message> _decryptIfNeeded(String communityId, Message msg) async {
    if (!msg.isEncrypted) return msg;
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
      return msg.copyWith(textContent: plaintext);
    } on StateError {
      debugPrint('Sender key missing for ${msg.senderId} in $communityId');
      return msg.copyWith(textContent: '[Waiting for encryption key...]');
    } catch (e) {
      debugPrint('Sender Key decrypt failed for msg ${msg.id}: $e');
      return msg.copyWith(textContent: '[Cannot decrypt]');
    }
  }
}
