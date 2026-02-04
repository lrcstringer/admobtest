import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/wallet.dart';
import '../entities/transaction.dart';
import '../entities/cashout.dart';
import '../entities/ledger_account.dart';
import '../entities/ledger_journal.dart';

/// Wallet repository interface
abstract class WalletRepository {
  /// Get user's main wallet
  Future<Either<Failure, Wallet>> getMainWallet();

  /// Stream wallet updates
  Stream<Either<Failure, Wallet>> watchWallet(String walletId);

  /// Get wallet by ID
  Future<Either<Failure, Wallet>> getWalletById(String walletId);

  /// Get all wallets for user
  Future<Either<Failure, List<Wallet>>> getUserWallets();

  /// Get transaction history
  Future<Either<Failure, List<Transaction>>> getTransactions({
    required String walletId,
    int? limit,
    DateTime? startAfter,
  });

  /// Stream transactions
  Stream<Either<Failure, List<Transaction>>> watchTransactions({
    required String walletId,
    int? limit,
  });

  /// Get transaction by ID
  Future<Either<Failure, Transaction>> getTransactionById(String transactionId);

  /// Request cashout
  Future<Either<Failure, Cashout>> requestCashout({
    required String walletId,
    required int tokenAmount,
    required CashoutMethod method,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
  });

  /// Get cashout history
  Future<Either<Failure, List<Cashout>>> getCashoutHistory({
    int? limit,
    DateTime? startAfter,
  });

  /// Get cashout by ID
  Future<Either<Failure, Cashout>> getCashoutById(String cashoutId);

  /// Cancel pending cashout
  Future<Either<Failure, void>> cancelCashout(String cashoutId);

  /// Get user's ledger account (Trust Ledger)
  Future<Either<Failure, LedgerAccount>> getLedgerAccount();

  /// Stream ledger account updates
  Stream<Either<Failure, LedgerAccount>> watchLedgerAccount();

  /// Get ledger balance (convenience method)
  Future<Either<Failure, int>> getLedgerBalance();

  /// Get ledger journals (Trust Ledger transaction history)
  Future<Either<Failure, List<LedgerJournal>>> getLedgerJournals({
    int? limit,
    DateTime? startAfter,
  });

  /// Stream ledger journals
  Stream<Either<Failure, List<LedgerJournal>>> watchLedgerJournals({int? limit});
}
