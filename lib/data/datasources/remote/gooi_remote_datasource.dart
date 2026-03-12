import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/gooi_contribution_model.dart';
import '../../models/gooi_cycle_model.dart';
import '../../models/gooi_debt_model.dart';
import '../../models/gooi_group_model.dart';
import '../../models/gooi_member_model.dart';
import '../../models/gooi_payout_model.dart';

abstract class GooiRemoteDataSource {
  Future<String> createGroup(Map<String, dynamic> data);
  Future<Map<String, dynamic>> getMyGroups();
  Future<GooiGroupModel?> getGroup(String groupId);
  Future<String> inviteMember(String groupId, String inviteeUserId);
  Future<void> respondInvitation(String groupId, bool accept);
  Future<List<String>> lockRoster(String groupId, List<String>? proposedOrder);
  Future<String> submitBid(String groupId, int targetPosition, int bidPercent);
  Future<Map<String, dynamic>> finalizeBidding(String groupId);
  Future<Map<String, dynamic>> confirmActivation(String groupId);
  Future<Map<String, dynamic>> contribute(String groupId, String cycleId, String? subAccountId);
  Future<void> toggleAutoContribute(String groupId, bool enabled, String? walletSubAccountId);
  Future<Map<String, dynamic>> triggerPayout(String groupId, String cycleId);
  Future<String> delegateTrigger(String groupId, String delegateUserId, int durationDays);
  Future<void> revokeDelegation(String groupId);
  Future<Map<String, dynamic>> extendGracePeriod(String groupId, String cycleId, int extensionHours);
  Future<Map<String, dynamic>> voteGraceExtension(String groupId, String cycleId, String voteId, bool approve);
  Future<int> applyLateFee(String groupId, String contributionId);
  Future<void> waiveLateFee(String groupId, String contributionId);
  Future<String> requestWithdrawal(String groupId, String? reason);
  Future<Map<String, dynamic>> voteWithdrawal(String groupId, String withdrawalId, bool approve);
  Future<void> applyPenalty(String groupId, String targetUserId, String action);
  Future<int> writeOffBadDebt(String groupId);
  Future<void> dissolveGroup(String groupId);

  // Firestore direct reads
  Future<List<GooiMemberModel>> getMembers(String groupId);
  Future<List<GooiCycleModel>> getCycles(String groupId);
  Future<GooiCycleModel?> getCycle(String groupId, String cycleId);
  Future<List<GooiContributionModel>> getContributions(String groupId, String cycleId);
  Future<List<GooiPayoutModel>> getPayouts(String groupId);
  Future<List<GooiDebtModel>> getMyDebts();
}

