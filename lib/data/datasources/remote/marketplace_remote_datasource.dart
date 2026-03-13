import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/buy_order_model.dart';
import '../../models/marketplace_listing_model.dart';
import '../../models/marketplace_offer_model.dart';
import '../../models/marketplace_provider_model.dart';
import '../../models/vouch_model.dart';

abstract class MarketplaceRemoteDataSource {
  /// Get marketplace listings by category (paginated)
  Future<List<MarketplaceListingModel>> getListings({
    String? category,
    String? communityId,
    int limit = 20,
    String? startAfterId,
  });

  /// Get a single listing by ID
  Future<MarketplaceListingModel?> getListing(String id);

  /// Get a marketplace provider profile
  Future<MarketplaceProviderModel?> getProvider(String id);

  /// Get provider's listings. When [statusFilter] is provided, only listings
  /// with that status are returned; when null, all statuses are included
  /// (for seller's own listing management).
  Future<List<MarketplaceListingModel>> getProviderListings(
    String providerId, {
    String? statusFilter,
  });

  /// Get vouches for a provider
  Future<List<VouchModel>> getProviderVouches(String providerId);

  /// Get user's orders (as buyer)
  Future<List<BuyOrderModel>> getBuyerOrders();

  /// Get user's orders (as seller)
  Future<List<BuyOrderModel>> getSellerOrders();

  /// Get a single order by ID
  Future<BuyOrderModel?> getOrder(String id);

  /// Register as a marketplace provider (calls CF)
  Future<String> registerProvider({
    required String displayName,
    String? bio,
    String? photoUrl,
    String? servicesDescription,
    String? communityId,
    String? category,
  });

  /// Create a marketplace listing (calls CF)
  Future<String> createListing({
    required String title,
    required String description,
    required String category,
    String? subCategory,
    required int priceTokens,
    required List<String> imageUrls,
    String? location,
    String? deliveryMethod,
    int? deliveryFee,
    String? serviceAreaType,
    Map<String, dynamic>? locationData,
  });

  /// Buy a marketplace item (calls CF — creates escrow)
  Future<String> buyItem({
    required String listingId,
    required String walletId,
  });

  /// Seller confirms fulfilment (calls CF)
  Future<void> confirmFulfilment(String orderId);

  /// Buyer confirms receipt (calls CF — releases escrow)
  Future<void> confirmReceipt(String orderId);

  /// Cancel an order (calls CF)
  Future<void> cancelOrder(String orderId);

  /// Dispute an order (calls CF)
  Future<void> disputeOrder(String orderId, String reason);

  /// Vouch for a provider (calls CF)
  Future<void> vouchForProvider({
    required String providerId,
    required int rating,
    String? comment,
    String? orderId,
  });

  /// Report a listing or provider (calls CF)
  Future<void> reportItem({
    required String targetId,
    required String targetType,
    required String reason,
    String? description,
  });

  /// Update an existing listing (calls CF)
  Future<void> updateListing({
    required String listingId,
    String? title,
    String? description,
    String? category,
    int? priceTokens,
    List<String>? imageUrls,
    String? location,
  });

  /// Toggle listing status (calls CF)
  Future<void> toggleListingStatus({
    required String listingId,
    required String action,
  });

  /// Renew an expired listing (calls CF)
  Future<void> renewListing({required String listingId});

  /// Make an offer on a listing (calls CF)
  Future<String> makeOffer({
    required String listingId,
    required int offerAmount,
    String? message,
  });

  /// Respond to an offer (calls CF)
  Future<String?> respondToOffer({
    required String offerId,
    required String action,
    int? counterAmount,
  });

  /// Seller-initiated refund (calls CF)
  Future<void> sellerRefund({
    required String orderId,
    String? reason,
  });

  /// Get a single offer by ID (Firestore read)
  Future<MarketplaceOfferModel?> getOffer(String offerId);

  /// Get seller dashboard analytics (calls CF)
  Future<Map<String, dynamic>> getSellerDashboard();

  /// Get marketplace stats (listing count, seller count, trending thumbnails)
  Future<({int listingCount, int sellerCount, List<String> thumbnails})>
      getMarketplaceStats();
}

