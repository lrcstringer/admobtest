import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../models/purchase_model.dart';
import '../../models/service_provider_model.dart';

abstract class PurchaseRemoteDataSource {
  /// Get all service providers
  Future<List<ServiceProviderModel>> getServiceProviders();

  /// Get providers by category
  Future<List<ServiceProviderModel>> getProvidersByCategory(String category);

  /// Get provider by ID
  Future<ServiceProviderModel> getProviderById(String providerId);

  /// Get products for provider
  Future<List<ServiceProductModel>> getProducts(String providerId);

  /// Get product by ID
  Future<ServiceProductModel> getProductById(String productId);

  /// Make a purchase
  Future<PurchaseModel> makePurchase({
    required String productId,
    required String recipientNumber,
  });

  /// Get purchase history
  Future<List<PurchaseModel>> getPurchaseHistory({
    String? category,
    int? limit,
    DateTime? startAfter,
  });

  /// Get purchase by ID
  Future<PurchaseModel> getPurchaseById(String purchaseId);

  /// Get recent recipients
  Future<List<String>> getRecentRecipients({
    String? category,
    int? limit,
  });

  /// Validate recipient number
  Future<bool> validateRecipientNumber({
    required String number,
    required String category,
  });
}

@LazySingleton(as: PurchaseRemoteDataSource)
class PurchaseRemoteDataSourceImpl implements PurchaseRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  PurchaseRemoteDataSourceImpl(
    this._firestore,
    this._auth,
    this._functions,
    this._playIntegrity,
  );

  String get _userId => _auth.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> get _providersCollection =>
      _firestore.collection('serviceProviders');

  CollectionReference<Map<String, dynamic>> get _productsCollection =>
      _firestore.collection('serviceProducts');

  CollectionReference<Map<String, dynamic>> get _purchasesCollection =>
      _firestore.collection('purchases');

  @override
  Future<List<ServiceProviderModel>> getServiceProviders() async {
    final snapshot = await _providersCollection
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ServiceProviderModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<ServiceProviderModel>> getProvidersByCategory(
      String category) async {
    final snapshot = await _providersCollection
        .where('isActive', isEqualTo: true)
        .where('category', isEqualTo: category)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ServiceProviderModel.fromJson(data);
    }).toList();
  }

  @override
  Future<ServiceProviderModel> getProviderById(String providerId) async {
    final doc = await _providersCollection.doc(providerId).get();

    if (!doc.exists) {
      throw Exception('Provider not found');
    }

    final data = doc.data()!;
    data['id'] = doc.id;
    return ServiceProviderModel.fromJson(data);
  }

  @override
  Future<List<ServiceProductModel>> getProducts(String providerId) async {
    final snapshot = await _productsCollection
        .where('providerId', isEqualTo: providerId)
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ServiceProductModel.fromJson(data);
    }).toList();
  }

  @override
  Future<ServiceProductModel> getProductById(String productId) async {
    final doc = await _productsCollection.doc(productId).get();

    if (!doc.exists) {
      throw Exception('Product not found');
    }

    final data = doc.data()!;
    data['id'] = doc.id;
    return ServiceProductModel.fromJson(data);
  }

  @override
  Future<PurchaseModel> makePurchase({
    required String productId,
    required String recipientNumber,
  }) async {
    try {
      // Get Play Integrity token for this sensitive operation
      final nonce = _playIntegrity.generateNonce();
      final integrityToken = await _playIntegrity.getIntegrityToken(nonce: nonce);

      final callable = _functions.httpsCallable('processPurchase');
      final result = await callable.call<Map<String, dynamic>>({
        'productId': productId,
        'recipientNumber': recipientNumber,
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final data = result.data;
      return PurchaseModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Purchase failed');
    }
  }

  @override
  Future<List<PurchaseModel>> getPurchaseHistory({
    String? category,
    int? limit,
    DateTime? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = _purchasesCollection
        .where('oddienceUserId', isEqualTo: _userId)
        .orderBy('createdAt', descending: true);

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }

    if (startAfter != null) {
      query = query.startAfter([Timestamp.fromDate(startAfter)]);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return PurchaseModel.fromJson(data);
    }).toList();
  }

  @override
  Future<PurchaseModel> getPurchaseById(String purchaseId) async {
    final doc = await _purchasesCollection.doc(purchaseId).get();

    if (!doc.exists) {
      throw Exception('Purchase not found');
    }

    final data = doc.data()!;
    data['id'] = doc.id;
    return PurchaseModel.fromJson(data);
  }

  @override
  Future<List<String>> getRecentRecipients({
    String? category,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _purchasesCollection
        .where('oddienceUserId', isEqualTo: _userId)
        .where('status', isEqualTo: 'completed')
        .orderBy('createdAt', descending: true);

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }

    final snapshot = await query.limit(limit ?? 10).get();

    // Extract unique recipient numbers
    final recipients = <String>{};
    for (final doc in snapshot.docs) {
      final recipientNumber = doc.data()['recipientNumber'] as String?;
      if (recipientNumber != null && recipientNumber.isNotEmpty) {
        recipients.add(recipientNumber);
      }
    }

    return recipients.toList();
  }

  @override
  Future<bool> validateRecipientNumber({
    required String number,
    required String category,
  }) async {
    // Basic validation based on category
    final cleanedNumber = number.replaceAll(RegExp(r'[^0-9]'), '');

    switch (category) {
      case 'airtime':
      case 'data':
        // SA mobile numbers: 10 digits starting with 0
        return cleanedNumber.length == 10 && cleanedNumber.startsWith('0');
      case 'electricity':
        // Meter numbers: typically 11-13 digits
        return cleanedNumber.length >= 11 && cleanedNumber.length <= 13;
      default:
        return cleanedNumber.length >= 10;
    }
  }
}
