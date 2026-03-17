import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/brand_product_model.dart';
import '../../models/brand_review_model.dart';
import '../../models/brand_storefront_model.dart';
import '../../models/buy_category_model.dart';
import '../../models/buy_regular_model.dart';
import '../../models/featured_item_model.dart';
import '../../models/vas_category_model.dart';

abstract class BuyRemoteDataSource {
  /// Get all buy categories from Firestore
  Future<List<BuyCategoryModel>> getBuyCategories();

  /// Get all VAS categories from Firestore
  Future<List<VasCategoryModel>> getVasCategories();

  /// Get user's buy regulars from Firestore
  Future<List<BuyRegularModel>> getBuyRegulars();

  /// Get active featured items from Firestore
  Future<List<FeaturedItemModel>> getFeaturedItems();

  /// Get active brand storefronts (for the strip)
  Future<List<BrandStorefrontModel>> getBrandStorefronts();

  /// Get a single brand storefront by ID
  Future<BrandStorefrontModel?> getBrandStorefront(String id);

  /// Get products for a brand storefront
  Future<List<BrandProductModel>> getBrandProducts(String storefrontId);

  /// Get visible reviews for a brand
  Future<List<BrandReviewModel>> getBrandReviews(String brandId);

  /// Submit a review for a brand via Cloud Function
  Future<void> submitBrandReview({
    required String brandId,
    required String orderId,
    required int qualityRating,
    required int valueRating,
    required int serviceRating,
    String? comment,
  });

  /// Check if the current user is following a brand, and when they followed
  Future<({bool isFollowing, DateTime? followedAt})> getFollowStatus(String brandId);

  /// Check if the current user is following a brand
  Future<bool> isFollowingBrand(String brandId);

  /// Get marketplace stats (listing count, seller count, trending thumbnails)
  Future<({int listingCount, int sellerCount, List<String> thumbnails})>
      getMarketplaceStats();

  /// Claim a coupon from a brand storefront
  Future<String> claimStorefrontCoupon({
    required String storefrontId,
    required String couponId,
    String? couponCode,
  });

  /// Get coupon IDs the current user has already claimed for a storefront
  Future<Set<String>> getClaimedCouponIds(String storefrontId);

  /// Record a storefront view (fire-and-forget analytics)
  Future<void> recordStorefrontView(String storefrontId);

  /// Toggle follow/unfollow for a brand
  Future<bool> toggleBrandFollow(String brandId);

  /// Toggle pin/unpin for a buy regular
  Future<void> toggleRegularPin(String regularId, {required bool isPinned});

  /// Delete a buy regular
  Future<void> deleteRegular(String regularId);
}

