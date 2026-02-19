import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/group_member.dart';
import '../../domain/entities/group_transaction.dart';
import '../../domain/entities/stokvel_analytics.dart';
import '../../domain/repositories/group_repository.dart';
import '../datasources/remote/group_remote_datasource.dart';

// DEPRECATED: Use CommunityRepositoryImpl instead. Will be removed in a future cleanup PR.
@LazySingleton(as: GroupRepository)
class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GroupRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  // =========================================================================
  // GROUP CRUD
  // =========================================================================

  @override
  Future<Either<Failure, Group>> createGroup(CreateGroupParams params) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final model = await _remoteDataSource.createGroup(params);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Group>> getGroup(String groupId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final model = await _remoteDataSource.getGroup(groupId);
      if (model == null) {
        return const Left(Failure.serverError(message: 'Group not found'));
      }
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Group>>> getUserGroups() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getUserGroups();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Group>>> watchUserGroups() {
    return _remoteDataSource.watchUserGroups().map<Either<Failure, List<Group>>>((models) {
      return Right(models.map((m) => m.toEntity()).toList());
    }).handleError((error) {
      if (error is ServerException) {
        return const Left(Failure.network());
      }
      return const Left(Failure.network());
    });
  }

  @override
  Future<Either<Failure, void>> updateGroup(
    String groupId,
    UpdateGroupParams params,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.updateGroup(groupId, params);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroup(String groupId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.deleteGroup(groupId);
      return const Right(null);
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
    String groupId,
    String userId,
    GroupRole role,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.inviteMember(groupId, userId, role);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptInvitation(String groupId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.acceptInvitation(groupId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> declineInvitation(String groupId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.declineInvitation(groupId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeMember(
    String groupId,
    String memberId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.removeMember(groupId, memberId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateMemberRole(
    String groupId,
    String memberId,
    GroupRole role,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.updateMemberRole(groupId, memberId, role);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveGroup(String groupId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.leaveGroup(groupId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupMember>>> getGroupMembers(
    String groupId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getGroupMembers(groupId);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<GroupMember>>> watchGroupMembers(String groupId) {
    return _remoteDataSource.watchGroupMembers(groupId).map<Either<Failure, List<GroupMember>>>((models) {
      return Right(models.map((m) => m.toEntity()).toList());
    }).handleError((error) {
      if (error is ServerException) {
        return const Left(Failure.network());
      }
      return const Left(Failure.network());
    });
  }

  @override
  Future<Either<Failure, List<GroupMember>>> getPendingInvitations() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getPendingInvitations();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // TRANSACTIONS
  // =========================================================================

  @override
  Future<Either<Failure, GroupTransaction>> contributeToGroup(
    String groupId,
    int amount, {
    String? description,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final model = await _remoteDataSource.contributeToGroup(
        groupId,
        amount,
        description: description,
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupTransaction>> withdrawFromGroup(
    String groupId,
    int amount, {
    String? description,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final model = await _remoteDataSource.withdrawFromGroup(
        groupId,
        amount,
        description: description,
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approveTransaction(
    String groupId,
    String transactionId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.approveTransaction(groupId, transactionId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectTransaction(
    String groupId,
    String transactionId, {
    String? reason,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.rejectTransaction(
        groupId,
        transactionId,
        reason: reason,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupTransaction>>> getGroupTransactions(
    String groupId, {
    int? limit,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getGroupTransactions(
        groupId,
        limit: limit,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<GroupTransaction>>> watchGroupTransactions(
    String groupId, {
    int? limit,
  }) {
    return _remoteDataSource.watchGroupTransactions(groupId, limit: limit).map<Either<Failure, List<GroupTransaction>>>((models) {
      return Right(models.map((m) => m.toEntity()).toList());
    }).handleError((error) {
      if (error is ServerException) {
        return const Left(Failure.network());
      }
      return const Left(Failure.network());
    });
  }

  @override
  Future<Either<Failure, List<PendingApproval>>> getPendingApprovals(
    String groupId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getPendingApprovals(groupId);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<PendingApproval>>> watchPendingApprovals(
    String groupId,
  ) {
    return _remoteDataSource.watchPendingApprovals(groupId).map<Either<Failure, List<PendingApproval>>>((models) {
      return Right(models.map((m) => m.toEntity()).toList());
    }).handleError((error) {
      if (error is ServerException) {
        return const Left(Failure.network());
      }
      return const Left(Failure.network());
    });
  }

  // =========================================================================
  // BALANCE & STATS
  // =========================================================================

  @override
  Future<Either<Failure, int>> getGroupBalance(String groupId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final balance = await _remoteDataSource.getGroupBalance(groupId);
      return Right(balance);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupDetails>> getGroupDetails(String groupId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final result = await _remoteDataSource.getGroupDetails(groupId);
      return Right(GroupDetails(
        group: result.group.toEntity(),
        members: result.members.map((m) => m.toEntity()).toList(),
      ));
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
  Future<Either<Failure, StokvelPayoutResult>> triggerStokvelPayout(
    String groupId, {
    String? recipientId,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final result = await _remoteDataSource.triggerStokvelPayout(
        groupId,
        recipientId: recipientId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StokvelAnalytics>> getStokvelAnalytics(
    String groupId, {
    int months = 6,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final result = await _remoteDataSource.getStokvelAnalytics(
        groupId,
        months: months,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
