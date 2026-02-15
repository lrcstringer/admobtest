import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/cashout.dart';
import '../../domain/entities/ledger_account.dart';
import '../../domain/entities/ledger_journal.dart';
import '../../domain/entities/sub_account.dart';
import '../../domain/entities/user_engagement_stats.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/remote/wallet_remote_datasource.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  WalletRepositoryImpl(this._remoteDataSource, this._networkInfo);

  // ============================================================
  // Ledger Account Methods
  // ============================================================

  @override
  Future<Either<Failure, LedgerAccount>> getLedgerAccount() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final ledgerModel = await _remoteDataSource.getLedgerAccount();
      if (ledgerModel == null) {
        return const Left(Failure.serverError(message: 'Ledger account not found'));
      }
      return Right(ledgerModel.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, LedgerAccount>> watchLedgerAccount() {
    return _remoteDataSource.watchLedgerAccount().map((ledgerModel) {
      if (ledgerModel == null) {
        return const Left(Failure.serverError(message: 'Ledger account not found'));
      }
      return Right(ledgerModel.toEntity());
    });
  }

  @override
  Future<Either<Failure, int>> getLedgerBalance() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final balance = await _remoteDataSource.getLedgerBalance();
      return Right(balance);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // ============================================================
  // Ledger Journal Methods
  // ============================================================

  @override
  Future<Either<Failure, List<LedgerJournal>>> getLedgerJournals({
    int? limit,
    DateTime? startAfter,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final journals = await _remoteDataSource.getLedgerJournals(
        limit: limit,
        startAfter: startAfter,
      );
      return Right(journals.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<LedgerJournal>>> watchLedgerJournals({int? limit}) {
    return _remoteDataSource.watchLedgerJournals(limit: limit).map((journals) {
      return Right(journals.map((m) => m.toEntity()).toList());
    });
  }

  // ============================================================
  // Engagement Stats Methods
  // ============================================================

  @override
  Future<Either<Failure, UserEngagementStats>> getEngagementStats() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final statsModel = await _remoteDataSource.getEngagementStats();
      if (statsModel == null) {
        // Return empty stats for new users
        final userId = _remoteDataSource.currentUserId;
        if (userId == null) {
          return const Left(Failure.unauthenticated());
        }
        return Right(UserEngagementStats.empty(userId));
      }
      return Right(statsModel.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, UserEngagementStats>> watchEngagementStats() {
    return _remoteDataSource.watchEngagementStats().map((statsModel) {
      if (statsModel == null) {
        // Return empty stats for new users
        final userId = _remoteDataSource.currentUserId;
        if (userId == null) {
          return Left<Failure, UserEngagementStats>(const Failure.unauthenticated());
        }
        return Right<Failure, UserEngagementStats>(UserEngagementStats.empty(userId));
      }
      return Right<Failure, UserEngagementStats>(statsModel.toEntity());
    });
  }

  // ============================================================
  // Sub-Account Methods (Multi-Wallet)
  // ============================================================

  @override
  Future<Either<Failure, List<SubAccount>>> getSubAccounts() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final models = await _remoteDataSource.getSubAccounts();
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<SubAccount>>> watchSubAccounts() {
    return _remoteDataSource.watchSubAccounts().map((models) {
      try {
        return Right<Failure, List<SubAccount>>(
          models.map((m) => m.toEntity()).toList(),
        );
      } catch (e) {
        return Left<Failure, List<SubAccount>>(
          Failure.serverError(message: e.toString()),
        );
      }
    });
  }

  @override
  Future<Either<Failure, String>> createUserWallet({required String name}) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final subAccountId = await _remoteDataSource.createUserWallet(name: name);
      return Right(subAccountId);
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> transferBetweenWallets({
    required String fromSubAccountId,
    required String toSubAccountId,
    required int amount,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.transferBetweenWallets(
        fromSubAccountId: fromSubAccountId,
        toSubAccountId: toSubAccountId,
        amount: amount,
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendP2PTransfer({
    required String recipientUserId,
    required int amount,
    required String subAccountId,
    String? note,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.sendP2PTransfer(
        recipientUserId: recipientUserId,
        amount: amount,
        subAccountId: subAccountId,
        note: note,
      );
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // ============================================================
  // Cashout Methods
  // ============================================================

  @override
  Future<Either<Failure, Cashout>> requestCashout({
    required int tokenAmount,
    required CashoutMethod method,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final cashoutModel = await _remoteDataSource.requestCashout(
        tokenAmount: tokenAmount,
        method: method,
        destinationDetails: destinationDetails,
        bankName: bankName,
        accountNumber: accountNumber,
        accountHolderName: accountHolderName,
        mobileNumber: mobileNumber,
      );
      return Right(cashoutModel.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Cashout>>> getCashoutHistory({
    int? limit,
    DateTime? startAfter,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final cashouts = await _remoteDataSource.getCashoutHistory(
        limit: limit,
        startAfter: startAfter,
      );
      return Right(cashouts.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cashout>> getCashoutById(String cashoutId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final cashoutModel = await _remoteDataSource.getCashout(cashoutId);
      if (cashoutModel == null) {
        return const Left(Failure.serverError(message: 'Cashout not found'));
      }
      return Right(cashoutModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelCashout(String cashoutId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      await _remoteDataSource.cancelCashout(cashoutId);
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
