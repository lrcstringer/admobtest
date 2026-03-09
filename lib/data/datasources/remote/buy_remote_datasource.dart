import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/brand_storefront_model.dart';
import '../../models/buy_category_model.dart';
import '../../models/buy_regular_model.dart';
import '../../models/featured_item_model.dart';

abstract class BuyRemoteDataSource {
  /// Get all buy categories from Firestore
  Future<List<BuyCategoryModel>> getBuyCategories();

  /// Get user's buy regulars from Firestore
  Future<List<BuyRegularModel>> getBuyRegulars();

  /// Get active featured items from Firestore
  Future<List<FeaturedItemModel>> getFeaturedItems();

  /// Get active brand storefronts (for the strip)
  Future<List<BrandStorefrontModel>> getBrandStorefronts();

  /// Get a single brand storefront by ID
  Future<BrandStorefrontModel?> getBrandStorefront(String id);
}

@LazySingleton(as: BuyRemoteDataSource)
class BuyRemoteDataSourceImpl implements BuyRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  BuyRemoteDataSourceImpl(this._firestore, this._firebaseAuth);

  CollectionReference<Map<String, dynamic>> get _categoriesCollection =>
      _firestore.collection('buyCategories');

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
    final snapshot = await _firestore
        .collection('featuredItems')
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
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
    data['id'] = doc.id;
    return BrandStorefrontModel.fromJson(data);
  }
}
