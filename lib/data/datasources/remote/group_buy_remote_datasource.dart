import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/enums/group_buy_type.dart';
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
    String? imageUrl,
    int? pricePerPerson,
  });
  Future<void> joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
    String? deliveryAddress,
  });
  Future<List<GroupBuyModel>> getHubGroupBuys({
    List<String> userClusters = const [],
  });
  Future<void> completeGroupBuy({required String groupBuyId});
  Future<void> leaveGroupBuy({required String groupBuyId});
  Future<String> suggestGroupBuyDeal({
    required String description,
    required String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    bool wantsToJoin,
  });
  Future<void> confirmCollection({
    required String groupBuyId,
    required String contributionId,
  });
  Future<void> cancelGroupBuy({
    required String groupBuyId,
    String? reason,
  });
  Future<void> updateDeliveryStatus({
    required String groupBuyId,
    required String deliveryStatus,
    String? trackingInfo,
  });
  Future<void> extendDeadline({
    required String groupBuyId,
    required DateTime newDeadline,
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
        .limit(100)
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
    String? imageUrl,
    int? pricePerPerson,
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
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (pricePerPerson != null) 'pricePerPerson': pricePerPerson,
    });
    return result.data['groupBuyId'] as String;
  }

  @override
  Future<void> joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
    String? deliveryAddress,
  }) async {
    await _functions
        .httpsCallable('joinGroupBuy')
        .call({
      'groupBuyId': groupBuyId,
      'amount': amount,
      'walletId': walletId,
      if (deliveryAddress != null) 'deliveryAddress': deliveryAddress,
    });
  }

  @override
  Future<void> completeGroupBuy({required String groupBuyId}) async {
    await _functions
        .httpsCallable('completeGroupBuy')
        .call({'groupBuyId': groupBuyId});
  }

  @override
  Future<void> leaveGroupBuy({required String groupBuyId}) async {
    await _functions
        .httpsCallable('leaveGroupBuy')
        .call({'groupBuyId': groupBuyId});
  }

  @override
  Future<String> suggestGroupBuyDeal({
    required String description,
    required String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    bool wantsToJoin = true,
  }) async {
    final result = await _functions
        .httpsCallable('suggestGroupBuyDeal')
        .call({
      'description': description,
      'brandOrStore': brandOrStore,
      if (estimatedPrice != null) 'estimatedPrice': estimatedPrice,
      if (sourceUrl != null) 'sourceUrl': sourceUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'wantsToJoin': wantsToJoin,
    });
    return result.data['requestId'] as String;
  }

  @override
  Future<List<GroupBuyModel>> getHubGroupBuys({
    List<String> userClusters = const [],
  }) async {
    // Get all admin-curated open group buys
    final snap = await _firestore
        .collection('groupBuys')
        .where('createdByAdmin', isEqualTo: true)
        .where('status', isEqualTo: 'open')
        .orderBy('deadline', descending: false)
        .limit(20)
        .get();

    final allDeals =
        snap.docs.map((d) => GroupBuyModel.fromFirestore(d)).toList();

    // Filter: digital deals shown to all, physical deals only if user
    // is in a matching cluster
    return allDeals.where((deal) {
      if (deal.type == GroupBuyType.digital) return true;
      if (deal.clusters.isEmpty) return true;
      if (userClusters.isEmpty) return false;
      return deal.clusters.any((c) => userClusters.contains(c));
    }).toList();
  }

  @override
  Future<void> confirmCollection({
    required String groupBuyId,
    required String contributionId,
  }) async {
    await _functions.httpsCallable('confirmGroupBuyCollection').call({
      'groupBuyId': groupBuyId,
      'contributionId': contributionId,
    });
  }

  @override
  Future<void> cancelGroupBuy({
    required String groupBuyId,
    String? reason,
  }) async {
    await _functions.httpsCallable('cancelCommunityGroupBuy').call({
      'groupBuyId': groupBuyId,
      if (reason != null) 'reason': reason,
    });
  }

  @override
  Future<void> updateDeliveryStatus({
    required String groupBuyId,
    required String deliveryStatus,
    String? trackingInfo,
  }) async {
    await _functions.httpsCallable('updateGroupBuyDeliveryStatus').call({
      'groupBuyId': groupBuyId,
      'deliveryStatus': deliveryStatus,
      if (trackingInfo != null) 'trackingInfo': trackingInfo,
    });
  }

  @override
  Future<void> extendDeadline({
    required String groupBuyId,
    required DateTime newDeadline,
  }) async {
    await _functions.httpsCallable('extendGroupBuyDeadline').call({
      'groupBuyId': groupBuyId,
      'newDeadline': newDeadline.toUtc().toIso8601String(),
    });
  }
}
