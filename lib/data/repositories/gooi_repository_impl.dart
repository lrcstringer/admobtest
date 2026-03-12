import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/gooi_contribution.dart';
import '../../domain/entities/gooi_cycle.dart';
import '../../domain/entities/gooi_debt.dart';
import '../../domain/entities/gooi_group.dart';
import '../../domain/entities/gooi_member.dart';
import '../../domain/entities/gooi_payout.dart';
import '../../domain/enums/gooi_cycle_frequency.dart';
import '../../domain/enums/gooi_roster_method.dart';
import '../../domain/repositories/gooi_repository.dart';
import '../datasources/remote/gooi_remote_datasource.dart';
import '../models/gooi_group_model.dart';

@LazySingleton(as: GooiRepository)
class GooiRepositoryImpl implements GooiRepository {
  final GooiRemoteDataSource _remote;

  GooiRepositoryImpl(this._remote);

  Either<Failure, T> _handleError<T>(Object e) {
    if (e is FirebaseFunctionsException) {
      return Left(Failure.serverError(code: e.code, message: e.message));
    }
    return Left(Failure.serverError(message: e.toString()));
  }

  @override
  Future<Either<Failure, String>> createGroup({
    required String name,
    required int contributionAmount,
    required GooiCycleFrequency cycleFrequency,
    required int totalCycles,
    required GooiRosterMethod rosterMethod,
    int gracePeriodHours = 48,
    int lateFeePercent = 5,
    bool recipientContributes = true,
  }) async {
    try {
      final groupId = await _remote.createGroup({
        'name': name,
        'contributionAmount': contributionAmount,
        'cycleFrequency': cycleFrequency.name.toUpperCase(),
        'totalCycles': totalCycles,
        'rosterMethod': rosterMethod.name.toUpperCase(),
        'gracePeriodHours': gracePeriodHours,
        'lateFeePercent': lateFeePercent,
        'recipientContributes': recipientContributes,
      });
      return Right(groupId);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<GooiGroup>>> getMyGroups() async {
    try {
      final result = await _remote.getMyGroups();
      final groupsList = result['groups'] as List<dynamic>?;
      if (groupsList == null) return const Right([]);
      final groups = groupsList
          .map((g) => GooiGroupModel.fromJson(Map<String, dynamic>.from(g as Map)).toEntity())
          .toList();
      return Right(groups);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, GooiGroup>> getGroup(String groupId) async {
    try {
      final model = await _remote.getGroup(groupId);
      if (model == null) return const Left(Failure.serverError(message: 'Group not found'));
      return Right(model.toEntity());
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> dissolveGroup(String groupId) async {
    try {
      await _remote.dissolveGroup(groupId);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, String>> inviteMember({
    required String groupId,
    required String inviteeUserId,
  }) async {
    try {
      final memberId = await _remote.inviteMember(groupId, inviteeUserId);
      return Right(memberId);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> respondInvitation({
    required String groupId,
    required bool accept,
  }) async {
    try {
      await _remote.respondInvitation(groupId, accept);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<GooiMember>>> getMembers(String groupId) async {
    try {
      final models = await _remote.getMembers(groupId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<String>>> lockRoster({
    required String groupId,
    List<String>? proposedOrder,
  }) async {
    try {
      final order = await _remote.lockRoster(groupId, proposedOrder);
      return Right(order);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, String>> submitBid({
    required String groupId,
    required int targetPosition,
    required int bidPercent,
  }) async {
    try {
      final bidId = await _remote.submitBid(groupId, targetPosition, bidPercent);
      return Right(bidId);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, BiddingResult>> finalizeBidding(String groupId) async {
    try {
      final result = await _remote.finalizeBidding(groupId);
      return Right(BiddingResult(
        rosterOrder: (result['rosterOrder'] as List<dynamic>?)?.cast<String>() ?? [],
        discountPool: (result['discountPool'] as num?)?.toInt() ?? 0,
      ));
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, bool>> confirmActivation(String groupId) async {
    try {
      final result = await _remote.confirmActivation(groupId);
      return Right(result['activated'] as bool? ?? false);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, String>> contribute({
    required String groupId,
    required String cycleId,
    String? subAccountId,
  }) async {
    try {
      final result = await _remote.contribute(groupId, cycleId, subAccountId);
      return Right(result['journalId'] as String? ?? '');
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> toggleAutoContribute({
    required String groupId,
    required bool enabled,
    String? walletSubAccountId,
  }) async {
    try {
      await _remote.toggleAutoContribute(groupId, enabled, walletSubAccountId);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<GooiContribution>>> getContributions({
    required String groupId,
    required String cycleId,
  }) async {
    try {
      final models = await _remote.getContributions(groupId, cycleId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, PayoutResult>> triggerPayout({
    required String groupId,
    required String cycleId,
  }) async {
    try {
      final result = await _remote.triggerPayout(groupId, cycleId);
      return Right(PayoutResult(
        payoutId: result['payoutId'] as String? ?? '',
        payoutAmount: (result['payoutAmount'] as num?)?.toInt() ?? 0,
        groupCompleted: result['groupCompleted'] as bool? ?? false,
      ));
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<GooiPayout>>> getPayouts(String groupId) async {
    try {
      final models = await _remote.getPayouts(groupId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<GooiCycle>>> getCycles(String groupId) async {
    try {
      final models = await _remote.getCycles(groupId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, GooiCycle>> getCycle({
    required String groupId,
    required String cycleId,
  }) async {
    try {
      final model = await _remote.getCycle(groupId, cycleId);
      if (model == null) return const Left(Failure.serverError(message: 'Cycle not found'));
      return Right(model.toEntity());
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, String>> delegateTrigger({
    required String groupId,
    required String delegateUserId,
    int durationDays = 7,
  }) async {
    try {
      final expiresAt = await _remote.delegateTrigger(groupId, delegateUserId, durationDays);
      return Right(expiresAt);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> revokeDelegation(String groupId) async {
    try {
      await _remote.revokeDelegation(groupId);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, GraceExtensionResult>> extendGracePeriod({
    required String groupId,
    required String cycleId,
    required int extensionHours,
  }) async {
    try {
      final result = await _remote.extendGracePeriod(groupId, cycleId, extensionHours);
      return Right(GraceExtensionResult(
        newGraceCloseDate: DateTime.parse(result['newGraceCloseDate'] as String),
        voteId: result['voteId'] as String?,
      ));
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, VoteResult>> voteGraceExtension({
    required String groupId,
    required String cycleId,
    required String voteId,
    required bool approve,
  }) async {
    try {
      final result = await _remote.voteGraceExtension(groupId, cycleId, voteId, approve);
      return Right(VoteResult(
        passed: result['passed'] as bool? ?? false,
        votesFor: (result['votesFor'] as num?)?.toInt() ?? 0,
        votesAgainst: (result['votesAgainst'] as num?)?.toInt() ?? 0,
      ));
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, int>> applyLateFee({
    required String groupId,
    required String contributionId,
  }) async {
    try {
      final amount = await _remote.applyLateFee(groupId, contributionId);
      return Right(amount);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> waiveLateFee({
    required String groupId,
    required String contributionId,
  }) async {
    try {
      await _remote.waiveLateFee(groupId, contributionId);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, String>> requestWithdrawal({
    required String groupId,
    String? reason,
  }) async {
    try {
      final withdrawalId = await _remote.requestWithdrawal(groupId, reason);
      return Right(withdrawalId);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, VoteResult>> voteWithdrawal({
    required String groupId,
    required String withdrawalId,
    required bool approve,
  }) async {
    try {
      final result = await _remote.voteWithdrawal(groupId, withdrawalId, approve);
      return Right(VoteResult(
        passed: result['passed'] as bool? ?? false,
        votesFor: (result['votesFor'] as num?)?.toInt() ?? 0,
        votesAgainst: (result['votesAgainst'] as num?)?.toInt() ?? 0,
      ));
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, void>> applyPenalty({
    required String groupId,
    required String targetUserId,
    required String action,
  }) async {
    try {
      await _remote.applyPenalty(groupId, targetUserId, action);
      return const Right(null);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, int>> writeOffBadDebt(String groupId) async {
    try {
      final amount = await _remote.writeOffBadDebt(groupId);
      return Right(amount);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<GooiDebt>>> getMyDebts() async {
    try {
      final models = await _remote.getMyDebts();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return _handleError(e);
    }
  }
}