@LazySingleton(as: GooiRemoteDataSource)
class GooiRemoteDataSourceImpl implements GooiRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final FirebaseAuth _auth;

  GooiRemoteDataSourceImpl(this._firestore, this._functions, this._auth);

  // ── Cloud Function calls ──

  @override
  Future<String> createGroup(Map<String, dynamic> data) async {
    final result = await _functions.httpsCallable('createGooiGroup').call(data);
    return result.data['groupId'] as String;
  }

  @override
  Future<Map<String, dynamic>> getMyGroups() async {
    final result = await _functions.httpsCallable('getMyGooiGroups').call();
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<GooiGroupModel?> getGroup(String groupId) async {
    final doc = await _firestore.collection('gooiGroups').doc(groupId).get();
    if (!doc.exists) return null;
    return GooiGroupModel.fromFirestore(doc);
  }

  @override
  Future<String> inviteMember(String groupId, String inviteeUserId) async {
    final result = await _functions.httpsCallable('inviteGooiMember').call({
      'groupId': groupId,
      'inviteeUserId': inviteeUserId,
    });
    return result.data['memberId'] as String;
  }

  @override
  Future<void> respondInvitation(String groupId, bool accept) async {
    await _functions.httpsCallable('respondGooiInvitation').call({
      'groupId': groupId,
      'accept': accept,
    });
  }

  @override
  Future<List<String>> lockRoster(String groupId, List<String>? proposedOrder) async {
    final result = await _functions.httpsCallable('lockGooiRoster').call({
      'groupId': groupId,
      if (proposedOrder != null) 'proposedOrder': proposedOrder,
    });
    return List<String>.from(result.data['rosterOrder'] as List);
  }

  @override
  Future<String> submitBid(String groupId, int targetPosition, int bidPercent) async {
    final result = await _functions.httpsCallable('submitGooiBid').call({
      'groupId': groupId,
      'targetPosition': targetPosition,
      'bidPercent': bidPercent,
    });
    return result.data['bidId'] as String;
  }

  @override
  Future<Map<String, dynamic>> finalizeBidding(String groupId) async {
    final result = await _functions.httpsCallable('finalizeBidding').call({'groupId': groupId});
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<Map<String, dynamic>> confirmActivation(String groupId) async {
    final result = await _functions.httpsCallable('confirmGooiActivation').call({'groupId': groupId});
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<Map<String, dynamic>> contribute(String groupId, String cycleId, String? subAccountId) async {
    final result = await _functions.httpsCallable('contributeGooiCycle').call({
      'groupId': groupId,
      'cycleId': cycleId,
      if (subAccountId != null) 'subAccountId': subAccountId,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<void> toggleAutoContribute(String groupId, bool enabled, String? walletSubAccountId) async {
    await _functions.httpsCallable('toggleAutoContribute').call({
      'groupId': groupId,
      'enabled': enabled,
      if (walletSubAccountId != null) 'walletSubAccountId': walletSubAccountId,
    });
  }

  @override
  Future<Map<String, dynamic>> triggerPayout(String groupId, String cycleId) async {
    final result = await _functions.httpsCallable('triggerGooiPayout').call({
      'groupId': groupId,
      'cycleId': cycleId,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<String> delegateTrigger(String groupId, String delegateUserId, int durationDays) async {
    final result = await _functions.httpsCallable('delegateGooiTrigger').call({
      'groupId': groupId,
      'delegateUserId': delegateUserId,
      'durationDays': durationDays,
    });
    return result.data['expiresAt'] as String;
  }

  @override
  Future<void> revokeDelegation(String groupId) async {
    await _functions.httpsCallable('revokeGooiDelegation').call({'groupId': groupId});
  }

  @override
  Future<Map<String, dynamic>> extendGracePeriod(String groupId, String cycleId, int extensionHours) async {
    final result = await _functions.httpsCallable('extendGooiGracePeriod').call({
      'groupId': groupId,
      'cycleId': cycleId,
      'extensionHours': extensionHours,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<Map<String, dynamic>> voteGraceExtension(String groupId, String cycleId, String voteId, bool approve) async {
    final result = await _functions.httpsCallable('voteGooiGraceExtension').call({
      'groupId': groupId,
      'cycleId': cycleId,
      'voteId': voteId,
      'approve': approve,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<int> applyLateFee(String groupId, String contributionId) async {
    final result = await _functions.httpsCallable('applyGooiLateFee').call({
      'groupId': groupId,
      'contributionId': contributionId,
    });
    return (result.data['feeAmount'] as num).toInt();
  }

  @override
  Future<void> waiveLateFee(String groupId, String contributionId) async {
    await _functions.httpsCallable('waiveGooiLateFee').call({
      'groupId': groupId,
      'contributionId': contributionId,
    });
  }

  @override
  Future<String> requestWithdrawal(String groupId, String? reason) async {
    final result = await _functions.httpsCallable('requestGooiWithdrawal').call({
      'groupId': groupId,
      if (reason != null) 'reason': reason,
    });
    return result.data['withdrawalId'] as String;
  }

  @override
  Future<Map<String, dynamic>> voteWithdrawal(String groupId, String withdrawalId, bool approve) async {
    final result = await _functions.httpsCallable('voteGooiWithdrawal').call({
      'groupId': groupId,
      'withdrawalId': withdrawalId,
      'approve': approve,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  @override
  Future<void> applyPenalty(String groupId, String targetUserId, String action) async {
    await _functions.httpsCallable('applyGooiPenalty').call({
      'groupId': groupId,
      'targetUserId': targetUserId,
      'action': action,
    });
  }

  @override
  Future<int> writeOffBadDebt(String groupId) async {
    final result = await _functions.httpsCallable('writeOffGooiBadDebt').call({'groupId': groupId});
    return (result.data['writeoffAmount'] as num).toInt();
  }

  @override
  Future<void> dissolveGroup(String groupId) async {
    await _functions.httpsCallable('dissolveGooiGroup').call({'groupId': groupId});
  }

  // ── Firestore direct reads ──

  @override
  Future<List<GooiMemberModel>> getMembers(String groupId) async {
    final snap = await _firestore
        .collection('gooiGroups')
        .doc(groupId)
        .collection('members')
        .where('isActive', isEqualTo: true)
        .orderBy('position')
        .get();
    return snap.docs.map((d) => GooiMemberModel.fromFirestore(d)).toList();
  }

  @override
  Future<List<GooiCycleModel>> getCycles(String groupId) async {
    final snap = await _firestore
        .collection('gooiGroups')
        .doc(groupId)
        .collection('cycles')
        .orderBy('cycleNumber')
        .get();
    return snap.docs.map((d) => GooiCycleModel.fromFirestore(d)).toList();
  }

  @override
  Future<GooiCycleModel?> getCycle(String groupId, String cycleId) async {
    final doc = await _firestore
        .collection('gooiGroups')
        .doc(groupId)
        .collection('cycles')
        .doc(cycleId)
        .get();
    if (!doc.exists) return null;
    return GooiCycleModel.fromFirestore(doc);
  }

  @override
  Future<List<GooiContributionModel>> getContributions(String groupId, String cycleId) async {
    final snap = await _firestore
        .collection('gooiGroups')
        .doc(groupId)
        .collection('contributions')
        .where('cycleId', isEqualTo: cycleId)
        .get();
    return snap.docs.map((d) => GooiContributionModel.fromFirestore(d)).toList();
  }

  @override
  Future<List<GooiPayoutModel>> getPayouts(String groupId) async {
    final snap = await _firestore
        .collection('gooiGroups')
        .doc(groupId)
        .collection('payouts')
        .orderBy('cycleNumber')
        .get();
    return snap.docs.map((d) => GooiPayoutModel.fromFirestore(d)).toList();
  }

  @override
  Future<List<GooiDebtModel>> getMyDebts() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];
    final snap = await _firestore
        .collection('gooiGooiDebts')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'OUTSTANDING')
        .get();
    return snap.docs.map((d) => GooiDebtModel.fromFirestore(d)).toList();
  }
}
