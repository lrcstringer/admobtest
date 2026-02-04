import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../../domain/entities/cashout.dart';
import '../../models/cashout_model.dart';
import '../../models/ledger_account_model.dart';
import '../../models/ledger_journal_model.dart';
import '../../models/user_engagement_stats_model.dart';

abstract class WalletRemoteDataSource {
  String? get currentUserId;

  // Ledger account methods
  Future<LedgerAccountModel?> getLedgerAccount();
  Stream<LedgerAccountModel?> watchLedgerAccount();
  Future<int> getLedgerBalance();

  // Ledger journal methods (transaction history from Trust Ledger)
  Future<List<LedgerJournalModel>> getLedgerJournals({
    int? limit,
    DateTime? startAfter,
  });
  Stream<List<LedgerJournalModel>> watchLedgerJournals({int? limit});

  // Engagement stats methods (streak tracking)
  Future<UserEngagementStatsModel?> getEngagementStats();
  Stream<UserEngagementStatsModel?> watchEngagementStats();

  // Cashout methods
  Future<CashoutModel> requestCashout({
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

  CollectionReference<Map<String, dynamic>> get _cashoutCollection =>
      _firestore.collection('cashouts');

  CollectionReference<Map<String, dynamic>> get _ledgerAccountsCollection =>
      _firestore.collection('ledgerAccounts');

  CollectionReference<Map<String, dynamic>> get _ledgerJournalsCollection =>
      _firestore.collection('ledgerJournals');

  CollectionReference<Map<String, dynamic>> get _engagementStatsCollection =>
      _firestore.collection('userEngagementStats');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  // ============================================================
  // Ledger Account Methods
  // ============================================================

  @override
  Future<LedgerAccountModel?> getLedgerAccount() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      // Ledger account ID format: user:{userId}
      final doc = await _ledgerAccountsCollection.doc('user:$userId').get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return LedgerAccountModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<LedgerAccountModel?> watchLedgerAccount() {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    return _ledgerAccountsCollection.doc('user:$userId').snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return LedgerAccountModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    });
  }

  @override
  Future<int> getLedgerBalance() async {
    final account = await getLedgerAccount();
    return account?.balance ?? 0;
  }

  // ============================================================
  // Ledger Journal Methods
  // ============================================================

  @override
  Future<List<LedgerJournalModel>> getLedgerJournals({
    int? limit,
    DateTime? startAfter,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      // Query journals where user's account appears in the entries
      // Account ID format: user:{userId}
      final userAccountId = 'user:$userId';

      var query = _ledgerJournalsCollection
          .where('status', isEqualTo: 'posted')
          .orderBy('postedAt', descending: true);

      if (startAfter != null) {
        query = query.startAfter([Timestamp.fromDate(startAfter)]);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();

      // Filter journals that contain the user's account in entries
      final journals = <LedgerJournalModel>[];
      for (final doc in snapshot.docs) {
        final data = sanitizeFirestoreData(doc.data());
        final entries = data['entries'] as List<dynamic>? ?? [];

        // Check if user's account is in any entry
        final hasUserAccount = entries.any((entry) {
          final e = entry as Map<String, dynamic>;
          return e['accountId'] == userAccountId;
        });

        if (hasUserAccount) {
          journals.add(LedgerJournalModel.fromJson({...data, 'id': doc.id}));
        }
      }

      return journals;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<LedgerJournalModel>> watchLedgerJournals({int? limit}) {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    final userAccountId = 'user:$userId';

    var query = _ledgerJournalsCollection
        .where('status', isEqualTo: 'posted')
        .orderBy('postedAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final journals = <LedgerJournalModel>[];
      for (final doc in snapshot.docs) {
        final data = sanitizeFirestoreData(doc.data());
        final entries = data['entries'] as List<dynamic>? ?? [];

        // Check if user's account is in any entry
        final hasUserAccount = entries.any((entry) {
          final e = entry as Map<String, dynamic>;
          return e['accountId'] == userAccountId;
        });

        if (hasUserAccount) {
          journals.add(LedgerJournalModel.fromJson({...data, 'id': doc.id}));
        }
      }
      return journals;
    });
  }

  // ============================================================
  // Engagement Stats Methods
  // ============================================================

  @override
  Future<UserEngagementStatsModel?> getEngagementStats() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final doc = await _engagementStatsCollection.doc(userId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return UserEngagementStatsModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<UserEngagementStatsModel?> watchEngagementStats() {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    return _engagementStatsCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return UserEngagementStatsModel.fromFirestore(doc);
    });
  }

  // ============================================================
  // Cashout Methods
  // ============================================================

  @override
  Future<CashoutModel> requestCashout({
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
        id: data['cashoutId'] as String? ?? '',
        walletId: 'user:$userId', // Use ledger account ID
        userId: userId,
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
          .where('userId', isEqualTo: userId)
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
      if (data['userId'] != userId) {
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
