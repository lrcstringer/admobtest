import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/cashout.dart';
import '../entities/ledger_account.dart';
import '../entities/ledger_journal.dart';
import '../entities/user_engagement_stats.dart';

/// Repository for ledger, cashout, and engagement stats operations
/// Note: Legacy wallet methods have been removed. Balance and transactions
/// are now managed through the Trust Ledger system.
abstract class WalletRepository {
  // ============================================================
  // Ledger Account Methods
  // ============================================================

  /// Get user's ledger account (Trust Ledger)
  Future<Either<Failure, LedgerAccount>> getLedgerAccount();

  /// Stream ledger account updates
  Stream<Either<Failure, LedgerAccount>> watchLedgerAccount();

  /// Get ledger balance (convenience method)
  Future<Either<Failure, int>> getLedgerBalance();

  // ============================================================
  // Ledger Journal Methods (Transaction History)
  // ============================================================

  /// Get ledger journals (Trust Ledger transaction history)
  Future<Either<Failure, List<LedgerJournal>>> getLedgerJournals({
    int? limit,
    DateTime? startAfter,
  });

  /// Stream ledger journals
  Stream<Either<Failure, List<LedgerJournal>>> watchLedgerJournals({int? limit});

  // ============================================================
  // Engagement Stats Methods
  // ============================================================

  /// Get user's engagement stats (streak tracking)
  Future<Either<Failure, UserEngagementStats>> getEngagementStats();

  /// Stream engagement stats updates
  Stream<Either<Failure, UserEngagementStats>> watchEngagementStats();

  // ============================================================
  // Cashout Methods
  // ============================================================

  /// Request cashout from ledger account
  Future<Either<Failure, Cashout>> requestCashout({
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
}