@LazySingleton(as: BuyRemoteDataSource)
class BuyRemoteDataSourceImpl implements BuyRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  BuyRemoteDataSourceImpl(this._firestore, this._firebaseAuth);

  FirebaseFunctions get _functions =>
      FirebaseFunctions.instanceFor(region: 'africa-south1');

  CollectionReference<Map<String, dynamic>> get _categoriesCollection =>
      _firestore.collection('buyCategories');

  CollectionReference<Map<String, dynamic>> get _vasCategoriesCollection =>
      _firestore.collection('vasCategories');

  @override
  Future<List<BuyCategoryModel>> getBuyCategories() async {
    final snapshot = await _categoriesCollection
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    // Also get coming soon items (separate query since Firestore
    // doesn't support OR on different fields)
    final comingSoonSnapshot = await _categoriesCollection
        .where('isComingSoon', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    final seenIds = <String>{};
    final categories = <BuyCategoryModel>[];

    for (final doc in [...snapshot.docs, ...comingSoonSnapshot.docs]) {
      if (seenIds.add(doc.id)) {
        final data = doc.data();
        data['id'] = doc.id;
        categories.add(BuyCategoryModel.fromJson(data));
      }
    }

    categories.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return categories;
  }

  @override
  Future<List<VasCategoryModel>> getVasCategories() async {
    final snapshot = await _vasCategoriesCollection
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return VasCategoryModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<BuyRegularModel>> getBuyRegulars() async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return [];

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('buyRegulars')
        .orderBy('lastUsedAt', descending: true)
        .limit(20)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return BuyRegularModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<FeaturedItemModel>> getFeaturedItems() async {
    // Server-side filter: only fetch items whose schedule hasn't expired.
    // Items without scheduledEnd are open-ended and always included.
    // Client-side isCurrentlyActive check provides defense-in-depth.
    // Note: isDeleted filter removed from query — Firestore treats a missing
    // field as != false, so docs without isDeleted would be silently excluded.
    // Client-side isCurrentlyActiveAt() checks isDeleted as defense-in-depth.
    final snapshot = await _firestore
        .collection('featuredItems')
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .limit(50)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return FeaturedItemModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<BrandStorefrontModel>> getBrandStorefronts() async {
    final snapshot = await _firestore
        .collection('brandStorefronts')
        .where('isActive', isEqualTo: true)
        .where('isDeleted', isEqualTo: false)
        .where('isDraft', isEqualTo: false)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return BrandStorefrontModel.fromJson(data);
    }).toList();
  }

  @override
  Future<BrandStorefrontModel?> getBrandStorefront(String id) async {
    final doc =
        await _firestore.collection('brandStorefronts').doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    // Guard: reject inactive, deleted, or draft storefronts
    if (data['isActive'] == false ||
        data['isDeleted'] == true ||
        data['isDraft'] == true) {
      return null;
    }
    data['id'] = doc.id;
    return BrandStorefrontModel.fromJson(data);
  }

  @override
  Future<List<BrandProductModel>> getBrandProducts(String storefrontId) async {
    final snapshot = await _firestore
        .collection('brandProducts')
        .where('storefrontId', isEqualTo: storefrontId)
        .where('isActive', isEqualTo: true)
        .where('isDeleted', isEqualTo: false)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return BrandProductModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<BrandReviewModel>> getBrandReviews(String brandId) async {
    // Reviews are stored in top-level brandReviews collection (matching CF)
    final snapshot = await _firestore
        .collection('brandReviews')
        .where('brandId', isEqualTo: brandId)
        .where('isRemovedByAdmin', isEqualTo: false)
        .where('isFiltered', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return BrandReviewModel.fromJson(data);
    }).toList();
  }

  @override
  Future<void> submitBrandReview({
    required String brandId,
    required String orderId,
    required int qualityRating,
    required int valueRating,
    required int serviceRating,
    String? comment,
  }) async {
    await _functions.httpsCallable('submitBrandReview').call<dynamic>({
      'brandId': brandId,
      'orderId': orderId,
      'qualityRating': qualityRating,
      'valueRating': valueRating,
      'serviceRating': serviceRating,
      if (comment != null && comment.isNotEmpty) 'comment': comment,
    });
  }

  @override
  Future<({bool isFollowing, DateTime? followedAt})> getFollowStatus(
      String brandId) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return (isFollowing: false, followedAt: null);

    final doc = await _firestore
        .collection('brandFollowers')
        .doc(brandId)
        .collection('followers')
        .doc(uid)
        .get();
    if (!doc.exists) return (isFollowing: false, followedAt: null);

    final data = doc.data();
    DateTime? followedAt;
    if (data != null && data['followedAt'] is Timestamp) {
      followedAt = (data['followedAt'] as Timestamp).toDate();
    }
    return (isFollowing: true, followedAt: followedAt);
  }

  @override
  Future<bool> isFollowingBrand(String brandId) async {
    final status = await getFollowStatus(brandId);
    return status.isFollowing;
  }

  @override
  Future<({int listingCount, int sellerCount, List<String> thumbnails})>
      getMarketplaceStats() async {
    final listingsSnapshot = await _firestore
        .collection('marketplaceListings')
        .where('status', isEqualTo: 'active')
        .count()
        .get();

    final sellersSnapshot = await _firestore
        .collection('providers')
        .where('status', isEqualTo: 'approved')
        .count()
        .get();

    final trendingSnapshot = await _firestore
        .collection('marketplaceListings')
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(4)
        .get();

    final thumbnails = trendingSnapshot.docs
        .map((doc) {
          final data = doc.data();
          final thumb = data['thumbnailUrl'] as String?;
          if (thumb != null && thumb.isNotEmpty) return thumb;
          final images = data['images'] as List<dynamic>?;
          return images?.firstOrNull as String?;
        })
        .where((url) => url != null && url.isNotEmpty)
        .cast<String>()
        .toList();

    return (
      listingCount: listingsSnapshot.count ?? 0,
      sellerCount: sellersSnapshot.count ?? 0,
      thumbnails: thumbnails,
    );
  }

  @override
  Future<String> claimStorefrontCoupon({
    required String storefrontId,
    required String couponId,
    String? couponCode,
  }) async {
    final result =
        await _functions.httpsCallable('claimStorefrontCoupon').call({
      'storefrontId': storefrontId,
      'couponId': couponId,
      if (couponCode != null) 'couponCode': couponCode,
    });
    return (result.data['couponCode'] as String?) ?? couponCode ?? couponId;
  }

  @override
  Future<Set<String>> getClaimedCouponIds(String storefrontId) async {
    final result =
        await _functions.httpsCallable('getClaimedCoupons').call({
      'storefrontId': storefrontId,
    });
    final couponIds = (result.data['couponIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toSet() ??
        {};
    return couponIds;
  }

  @override
  Future<void> recordStorefrontView(String storefrontId) async {
    await _functions.httpsCallable('recordStorefrontView').call({
      'storefrontId': storefrontId,
    });
  }

  @override
  Future<bool> toggleBrandFollow(String brandId) async {
    final result =
        await _functions.httpsCallable('toggleBrandFollow').call({
      'brandId': brandId,
    });
    return result.data['isFollowing'] as bool;
  }

  @override
  Future<void> toggleRegularPin(String regularId, {required bool isPinned}) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('buyRegulars')
        .doc(regularId)
        .update({'isPinned': isPinned});
  }

  @override
  Future<void> deleteRegular(String regularId) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('buyRegulars')
        .doc(regularId)
        .delete();
  }
}
