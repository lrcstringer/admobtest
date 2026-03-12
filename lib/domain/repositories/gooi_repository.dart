import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/gooi_contribution.dart';
import '../entities/gooi_cycle.dart';
import '../entities/gooi_debt.dart';
import '../entities/gooi_group.dart';
import '../entities/gooi_member.dart';
import '../entities/gooi_payout.dart';
import '../enums/gooi_cycle_frequency.dart';
import '../enums/gooi_roster_method.dart';

/// Result of finalizing bidding.
class BiddingResult {
  final List<String> rosterOrder;
  final int discountPool;
  const BiddingResult({required this.rosterOrder, required this.discountPool});
}

/// Result of triggering a payout.
class PayoutResult {
  final String payoutId;
  final int payoutAmount;
  final bool groupCompleted;
  const PayoutResult({required this.payoutId, required this.payoutAmount, this.groupCompleted = false});
}

/// Result of a grace extension request.
class GraceExtensionResult {
  final DateTime newGraceCloseDate;
  final String? voteId;
  const GraceExtensionResult({required this.newGraceCloseDate, this.voteId});
}

/// Result of a vote action.
class VoteResult {
  final bool passed;
  final int votesFor;
  final int votesAgainst;
  const VoteResult({required this.passed, required this.votesFor, required this.votesAgainst});
}

abstract class GooiRepository {
  // ── Group lifecycle ──

  Future<Either<Failure, String>> createGroup({
    required String name,
    required int contributionAmount,
    required GooiCycleFrequency cycleFrequency,
    required int totalCycles,
    required GooiRosterMethod rosterMethod,
    int gracePeriodHours = 48,
    int lateFeePercent = 5,
    bool recipientContributes = true,
  });

  Future<Either<Failure, List<GooiGroup>>> getMyGroups();

  Future<Either<Failure, GooiGroup>> getGroup(String groupId);

  Future<Either<Failure, void>> dissolveGroup(String groupId);

  // ── Members ──

  Future<Either<Failure, String>> inviteMember({
    required String groupId,
    required String inviteeUserId,
  });

  Future<Either<Failure, void>> respondInvitation({
    required String groupId,
    required bool accept,
  });

  Future<Either<Failure, List<GooiMember>>> getMembers(String groupId);

  // ── Roster ──

  Future<Either<Failure, List<String>>> lockRoster({
    required String groupId,
    List<String>? proposedOrder,
  });

  Future<Either<Failure, String>> submitBid({
    required String groupId,
    required int targetPosition,
    required int bidPercent,
  });

  Future<Either<Failure, BiddingResult>> finalizeBidding(String groupId);

  // ── Activation ──

  Future<Either<Failure, bool>> confirmActivation(String groupId);

  // ── Contributions ──

  Future<Either<Failure, String>> contribute({
    required String groupId,
    required String cycleId,
    String? subAccountId,
  });

  Future<Either<Failure, void>> toggleAutoContribute({
    required String groupId,
    required bool enabled,
    String? walletSubAccountId,
  });

  Future<Either<Failure, List<GooiContribution>>> getContributions({
    required String groupId,
    required String cycleId,
  });

  // ── Payouts ──

  Future<Either<Failure, PayoutResult>> triggerPayout({
    required String groupId,
    required String cycleId,
  });

  Future<Either<Failure, List<GooiPayout>>> getPayouts(String groupId);

  // ── Cycles ──

  Future<Either<Failure, List<GooiCycle>>> getCycles(String groupId);

  Future<Either<Failure, GooiCycle>> getCycle({
    required String groupId,
    required String cycleId,
  });

  // ── Delegation ──

  Future<Either<Failure, String>> delegateTrigger({
    required String groupId,
    required String delegateUserId,
    int durationDays = 7,
  });

  Future<Either<Failure, void>> revokeDelegation(String groupId);

  // ── Grace extension ──

  Future<Either<Failure, GraceExtensionResult>> extendGracePeriod({
    required String groupId,
    required String cycleId,
    required int extensionHours,
  });

  Future<Either<Failure, VoteResult>> voteGraceExtension({
    required String groupId,
    required String cycleId,
    required String voteId,
    required bool approve,
  });

  // ── Late fees ──

  Future<Either<Failure, int>> applyLateFee({
    required String groupId,
    required String contributionId,
  });

  Future<Either<Failure, void>> waiveLateFee({
    required String groupId,
    required String contributionId,
  });

  // ── Withdrawal ──

  Future<Either<Failure, String>> requestWithdrawal({
    required String groupId,
    String? reason,
  });

  Future<Either<Failure, VoteResult>> voteWithdrawal({
    required String groupId,
    required String withdrawalId,
    required bool approve,
  });

  // ── Penalties ──

  Future<Either<Failure, void>> applyPenalty({
    required String groupId,
    required String targetUserId,
    required String action,
  });

  // ── Bad debt ──

  Future<Either<Failure, int>> writeOffBadDebt(String groupId);

  // ── Debts ──

  Future<Either<Failure, List<GooiDebt>>> getMyDebts();
}
