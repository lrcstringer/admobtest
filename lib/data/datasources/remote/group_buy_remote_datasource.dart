import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/group_buy_contribution_model.dart';
import '../../models/group_buy_model.dart';

abstract class GroupBuyRemoteDataSource {
  Future<List<GroupBuyModel>> getActiveGroupBuys({String? communityId});
  Future<GroupBuyModel?> getGroupBuy(String id);
  Future<List<GroupBuyContributionModel>> getContributions(String groupBuyId);
  Future<List<GroupBuyModel>> getMyGroupBuys();
  Future<String> createGroupBuy({
    required String title,
    required String description,
    required int targetAmount,
    required DateTime deadline,
    String? linkedListingId,
    int minParticipants,
    int? maxParticipants,
  });
  Future<void> joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
  });
}

@LazySingleton(as: GroupBuyRemoteDataSource)
class GroupBuyRemoteDataSourceImpl implements GroupBuyRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final FirebaseAuth _auth;

  GroupBuyRemoteDataSourceImpl(
    this._firestore,
    this._functions,
    this._auth,
  );

  @override
  Future<List<GroupBuyModel>> getActiveGroupBuys({String? communityId}) async {
    Query query = _firestore
        .collection('groupBuys')
        .where('status', whereIn: ['open', 'targetMet'])
        .orderBy('deadline', descending: false);

    if (communityId != null) {
      query = query.where('communityId', isEqualTo: communityId);
    }

    final snap = await query.limit(50).get();
    return snap.docs
        .map((d) => GroupBuyModel.fromFirestore(d))
        .toList();
  }

  @override
  Future<GroupBuyModel?> getGroupBuy(String id) async {
    final doc = await _firestore.collection('groupBuys').doc(id).get();
    if (!doc.exists) return null;
    return GroupBuyModel.fromFirestore(doc);
  }

  @override
  Future<List<GroupBuyContributionModel>> getContributions(
      String groupBuyId) async {
    final snap = await _firestore
        .collection('groupBuys')
        .doc(groupBuyId)
        .collection('contributions')
        .orderBy('contributedAt', descending: true)
        .get();
    return snap.docs
        .map((d) => GroupBuyContributionModel.fromFirestore(d))
        .toList();
  }

  @override
  Future<List<GroupBuyModel>> getMyGroupBuys() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    // Get group buys where user has contributed
    final snap = await _firestore
        .collectionGroup('contributions')
        .where('userId', isEqualTo: uid)
        .orderBy('contributedAt', descending: true)
        .limit(50)
        .get();

    final groupBuyIds = snap.docs
        .map((d) => d.reference.parent.parent?.id)
        .where((id) => id != null)
        .cast<String>()
        .toSet()
        .toList();

    if (groupBuyIds.isEmpty) return [];

    // Firestore 'in' query limited to 30 at a time
    final results = <GroupBuyModel>[];
    for (var i = 0; i < groupBuyIds.length; i += 30) {
      final batch = groupBuyIds.sublist(
        i,
        i + 30 > groupBuyIds.length ? groupBuyIds.length : i + 30,
      );
      final batchSnap = await _firestore
          .collection('groupBuys')
          .where(FieldPath.documentId, whereIn: batch)
          .get();
      results.addAll(
        batchSnap.docs.map((d) => GroupBuyModel.fromFirestore(d)),
      );
    }

    return results;
  }

  @override
  Future<String> createGroupBuy({
    required String title,
    required String description,
    required int targetAmount,
    required DateTime deadline,
    String? linkedListingId,
    int minParticipants = 2,
    int? maxParticipants,
  }) async {
    final result = await _functions
        .httpsCallable('createGroupBuy')
        .call({
      'title': title,
      'description': description,
      'targetAmount': targetAmount,
      'deadline': deadline.toIso8601String(),
      if (linkedListingId != null) 'linkedListingId': linkedListingId,
      'minParticipants': minParticipants,
      if (maxParticipants != null) 'maxParticipants': maxParticipants,
    });
    return result.data['groupBuyId'] as String;
  }

  @override
  Future<void> joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
  }) async {
    await _functions
        .httpsCallable('joinGroupBuy')
        .call({
      'groupBuyId': groupBuyId,
      'amount': amount,
      'walletId': walletId,
    });
  }
}
