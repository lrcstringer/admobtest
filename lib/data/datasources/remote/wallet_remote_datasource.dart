import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../../domain/entities/cashout.dart';
import '../../models/wallet_model.dart';
import '../../models/transaction_model.dart';
import '../../models/cashout_model.dart';

abstract class WalletRemoteDataSource {
  String? get currentUserId;
  Future<WalletModel?> getWallet(String walletId);
  Future<WalletModel?> getMainWallet();
  Stream<WalletModel?> watchWallet(String walletId);
  Future<List<WalletModel>> getUserWallets();
  Stream<List<WalletModel>> watchUserWallets();
  Future<List<TransactionModel>> getTransactions({
    required String walletId,
    int? limit,
    DateTime? startAfter,
  });
  Stream<List<TransactionModel>> watchTransactions({
    required String walletId,
    int? limit,
  });
  Future<TransactionModel?> getTransaction(String transactionId);
  Future<CashoutModel> requestCashout({
    required String walletId,
    required int tokenAmount,
    required CashoutMethod method,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
  });
  Future<List<CashoutModel>> getCashoutHistory({
    int? limit,
    DateTime? startAfter,
  });
  Future<CashoutModel?> getCashout(String cashoutId);
  Future<void> cancelCashout(String cashoutId);
}

@LazySingleton(as: WalletRemoteDataSource)
class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  WalletRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _walletsCollection =>
      _firestore.collection('wallets');

  CollectionReference<Map<String, dynamic>> get _transactionsCollection =>
      _firestore.collection('transactions');

  CollectionReference<Map<String, dynamic>> get _cashoutCollection =>
      _firestore.collection('cashouts');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<WalletModel?> getWallet(String walletId) async {
    try {
      final doc = await _walletsCollection.doc(walletId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return WalletModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<WalletModel?> getMainWallet() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final snapshot = await _walletsCollection
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: 'main')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      final doc = snapshot.docs.first;
      return WalletModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<WalletModel?> watchWallet(String walletId) {
    return _walletsCollection.doc(walletId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return WalletModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    });
  }

  @override
  Future<List<WalletModel>> getUserWallets() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final snapshot = await _walletsCollection
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) {
        return WalletModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<WalletModel>> watchUserWallets() {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    return _walletsCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return WalletModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    });
  }

  @override
  Future<List<TransactionModel>> getTransactions({
    required String walletId,
    int? limit,
    DateTime? startAfter,
  }) async {
    try {
      var query = _transactionsCollection
          .where('walletId', isEqualTo: walletId)
          .orderBy('createdAt', descending: true);

      if (startAfter != null) {
        query = query.startAfter([Timestamp.fromDate(startAfter)]);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        return TransactionModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<TransactionModel>> watchTransactions({
    required String walletId,
    int? limit,
  }) {
    var query = _transactionsCollection
        .where('walletId', isEqualTo: walletId)
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TransactionModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    });
  }

  @override
  Future<TransactionModel?> getTransaction(String transactionId) async {
    try {
      final doc = await _transactionsCollection.doc(transactionId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return TransactionModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<CashoutModel> requestCashout({
    required String walletId,
    required int tokenAmount,
    required CashoutMethod method,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      // Get Play Integrity token for this sensitive operation
      final nonce = _playIntegrity.generateNonce();
      final integrityToken = await _playIntegrity.getIntegrityToken(nonce: nonce);

      final callable = _functions.httpsCallable('processCashout');
      final result = await callable.call<Map<String, dynamic>>({
        'amount': tokenAmount,
        'bankDetails': {
          'method': method.name,
          'destinationDetails': destinationDetails,
          'bankName': bankName,
          'accountNumber': accountNumber,
          'accountHolderName': accountHolderName,
          'mobileNumber': mobileNumber,
        },
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final data = result.data;
      final zarAmount = (data['zarAmount'] as num?)?.toDouble() ?? tokenAmount * 0.01;
      final now = DateTime.now();

      return CashoutModel(
        id: '',
        walletId: walletId,
        oddienceUserId: userId,
        tokenAmount: tokenAmount,
        zarAmount: zarAmount,
        method: method.name,
        status: 'pending',
        destinationDetails: destinationDetails,
        bankName: bankName,
        accountNumber: accountNumber,
        accountHolderName: accountHolderName,
        mobileNumber: mobileNumber,
        createdAt: now,
      );
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Cashout failed');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CashoutModel>> getCashoutHistory({
    int? limit,
    DateTime? startAfter,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      var query = _cashoutCollection
          .where('oddienceUserId', isEqualTo: userId)
          .orderBy('createdAt', descending: true);

      if (startAfter != null) {
        query = query.startAfter([Timestamp.fromDate(startAfter)]);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        return CashoutModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<CashoutModel?> getCashout(String cashoutId) async {
    try {
      final doc = await _cashoutCollection.doc(cashoutId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return CashoutModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> cancelCashout(String cashoutId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final doc = await _cashoutCollection.doc(cashoutId).get();
      if (!doc.exists) {
        throw const ServerException(message: 'Cashout not found');
      }

      final data = doc.data()!;
      if (data['oddienceUserId'] != userId) {
        throw const ServerException(message: 'Not authorized to cancel this cashout');
      }

      if (data['status'] != 'pending') {
        throw const ServerException(message: 'Can only cancel pending cashouts');
      }

      await _cashoutCollection.doc(cashoutId).update({
        'status': 'cancelled',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