@LazySingleton(as: MarketplaceRemoteDataSource)
class MarketplaceRemoteDataSourceImpl implements MarketplaceRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;

  MarketplaceRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
  );

  String? get _uid => _firebaseAuth.currentUser?.uid;

  @override
  Future<List<MarketplaceListingModel>> getListings({
    String? category,
    String? communityId,
    int limit = 20,
    String? startAfterId,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('marketplaceListings')
        .where('status', isEqualTo: 'active');

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }
    if (communityId != null) {
      query = query.where('communityId', isEqualTo: communityId);
    }

    query = query.orderBy('createdAt', descending: true).limit(limit);

    // Resolve document ID to snapshot for cursor-based pagination.
    // If cursor document was deleted, return empty to signal end of data
    // rather than silently restarting from the beginning.
    if (startAfterId != null) {
      final cursorDoc = await _firestore
          .collection('marketplaceListings')
          .doc(startAfterId)
          .get();
      if (cursorDoc.exists) {
        query = query.startAfterDocument(cursorDoc);
      } else {
        return [];
      }
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return MarketplaceListingModel.fromJson(data);
    }).toList();
  }

  @override
  Future<MarketplaceListingModel?> getListing(String id) async {
    final doc =
        await _firestore.collection('marketplaceListings').doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    data['id'] = doc.id;
    return MarketplaceListingModel.fromJson(data);
  }

  @override
  Future<MarketplaceProviderModel?> getProvider(String id) async {
    final doc =
        await _firestore.collection('providers').doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    data['id'] = doc.id;
    return MarketplaceProviderModel.fromJson(data);
  }

  @override
  Future<List<MarketplaceListingModel>> getProviderListings(
    String providerId, {
    String? statusFilter,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('marketplaceListings')
        .where('providerId', isEqualTo: providerId);

    if (statusFilter != null) {
      query = query.where('status', isEqualTo: statusFilter);
    }

    final snapshot = await query
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return MarketplaceListingModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<VouchModel>> getProviderVouches(String providerId) async {
    final snapshot = await _firestore
        .collection('vouches')
        .where('providerId', isEqualTo: providerId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return VouchModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<BuyOrderModel>> getBuyerOrders() async {
    final uid = _uid;
    if (uid == null) return [];

    final snapshot = await _firestore
        .collection('buyOrders')
        .where('buyerId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return BuyOrderModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<BuyOrderModel>> getSellerOrders() async {
    final uid = _uid;
    if (uid == null) return [];

    final snapshot = await _firestore
        .collection('buyOrders')
        .where('sellerId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return BuyOrderModel.fromJson(data);
    }).toList();
  }

  @override
  Future<BuyOrderModel?> getOrder(String id) async {
    final doc = await _firestore.collection('buyOrders').doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    data['id'] = doc.id;
    return BuyOrderModel.fromJson(data);
  }

  @override
  Future<String> registerProvider({
    required String displayName,
    String? bio,
    String? photoUrl,
    String? servicesDescription,
    String? communityId,
    String? category,
  }) async {
    final result =
        await _functions.httpsCallable('registerMarketplaceProvider').call({
      'displayName': displayName,
      if (bio != null) 'bio': bio,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (servicesDescription != null)
        'servicesDescription': servicesDescription,
      if (communityId != null) 'communityId': communityId,
      if (category != null) 'category': category,
    });
    return result.data['providerId'] as String;
  }

  @override
  Future<String> createListing({
    required String title,
    required String description,
    required String category,
    String? subCategory,
    required int priceTokens,
    required List<String> imageUrls,
    String? location,
    String? deliveryMethod,
    int? deliveryFee,
    String? serviceAreaType,
    Map<String, dynamic>? locationData,
  }) async {
    final result =
        await _functions.httpsCallable('createMarketplaceListing').call({
      'title': title,
      'description': description,
      'category': category,
      if (subCategory != null) 'subCategory': subCategory,
      'priceTokens': priceTokens,
      'imageUrls': imageUrls,
      if (location != null) 'location': location,
      if (deliveryMethod != null) 'deliveryMethod': deliveryMethod,
      if (deliveryFee != null) 'deliveryFee': deliveryFee,
      if (serviceAreaType != null) 'serviceAreaType': serviceAreaType,
      if (locationData != null) 'locationData': locationData,
    });
    return result.data['listingId'] as String;
  }

  @override
  Future<String> buyItem({
    required String listingId,
    required String walletId,
  }) async {
    final result =
        await _functions.httpsCallable('buyMarketplaceItem').call({
      'listingId': listingId,
      'walletId': walletId,
    });
    return result.data['orderId'] as String;
  }

  @override
  Future<void> confirmFulfilment(String orderId) async {
    await _functions.httpsCallable('confirmMarketplaceFulfilment').call({
      'orderId': orderId,
    });
  }

  @override
  Future<void> confirmReceipt(String orderId) async {
    await _functions.httpsCallable('confirmMarketplaceReceipt').call({
      'orderId': orderId,
    });
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _functions.httpsCallable('cancelMarketplaceOrder').call({
      'orderId': orderId,
    });
  }

  @override
  Future<void> disputeOrder(String orderId, String reason) async {
    await _functions.httpsCallable('disputeMarketplaceOrder').call({
      'orderId': orderId,
      'reason': reason,
    });
  }

  @override
  Future<void> vouchForProvider({
    required String providerId,
    required int rating,
    String? comment,
    String? orderId,
  }) async {
    await _functions.httpsCallable('vouchForProvider').call({
      'providerId': providerId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (orderId != null) 'orderId': orderId,
    });
  }

  @override
  Future<void> reportItem({
    required String targetId,
    required String targetType,
    required String reason,
    String? description,
  }) async {
    await _functions.httpsCallable('reportMarketplaceItem').call({
      'targetId': targetId,
      'targetType': targetType,
      'reason': reason,
      if (description != null) 'description': description,
    });
  }

  @override
  Future<void> updateListing({
    required String listingId,
    String? title,
    String? description,
    String? category,
    int? priceTokens,
    List<String>? imageUrls,
    String? location,
  }) async {
    await _functions.httpsCallable('updateMarketplaceListing').call({
      'listingId': listingId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (priceTokens != null) 'priceTokens': priceTokens,
      if (imageUrls != null) 'imageUrls': imageUrls,
      if (location != null) 'location': location,
    });
  }

  @override
  Future<void> toggleListingStatus({
    required String listingId,
    required String action,
  }) async {
    await _functions.httpsCallable('toggleMarketplaceListingStatus').call({
      'listingId': listingId,
      'action': action,
    });
  }

  @override
  Future<void> renewListing({required String listingId}) async {
    await _functions.httpsCallable('renewMarketplaceListing').call({
      'listingId': listingId,
    });
  }

  @override
  Future<String> makeOffer({
    required String listingId,
    required int offerAmount,
    String? message,
  }) async {
    final result = await _functions.httpsCallable('makeOffer').call({
      'listingId': listingId,
      'offerAmount': offerAmount,
      if (message != null) 'message': message,
    });
    return result.data['offerId'] as String;
  }

  @override
  Future<String?> respondToOffer({
    required String offerId,
    required String action,
    int? counterAmount,
  }) async {
    final result = await _functions.httpsCallable('respondToOffer').call({
      'offerId': offerId,
      'action': action,
      if (counterAmount != null) 'counterAmount': counterAmount,
    });
    return result.data['orderId'] as String?;
  }

  @override
  Future<void> sellerRefund({
    required String orderId,
    String? reason,
  }) async {
    await _functions.httpsCallable('sellerInitiatedRefund').call({
      'orderId': orderId,
      if (reason != null) 'reason': reason,
    });
  }

  @override
  Future<MarketplaceOfferModel?> getOffer(String offerId) async {
    final doc =
        await _firestore.collection('marketplaceOffers').doc(offerId).get();
    if (!doc.exists || doc.data() == null) return null;
    return MarketplaceOfferModel.fromJson({...doc.data()!, 'id': doc.id});
  }

  @override
  Future<Map<String, dynamic>> getSellerDashboard() async {
    final result =
        await _functions.httpsCallable('getSellerDashboard').call({});
    return Map<String, dynamic>.from(result.data['dashboard'] as Map);
  }

  @override
  Future<({int listingCount, int sellerCount, List<String> thumbnails})>
      getMarketplaceStats() async {
    // Get listing count (marketplaceListings use 'status' enum, not 'isActive')
    final listingsSnapshot = await _firestore
        .collection('marketplaceListings')
        .where('status', isEqualTo: 'active')
        .count()
        .get();

    // Get unique seller count (providers collection, status = 'approved')
    final sellersSnapshot = await _firestore
        .collection('providers')
        .where('status', isEqualTo: 'approved')
        .count()
        .get();

    // Get trending thumbnails (latest 4 listings with images)
    final trendingSnapshot = await _firestore
        .collection('marketplaceListings')
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(4)
        .get();

    // Listings store images as List<String> 'images' and optional 'thumbnailUrl'
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
}
