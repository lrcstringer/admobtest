import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/cashout.dart';
import '../../domain/entities/ledger_account.dart';
import '../../domain/entities/ledger_journal.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/remote/wallet_remote_datasource.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  WalletRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Wallet>> getMainWallet() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final walletModel = await _remoteDataSource.getMainWallet();
      if (walletModel == null) {
        return const Left(Failure.serverError(message: 'Wallet not found'));
      }
      return Right(walletModel.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, Wallet>> watchWallet(String walletId) {
    return _remoteDataSource.watchWallet(walletId).map((walletModel) {
      if (walletModel == null) {
        return const Left(Failure.serverError(message: 'Wallet not found'));
      }
      return Right(walletModel.toEntity());
    });
  }

  @override
  Future<Either<Failure, Wallet>> getWalletById(String walletId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final walletModel = await _remoteDataSource.getWallet(walletId);
      if (walletModel == null) {
        return const Left(Failure.serverError(message: 'Wallet not found'));
      }
      return Right(walletModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Wallet>>> getUserWallets() async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final walletModels = await _remoteDataSource.getUserWallets();
      return Right(walletModels.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions({
    required String walletId,
    int? limit,
    DateTime? startAfter,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final transactions = await _remoteDataSource.getTransactions(
        walletId: walletId,
        limit: limit,
        startAfter: startAfter,
      );
      return Right(transactions.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Transaction>>> watchTransactions({
    required String walletId,
    int? limit,
  }) {
    return _remoteDataSource
        .watchTransactions(walletId: walletId, limit: limit)
        .map((transactions) {
      return Right(transactions.map((m) => m.toEntity()).toList());
    });
  }

  @override
  Future<Either<Failure, Transaction>> getTransactionById(
      String transactionId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(Failure.network());
    }

    try {
      final transactionModel =
          await _remoteDataSource.getTransaction(transactionId);
      if (transactionModel == null) {
        return const Left(Failure.serverError(message: 'Transaction not found'));
      }
      return Right(transactionModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cashout>> requestCashout({
    required String walletId,
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
        walletId: walletId,
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
}
