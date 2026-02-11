import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../models/reward_campaign_model.dart';
import '../../models/reward_item_model.dart';

abstract class RewardRemoteDataSource {
  String? get currentUserId;

  /// Get user's reward items (allocated/redeemed/expired)
  Future<List<RewardItemModel>> getUserRewardItems({String? status});

  /// Get single reward item with decrypted code value
  Future<RewardItemModel> getRewardItemDetail(String itemId);

  /// Mark reward item as redeemed
  Future<void> redeemRewardItem(String itemId, {String? location});

  /// Get active reward campaigns the user can earn from
  Future<List<RewardCampaignModel>> getActiveCampaigns();
}

@LazySingleton(as: RewardRemoteDataSource)
class RewardRemoteDataSourceImpl implements RewardRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;

  RewardRemoteDataSourceImpl(
    this._firebaseAuth,
    this._functions,
  );

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<List<RewardItemModel>> getUserRewardItems({String? status}) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getUserRewardItems');
      final result = await callable.call<Map<String, dynamic>>({
        if (status != null) 'status': status,
      });

      final data = result.data;
      final items = (data['items'] as List?) ?? [];

      return items.map((item) {
        final itemMap = deepConvertMap(item as Map);
        return RewardItemModel.fromJson(itemMap);
      }).toList();
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to fetch reward items');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<RewardItemModel> getRewardItemDetail(String itemId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getRewardItemDetail');
      final result = await callable.call<Map<String, dynamic>>({
        'itemId': itemId,
      });

      final data = result.data;
      final item = data['item'] as Map<String, dynamic>?;
      if (item == null) {
        throw const ServerException(message: 'Reward item not found');
      }

      final itemMap = deepConvertMap(item);
      return RewardItemModel.fromJson(itemMap);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to fetch reward item detail');
    } catch (e) {
      if (e is AuthException || e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> redeemRewardItem(String itemId, {String? location}) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('redeemRewardItem');
      final result = await callable.call<Map<String, dynamic>>({
        'itemId': itemId,
        if (location != null) 'location': location,
      });

      final data = result.data;
      if (data['success'] != true) {
        throw ServerException(
            message: data['error'] as String? ?? 'Failed to redeem reward');
      }
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to redeem reward item');
    } catch (e) {
      if (e is AuthException || e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<RewardCampaignModel>> getActiveCampaigns() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getActiveRewardCampaigns');
      final result = await callable.call<Map<String, dynamic>>({});

      final data = result.data;
      final campaigns = (data['campaigns'] as List?) ?? [];

      return campaigns.map((campaign) {
        final campaignMap = deepConvertMap(campaign as Map);
        return RewardCampaignModel.fromJson(campaignMap);
      }).toList();
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to fetch active campaigns');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
